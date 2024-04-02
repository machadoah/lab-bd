-- aula - Orientação a Objetos

-- Criar um objeto tipo PESSOAS com nome e endereço que possa ser herdado por outros objetos

CREATE TYPE pessoas AS OBJECT (cdpessoa INTEGER, nmpessoa VARCHAR(50)) NOT FINAL;

-- Exibir os erros

-- ERRADO: CREATE TYPE pessoas (cdpessoa INTEGER, nmpessoa VARCHAR(50), NOT FINAL)

-- Exibir a estrutura do tipo PESSOAS

DESC pessoas

-- Criar uma subclasse chamada FISICA que herde as caracteristicas da superclasse PESSOAS

CREATE TYPE fisica UNDER pessoas (cpf CHAR(11), sexo CHAR(1));

-- Exibir a estrutura do tipo FISICAS

DESC fisica

-- Criar a tabela PES_FISICA com base no tipo FISICAS

CREATE TABLE pes_fisicas OF fisica

-- acrescentar chave primaria na tabela na coluna cdpessoa:

alter table pes_fisicas add constraint pesfisica_pk primary key (cdpessoa)

-- Inserir registro na tabela PES_FISICA

insert into pes_fisicas values (1, 'Cariolando', '16236617859', 'M')

-- Exibir os registros da tabela PES_FISICA

select * from pes_fisicas

-- TABELAS ANINHADAS
/*
Tabelas com colunas cujo tipo de dado de dominio é outra tabela.
Criar uma tabela aninhada (coluna) chamada t_ende
com a estrutura abaixo:
*/

-- TABELAS ANINHADAS: Tabela criada como se fosse um tipo de dado de uma coluna da tabela:
 
-- Criar um tipo de dado coluna chamado lista_ende com base na tabela aninhada t_ende:

-- ARRAY EM BANCO DE DADOS

-- Criar um tipo de dados array chamado tele varchar(10) com 5 posicoes

-- Criar a tabela CLIENTE_LOJA com os tipos de dados COMPOSTO e ARRAY:

-- Inserir registro na tabela CLIENTE_LOJA

-- Selecionar os registros:

-- Exercicios: Teams

-- 1)Criar o tipo JURIDICAS com inscricao estadual varchar(30) e cnpj char(14) que herda as caracteristicas de PESSOAS

CREATE TYPE juridica UNDER pessoas (inscricao_estadual VARCHAR(30), cnpj CHAR(14));

-- Criar a tabela PES_JURIDICAS com base no tipo JURIDICAS

CREATE TABLE pes_juridicas OF juridica

desc pes_juridicas

-- acrescentar chave primaria na tabela na coluna cdpessoa:

alter table pes_juridicas add constraint pesjuridica_pk primary key (cdpessoa)

-- Inserir registro na tabela PES_JURIDICA

insert into pes_juridicas values (1, 'Isadora', '16236617855', '0123456789123')

-- Exibir os registros da tabela PES_JURIDICA

select * from pes_juridicas


