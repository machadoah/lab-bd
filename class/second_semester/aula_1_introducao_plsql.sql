-- aula dia 16 de abril de 2024

/*
Operadores Relacionais: =, <, >, <=, >=, != ou <> (DIFERENTE) E  := (atribuição)

Saída de tela pacote: DBMS_OUTPUT.PUT_LINE(expressão)

Habilitar o pacote DBMS: SET SERVEROUTPUT ON

Desabilitar a troca de variáveis de substituição: SET VERIFY OFF - LINHA DE COMANDO: &

APEX VARIÁVEL DE SUBSTITUIÇÃO :

Exibir erros: SHOW ERRORS

%TYPE: declaração por referência, onde a constante e/ou variável será do mesmo tipo de dado e quantidade de caracteres da coluna da tabela referenciada.
*/

-- BLOCOS ANÔNIMOS

-- 1) Criar um bloco anônimo que entre com 3 notas e exiba a média aritmética final

DECLARE
		v_p1 NUMBER(5,2) := :P1;
		v_p2 NUMBER(5,2) := :P2;
		v_ts NUMBER(5,2) := :TS;
		v_media NUMBER(5,2);

	BEGIN
		v_media := (v_p1 + v_p2 + v_ts)/3;
		DBMS_OUTPUT.PUT_LINE('Media = ' || v_media);
END;

-- 2)Criar um bloco anônimo que entre com o valor de salário e exiba o valor de vale transporte 6% sobre o salário

DECLARE 
        SALARIO INT := :SALARIO_FUNCIONARIO;
        VT INT; 

BEGIN 
    VT := (SALARIO * 0.06); 
    DBMS_OUTPUT.PUT_LINE('Vale Transporte = ' || VT);
END; 

-- 4)Criar a tabela PRODUTO com:
-- id INTEGER, nome VARCHAR(30), valor NUMBER(8,2) e 
-- qtde INTEGER

CREATE TABLE produto (
	id  	INTEGER PRIMARY KEY NOT NULL,
	nome	VARCHAR(30) NOT NULL,
	valor   NUMBER(8, 2) NOT NULL,
	qtde	INTEGER NOT NULL
); 

-- 5)Criar um bloco que insira na tabela PRODUTO:

DECLARE
	v_id	INTEGER           	:= :id;
	v_nome  produto.nome%TYPE 	:= :nome;
	v_valor produto.valor%TYPE	:= :valor;
	v_qtde  produto.qtde%TYPE 	:= :quantidade;
BEGIN
	INSERT INTO produto(
    	id,
    	nome,
    	valor,
    	qtde
	)
	VALUES(
    	v_id,
    	v_nome,
    	v_valor,
    	v_qtde
	);
	COMMIT;
END

-- 6)Criar um bloco que informe o id e retorne o nome do produto

DECLARE
	v_id	INTEGER           	:= :id;
BEGIN
	SELECT v_id FROM produto WHERE v_id == :id

-- 7)Criar um bloco que informe o id e atualize o valor do produto em 27%

DECLARE 
    v_id INTEGER := :id;
BEGIN
    UPDATE produto
        SET valor = valor * 1.27
    WHERE id = v_id;
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Atualizado com sucesso!');
END;

-- Altere o bloco acima para que após a atualização exiba o nome do produto e novo valor ... 

DECLARE
	v_id	INTEGER           	:= :id;
	v_novo_valor produto.valor%TYPE;
BEGIN
	SELECT valor * 1.27 INTO v_novo_valor FROM produto WHERE id = v_id;

	UPDATE produto SET valor = v_novo_valor WHERE id = v_id;

	COMMIT;

	DBMS_OUTPUT.PUT_LINE('O valor do produto com ID ' || v_id || ' foi atualizado com sucesso para ' || v_novo_valor);
END;

-- or

DECLARE
    v_id    INTEGER := :id;
    v_nome  VARCHAR(30);
    v_valor NUMBER(8,2);
BEGIN
    UPDATE produto
        SET valor = valor * 1.27
    WHERE id = v_id;
COMMIT;

SELECT nome, valor INTO v_nome, v_valor FROM produto
    WHERE id = v_id;
    DBMS_OUTPUT.PUT_LINE(v_nome|| ' - ' || v_valor);
END;

-- 8)Criar um bloco que informe o id e exclua o produto da tabela.

DECLARE
    v_id    INTEGER := :id;
BEGIN
    DELETE FROM produto WHERE id = v_id;
COMMIT;
END;