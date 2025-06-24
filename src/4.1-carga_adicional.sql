CREATE OR REPLACE FUNCTION gerar_massa_dados_distribuidos(
    quantidade INTEGER,
    perc_aluno NUMERIC,
    perc_professor NUMERIC
)
RETURNS VOID AS $$
DECLARE
    nomes TEXT[] := ARRAY['Carlos', 'Adriana', 'Bruno', 'Fernanda', 'Diego', 'Juliana', 'Ricardo', 'Beatriz', 'Leandro', 'Vanessa', 'Felipe', 'Mariana', 'Gustavo', 'Camila', 'Rafael', 'Luiza', 'Thiago', 'Ana', 'Rodrigo', 'Paula', 'Simoni', 'Maria', 'Clara', 'Manuela', 'Andressa', 'Fabiola'];
    sobrenomes TEXT[] := ARRAY['Silva', 'Santos', 'Oliveira', 'Souza', 'Rodrigues', 'Ferreira', 'Alves', 'Pereira', 'Lima', 'Gomes', 'Costa', 'Ribeiro', 'Martins', 'Carvalho', 'Almeida', 'Lopes', 'Dias', 'Vieira', 'Barbosa', 'Nunes', 'Alves', 'Saraiva', 'Clinton', 'Usumaki', 'Uchiha', 'Leal', 'Uramoto'];
    titulacoes TEXT[] := ARRAY['Doutorado', 'Mestrado', 'Especialização', 'PhD'];
    especializacoes TEXT[] := ARRAY['Engenharia de Software', 'Direito Civil', 'Física de Partículas', 'Química Analítica', 'Administração de Empresas', 'Psicologia Clínica', 'História do Brasil', 'Inteligência Artificial', 'Letras Clássicas', 'Biologia Molecular'];
    ddds TEXT[] := ARRAY['11', '21', '31', '41', '51', '61', '71', '81', '91', '12', '19', '22', '27', '32', '48', '54', '62', '65', '85', '98'];

    novo_usuario_id INTEGER;
    nome_aleatorio TEXT;
    sobrenome_aleatorio TEXT;
    email_aleatorio TEXT;
    ddd_aleatorio TEXT;
    telefone_aleatorio TEXT;
    data_nasc_aleatoria DATE;
    sexo_aleatorio VARCHAR(20);
    localidade_aleatoria_id INTEGER;
    unidade_aleatoria_id INTEGER;
    roll NUMERIC;

    localidades_ids INTEGER[];
    unidades_ids INTEGER[];
BEGIN
    IF perc_aluno + perc_professor > 1.0 THEN
        RAISE EXCEPTION 'A soma das porcentagens de alunos e professores não pode exceder 1.0 (100%%)';
    END IF;

    SELECT array_agg(localidade_id) INTO localidades_ids FROM Localidade;
    IF localidades_ids IS NULL THEN
        localidades_ids := ARRAY[]::INTEGER[];
    END IF;

    SELECT array_agg(unidade_escolar_id) INTO unidades_ids FROM UnidadeEscolar;
    IF unidades_ids IS NULL THEN
        unidades_ids := ARRAY[]::INTEGER[];
    END IF;

    RAISE NOTICE 'Iniciando a inserção e distribuição de usuários...';

    FOR i IN 1..quantidade LOOP
        nome_aleatorio := nomes[1 + floor(random() * array_length(nomes, 1))];
        sobrenome_aleatorio := sobrenomes[1 + floor(random() * array_length(sobrenomes, 1))];
        email_aleatorio := lower(nome_aleatorio) || '.' || lower(sobrenome_aleatorio) || i || '@generated.com';
        ddd_aleatorio := ddds[1 + floor(random() * array_length(ddds, 1))];
        telefone_aleatorio := '(' || ddd_aleatorio || ') 9' || floor(random() * (9999-1000)+1000) || '-' || floor(random() * (9999-1000)+1000);
        data_nasc_aleatoria := CURRENT_DATE - (floor(random() * (32*365)) + (18*365))::INTEGER;
        sexo_aleatorio := CASE WHEN random() > 0.5 THEN 'M' ELSE 'F' END;
        localidade_aleatoria_id := localidades_ids[1 + floor(random() * array_length(localidades_ids, 1))];

        INSERT INTO Usuario (nome, sobrenome, telefone, data_nascimento, sexo, email, senha, localidade_id)
        VALUES (nome_aleatorio, sobrenome_aleatorio, telefone_aleatorio, data_nasc_aleatoria, sexo_aleatorio, email_aleatorio, 'senha_padrao_123', localidade_aleatoria_id)
        RETURNING usuario_id INTO novo_usuario_id;

        roll := random();
        unidade_aleatoria_id := unidades_ids[1 + floor(random() * array_length(unidades_ids, 1))];

        IF roll < perc_aluno THEN
            INSERT INTO Aluno (usuario_id, nusp, ano_ingresso, unidade_escolar_id)
            VALUES (
                novo_usuario_id,
                (10000000 + i)::VARCHAR,
                (extract(year from current_date) - floor(random() * 40))::INTEGER,
                unidade_aleatoria_id
            );
        ELSIF roll < perc_aluno + perc_professor THEN
            INSERT INTO Professor (usuario_id, titulacao, especializacao, unidade_escolar_id)
            VALUES (
                novo_usuario_id,
                titulacoes[1 + floor(random() * array_length(titulacoes, 1))],
                especializacoes[1 + floor(random() * array_length(especializacoes, 1))],
                unidade_aleatoria_id
            );
        ELSE
            INSERT INTO FuncionarioAdm (usuario_id, unidade_escolar_id)
            VALUES (novo_usuario_id, unidade_aleatoria_id);
        END IF;

        -- <<< NOVO TRECHO: Atualização de progresso >>>
        IF i % 10000 = 0 THEN
            RAISE NOTICE 'Inseridos até agora: % registros...', i;
        END IF;
    END LOOP;

    RAISE NOTICE 'Processo concluído com sucesso!';
END;
$$ LANGUAGE plpgsql;

SELECT setval(pg_get_serial_sequence('usuario', 'usuario_id'), (SELECT COALESCE(MAX(usuario_id), 1) FROM usuario));

SELECT gerar_massa_dados_distribuidos(1_000_000, 0.85, 0.10);

