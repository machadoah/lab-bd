-- LABORATÓRIO DE BANCO DE DADOS - REVISÃO P1


-- 1) Exibir  o nome do cliente e o valor total das faturas. Ordenar em ordem crescente pelo nome  

SELECT nm_cliente, vl_total_fatura from CLIENTE c , 
    JOIN FATURA f ON c.cd_cliente = f.cd_cliente ORDER BY c.nm_cliente ASC

-- 2) Exibir o nome dos produtos e a quantidade de itens da fatura deste produto

SELECT p.nm_produto, SUM(i.qt_item_fatura) AS quantidade_itens
FROM produto p
JOIN item_fatura i ON p.cd_produto = i.cd_produto
GROUP BY p.nm_produto;


-- 3) Exibir o nome do cliente, a data da fatura e a média do valor total da fatura.  Ordenar em ordem decrescente pela média.
-- E NÃO ACEITA ORDENAR POR APELIDO DE COLUNA

SELECT
  cliente.nm_cliente AS NomeCliente,
  fatura.dt_fatura AS DataFatura,
  AVG(fatura.vl_total_fatura) AS MediaValorTotal
FROM
  cliente
JOIN item_fatura ON cliente.cd_cliente = item_fatura.cd_cliente
JOIN fatura ON item_fatura.cd_fatura = fatura.cd_fatura
GROUP BY
  cliente.nm_cliente,
  fatura.dt_fatura
ORDER BY
  AVG(fatura.vl_total_fatura) DESC

-- 4) Alterar o exercício 3 para exibir somente quando a média for igual ou maior que 3000. FALTA AGRUPAR

SELECT c.nm_cliente, f.dt_fatura, AVG(f.vl_total_fatura) 
FROM cliente c JOIN fatura f 
ON (c.cd_cliente = f.cd_cliente) 
GROUP BY c.nm_cliente, f.dt_fatura
HAVING AVG(f.vl_total_fatura) >= 3000 
ORDER BY AVG(f.vl_total_fatura) desc 


-- 5) Exibir o código e o email dos clientes e a quantidade de itens da fatura. Criar uma subconsulta dos clientes que tiveram faturas emitidas na mesma data que o cliente com código 171; 
SELECT c.cd_cliente, c.nm_email, COUNT(f.cd_fatura) 
FROM cliente c JOIN fatura f 
ON(c.cd_cliente = f.cd_cliente) 
WHERE c.dt_fatura in (SELECT dt_fatura FROM cliente WHERE cd_fatura= 171) 
GROUP BY c.cd_cliente, c.nm_cliente 


-- 6) Criar uma subconsulta que exiba todos os produtos que nunca foram vendidos.
SELECT cd_produto, nm_produto 
FROM produto WHERE cd_produto 
NOT IN ( SELECT cd_produto   FROM item_fatura );

-- 7) Utilizando os operadores de conjunto, exibir todos os códigos de produtos que já foram vendidos;
SELECT DISTINCT p.cd_produto
FROM produto p
WHERE EXISTS (
    SELECT 1
    FROM item_fatura v
    WHERE v.cd_produto = p.cd_produto
);

-- 8) Alterar o exercício 7 para que a solução seja com subconsulta;

SELECT DISTINCT p.cd_produto
FROM produto p 
WHERE p.cd_produto IN ( 
SELECT DISTINCT cd_produto 
FROM item_fatura 
);

-- 9) Alterar o exercício 7 para que a solução seja com junção de tabelas;

SELECT p.cd_produto
FROM produto p
JOIN item_fatura i ON p.cd_produto = i.cd_produto;


-- 10) Utilizando os operadores de conjunto, exibir todos os clientes que nunca tiveram faturas emitidas;

SELECT DISTINCT c.nm_cliente
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1
    FROM fatura v
    WHERE v.cd_cliente = c.cd_cliente
);

-- 11) Alterar o exercício 10 para que a solução seja com subconsulta;

SELECT * FROM CLIENTE
WHERE cd_cliente NOT IN (
	SELECT cd_cliente
	FROM FATURA);

