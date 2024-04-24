-- 23/04/2024 - ESTRUTURA DE CONTROLE: 

--- A FAZER: Excluir tabelas: CLIENTE, PRODUTO e VENDA (se houver) do APEX
DROP TABLE cliente;
DROP TABLE produto;
DROP TABLE venda;


DESC produto;
DESC cliente;

/*

CONDICIONAL
IF-THEN-ELSIF-ELSE-END IF; (PL/SQL)
CASE (SQL - ANSI)
DECODE (SQL - ORACLE)

Podemos alterar o fluxo lógico de instruções usando estruturas de controle de loop. Condicionais:
   IF-THEN-END IF   1 CONDIÇÃO

   IF-THEN-ELSE-END IF 2 CONDIÇÕES (ALTERNATIVA)

   IF-THEN-ELSIF-ELSE-END IF MAIS QUE DUAS CONDIÇÕES 

  Sintaxe:
  IF condição THEN
       instrução;
  [ELSIF condicao THEN
      instrução;
  [ELSE
    instrucao]];
  END IF;

*/

-- EXERCICIOS

/*
    1)Criar um bloco que de acordo com o id do depto. exiba:
    se for entre 10 e 30: a soma salarial
    se for entre 40 e 60: a média salarial
    se for entre 70 e 90: a qtde de empregados
    Caso contrário, exibir todas as informações: SOMA, MEDIA e QTDE
    Obs. o id dos deptos são 10, 20, 30, 40, 50, 60, e assim por diante…
*/

-- A)

DECLARE
    v_id    INTEGER := :depto;
    v_soma  NUMBER(10,2);
    v_media NUMBER(10,2);
    v_qtde  INTEGER;
BEGIN
    SELECT SUM(salary), AVG(salary), COUNT(employee_id)
        INTO v_soma, v_media, v_qtde
        FROM employees
        WHERE department_id = v_id;
    IF v_id BETWEEN 10 AND 30 THEN
        DBMS_OUTPUT.PUT_LINE('soma ' || v_soma);
    ELSIF v_id BETWEEN 40 AND 60 THEN
        DBMS_OUTPUT.PUT_LINE('media ' || v_media);
    ELSIF v_id BETWEEN 70 AND 90 THEN
        DBMS_OUTPUT.PUT_LINE('quantidade ' || v_qtde);
    ELSE
         DBMS_OUTPUT.PUT_LINE('soma ' || v_soma);
         DBMS_OUTPUT.PUT_LINE('media ' || v_media);
         DBMS_OUTPUT.PUT_LINE('quantidade ' || v_qtde);
    END IF;
END;

-- B)ALTERAR O TIPO A PARA TER UMA CONSULTA EM CADA CONDICAO

DECLARE
    v_id    INTEGER := :depto;
    v_soma  NUMBER(10,2);
    v_media NUMBER(10,2);
    v_qtde  INTEGER;
BEGIN
    
    IF v_id BETWEEN 10 AND 30 THEN
    SELECT SUM(salary)
        INTO v_soma
        FROM employees
        WHERE department_id = v_id;
        DBMS_OUTPUT.PUT_LINE('soma ' || v_soma);
    ELSIF v_id BETWEEN 40 AND 60 THEN
    SELECT AVG(salary)
        INTO v_media
        FROM employees
        WHERE department_id = v_id;
        DBMS_OUTPUT.PUT_LINE('media ' || v_media);
    ELSIF v_id BETWEEN 70 AND 90 THEN
    SELECT COUNT(employee_id)
        INTO v_qtde
        FROM employees
        WHERE department_id = v_id;
        DBMS_OUTPUT.PUT_LINE('quantidade ' || v_qtde);
    ELSE
    SELECT SUM(salary), AVG(salary), COUNT(employee_id)
        INTO v_soma, v_media, v_qtde
        FROM employees
        WHERE department_id = v_id;
        
         DBMS_OUTPUT.PUT_LINE('soma ' || v_soma);
         DBMS_OUTPUT.PUT_LINE('media ' || v_media);
         DBMS_OUTPUT.PUT_LINE('quantidade ' || v_qtde);
    END IF;
END;

/*
Exercício)
2)Criar um bloco que entre com o id do empregado (inicia 100,101, etc) e exiba:
Se for entre 100 e 110 exibir o nome do empregado;
Se for entre 111 e 120  exibir o salário;
Caso contrário, exibir o nome, o salário e a data de admissão EMPLOYEES (employee_id, first_name, salary, hire_date).
*/

DECLARE
	v_id	INTEGER :=  :empregado;
	v_nome VARCHAR(80);
	v_sal NUMBER(10,2);
	v_dataAdm DATE;
