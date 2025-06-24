-- Query 1: Relatório de Desempenho de um Aluno Específico em um Período Letivo
-- Esta consulta demonstra a capacidade de gerar um histórico detalhado para um aluno,
-- mostrando as disciplinas cursadas, notas e status em um determinado semestre.
-- É fundamental para o acompanhamento acadêmico individual.

SELECT
    u.nome AS nome_aluno,
    u.sobrenome AS sobrenome_aluno,
    d.codigo_nome AS disciplina,
    pl.ano,
    pl.tipo AS periodo,
    m.nota_final,
    m.status
FROM
    Matricula m
JOIN Aluno a ON m.aluno_id = a.usuario_id
JOIN Usuario u ON a.usuario_id = u.usuario_id
JOIN OfertaDisciplina od ON m.oferta_disciplina_id = od.oferta_id
JOIN Disciplina d ON od.disciplina_id = d.disciplina_id
JOIN PeriodoLetivo pl ON od.periodo_letivo_id = pl.periodo_letivo_id
WHERE
    a.usuario_id = 1 -- Filtra pelo ID do aluno (João Mendes)
    AND pl.periodo_letivo_id = 1; -- Filtra pelo primeiro período letivo de 2024

-- ===================================================================================

-- Query 2: Média de Avaliação dos Professores por Disciplina
-- Esta consulta mostra a capacidade do sistema de coletar e consolidar feedback,
-- calculando a média das avaliações de didática que os professores recebem.
-- Essencial para a gestão de qualidade do corpo docente.

SELECT
    p_usuario.nome AS nome_professor,
    p_usuario.sobrenome AS sobrenome_professor,
    d.codigo_nome AS disciplina,
    AVG(av.didatica) AS media_didatica
FROM
    Avaliacao av
JOIN AvaliaProfessor ap ON av.avaliacao_id = ap.avaliacao_id
JOIN Professor p ON ap.professor_id = p.usuario_id
JOIN Usuario p_usuario ON p.usuario_id = p_usuario.usuario_id
JOIN AvaliaDisciplina ad ON av.avaliacao_id = ad.avaliacao_id
JOIN Disciplina d ON ad.disciplina_id = d.disciplina_id
GROUP BY
    p_usuario.nome, p_usuario.sobrenome, d.codigo_nome
ORDER BY
    media_didatica DESC;

-- ===================================================================================

-- Query 3: Taxa de Ocupação das Salas de Aula no Período Atual
-- Esta consulta é uma ferramenta de gestão administrativa que calcula a porcentagem
-- de vagas ocupadas em cada sala, ajudando no planejamento e otimização do uso da infraestrutura.

SELECT
    s.sala_id,
    ue.predio,
    ue.bloco,
    od.horario,
    od.dias_sem,
    s.capacidade,
    COUNT(m.matricula_id) AS alunos_matriculados,
    (COUNT(m.matricula_id) * 100.0 / s.capacidade) AS taxa_ocupacao_percentual
FROM
    OfertaDisciplina od
JOIN Sala s ON od.sala_id = s.sala_id
JOIN UnidadeEscolar ue ON s.unidade_escolar_id = ue.unidade_escolar_id
LEFT JOIN Matricula m ON od.oferta_id = m.oferta_disciplina_id AND m.status = 'Confirmada'
WHERE
    od.periodo_letivo_id IN (1, 2) -- Filtra pelos períodos de 2024
GROUP BY
    s.sala_id, ue.predio, ue.bloco, od.horario, od.dias_sem
ORDER BY
    taxa_ocupacao_percentual DESC;

-- ===================================================================================

-- Query 4: Histórico Completo de Comunicações com um Aluno
-- Demonstra a capacidade do sistema de centralizar a comunicação. A consulta une
-- mensagens diretas e avisos gerais/de curso enviados a um aluno específico.

