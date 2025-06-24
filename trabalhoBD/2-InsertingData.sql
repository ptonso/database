-- Tabela UnidadeEscolar
INSERT INTO UnidadeEscolar (unidade_escolar_id, cidade, estado, pais, predio, bloco) VALUES
(1, 'São Paulo', 'SP', 'Brasil', 'Prédio Principal', 'A'),
(2, 'Rio de Janeiro', 'RJ', 'Brasil', 'Edifício Central', 'B'),
(3, 'Belo Horizonte', 'MG', 'Brasil', 'Prédio de Engenharia', 'C'),
(4, 'Curitiba', 'PR', 'Brasil', 'Campus Politécnico', 'D'),
(5, 'Salvador', 'BA', 'Brasil', 'Campus Ondina', 'E'),
(6, 'Porto Alegre', 'RS', 'Brasil', 'Campus do Vale', 'F'),
(7, 'Recife', 'PE', 'Brasil', 'Centro de Tecnologia', 'G');

-- Tabela PeriodoLetivo
INSERT INTO PeriodoLetivo (periodo_letivo_id, ano, tipo, data_inicio, data_fim, dt_limite_cancel) VALUES
(1, 2024, 'Semestral', '2024-02-01', '2024-06-30', '2024-03-15'),
(2, 2024, 'Semestral', '2024-08-01', '2024-12-20', '2024-09-15'),
(3, 2025, 'Semestral', '2025-02-01', '2025-06-30', '2025-03-15'),
(4, 2025, 'Anual', '2025-02-10', '2025-12-05', '2025-04-10'),
(5, 2023, 'Semestral', '2023-08-01', '2023-12-20', '2023-09-15'),
(6, 2023, 'Semestral', '2023-02-01', '2023-06-30', '2023-03-15'),
(7, 2024, 'Anual', '2024-02-10', '2024-12-05', '2024-04-10');


-- Tabela NivelCurso
INSERT INTO NivelCurso (nivel_curso_id, nivel) VALUES
(1, 'Graduação'),
(2, 'Pós-Graduação Lato Sensu'),
(3, 'Pós-Graduação Stricto Sensu - Mestrado'),
(4, 'Pós-Graduação Stricto Sensu - Doutorado'),
(5, 'Extensão Universitária'),
(6, 'Curso Técnico'),
(7, 'Curso de Aperfeiçoamento');

-- Tabela Sala
INSERT INTO Sala (sala_id, capacidade, unidade_escolar_id) VALUES
(1, 50, 1),
(2, 35, 1),
(3, 100, 2),
(4, 40, 3),
(5, 80, 2),
(6, 25, 4),
(7, 60, 5);

-- Tabela Localidade
INSERT INTO Localidade (cidade, estado, pais) VALUES
('São Paulo', 'SP', 'Brasil'),
('Ribeirão Preto', 'SP', 'Brasil'),
('Campinas', 'SP', 'Brasil'),
('Rio de Janeiro', 'RJ', 'Brasil'),
('Niterói', 'RJ', 'Brasil'),
('Belo Horizonte', 'MG', 'Brasil'),
('Curitiba', 'PR', 'Brasil');

-- Tabela Disciplina
INSERT INTO Disciplina (disciplina_id, codigo_nome, aulas_semanais, material_didatico, unidade_escolar_id) VALUES
(1, 'Cálculo I', 4, 'Livro: "Cálculo Volume 1" de James Stewart. Notas de aula disponíveis no portal.', 1),
(2, 'Algoritmos e Estrutura de Dados I', 4, 'Livro: "Introduction to Algorithms" de Cormen et al. Slides das aulas.', 1),
(3, 'Física Geral I', 6, 'Livro: "Fundamentos de Física" de Halliday e Resnick. Listas de exercícios semanais.', 2),
(4, 'Química Orgânica', 4, 'Livro: "Química Orgânica" de Solomons. Material de laboratório.', 3),
(5, 'Direito Constitucional', 4, 'Constituição Federal. Artigos e jurisprudência selecionada.', 4),
(6, 'Introdução à Economia', 4, 'Livro: "Princípios de Economia" de Mankiw. Notícias e artigos.', 5),
(7, 'História da Arte', 2, 'Livro: "A História da Arte" de Gombrich. Apresentações de slides.', 6);