BEGIN
	IF v_id BETWEEN 100 AND 110 THEN
    	SELECT first_name
    	INTO v_nome
    	FROM employees
    	WHERE v_id = employee_id;
    	DBMS_OUTPUT.PUT_LINE('Nome ' || v_nome);
	ELSIF v_id BETWEEN 111 AND 120 THEN
    	SELECT salary
    	INTO v_sal
    	FROM employees
    	WHERE v_id = employee_id;
    	DBMS_OUTPUT.PUT_LINE('Salário ' || v_sal);
	ELSE
    	SELECT first_name, salary, hire_Date
    	INTO v_nome, v_sal, v_dataAdm
    	FROM employees
    	WHERE v_id = employee_id;
    	DBMS_OUTPUT.PUT_LINE('Nome ' || v_nome);
    	DBMS_OUTPUT.PUT_LINE('Salário ' || v_sal);
    	DBMS_OUTPUT.PUT_LINE('Data de admissão ' || v_dataAdm);
	END IF;
END;

-- option 2:

DECLARE
	v_id	INTEGER :=  :empregado;
	v_nome VARCHAR(80);
	v_sal NUMBER(10,2);
	v_dataAdm DATE;
BEGIN

    SELECT first_name, salary, hire_Date
    	INTO v_nome, v_sal, v_dataAdm
    	FROM employees
    	WHERE v_id = employee_id;

	IF v_id BETWEEN 100 AND 110 THEN
    	DBMS_OUTPUT.PUT_LINE('Nome ' || v_nome);
	ELSIF v_id BETWEEN 111 AND 120 THEN
    	DBMS_OUTPUT.PUT_LINE('Salário ' || v_sal);
	ELSE
    	
    	DBMS_OUTPUT.PUT_LINE('Nome ' || v_nome);
    	DBMS_OUTPUT.PUT_LINE('Salário ' || v_sal);
    	DBMS_OUTPUT.PUT_LINE('Data de admissão ' || v_dataAdm);
	END IF;
END;

-- LOOP

/*
    São eles LOOP BÁSICO, WHILE, FOR E FOR REVERSO
    Criar a tabela abaixo

    CREATE TABLE loop
    (numero  INTEGER,
    tipo    VARCHAR(15));
*/

/*
LOOP
    INSTRUCOES;
    INCREMENTO;
    EXIT WHEN 
END LOOP;
*/

DECLARE
    v_num INTEGER :=1;
BEGIN
    LOOP
        INSERT INTO loop (numero, tipo) VALUES (v_num, 'Loop Basico');
        v_num := v_num + 1;
        EXIT WHEN v_num > 10;
    END LOOP;
    COMMIT; 
END;

SELECT * FROM LOOP ;

-- While
DECLARE
    v_num INTEGER :=1;
BEGIN
    DELETE FROM loop; -- apaga os registros da tabela
    COMMIT;
    WHILE v_num <= 10 LOOP
        INSERT INTO loop (numero, tipo) VALUES (v_num, 'While');
        v_num := v_num + 1;
        EXIT WHEN v_num > 1000;
    END LOOP;
    COMMIT; 
END;

SELECT * FROM LOOP;

--- For

BEGIN
    FOR i IN 1..10 LOOP 
        INSERT INTO loop (numero, tipo)
        VALUES (i, 'For');
    END LOOP;
    COMMIT;
END;

-- FOR AO CONTRARIO

BEGIN
    FOR i IN REVERSE 1..10 LOOP 
        INSERT INTO loop (numero, tipo)
        VALUES (i, 'For');
    END LOOP;
    COMMIT;
END;

SELECT * FROM LOOP;

-- exercicio

/*
    Criar um bloco que informe um número. 
    Se este número for entre 1 e 10 inserir na tabela LOOP números com incremento 2. Caso contrário, inserir números com incremento 1.
    Obs. Você irá delimitar o valor de saída do LOOP.
*/

DECLARE 
    v_numero INTEGER := :numero;
BEGIN
    DELETE  FROM loop;
    COMMIT;
    IF v_numero BETWEEN 1 AND 10 THEN
        LOOP 
            INSERT INTO loop (numero, tipo) VALUES (v_numero, 'Condicao 1');
            v_numero := v_numero + 2;
            EXIT WHEN v_numero > 100;
        END LOOP;
    ELSE
        LOOP
            INSERT INTO loop (numero, tipo) VALUES (v_numero, 'Condicao 2');
            v_numero := v_numero + 1;
            EXIT WHEN v_numero > 100;
        END LOOP;
    END IF;
COMMIT;
END;



-- Cursores Explicitos

/*

1)Criar um bloco anônimo que informe o id do depto e exiba o nome
do empregado e o título do seu cargo dos funcionários que trabalham
neste depto.

*/

DECLARE
    v_id  INTEGER := :depto;
    v_nome employees.first_name%TYPE;
    v_titulo jobs.job_title%TYPE;
    CURSOR semIntervaloEmMaio IS 
        SELECT e.first_name, j.job_title
            FROM employees e, jobs j 
        WHERE e.department_id = v_id
            AND e.job_id = j.job_id;
BEGIN
    OPEN semIntervaloEmMaio;
        LOOP    
            FETCH semIntervaloEmMaio INTO v_nome, v_titulo;-- ordem do select
            EXIT WHEN  semIntervaloEmMaio%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_nome|| ' trabalha como '|| v_titulo);
        END LOOP;
    CLOSE semIntervaloEmMaio;
