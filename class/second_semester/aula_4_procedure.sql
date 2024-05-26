--- FUNCAO DENTRO DE UMA PROCEDURE 

/*
1. Criar uma procedure chamada prc_emp que entre com o id do depto. e
exiba o nome dos funcionários, o salário e o vale transporte.
Obs. chamar a funcao fnc_vale na procedure
*/

CREATE OR REPLACE PROCEDURE prc_emp(v_id INTEGER)
IS
v_nome employees.first_name%TYPE;
v_sal employees.salary%TYPE;
v_vale NUMBER(10,2);
CURSOR cursor1 IS
SELECT first_name, salary FROM employees WHERE department_id = v_id;
BEGIN 
    OPEN cursor1;
        LOOP 
            FETCH cursor1 INTO v_nome, v_sal;
            EXIT WHEN cursor1%NOTFOUND;
            v_vale :=fnc_vale(v_sal);
            DBMS_OUTPUT.PUT_LINE('NOME ' || v_nome);
            DBMS_OUTPUT.PUT_LINE('SALARIO ' || v_sal);
            DBMS_OUTPUT.PUT_LINE('VALE TRANSPORTE ' || v_vale);
            DBMS_OUTPUT.PUT_LINE('****************');
        END LOOP;
    CLOSE cursor1;
END;


--A)Consultar todos os objetos do tipo FUNCTION ou PROCEDURES:
SELECT OBJECT_NAME OBJECT_TYPE FROM USER_OBJECTS
WHERE OBJECT_TYPE IN ('FUNCTION', 'PROCEDURE')

--B)Para executar:
BEGIN 
    PRC_EMP(60);
END;    

--C)Consultar o código da procedure criada:

SELECT TEXT FROM USER_SOURCE WHERE NAME = 'PRC_EMP'

-- PACKAGES

--1)a) criacao da especificacao(pacote) - não aceita create dentro de create

/*
Quando pedir o body é necessario fazer o head ANTES;
É possivel criar só o head
corpo e cabeçalho dvem ser compativeis, 
head só aceita procedure
body aceita funcao a funcao pega carona com alguma

CURSOR -> usar quando nao sei quantos registros vou retornar
*/

/*
1) Criar um pacote chamado pk_emp que tenha:
a)procedure prc_empregado que entre com o id do empregado e exiba o nome e o  titulo do cargo;
b)procedure prc_depto que informe o id do depto e traga o sobrenome, salário e o valor de comissão.
c)function fnc_com que de acordo com o salario e o percentual de comissao retorne o valor de comissão a receber:
PASSOS:

*/

CREATE OR REPLACE PACKAGE pk_emp
IS 
    PROCEDURE prc_empregado(v_id IN INTEGER);
    PROCEDURE prc_depto(v_depto IN departments.department_id%TYPE);
END;

-- b)
CREATE OR REPLACE PACKAGE BODY pk_emp
IS 
    FUNCTION fnc_com(v_sal IN NUMBER, v_percentual IN NUMBER)
    RETURN NUMBER
    IS
        v_comissao NUMBER;
        BEGIN  
            v_comissao := v_sal * NVL(v_percentual,0);
            RETURN (v_comissao);
        END fnc_com;   
        PROCEDURE prc_empregado(v_id IN INTEGER)
        IS  
            v_nome VARCHAR2(30);
            v_cargo VARCHAR2(40);
        BEGIN    
            SELECT e.first_name, j.job_title
            INTO  v_nome, v_cargo
            FROM employees e
            JOIN jobs j ON  e.job_id = j.job_id
            WHERE e.employee_id = v_id;
                DBMS_OUTPUT.PUT_LINE(v_nome || '-'|| v_cargo);
        END prc_empregado;
        PROCEDURE prc_depto(v_depto IN departments.department_id%TYPE)
        IS
            v_sobre employees.last_name%TYPE;
            v_sal NUMBER(8,2);
            v_com NUMBER(8,2);
            v_perc NUMBER(8,2);
            CURSOR cursor1 IS
                SELECT last_name, salary, commission_pct
                FROM employees
                WHERE department_id = v_depto;
BEGIN   
    OPEN cursor1;
    LOOP
        FETCH cursor1 INTO v_sobre, v_sal, v_perc;
        EXIT WHEN cursor1%NOTFOUND;
        v_com := fnc_com (v_sal, v_perc);
        DBMS_OUTPUT.PUT_LINE(v_sobre || ' - Salario: ' || v_sal || ' - Comissao: '|| v_com);
        END LOOP;
        CLOSE cursor1;
        END prc_depto;
    END pk_emp;

DESC pk_emp    

BEGIN 
    pk_emp.prc_empregado(100);
END;    

BEGIN 
    pk_emp.prc_depto(80);
END; 

SELECT OBJECT_NAME, OBJECT_TYPE
FROM USER_OBJECTS WHERE OBJECT_TYPE = 'PACKAGE'

SELECT TEXT FROM USER_SOURCE WHERE NAME = 'PK_EMP'

