-- 1.Criar um bloco que informe o id do depto. e exclua este departamento da tabela DEPARTMENTS. Caso haja empregados não será permitido a exclusão.

DECLARE 
    v_dept INTEGER := :depto;
   BEGIN 
    DELETE FROM departments WHERE department_id = v_dept;
    COMMIT;
END;     

-- Com tratamento. Usando o PRAGMA EXCEPTIOM_INIT (nomeDaExcecao, -numeroErro) 

DECLARE  
    v_dept INTEGER := :depto;
    emp_excecao EXCEPTION;
    PRAGMA EXCEPTION_INIT(emp_excecao, -2292);
   BEGIN 
    DELETE FROM departments WHERE department_id = v_dept;
    EXCEPTION 
        WHEN emp_excecao THEN 
            DBMS_OUTPUT.PUT_LINE('Impossível apagar, existe empregados nesse departamento');
END;     


/*2.Tentativa de armazenar valores duplicados em uma coluna restrita. 
Cadastrar um novo departamento na tabela DEPARTMENTS com valor para todas as colunas: obs. EXECUTAR 2 VEZES PARA SIMULAR O ERRO*/

BEGIN 
    INSERT INTO departments
    (department_id, department_name, manager_id, location_id) 
    VALUES ( 1, 'TCHURMA DE 3F', null, 1700);
END;    

SELECT * FROM departments

-- Tratamento do erro 
BEGIN 
    INSERT INTO departments
    (department_id, department_name, manager_id, location_id) 
    VALUES ( 1, 'TCHURMA DE 3F', null, 1700);
EXCEPTION 
        WHEN DUP_VAL_ON_INDEX THEN 
        DBMS_OUTPUT.PUT_LINE('Duplicidade em campo de chave primaria');
END; 

--3. EXERCÍCIO: Criar um bloco que insira um número e dividir este número por zero. Tratar este erro

DECLARE 
    v_numero INTEGER := :numero;
BEGIN 
    DBMS_OUTPUT.PUT_LINE(v_numero/0);
EXCEPTION 
        WHEN ZERO_DIVIDE THEN 
        DBMS_OUTPUT.PUT_LINE('Não é possivel realizar divisão por zero');
END;

/* RAISE: Erros definidos pelo desenvolvedor
4. Criar um bloco que atualize o salário do empregado informado em 50%. Tratar quando for informado um id de empregado não cadastrado.
DICA: Testar com número menor que 100 ou maior que 300
*/

DECLARE
    e_invalido EXCEPTION;
    v_id employees.employee_id%TYPE := :emp;
BEGIN     
    UPDATE employees SET salary = salary * 1.5
        WHERE employee_id = v_id;
        IF SQL%NOTFOUND THEN 
            RAISE e_invalido;
        END IF;
        EXCEPTION
            WHEN e_invalido THEN 
                DBMS_OUTPUT.PUT_LINE('Empregado com id ' || v_id || ' inexistente');

END;

/*
RAISE_APPLICATION_ERROR: permite criar uma exception como se fosse um erro ocorrido no próprio servidor Oracle (-20000 a -20999)
5. Criar um bloco que exclua todos os empregados subordinados ao gerente informado.
*/    

DECLARE 
    manager_id employees.manager_id%TYPE := :manager;
BEGIN 
    DELETE FROM employees
    WHERE  manager_id = v_id;
    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20300, 'Gerente nao existe');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('Empregados do gerente excluido');      
    END IF;
END;    

-- Procedures
/*
1.Criar uma procedure chamada prc_emp que de acordo com o id do cargo retorne o nome do funcionário, o salário e o título do cargo 
DICA: id é uma string, join entre EMPLOYEES  e JOBS.
*/
CREATE OR REPLACE PROCEDURE  prc_emp (p_id IN jobs.job_id%TYPE)
IS
    v_nome  VARCHAR(30);
    v_sal employees.salary%TYPE;
    v_cargo jobs.job_title%TYPE;
CURSOR cursor1 IS
    SELECT e.first_name, e.salary, j.job_title
        FROM employees e, jobs j
    WHERE e.job_id = UPPER(p_id) AND e.job_id = j.job_id;

BEGIN
    OPEN cursor1;
        LOOP
            FETCH cursor1 INTO v_nome, v_sal, v_cargo;
            EXIT WHEN cursor1%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_nome || ' - ' || v_sal || ' - ' || v_cargo);
        END LOOP;
    CLOSE cursor1;
END;

