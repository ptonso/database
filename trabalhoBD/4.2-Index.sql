-- Teste feito com 1_000_000 de usuários

---------------------------------------------------------------
-- Primeiro exemplo:

--  Justificativa: O campo localidade_id tem muitos valores diferentes (alta cardinalidade) e consultas filtrando por localidade são comuns, então um índice B-Tree vai melhorar bastante a busca.

EXPLAIN ANALYZE 
SELECT * FROM Usuario WHERE localidade_id = 5;
-- "Planning Time: 0.137 ms" "Execution Time: 194.693 ms"

-- Criação do index
CREATE INDEX idx_usuario_localidade ON Usuario(localidade_id);

EXPLAIN ANALYZE 
SELECT * FROM Usuario WHERE localidade_id = 5;
-- "Planning Time: 0.150 ms" "Execution Time: 0.039 ms"
----------------------------------------------------------------------------
-- Segundo exemplo:

-- Justificativa: Filtros por faixa de anos (BETWEEN) são comuns em relatórios de ingresso de alunos. Um índice B-Tree é muito eficiente para buscas por intervalos.

EXPLAIN ANALYZE 
SELECT * FROM Aluno WHERE ano_ingresso BETWEEN 2000 AND 2010;
-- "Planning Time: 0.140 ms" "Execution Time: 200.193 ms"

-- Criação do index
CREATE INDEX idx_aluno_ano_ingresso ON Aluno(ano_ingresso);

EXPLAIN ANALYZE 
SELECT * FROM Aluno WHERE ano_ingresso BETWEEN 2000 AND 2010;
-- "Planning Time: 0.172 ms" "Execution Time: 69.646 ms"

--------------------------------------------------------------------------------------
-- Terceiro exemplo:

-- Justificativa: Campo com alta cardinalidade (muitas datas diferentes ao longo do tempo).

EXPLAIN ANALYZE 
SELECT * FROM Usuario WHERE data_nascimento BETWEEN '2000-01-01' AND '2005-12-31';
-- "Planning Time: 0.180 ms" "Execution Time: 267.390 ms"
-- Criação do index
CREATE INDEX idx_usuario_data_nascimento ON Usuario(data_nascimento);

EXPLAIN ANALYZE 
SELECT * FROM Usuario WHERE data_nascimento BETWEEN '2000-01-01' AND '2005-12-31';
-- "Planning Time: 0.174 ms" "Execution Time: 192.039 ms"
--------------------------------------------------------------------------------------