(SELECT
    'Mensagem Direta' AS tipo_comunicacao,
    msg."timestamp",
    msg.texto,
    remetente.nome || ' ' || remetente.sobrenome AS remetente
FROM
    Mensagem msg
JOIN Usuario remetente ON msg.remetente_usuario_id = remetente.usuario_id
WHERE
    msg.destinatario_usuario_id = 4 -- ID do Aluno (Sofia Lima)
)
UNION ALL
(SELECT
    'Aviso' AS tipo_comunicacao,
    av."timestamp",
    av.mensagem AS texto,
    remetente.nome || ' ' || remetente.sobrenome AS remetente
FROM
    Aviso av
JOIN FuncionarioAdm fa ON av.remetente_funcionario_adm_id = fa.usuario_id
JOIN Usuario remetente ON fa.usuario_id = remetente.usuario_id
WHERE
    av.destinatario_usuario_id = 4 -- ID do Aluno (Sofia Lima)
)
ORDER BY "timestamp" DESC;

-- ===================================================================================

-- Query 5: Alunos com Nota Final Abaixo da Média em Disciplinas Atuais
-- Esta consulta serve como um alerta para a administração, identificando alunos
-- com baixo desempenho (nota menor que 5.0) durante todo o histórico,
-- permitindo ações proativas como recuperação ou apoio pedagógico.

SELECT
    u.nome,
    u.sobrenome,
    d.codigo_nome AS disciplina,
    m.nota_final,
    p_usuario.nome AS professor_responsavel,
    u.telefone,
    u.email
FROM
    Matricula m
JOIN Aluno a ON m.aluno_id = a.usuario_id
JOIN Usuario u ON a.usuario_id = u.usuario_id
JOIN OfertaDisciplina od ON m.oferta_disciplina_id = od.oferta_id
JOIN Disciplina d ON od.disciplina_id = d.disciplina_id
JOIN MinistraPor mp ON od.oferta_id = mp.oferta_disciplina_id
JOIN Professor p ON mp.professor_id = p.usuario_id
JOIN Usuario p_usuario ON p.usuario_id = p_usuario.usuario_id
WHERE
    m.status = 'Confirmada'
    AND m.nota_final < 5.0

-- ===================================================================================

-- Query 6: Grade Curricular e Pré-requisitos de um Curso
-- Esta consulta demonstra a capacidade de gerenciar a estrutura dos cursos,
-- listando todas as disciplinas de um curso específico e seus respectivos pré-requisitos.
-- Fundamental para a montagem da grade dos alunos e planejamento acadêmico.

SELECT
    c.nome AS nome_curso,
    d.codigo_nome AS disciplina_do_curso,
    prd.codigo_nome AS pre_requisito
FROM
    Curso c
JOIN Integra i ON c.codigo_id = i.curso_id
JOIN Disciplina d ON i.disciplina_id = d.disciplina_id
LEFT JOIN PreRequisitoDisciplina pr ON d.disciplina_id = pr.disciplina_id
LEFT JOIN Disciplina prd ON pr.pre_req_disciplina_id = prd.disciplina_id
WHERE
    c.codigo_id = 1 -- Filtra pelo ID do curso (Engenharia de Computação)
ORDER BY
    d.codigo_nome;

-- ===================================================================================

-- Query 7: Relatório Financeiro de Matrículas por Curso
-- Demonstra a capacidade de gestão financeira, sumarizando os valores totais de taxas,
-- descontos e bolsas por curso, oferecendo uma visão clara da saúde financeira de cada um.

SELECT
    c.nome AS nome_curso,
    COUNT(m.matricula_id) AS total_matriculas,
    SUM(m.taxas) AS total_arrecadado_taxas,
    SUM(m.desconto) AS total_descontos_concedidos,
    SUM(m.bolsa_estudo) AS total_bolsas
FROM
    Matricula m
JOIN OfertaDisciplina od ON m.oferta_disciplina_id = od.oferta_id
JOIN Disciplina d ON od.disciplina_id = d.disciplina_id
JOIN Integra i ON d.disciplina_id = i.disciplina_id
JOIN Curso c ON i.curso_id = c.codigo_id
WHERE
    m.status IN ('Confirmada', 'Pendente') -- Considera matrículas ativas
GROUP BY
    c.nome
ORDER BY
    total_arrecadado_taxas DESC;