-- Tabela Usuario
INSERT INTO Usuario (usuario_id, nome, sobrenome, telefone, data_nascimento, sexo, email, senha, localidade_id) VALUES
(1, 'João', 'Mendes', '(11) 91111-1111', '2004-03-12', 'M', 'joao.mendes@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'São Paulo' AND estado = 'SP' AND pais = 'Brasil')),
(2, 'Maria', 'Oliveira', '(21) 92222-2222', '2003-07-22', 'F', 'maria.oliveira@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Rio de Janeiro' AND estado = 'RJ' AND pais = 'Brasil')),
(3, 'Pedro', 'Santos', '(31) 93333-3333', '2005-01-05', 'M', 'pedro.santos@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Belo Horizonte' AND estado = 'MG' AND pais = 'Brasil')),
(4, 'Sofia', 'Lima', '(41) 94444-4444', '2004-09-18', 'F', 'sofia.lima@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Curitiba' AND estado = 'PR' AND pais = 'Brasil')),
(5, 'Lucas', 'Souza', '(51) 95555-5555', '2002-11-25', 'M', 'lucas.souza@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Porto Alegre' AND estado = 'RS' AND pais = 'Brasil')),
(6, 'Laura', 'Gomes', '(61) 96666-6666', '2005-02-14', 'F', 'laura.gomes@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Brasília' AND estado = 'DF' AND pais = 'Brasil')),
(7, 'Mateus', 'Alves', '(71) 97777-7777', '2003-06-30', 'M', 'mateus.alves@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Salvador' AND estado = 'BA' AND pais = 'Brasil')),
(8, 'Isabela', 'Ribeiro', '(81) 98888-8888', '2004-08-08', 'F', 'isabela.ribeiro@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Recife' AND estado = 'PE' AND pais = 'Brasil')),
(9, 'Guilherme', 'Martins', '(91) 99999-9999', '2002-12-01', 'M', 'guilherme.martins@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Belém' AND estado = 'PA' AND pais = 'Brasil')),
(10,'Valentina', 'Rocha', '(11) 91010-1010', '2005-04-03', 'F', 'valentina.rocha@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'São Paulo' AND estado = 'SP' AND pais = 'Brasil')),
(11, 'Enzo', 'Barbosa', '(21) 91111-1112', '2003-10-10', 'M', 'enzo.barbosa@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Rio de Janeiro' AND estado = 'RJ' AND pais = 'Brasil')),
(12, 'Helena', 'Carvalho', '(31) 91212-1212', '2004-05-19', 'F', 'helena.carvalho@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Belo Horizonte' AND estado = 'MG' AND pais = 'Brasil')),
(13, 'Miguel', 'Pereira', '(41) 91313-1313', '2002-03-28', 'M', 'miguel.pereira@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Curitiba' AND estado = 'PR' AND pais = 'Brasil')),
(14, 'Alice', 'Rodrigues', '(51) 91414-1414', '2005-07-07', 'F', 'alice.rodrigues@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Porto Alegre' AND estado = 'RS' AND pais = 'Brasil')),
(15, 'Davi', 'Nunes', '(61) 91515-1515', '2003-09-11', 'M', 'davi.nunes@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Brasília' AND estado = 'DF' AND pais = 'Brasil')),
(16, 'Manuela', 'Freitas', '(71) 91616-1616', '2004-02-20', 'F', 'manuela.freitas@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Salvador' AND estado = 'BA' AND pais = 'Brasil')),
(17, 'Arthur', 'Cardoso', '(81) 91717-1717', '2002-08-17', 'M', 'arthur.cardoso@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Recife' AND estado = 'PE' AND pais = 'Brasil')),
(18, 'Livia', 'Pires', '(91) 91818-1818', '2005-10-23', 'F', 'livia.pires@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Belém' AND estado = 'PA' AND pais = 'Brasil')),
(19, 'Heitor', 'Jesus', '(11) 91919-1919', '2003-01-01', 'M', 'heitor.jesus@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'São Paulo' AND estado = 'SP' AND pais = 'Brasil')),
(20, 'Giovanna', 'Barros', '(21) 92020-2020', '2004-06-15', 'F', 'giovanna.barros@email.com', 'senha123', (SELECT localidade_id FROM Localidade WHERE cidade = 'Rio de Janeiro' AND estado = 'RJ' AND pais = 'Brasil')),
(21, 'Ricardo', 'Nogueira', '(11) 92121-2121', '1980-05-20', 'M', 'ricardo.nogueira@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'São Paulo' AND estado = 'SP' AND pais = 'Brasil')),
(22, 'Carla', 'Monteiro', '(21) 92222-2121', '1975-09-15', 'F', 'carla.monteiro@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Rio de Janeiro' AND estado = 'RJ' AND pais = 'Brasil')),
(23, 'Fábio', 'Azevedo', '(31) 92323-2323', '1982-02-28', 'M', 'fabio.azevedo@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Belo Horizonte' AND estado = 'MG' AND pais = 'Brasil')),
(24, 'Patrícia', 'Fogaça', '(41) 92424-2424', '1985-11-01', 'F', 'patricia.fogaca@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Curitiba' AND estado = 'PR' AND pais = 'Brasil')),
(25, 'Marcelo', 'Pinto', '(51) 92525-2525', '1978-01-10', 'M', 'marcelo.pinto@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Porto Alegre' AND estado = 'RS' AND pais = 'Brasil')),
(26, 'Vanessa', 'Dias', '(61) 92626-2626', '1988-07-07', 'F', 'vanessa.dias@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Brasília' AND estado = 'DF' AND pais = 'Brasil')),
(27, 'André', 'Cunha', '(71) 92727-2727', '1970-03-17', 'M', 'andre.cunha@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Salvador' AND estado = 'BA' AND pais = 'Brasil')),
(28, 'Camila', 'Teixeira', '(81) 92828-2828', '1990-08-30', 'F', 'camila.teixeira@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Recife' AND estado = 'PE' AND pais = 'Brasil')),
(29, 'Leandro', 'Moraes', '(91) 92929-2929', '1983-04-14', 'M', 'leandro.moraes@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Belém' AND estado = 'PA' AND pais = 'Brasil')),
(30, 'Tatiane', 'Correia', '(11) 93030-3030', '1986-06-25', 'F', 'tatiane.correia@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'São Paulo' AND estado = 'SP' AND pais = 'Brasil')),
(31, 'Rodrigo', 'Fernandes', '(21) 93131-3131', '1979-10-03', 'M', 'rodrigo.fernandes@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Rio de Janeiro' AND estado = 'RJ' AND pais = 'Brasil')),
(32, 'Daniela', 'Castro', '(31) 93232-3232', '1981-12-12', 'F', 'daniela.castro@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Belo Horizonte' AND estado = 'MG' AND pais = 'Brasil')),
(33, 'Vinicius', 'Moreira', '(41) 93333-3131', '1984-05-09', 'M', 'vinicius.moreira@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Curitiba' AND estado = 'PR' AND pais = 'Brasil')),
(34, 'Renata', 'Campos', '(51) 93434-3434', '1987-09-21', 'F', 'renata.campos@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Porto Alegre' AND estado = 'RS' AND pais = 'Brasil')),
(35, 'Thiago', 'Araújo', '(61) 93535-3535', '1977-02-19', 'M', 'thiago.araujo@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Brasília' AND estado = 'DF' AND pais = 'Brasil')),
(36, 'Jéssica', 'Melo', '(71) 93636-3636', '1991-01-29', 'F', 'jessica.melo@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Salvador' AND estado = 'BA' AND pais = 'Brasil')),
(37, 'Rafael', 'Duarte', '(81) 93737-3737', '1980-11-11', 'M', 'rafael.duarte@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Recife' AND estado = 'PE' AND pais = 'Brasil')),
(38, 'Aline', 'Bezerra', '(91) 93838-3838', '1989-03-03', 'F', 'aline.bezerra@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Belém' AND estado = 'PA' AND pais = 'Brasil')),
(39, 'Gustavo', 'Rezende', '(11) 93939-3939', '1976-08-16', 'M', 'gustavo.rezende@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'São Paulo' AND estado = 'SP' AND pais = 'Brasil')),
(40, 'Larissa', 'Vieira', '(21) 94040-4040', '1992-04-26', 'F', 'larissa.vieira@email.com', 'senhaPro', (SELECT localidade_id FROM Localidade WHERE cidade = 'Rio de Janeiro' AND estado = 'RJ' AND pais = 'Brasil')),
(41, 'Sérgio', 'Nascimento', '(11) 94141-4141', '1995-01-20', 'M', 'sergio.nascimento@email.com', 'senhaAdm', (SELECT localidade_id FROM Localidade WHERE cidade = 'São Paulo' AND estado = 'SP' AND pais = 'Brasil')),
(42, 'Mônica', 'Ramos', '(21) 94242-4242', '1993-02-25', 'F', 'monica.ramos@email.com', 'senhaAdm', (SELECT localidade_id FROM Localidade WHERE cidade = 'Rio de Janeiro' AND estado = 'RJ' AND pais = 'Brasil')),
(43, 'Eduardo', 'Neves', '(31) 94343-4343', '1988-06-13', 'M', 'eduardo.neves@email.com', 'senhaAdm', (SELECT localidade_id FROM Localidade WHERE cidade = 'Belo Horizonte' AND estado = 'MG' AND pais = 'Brasil')),
(44, 'Cristina', 'Aguiar', '(41) 94444-4141', '1991-10-10', 'F', 'cristina.aguiar@email.com', 'senhaAdm', (SELECT localidade_id FROM Localidade WHERE cidade = 'Curitiba' AND estado = 'PR' AND pais = 'Brasil')),
(45, 'Anderson', 'Silveira', '(51) 94545-4545', '1990-12-01', 'M', 'anderson.silveira@email.com', 'senhaAdm', (SELECT localidade_id FROM Localidade WHERE cidade = 'Porto Alegre' AND estado = 'RS' AND pais = 'Brasil'));

-- Tabela Aluno (20 exemplos)
INSERT INTO Aluno (usuario_id, NUSP, ano_ingresso, unidade_escolar_id) VALUES
(1, '11111111', 2023, 1),
(2, '22222222', 2022, 2),
(3, '33333333', 2024, 3),
(4, '44444444', 2023, 4),
(5, '55555555', 2021, 5),
(6, '66666666', 2024, 6),
(7, '77777777', 2022, 7),
(8, '88888888', 2023, 1),
(9, '99999999', 2021, 2),
(10, '11101010', 2024, 3),
(11, '12121212', 2022, 4),
(12, '13131313', 2023, 5),
(13, '14141414', 2021, 6),
(14, '15151515', 2024, 7),
(15, '16161616', 2022, 1),
(16, '17171717', 2023, 2),
(17, '18181818', 2021, 3),
(18, '19191919', 2024, 4),
(19, '20202020', 2022, 5),
(20, '21212121', 2023, 6);

-- Tabela Professor (20 exemplos)
INSERT INTO Professor (usuario_id, titulacao, especializacao, unidade_escolar_id) VALUES
(21, 'Doutorado', 'Engenharia de Software', 1),
(22, 'Mestrado', 'Direito Civil', 2),
(23, 'Doutorado', 'Física de Partículas', 3),
(24, 'Doutorado', 'Química Analítica', 4),
(25, 'Mestrado', 'Administração de Empresas', 5),
(26, 'Especialização', 'Psicologia Clínica', 6),
(27, 'Doutorado', 'História do Brasil', 7),
(28, 'Doutorado', 'Inteligência Artificial', 1),
(29, 'Mestrado', 'Letras Clássicas', 2),
(30, 'Doutorado', 'Biologia Molecular', 3),
(31, 'Doutorado', 'Robótica', 1),
(32, 'Mestrado', 'Direito Penal', 2),
(33, 'Doutorado', 'Astrofísica', 3),
(34, 'Doutorado', 'Bioquímica', 4),
(35, 'Mestrado', 'Marketing', 5),
(36, 'Especialização', 'Psicopedagogia', 6),
(37, 'Doutorado', 'História Medieval', 7),
(38, 'Doutorado', 'Redes de Computadores', 1),
(39, 'Mestrado', 'Linguística', 2),
(40, 'Doutorado', 'Genética', 3);

-- Tabela FuncionarioAdm (5 exemplos)
INSERT INTO FuncionarioAdm (usuario_id, unidade_escolar_id) VALUES
(41, 1),
(42, 2),
(43, 3),
(44, 4),
(45, 5);

-- Tabela Departamento (7 exemplos)
-- Os chefes são IDs de professores (21-40)
INSERT INTO Departamento (departamento_id, nome, chefe_professor_id, unidade_escolar_id) VALUES
(1, 'Departamento de Engenharia da Computação', 21, 1),
(2, 'Departamento de Direito', 22, 2),
(3, 'Departamento de Física', 23, 3),
(4, 'Departamento de Química', 24, 4),
(5, 'Departamento de Administração', 25, 5),
(6, 'Departamento de Psicologia', 26, 6),
(7, 'Departamento de História', 27, 7);

-- Tabela Curso (7 exemplos)
INSERT INTO Curso (codigo_id, nome, ch_total, numero_vagas, ementa, departamento_id, sala_id, unidade_escolar_id) VALUES
(1, 'Engenharia de Computação', 3600, 50, 'Ementa completa do curso de Engenharia de Computação...', 1, 1, 1),
(2, 'Direito', 3700, 80, 'Ementa completa do curso de Direito...', 2, 3, 2),
(3, 'Física (Bacharelado)', 2800, 40, 'Ementa completa do curso de Física...', 3, 4, 3),
(4, 'Farmácia', 4000, 50, 'Ementa completa do curso de Farmácia...', 4, 6, 4),
(5, 'Administração', 3000, 100, 'Ementa completa do curso de Administração...', 5, 5, 5),
(6, 'Psicologia', 4200, 60, 'Ementa completa do curso de Psicologia...', 6, 7, 6),
(7, 'História (Licenciatura)', 2900, 50, 'Ementa completa do curso de História...', 7, 2, 7);

-- Tabela RegraCurso (7 exemplos)
INSERT INTO RegraCurso (regra_id, curso_id, definicao) VALUES
(1, 1, 'Mínimo de 240h em atividades complementares obrigatórias.'),
(2, 2, 'Aprovação no Exame da OAB é requisito para colação de grau.'),
(3, 3, 'Obrigatório apresentar seminário de tese no 7º semestre.'),
(4, 4, 'Estágio supervisionado de 600h é mandatório.'),
(5, 5, 'Apresentação de Trabalho de Conclusão de Curso (TCC) em formato de plano de negócios.'),
(6, 1, 'Coeficiente de Rendimento mínimo de 5.0 para prosseguir.'),
(7, 2, 'Participação em júri simulado é parte da avaliação de Prática Jurídica.');

-- Tabela InfraestruturaCurso (7 exemplos)
INSERT INTO InfraestruturaCurso (infraestrutura_id, curso_id, definicao) VALUES
(1, 1, 'Acesso a 5 laboratórios de informática com software especializado.'),
(2, 2, 'Disponibilidade do Núcleo de Prática Jurídica para atendimento à comunidade.'),
(3, 3, 'Acesso ao Laboratório de Física Moderna e Observatório Astronômico.'),
(4, 4, 'Uso de 3 laboratórios de química para aulas práticas.'),
(5, 5, 'Acesso à incubadora de empresas da universidade.'),
(6, 6, 'Clínica de atendimento psicológico para estágio supervisionado.'),
(7, 7, 'Acesso ao Arquivo Histórico e laboratório de arqueologia.');

-- Tabela OfertaDisciplina (7 exemplos)
INSERT INTO OfertaDisciplina (oferta_id, disciplina_id, periodo_letivo_id, sala_id, horario, dias_sem, capacidade_turma) VALUES
(1, 1, 1, 1, '08:00-10:00', 'SEG/QUA', 50),
(2, 2, 1, 2, '10:00-12:00', 'TER/QUI', 35),
(3, 3, 2, 3, '14:00-16:00', 'SEG/QUA/SEX', 90),
(4, 4, 2, 4, '19:00-21:00', 'TER/QUI', 40),
(5, 5, 1, 5, '08:00-10:00', 'SEG/SEX', 80),
(6, 6, 2, 7, '10:00-12:00', 'QUA/SEX', 60),
(7, 7, 1, 6, '16:00-18:00', 'TER', 25);

-- Tabela Matricula (7 exemplos)
INSERT INTO Matricula (matricula_id, aluno_id, oferta_disciplina_id, data_matricula, status, nota_final, bolsa_estudo, desconto, dt_confirmacao, dt_cancelamento, taxas) VALUES
(1, 1, 1, '2024-01-20', 'Confirmada', 8.50, 0.00, 50.00, '2024-01-22', NULL, 750.00),
(2, 2, 3, '2024-07-25', 'Confirmada', 7.00, 400.00, 0.00, '2024-07-28', NULL, 800.00),
(3, 3, 5, '2024-01-21', 'Confirmada', 4.50, 0.00, 0.00, '2024-01-23', NULL, 800.00),
(4, 4, 7, '2024-01-22', 'Pendente', NULL, 0.00, 0.00, NULL, NULL, 800.00),
(5, 1, 2, '2024-01-20', 'Confirmada', 9.25, 0.00, 50.00, '2024-01-22', NULL, 750.00),
(6, 5, 6, '2024-07-26', 'Cancelada', NULL, 0.00, 0.00, NULL, '2024-08-10', 50.00),
(7, 6, 4, '2024-07-27', 'Confirmada', 6.75, 0.00, 0.00, '2024-07-30', NULL, 800.00);

-- Tabela ClassificadoComo (7 exemplos)
INSERT INTO ClassificadoComo (curso_id, nivel_curso_id) VALUES
(1, 1), -- Engenharia -> Graduação
(2, 1), -- Direito -> Graduação
(3, 1), -- Física -> Graduação
(4, 1), -- Farmácia -> Graduação
(5, 1), -- Administração -> Graduação
(6, 1), -- Psicologia -> Graduação
(7, 1); -- História -> Graduação

-- Tabela PreRequisitoCurso (7 exemplos)
-- Esta tabela geralmente é esparsa. Aqui são exemplos ilustrativos.
INSERT INTO PreRequisitoCurso (curso_id, pre_req_curso_id) VALUES
(3, 1), -- Exemplo: Para fazer Doutorado em Física (hipotético curso 3), precisa de Graduação em Eng (hipotético curso 1)
(4, 3), -- Exemplo: Para fazer Mestrado em Farmacologia (hipotético curso 4), precisa de Graduação em Física (hipotético curso 3)
(5, 1),
(6, 2),
(7, 5),
(2, 6),
(1, 7);

-- Tabela PreRequisitoDisciplina (7 exemplos)
INSERT INTO PreRequisitoDisciplina (disciplina_id, pre_req_disciplina_id) VALUES
(2, 1), -- Algoritmos I (disc 2) requer Cálculo I (disc 1)
(3, 1), -- Física I (disc 3) requer Cálculo I (disc 1)
(4, 3), -- Química Orgânica (disc 4) requer Física I (disc 3)
(1, 3), -- Exemplo inverso para ilustração
(5, 7),
(6, 5),
(7, 6);

-- Tabela Integra (7 exemplos)
INSERT INTO Integra (disciplina_id, curso_id) VALUES
(1, 1), -- Cálculo I integra o curso de Engenharia de Computação
(2, 1), -- Algoritmos I integra o curso de Engenharia de Computação
(3, 3), -- Física I integra o curso de Física
(4, 4), -- Química Orgânica integra o curso de Farmácia
(5, 2), -- Direito Constitucional integra o curso de Direito
(6, 5), -- Introdução à Economia integra o curso de Administração
(7, 7); -- História da Arte integra o curso de História

-- Tabela ResponsavelPor (7 exemplos)
INSERT INTO ResponsavelPor (disciplina_id, professor_id) VALUES
(1, 21), -- Disciplina Cálculo I -> Professor Ricardo (Eng. Software)
(2, 28), -- Disciplina Algoritmos I -> Professora Camila (IA)
(3, 23), -- Disciplina Física I -> Professor Fábio (Física)
(4, 24), -- Disciplina Química Orgânica -> Professora Patrícia (Química)
(5, 22), -- Disciplina Direito Const. -> Professora Carla (Direito)
(6, 25), -- Disciplina Intro a Economia -> Professor Marcelo (ADM)
(7, 27); -- Disciplina História da Arte -> Professor André (História)

-- Tabela MinistraPor (7 exemplos)
 INSERT INTO MinistraPor (professor_id, oferta_disciplina_id) VALUES
(21, 1), -- Professor Ricardo ministra a oferta 1 (Cálculo I)
(28, 2), -- Professora Camila ministra a oferta 2 (Algoritmos I)
(23, 3), -- Professor Fábio ministra a oferta 3 (Física I)
(24, 4), -- Professora Patrícia ministra a oferta 4 (Química Orgânica)
(22, 5), -- Professora Carla ministra a oferta 5 (Direito Const.)
(25, 6), -- Professor Marcelo ministra a oferta 6 (Intro a Economia)
(27, 7); -- Professor André ministra a oferta 7 (História da Arte)

-- Tabela Avaliacao (7 exemplos)
INSERT INTO Avaliacao (avaliacao_id, aluno_id, comentario, didatica, material_apoio, relevancia, infraestrutura) VALUES
(1, 1, 'Excelente professor, muito claro nas explicações.', 5, 5, 5, 4),
(2, 2, 'A matéria é complexa, mas os materiais ajudam muito.', 4, 5, 5, 5),
(3, 3, 'A infraestrutura do laboratório poderia ser melhor.', 5, 4, 5, 3),
(4, 4, 'O conteúdo é muito relevante para a carreira.', 5, 5, 5, 5),
(5, 5, 'Professor pouco didático, difícil de acompanhar.', 2, 3, 4, 5),
(6, 6, 'Gostei muito da disciplina, foi bem organizada.', 4, 4, 4, 4),
(7, 7, 'Poderia haver mais exemplos práticos.', 3, 4, 5, 4);

-- Tabela Aviso (7 exemplos)
INSERT INTO Aviso (aviso_id, "timestamp", mensagem, remetente_funcionario_adm_id, destinatario_usuario_id, destinatario_oferta_disciplina_id, destinatario_curso_id) VALUES
(1, '2024-10-25 10:00:00', 'A secretaria não funcionará no feriado.', 41, NULL, NULL, NULL), -- Aviso geral
(2, '2024-11-10 11:30:00', 'Prazo final para trancamento de matrícula do curso.', 42, NULL, NULL, 2), -- Aviso para curso 2
(3, '2024-05-01 09:00:00', 'A aula de hoje foi cancelada por motivo de força maior.', 43, NULL, 1, NULL), -- Aviso para oferta 1
(4, '2024-03-15 17:00:00', 'Seu documento de identidade está pendente na secretaria.', 41, 4, NULL, NULL), -- Aviso para usuário 4
(5, '2024-08-01 08:00:00', 'Boas-vindas ao novo semestre letivo!', 44, NULL, NULL, NULL), -- Aviso geral
(6, '2024-09-20 14:00:00', 'A palestra sobre Carreiras Jurídicas foi adiada.', 42, NULL, NULL, 2), -- Aviso para curso 2
(7, '2024-02-15 13:00:00', 'A sala da turma de Cálculo I foi alterada para a sala 102.', 41, NULL, 1, NULL); -- Aviso para oferta 1

-- Tabela Mensagem (7 exemplos)
INSERT INTO Mensagem (mensagem_id, "timestamp", texto, remetente_usuario_id, destinatario_usuario_id, destinatario_oferta_disciplina_id) VALUES
(1, '2024-03-10 14:30:00', 'Professor, estou com dúvida no exercício 5 da lista.', 1, 21, NULL), -- Aluno 1 para Professor 21
(2, '2024-03-10 15:00:00', 'Olá, Carlos. Pode me procurar no meu horário de atendimento na quarta-feira.', 21, 1, NULL), -- Professor 21 para Aluno 1
(3, '2024-08-15 09:00:00', 'Pessoal, o link para a aula de hoje é meet.google.com/xyz', 28, NULL, 2), -- Professor 28 para a turma da oferta 2
(4, '2024-04-05 11:20:00', 'Oi Maria, você entendeu a matéria de ontem?', 4, 2, NULL), -- Aluna 4 para Aluna 2
(5, '2024-04-05 11:25:00', 'Entendi mais ou menos, podemos estudar juntas mais tarde?', 2, 4, NULL), -- Aluna 2 para Aluna 4
(6, '2024-09-01 18:00:00', 'Lembrete: A prova será na próxima semana.', 23, NULL, 3), -- Professor 23 para a turma da oferta 3
(7, '2024-02-28 10:10:00', 'Prezado Prof. André, gostaria de sugerir um documentário para a turma.', 7, 27, NULL); -- Aluno 7 para Professor 27

-- Tabela AvaliaDisciplina (7 exemplos)
INSERT INTO AvaliaDisciplina (avaliacao_id, disciplina_id) VALUES
(1, 1), -- Avaliação 1 (do aluno 1) é sobre a disciplina 1 (Cálculo I)
(2, 3), -- Avaliação 2 (do aluno 2) é sobre a disciplina 3 (Física I)
(3, 1), -- Avaliação 3 (do aluno 3) é sobre a disciplina 1 (Cálculo I)
(4, 5), -- Avaliação 4 (do aluno 4) é sobre a disciplina 5 (Direito Const.)
(5, 6), -- Avaliação 5 (do aluno 5) é sobre a disciplina 6 (Intro a Economia)
(6, 2), -- Avaliação 6 (do aluno 6) é sobre a disciplina 2 (Algoritmos I)
(7, 4); -- Avaliação 7 (do aluno 7) é sobre a disciplina 4 (Química Orgânica)

-- Tabela AvaliaProfessor (7 exemplos)
INSERT INTO AvaliaProfessor (avaliacao_id, professor_id) VALUES
(1, 21), -- Avaliação 1 (do aluno 1) é sobre o professor 21 
(2, 23), -- Avaliação 2 (do aluno 2) é sobre o professor 23 
(3, 21), -- Avaliação 3 (do aluno 3) é sobre o professor 21 
(4, 22), -- Avaliação 4 (do aluno 4) é sobre a professora 22 
(5, 25), -- Avaliação 5 (do aluno 5) é sobre o professor 25 
(6, 28), -- Avaliação 6 (do aluno 6) é sobre a professora 28 
(7, 24); -- Avaliação 7 (do aluno 7) é sobre a professora 24 -- Tabela UnidadeEscolar