/*
2.Consultar as procedures criadas
A)OBJETOS
*/
SELECT OBJECT_NAME FROM USER_OBJECTS 
WHERE OBJECT_TYPE = 'PROCEDURE'

-- B)CODIGO
SELECT TEXT FROM USER_SOURCE WHERE NAME = 'PCR_EMP'

--3. Executar colocando como id de cargo: ST_CLERK, IT_PROG

BEGIN 
    PRC_EMP('ST_CLERK');
END;

BEGIN 
    PRC_EMP('it_prog');
END;

-- 4. Excluir a procedure criada:
DROP PROCEDURE prc_emp;


-- 5.Criar uma tabela chamada PROMOCAO:

CREATE TABLE promocao
(empno NUMBER(4),
 data  DATE,
 cargo   VARCHAR2(9),
 sal   NUMBER(7,2),
 constraint  promocao_pk PRIMARY KEY (empno, data));

/*6.Criar uma procedure prc_promocao que ao dar aumento e uma promocao ao funcionário armazene em uma tabela promocao, o salário e o cargo anterior.
*/

PROMOCAO (empno NUMBER(4), data DATE, cargo VARCHAR(2), sal NUMBER(10,2))

CREATE OR REPLACE PROCEDURE prc_promocao
(v_id IN INTEGER, v_novo_sal IN NUMBER, v_novo_cargo IN VARCHAR)
IS 
    v_salario NUMBER(10,2);
    v_cargo employees.job_id%TYPE;
BEGIN   
    SELECT salary, job_id INTO v_salario, v_cargo FROM employees
        WHERE employee_id = v_id;
    DBMS_OUTPUT.PUT_LINE('Salario anterior: ' || v_salario);
    DBMS_OUTPUT.PUT_LINE('Cargo anterior: ' || v_cargo);
    UPDATE employees
        SET salary = v_novo_sal, job_id = UPPER(v_novo_cargo)
      WHERE employee_id = v_id;
    INSERT INTO promocao
    VALUES (v_id, SYSDATE, v_cargo, v_salario);
COMMIT;
END;    

-- atualizacao do salario do empregado com id 125

BEGIN 
    PRC_PROMOCAO(125,4200,'IT_PROG');
END;

SELECT * FROM promocao;

-- 7.Criar a tabela abaixo:
CREATE TABLE folha
(id INTEGER,
 data DATE,
salbruto NUMBER(10,2),
vale NUMBER(10,2),
inss NUMBER(10,2),
comissao NUMBER(10,2),
salliq NUMBER(10,2))

--8.Criar uma procedure chamada prc_folha que insira na tabela FOLHA o id do empregado, a data atual e o salário bruto:

CREATE OR REPLACE PROCEDURE prc_folha() IS
BEGIN

	INSERT INTO FOLHA
	SELECT EMPLOYEE_ID, SYSDATE, SALARY
	FROM EMPLOYEES

	COMMIT;
END;


OPEN cursor1;
    LOOP
        FETCH cursor1 INTO v_id, v_sal;
        EXIT WHEN cursor1%NOTFOUND;
        INSERT INTO folha (id, data, salbruto)
        VALUES (v_id, SYSDATE, v_sal);
    END LOOP;
    COMMIT;
    CLOSE cursor1;
END;

BEGIN 
    PRC_FOLHA;
END; 

SELECT * FROM FOLHA

-- FUNCOES 

-- 1. Criar uma function chamada fnc_emp que entre com o id do funcionário e exiba o salário anual

CREATE OR REPLACE FUNCTION fnc_emp(v_id IN INTEGER)
RETURN NUMBER
IS 
    v_anual NUMBER(10,2);
BEGIN 
    SELECT salary * 12 INTO v_anual FROM employees
        WHERE employee_id = v_id;
    RETURN (v_anual);
END;    

--2.Consultar no dicionário de dados:

SELECT OBJECT_NAME FROM USER_OBJECTS
    WHERE OBJECT_TYPE = 'FUNCTION';

SELECT TEXT FROM USER_SOURCE WHERE NAME = 'FNC_EMP';

SELECT FNC_EMP(employee_id) FROM employees




--3.Consultar o código da function:

SELECT FNC_EMP(100) FROM DUAL;
--4. Executar a function:


--5.Excluir a function:
DROP FUNCTION fnc_emp;


CREATE FUNCTION fnc_vale (v_sal IN NUMBER)
RETURN NUMBER
IS
BEGIN 
    RETURN(v_sal*0.06);
END;    

SELECT employee_id, fnc_vale(salary)
    FROM employees 
    WHERE departament_id < 30;

SELECT fnc_vale(8700) FROM DUAL