END;

/*
2)Alterar o exemplo anterior para exibir somente os 3 primeiros funcionários. Obs. O uso do ROWCOUNT SEMPRE TEM QUE ESTAR TAMBÉM COM O NOTFOUND
*/

DECLARE
    v_id  INTEGER := :depto;
    v_nome employees.first_name%TYPE;
    v_titulo jobs.job_title%TYPE;
    CURSOR semIntervaloEmMaio IS 
        SELECT e.first_name, j.job_title
            FROM employees e, jobs j 
        WHERE e.department_id = v_id
            AND e.job_id = j.job_id;
BEGIN
    OPEN semIntervaloEmMaio;
        LOOP    
            FETCH semIntervaloEmMaio INTO v_nome, v_titulo;-- ordem do select
            EXIT WHEN  semIntervaloEmMaio%NOTFOUND  OR semIntervaloEmMaio%ROWCOUNT>3;
            DBMS_OUTPUT.PUT_LINE(v_nome|| ' trabalha como '|| v_titulo);
        END LOOP;
    CLOSE semIntervaloEmMaio;
END;

/*Criação tabela*/

CREATE TABLE temporaria(
    id  INTEGER PRIMARY KEY,
    nome    VARCHAR(60) NOT NULL,
    salanual NUMBER(8,2)
);

/*
3)Criar um bloco que insira na tabela TEMPORARIA o id, o nome e o salário anual (*12)
buscar o salário, o id e o nome na employees
inserir na tabela temporaria os dados calculados
não há variável de entrada
*/

DECLARE
    v_id INTEGER;
    v_nome VARCHAR(60);
    v_salario NUMBER(10,2);

    CURSOR temp1 IS 
        SELECT employee_id, first_name || ' ' || last_name, salary * 12
        FROM employees;
BEGIN
    OPEN temp1;
    LOOP
        FETCH temp1 INTO v_id, v_nome, v_salario;
    EXIT WHEN temp1%NOTFOUND;
    INSERT INTO temporaria (id, nome, salanual)
        VALUES (v_id, v_nome, v_salario);
    END LOOP;
    COMMIT;
    CLOSE temp1;
END;    

/*
CURSORES E REGISTROS: define registros para usar a estrutura de colunas em tabela usando as colunas do cursor explícito.
*/

/*
4) Criar um bloco que exiba o id e o nome de todos os empregados usando o cursor com registro.Obs.não há variável de entrada
*/

DECLARE
    CURSOR emp_cursor IS
    SELECT employee_id, last_name FROM employees;
    emp_registro emp_cursor%ROWTYPE;

BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_registro;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(emp_registro.employee_id || ' - ' || emp_registro.last_name);
    END LOOP;
    CLOSE emp_cursor;
END;

/*
CURSOR COM FOR: considerado um atalho porque o cursor é aberto, onde os registros são extraídos uma vez para cada iteração do loop e o cursor e fechado automaticamente.
*/

/*
5) Criar um bloco que recupere todos os funcionários que estão trabalhando no depto. com id 80
*/

DECLARE
   CURSOR emp_cursor IS
  SELECT first_name, department_id
     FROM employees;
 BEGIN
  FOR emp_registro IN emp_cursor LOOP
   IF emp_registro.department_id = 80 THEN
    DBMS_OUTPUT.PUT_LINE(emp_registro.first_name||
    ' trabalha no depto. com id 80');
  END IF;
END LOOP;
END;

-- PROCEDURES E FUNCTIONS
-- OBS.: -- PROCEDORE - PODE RETORNAR MAIS DE UM TIPO DE DADO, FUNCTION SÓ RETORNA UM TIPO

/*
a)PROCEDURES
Subprogramas que tem o objetivo executar uma ação específica.
Elas não retornam valores, portanto, utilizadas em atribuições
 a variáveis ou como argumento em um comando SELECT. Modos:
IN (padrao), OUT e IN OUT

Sintaxe:
CREATE OR REPLACE PROCEDURE nome
(argumento modo tipo-de-dados, argumento1 modo tipo-de-dados)
IS
Variaveis, constantes, cursores, tratamento de exceptions
BEGIN
END;

Criar uma procedure chamada prc_emp que informe o id do empregado
e exiba seu nome e o nome do depto. que ele trabalha:

Consultar as procedures existentes neste usuário:
*/


CREATE OR REPLACE PROCEDURE prc_emp(p_id IN INTEGER)
IS 
    v_nome VARCHAR(30);
    v_dept VARCHAR(60);
BEGIN
    SELECT e.first_name, d.department_name
        INTO v_nome, v_dept
        FROM employees e JOIN departments d 
        ON (e.department_id = d.department_id)
        WHERE e.employee_id = p_id;
        DBMS_OUTPUT.PUT_LINE(v_nome || ' trabalha no dpt ' || v_dept);
END;

-- EXECUTAR 

BEGIN 
    prc_emp(:id);
END;