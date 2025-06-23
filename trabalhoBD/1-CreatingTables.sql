-- Tabela para armazenar informações de localização
CREATE TABLE Localidade (
    localidade_id SERIAL PRIMARY KEY,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    CONSTRAINT uk_localidade UNIQUE (cidade, estado)
);

-- Tabela para unidades escolares (campi, institutos, etc.)
CREATE TABLE UnidadeEscolar (
    unidade_escolar_id SERIAL PRIMARY KEY,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    predio VARCHAR(100),
    bloco VARCHAR(50)
);

-- Tabela para os níveis de curso (ex: Graduação, Pós-Graduação)
CREATE TABLE NivelCurso (
    nivel_curso_id SERIAL PRIMARY KEY,
    nivel VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela para os períodos letivos (semestres, trimestres)
CREATE TABLE PeriodoLetivo (
    periodo_letivo_id SERIAL PRIMARY KEY,
    ano SMALLINT NOT NULL,
    tipo VARCHAR(50) NOT NULL, -- Ex: '1º Semestre', 'Anual'
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    dt_limite_cancel DATE
);

-- Tabela para salas de aula
CREATE TABLE Sala (
    sala_id SERIAL PRIMARY KEY,
    capacidade INTEGER NOT NULL,
    unidade_escolar_id INTEGER NOT NULL,
    FOREIGN KEY (unidade_escolar_id) REFERENCES UnidadeEscolar(unidade_escolar_id)
);

-- Tabela central de usuários
CREATE TABLE Usuario (
    usuario_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    telefone VARCHAR(25) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo VARCHAR(20),
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    localidade_id INTEGER,
    CONSTRAINT uk_usuario UNIQUE (nome, sobrenome, telefone),
    FOREIGN KEY (localidade_id) REFERENCES Localidade(localidade_id)
);

-- Tabela de especialização para Alunos
CREATE TABLE Aluno (
    usuario_id INTEGER PRIMARY KEY,
    nusp VARCHAR(20) NOT NULL UNIQUE,
    ano_ingresso INTEGER NOT NULL,
    unidade_escolar_id INTEGER NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (unidade_escolar_id) REFERENCES UnidadeEscolar(unidade_escolar_id)
);

-- Tabela de especialização para Professores
CREATE TABLE Professor (
    usuario_id INTEGER PRIMARY KEY,
    titulacao VARCHAR(100),
    especializacao VARCHAR(255),
    unidade_escolar_id INTEGER NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (unidade_escolar_id) REFERENCES UnidadeEscolar(unidade_escolar_id)
);

-- Tabela de especialização para Funcionários Administrativos
CREATE TABLE FuncionarioAdm (
    usuario_id INTEGER PRIMARY KEY,
    unidade_escolar_id INTEGER NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (unidade_escolar_id) REFERENCES UnidadeEscolar(unidade_escolar_id)
);

-- Tabela para Departamentos
CREATE TABLE Departamento (
    departamento_id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL UNIQUE,
    chefe_professor_id INTEGER UNIQUE,
    unidade_escolar_id INTEGER NOT NULL,
    FOREIGN KEY (chefe_professor_id) REFERENCES Professor(usuario_id),
    FOREIGN KEY (unidade_escolar_id) REFERENCES UnidadeEscolar(unidade_escolar_id)
);

-- Tabela de Cursos
CREATE TABLE Curso (
    codigo_id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    ch_total INTEGER,
    numero_vagas INTEGER,
    ementa TEXT,
    departamento_id INTEGER,
    sala_id INTEGER,
    unidade_escolar_id INTEGER NOT NULL,
    FOREIGN KEY (departamento_id) REFERENCES Departamento(departamento_id),
    FOREIGN KEY (sala_id) REFERENCES Sala(sala_id),
    FOREIGN KEY (unidade_escolar_id) REFERENCES UnidadeEscolar(unidade_escolar_id)
);

-- Tabela de Disciplinas
CREATE TABLE Disciplina (
    disciplina_id SERIAL PRIMARY KEY,
    codigo_nome VARCHAR(100) NOT NULL,
    aulas_semanais SMALLINT,
    material_didatico TEXT,
    unidade_escolar_id INTEGER NOT NULL,
    FOREIGN KEY (unidade_escolar_id) REFERENCES UnidadeEscolar(unidade_escolar_id)
);

-- Tabela para ofertas de disciplinas em um período letivo
CREATE TABLE OfertaDisciplina (
    oferta_id SERIAL PRIMARY KEY,
    disciplina_id INTEGER NOT NULL,
    periodo_letivo_id INTEGER NOT NULL,
    sala_id INTEGER,
    horario VARCHAR(100),
    dias_sem VARCHAR(100),
    capacidade_turma INTEGER,
    CONSTRAINT uk_oferta_disciplina UNIQUE (disciplina_id, periodo_letivo_id, sala_id),
    FOREIGN KEY (disciplina_id) REFERENCES Disciplina(disciplina_id),
    FOREIGN KEY (periodo_letivo_id) REFERENCES PeriodoLetivo(periodo_letivo_id),
    FOREIGN KEY (sala_id) REFERENCES Sala(sala_id)
);

-- Tabela para Avaliações feitas por alunos
CREATE TABLE Avaliacao (
    avaliacao_id SERIAL PRIMARY KEY,
    aluno_id INTEGER NOT NULL,
    comentario TEXT,
    didatica SMALLINT, -- Ex: nota de 1 a 5
    material_apoio SMALLINT,
    relevancia SMALLINT,
    infraestrutura SMALLINT,
    FOREIGN KEY (aluno_id) REFERENCES Aluno(usuario_id)
);

-- Tabela para Matrículas de alunos em disciplinas
CREATE TABLE Matricula (
    matricula_id SERIAL PRIMARY KEY,
    aluno_id INTEGER NOT NULL,
    oferta_disciplina_id INTEGER NOT NULL,
    data_matricula DATE DEFAULT CURRENT_DATE,
    status VARCHAR(50),
    nota_final NUMERIC(4, 2),
    bolsa_estudo NUMERIC(10, 2),
    desconto NUMERIC(5, 2),
    dt_confirmacao DATE,
    dt_cancelamento DATE,
    taxas NUMERIC(10, 2),
    CONSTRAINT uk_matricula UNIQUE (aluno_id, oferta_disciplina_id),
    FOREIGN KEY (aluno_id) REFERENCES Aluno(usuario_id),
    FOREIGN KEY (oferta_disciplina_id) REFERENCES OfertaDisciplina(oferta_id)
);

-- Tabela para Mensagens (entre usuários ou para turmas)
CREATE TABLE Mensagem (
    mensagem_id SERIAL PRIMARY KEY,
    "timestamp" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    texto TEXT NOT NULL,
    remetente_usuario_id INTEGER NOT NULL,
    destinatario_usuario_id INTEGER,
    destinatario_oferta_disciplina_id INTEGER,
    FOREIGN KEY (remetente_usuario_id) REFERENCES Usuario(usuario_id),
    FOREIGN KEY (destinatario_usuario_id) REFERENCES Usuario(usuario_id),
    FOREIGN KEY (destinatario_oferta_disciplina_id) REFERENCES OfertaDisciplina(oferta_id)
);

-- Tabela para Avisos (geralmente da administração)
CREATE TABLE Aviso (
    aviso_id SERIAL PRIMARY KEY,
    "timestamp" TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    mensagem TEXT NOT NULL,
    remetente_funcionario_adm_id INTEGER NOT NULL,
    destinatario_usuario_id INTEGER,
    destinatario_oferta_disciplina_id INTEGER,
    destinatario_curso_id INTEGER,
    FOREIGN KEY (remetente_funcionario_adm_id) REFERENCES FuncionarioAdm(usuario_id),
    FOREIGN KEY (destinatario_usuario_id) REFERENCES Usuario(usuario_id),
    FOREIGN KEY (destinatario_oferta_disciplina_id) REFERENCES OfertaDisciplina(oferta_id),
    FOREIGN KEY (destinatario_curso_id) REFERENCES Curso(codigo_id)
);

-- Tabelas de regras e infraestrutura específicas de um curso
CREATE TABLE RegraCurso (
    regra_id SERIAL,
    curso_id INTEGER NOT NULL,
    definicao TEXT NOT NULL,
    PRIMARY KEY (regra_id, curso_id),
    FOREIGN KEY (curso_id) REFERENCES Curso(codigo_id) ON DELETE CASCADE
);

CREATE TABLE InfraestruturaCurso (
    infraestrutura_id SERIAL,
    curso_id INTEGER NOT NULL,
    definicao TEXT NOT NULL,
    PRIMARY KEY (infraestrutura_id, curso_id),
    FOREIGN KEY (curso_id) REFERENCES Curso(codigo_id) ON DELETE CASCADE
);

-- Relaciona Cursos com seus Níveis
CREATE TABLE ClassificadoComo (
    curso_id INTEGER NOT NULL,
    nivel_curso_id INTEGER NOT NULL,
    PRIMARY KEY (curso_id, nivel_curso_id),
    FOREIGN KEY (curso_id) REFERENCES Curso(codigo_id) ON DELETE CASCADE,
    FOREIGN KEY (nivel_curso_id) REFERENCES NivelCurso(nivel_curso_id) ON DELETE CASCADE
);

-- Relaciona Cursos com seus pré-requisitos (outros cursos)
CREATE TABLE PreRequisitoCurso (
    curso_id INTEGER NOT NULL,
    pre_req_curso_id INTEGER NOT NULL,
    PRIMARY KEY (curso_id, pre_req_curso_id),
    FOREIGN KEY (curso_id) REFERENCES Curso(codigo_id) ON DELETE CASCADE,
    FOREIGN KEY (pre_req_curso_id) REFERENCES Curso(codigo_id) ON DELETE CASCADE
);

-- Relaciona Disciplinas com seus pré-requisitos (outras disciplinas)
CREATE TABLE PreRequisitoDisciplina (
    disciplina_id INTEGER NOT NULL,
    pre_req_disciplina_id INTEGER NOT NULL,
    PRIMARY KEY (disciplina_id, pre_req_disciplina_id),
    FOREIGN KEY (disciplina_id) REFERENCES Disciplina(disciplina_id) ON DELETE CASCADE,
    FOREIGN KEY (pre_req_disciplina_id) REFERENCES Disciplina(disciplina_id) ON DELETE CASCADE
);

-- Relaciona Disciplinas que integram a grade de um Curso
CREATE TABLE Integra (
    disciplina_id INTEGER NOT NULL,
    curso_id INTEGER NOT NULL,
    PRIMARY KEY (disciplina_id, curso_id),
    FOREIGN KEY (disciplina_id) REFERENCES Disciplina(disciplina_id) ON DELETE CASCADE,
    FOREIGN KEY (curso_id) REFERENCES Curso(codigo_id) ON DELETE CASCADE
);

-- Relaciona Professores como responsáveis por Disciplinas
CREATE TABLE ResponsavelPor (
    disciplina_id INTEGER NOT NULL,
    professor_id INTEGER NOT NULL,
    PRIMARY KEY (disciplina_id, professor_id),
    FOREIGN KEY (disciplina_id) REFERENCES Disciplina(disciplina_id) ON DELETE CASCADE,
    FOREIGN KEY (professor_id) REFERENCES Professor(usuario_id) ON DELETE CASCADE
);

-- Relaciona Professores que ministram uma Oferta de Disciplina
CREATE TABLE MinistraPor (
    professor_id INTEGER NOT NULL,
    oferta_disciplina_id INTEGER NOT NULL,
    PRIMARY KEY (professor_id, oferta_disciplina_id),
    FOREIGN KEY (professor_id) REFERENCES Professor(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (oferta_disciplina_id) REFERENCES OfertaDisciplina(oferta_id) ON DELETE CASCADE
);

-- Relaciona uma Avaliação a uma Disciplina específica
CREATE TABLE AvaliaDisciplina (
    avaliacao_id INTEGER NOT NULL,
    disciplina_id INTEGER NOT NULL,
    PRIMARY KEY (avaliacao_id, disciplina_id),
    FOREIGN KEY (avaliacao_id) REFERENCES Avaliacao(avaliacao_id) ON DELETE CASCADE,
    FOREIGN KEY (disciplina_id) REFERENCES Disciplina(disciplina_id) ON DELETE CASCADE
);

-- Relaciona uma Avaliação a um Professor específico
CREATE TABLE AvaliaProfessor (
    avaliacao_id INTEGER NOT NULL,
    professor_id INTEGER NOT NULL,
    PRIMARY KEY (avaliacao_id, professor_id),
    FOREIGN KEY (avaliacao_id) REFERENCES Avaliacao(avaliacao_id) ON DELETE CASCADE,
    FOREIGN KEY (professor_id) REFERENCES Professor(usuario_id) ON DELETE CASCADE
);

