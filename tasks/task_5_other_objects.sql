-- Criar uma view chamada vw_cargo que tenha as colunas job_id e job_title;
CREATE OR REPLACE VIEW vw_cargo AS
SELECT job_id, job_title FROM jobs;

-- Exibir a estrutura da view
DESCRIBE vw_cargo;

-- Exibir os cargos que tenham um i minusculo em seu nome
SELECT * FROM vw_cargo WHERE LOWER(job_title) LIKE '%i%';

-- Utilizando o dicionário de dados, exibir a consulta que criou a view
SELECT text FROM all_views WHERE view_name = 'VW_CARGO';

-- Inserir um cargo com id = 'PL' nome= 'Programador PL/SQL'
INSERT INTO jobs (job_id, job_title) VALUES ('PL', 'Programador PL/SQL');

-- Alterar a view para que seja somente de leitura
DROP VIEW vw_cargo;
CREATE OR REPLACE VIEW vw_cargo AS
SELECT job_id, job_title FROM jobs WHERE 1=0;

-- Tentativa de inserir um cargo com id = 'ES' nome = 'Engenheiro de Software'
-- Isso resultará em um erro porque a view é de apenas leitura

-- Excluir a view
DROP VIEW vw_cargo;

-- Criar um sinonimo chamado cargo para jobs
CREATE SYNONYM cargo FOR jobs;

-- Criar a tabela aluno com matricula INTEGER PRIMARY KEY e nome VARCHAR(20)
CREATE TABLE aluno (
    matricula INTEGER PRIMARY KEY,
    nome VARCHAR(20)
);

-- Criar uma sequencia chamada seq_aluno que inicie em 10 com incremento 10
CREATE SEQUENCE seq_aluno START WITH 10 INCREMENT BY 10;

-- Utilizando a sequencia criada, inserir 3 registros na tabela ALUNO
INSERT INTO aluno (matricula, nome) VALUES (seq_aluno.nextval, 'Nome1');
INSERT INTO aluno (matricula, nome) VALUES (seq_aluno.nextval, 'Nome2');
INSERT INTO aluno (matricula, nome) VALUES (seq_aluno.nextval, 'Nome3');
