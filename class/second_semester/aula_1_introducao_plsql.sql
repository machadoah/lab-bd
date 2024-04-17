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

-- 9) Criar um bloco que entre com o id do depto. e exiba o nome do depto, a soma salarial e a quantidade de funcionários do depto

DECLARE
    v_id    INTEGER := :id;
    v_depto VARCHAR(30);
    v_soma  NUMBER(8,2);
    v_qtde  INTEGER;
BEGIN
    SELECT d.department_name, SUM(e.salary), COUNT(e.employee_id)
        INTO v_depto, v_soma, v_qtde
        FROM departments d, employees e
    WHERE d.department_id = v_id AND d.department_id = e.department_id
    GROUP BY d.department_name;

    DBMS_OUTPUT.PUT_LINE(v_depto);
    DBMS_OUTPUT.PUT_LINE(v_soma);
    DBMS_OUTPUT.PUT_LINE(v_qtde);
END;

-- 10)Criar um bloco que entre com o código de um depto e exiba a qtde de empregados e a soma salarial

DECLARE
	v_id_depto	INTEGER := :id;
	v_soma    	NUMBER(8,2);
	v_qtde    	INTEGER;
BEGIN
	SELECT COUNT(employee_id), SUM(salary)
	INTO  v_qtde, v_soma
	FROM employees
	WHERE department_id = v_id_depto;
	DBMS_OUTPUT.PUT_LINE(v_id_depto);
	DBMS_OUTPUT.PUT_LINE(v_soma);
	DBMS_OUTPUT.PUT_LINE(v_qtde);
END;

-- 11)Criar um bloco para exibir o nome do empregado e o nome do depto. do id de empregado informado

DECLARE
	v_id	INTEGER := :id;
	v_nome  employees.first_name%TYPE;
	v_nome_depto  VARCHAR(30);
BEGIN
	SELECT e.employee_id, e.first_name,d.department_name
	INTO  v_id, v_nome ,v_nome_depto
	FROM employees e, departments d
	WHERE v_id = e.employee_id
	AND d.department_id = e.department_id;
	DBMS_OUTPUT.PUT_LINE(v_nome);
	DBMS_OUTPUT.PUT_LINE(v_nome_depto);
END;

-- 12)Crie um bloco PL/SQL que selecione o número máximo de departamento na tabela DEPARTMENTS e exibe resultado

DECLARE
    v_nome  VARCHAR(30);
    v_id    INTEGER;
BEGIN
    SELECT MAX(department_id) INTO v_id FROM departments;
    SELECT department_name INTO v_nome FROM departments
        WHERE department_id = v_id;
    
    DBMS_OUTPUT.PUT_LINE(v_id || ' - ' || v_nome);
END;


-- 13)Criar um bloco anônimo que entre com o id de um empregado (EMPLOYEE_ID) e exiba o seu nome (FIRST_NAME), o titulo do cargo (JOB_TITLE) e o nome do departamento (DEPARTMENT_NAME). DICA: join.

DECLARE
    v_id INTEGER := :id;
    v_nome VARCHAR (30);
    v_cargo VARCHAR(30);
    v_depto VARCHAR(30);

BEGIN
    SELECT e.first_name, j.job_title, d.department_name
    INTO v_nome, v_cargo, v_depto
    FROM employees e, jobs j, departments d 
    WHERE e.employee_id = v_id 
    AND j.job_id = e.job_id
    AND d.department_id = e.department_id;

 DBMS_OUTPUT.PUT_LINE(v_nome || ' - ' ||v_cargo || ' - ' ||v.depto);

 END;

-- 14)Criar um bloco que entre com o id do depto e retorne o nome do depto., o maior e o menor salario.

DECLARE
    v_id INTEGER := :id;
    v_name VARCHAR(30);
    v_max NUMBER(10, 2);
    v_min NUMBER(10, 2);
BEGIN
    SELECT d.department_name, MAX(e.salary), MIN(e.salary)
        INTO v_name, v_max, v_min
        FROM employees e, departments d

    WHERE d.department_id = v_id
        AND e.department_id = d.department_id
    GROUP BY d.department_name;

    DBMS_OUTPUT.PUT_LINE('Maior' || v_max);
    DBMS_OUTPUT.PUT_LINE('Menor' || v_min);

END;




-- 14)Criar um bloco que entre com o id do depto e retorne o nome do depto., o maior e o menor salario.




