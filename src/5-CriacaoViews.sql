-- =============================================================================
-- Visão 1: vw_detalhes_alunos
-- =============================================================================
-- OBJETIVO: Criar uma visão consolidada que combina as informações do usuário,
-- do aluno e da sua unidade escolar, eliminando a necessidade de múltiplos JOINs.

CREATE OR REPLACE VIEW vw_detalhes_alunos AS
SELECT
    a.usuario_id AS aluno_id,
    a.nusp,
    u.nome || ' ' || u.sobrenome AS nome_completo,
    u.email,
    u.telefone,
    u.data_nascimento,
    a.ano_ingresso,
    ue.cidade AS cidade_unidade,
    ue.predio AS predio_unidade
FROM
    Aluno a
JOIN
    Usuario u ON a.usuario_id = u.usuario_id
JOIN
    UnidadeEscolar ue ON a.unidade_escolar_id = ue.unidade_escolar_id;

SELECT * FROM vw_detalhes_alunos

-- =============================================================================
-- Visão 2: vw_disciplinas_professores_responsaveis
-- =============================================================================
-- OBJETIVO: Fornecer uma lista clara de todas as disciplinas e os seus
-- respectivos professores responsáveis, incluindo a especialização deles.
-- Esta visão abstrai a complexidade das junções entre as tabelas 'Disciplina',
-- 'ResponsavelPor', 'Professor' e 'Usuario'.

CREATE OR REPLACE VIEW vw_disciplinas_professores_responsaveis AS
SELECT
    d.disciplina_id,
    d.codigo_nome AS nome_disciplina,
    p.usuario_id AS professor_id,
    u.nome || ' ' || u.sobrenome AS professor_responsavel,
    p.titulacao,
    p.especializacao,
    d.unidade_escolar_id
FROM
    Disciplina d
JOIN
    ResponsavelPor rp ON d.disciplina_id = rp.disciplina_id
JOIN
    Professor p ON rp.professor_id = p.usuario_id
JOIN
    Usuario u ON p.usuario_id = u.usuario_id;

SELECT * FROM vw_disciplinas_professores_responsaveis

-- =============================================================================
-- Visão 3: vw_matriculas_detalhadas
-- =============================================================================
-- OBJETIVO: Criar uma visão completa sobre as matrículas, mostrando quem
-- se matriculou em quê, quando, e qual foi o resultado. Esta pode ser uma das
-- visões mais úteis para os relatórios acadêmicos. Ela junta
-- dados de Aluno, Usuário, Matrícula, Oferta de Disciplina, Disciplina e
-- Período Letivo.

CREATE OR REPLACE VIEW vw_matriculas_detalhadas AS
SELECT
    m.matricula_id,
    m.status AS status_matricula,
    m.nota_final,
    m.data_matricula,
    a.usuario_id AS aluno_id,
    u.nome || ' ' || u.sobrenome AS nome_aluno,
    d.disciplina_id,
    d.codigo_nome AS nome_disciplina,
    pl.ano AS ano_letivo,
    pl.tipo AS periodo_letivo,
    od.horario,
    od.dias_sem
FROM
    Matricula m
JOIN
    Aluno a ON m.aluno_id = a.usuario_id
JOIN
    Usuario u ON a.usuario_id = u.usuario_id
JOIN
    OfertaDisciplina od ON m.oferta_disciplina_id = od.oferta_id
JOIN
    Disciplina d ON od.disciplina_id = d.disciplina_id
JOIN
    PeriodoLetivo pl ON od.periodo_letivo_id = pl.periodo_letivo_id;

SELECT * FROM vw_matriculas_detalhadas

