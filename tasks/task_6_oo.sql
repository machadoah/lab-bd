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