-- 12) Alterar o exercício 10 para que a solução seja com junção de tabelas;                           

SELECT c.cd_cliente, c.nm_cliente
 FROM CLIENTE c LEFT JOIN FATURA f 
ON c.cd_cliente = f.cd_cliente 
WHERE f.cd_cliente IS NULL;

-- 13) Criar um índice chamado idx_cliente para a coluna nm_cliente da tabela CLIENTE;

create index idx_cliente on CLIENTE ( nm_cliente ); (feito pelo Afonso)

-- 14) Consulte os índices criados no usuário logado;
SELECT index_name FROM user_indexes;

-- 15) Excluir o índice chamado idx_cliente;
DROP index idx_cliente

-- 16) Criar uma sequência chamada seq_produto que inicie em 100 com incremento de 3, sem valores na memória cachê;
CREATE SEQUENCE seq_produto
    START WITH 100
    INCREMENT BY 3 NOCACHE
    	
-- 17) Consultar informações das sequências existentes neste usuário;

SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences;


-- 18) Criar uma visão chamada vw_vendas que exiba o nome do cliente, a data de fatura e a quantidade de itens que ele adquiriu PARA QUE SEJA SOMENTE DE LEITURA.
CREATE VIEW vw_vendas (nome, data, quantidade)
	AS SELECT c.nm_cliente, f.dt_fatura, SUM(i.qt_item_fatura)
	FROM fatura f
	JOIN cliente c ON c.cd_cliente = f.cd_cliente 
	JOIN item_fatura i ON i.cd_fatura = f.cd_fatura
	GROUP BY c.nm_cliente, f.dt_fatura
 WITH READ ONLY

-- 19) Criar uma visão chamada vw_vendas que exiba o nome do cliente, a data de fatura e a quantidade de itens que ele adquiriu;
CREATE VIEW vw_vendas (nome, data, quantidade)
	AS SELECT c.nm_cliente, f.dt_fatura, SUM(i.qt_item_fatura)
	FROM fatura f
	JOIN cliente c ON c.cd_cliente = f.cd_cliente 
	JOIN item_fatura i ON i.cd_fatura = f.cd_fatura
	GROUP BY c.nm_cliente, f.dt_fatura


-- 20) Consultar o script da view criada usando o dicionário de dados;
SELECT * FROM USER_VIEWS WHERE VIEW_NAME = ‘VW_VENDAS’;

-- 21) Criar um sinônimo chamado MERCADORIA para a tabela PRODUTO;
CREATE SYNONYM MERCADORIA FOR PRODUTO 

-- 22) Excluir a view criada e excluir o sinônimo criado.
DROP VIEW vw_vendas
DROP SYNONYM MERCADORIA

-- 23) Criar um tipo de objeto CONTA com código e data que será super classe;
CREATE TYPE conta AS OBJECT (cdconta INTEGER , dtconta DATETIME) NOT FINAL;

-- 24) Criar um tipo chamado CONTA_INVESTIMENTO que tenha o saldo e herda as características do tipo CONTA;
CREATE TYPE conta_investimento UNDER conta (vlsaldo DECIMAL(10, 2));

-- 25) Criar a tabela TB_INVESTIMENTO com base no tipo CONTA_INVESTIMENTO (EMILY)
CREATE TABLE TB_INVESTIMENTO OF CONTA_INVESTIMENTO

-- 26) Inserir um registro na tabela TB_INVESTIMENTO
INSERT INTO tb_investimento VALUES (001, '12/12/2023', 10000,00);

-- 27) Consultar o registro inserido.
SELECT * FROM TB_INVESTIMENTO

-- 28) Criar o tipo POUPANCA com data_aniversario e saldo que herda características do tipo CONTA.

CREATE TYPE poupanca UNDER CONTA
(data_aniversario date ,
saldo DECIMAL (10,2 ));

-- 29) Criar a tabela TB_POUPANCA com base no tipo POUPANCA
CREATE TABLE tb_poupanca OF poupanca

