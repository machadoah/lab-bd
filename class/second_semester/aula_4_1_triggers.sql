
/*
    Triggers 🐯

    disparada antes ou depois de um evendo dml (CRUD), SERVE PARA TABELAS E VIEWS;

    não possui COMMIT ou ROLLBACK

    pode ser de dois tipos:
    instrução ou linha
    possui alguns qualificadores
    digo a coluna que posso atualizar

*/
/*
1.Criar um gatilho TG_GATILHO para restringir as inserções na tabela EMPLOYEES a determinado horário comercial de segunda a sexta-feira das 8h às 18h. Se um usuário tentar inserir no sábado ou fora do horário,  o gatilho falhará e a instrução sofre rollback.

*/

CREATE OR REPLACE TRIGGER td_gatilho
BEFORE INSERT ON EMPLOYEES
BEGIN
    IF(TO_CHAR(sysdate, 'DY') IN ('SAB', 'DOM'))OR 
    (TO_CHAR(sysdate, 'HH24') NOT BETWEEN '08' AND '18') THEN
    RAISE_APPLICATION_ERROR
    (-20500, 'Somente permitido no horario das 8h as 18h.');
    END IF;
END;

INSERT INTO EMPLOYEES (employee_id, last_name, email, hire_date, job_id) VALUES (900, 'Romano','romano@exemple.com', SYSDATE, 'IT PROG')
SELECT * FROM EMPLOYEES WHERE employee_id = 900;

-- DESABILITANDO TRIGGER

ALTER TRIGGER td_gatilho DISABLE;

-- Mostrando usuario adicionado 

SELECT * FROM EMPLOYEES WHERE employee_id = 900;

-- HABILITANDO TRIGGER

ALTER TRIGGER td_gatilho ENABLE;

-- Outro 

INSERT INTO EMPLOYEES (employee_id, last_name, email, hire_date, job_id) VALUES (800, 'Henrique','henrique@exemple.com', SYSDATE, 'IT PROG')

ALTER TRIGGER td_gatilho DISABLE;

SELECT * FROM EMPLOYEES WHERE employee_id = 800;

ALTER TRIGGER td_gatilho ENABLE;


SELECT TRIGGER_NAME, TRIGGER_TYPE, TABLE_NAME, COLUMN_NAME FROM USER_TRIGGERS

SELECT TEXT FROM USER_SOURCE WHERE NAME = 'TG_GATILHO' -- tem que colocar maiusculo

DROP TRIGGER td_gatilho

-- trigger de linha -> compara todas as situçoes (registros)

/*2)Crie um gatilho TG_VERIFICA para permitir que somente determinados funcionarios possam receber salários abaixo de 10000. Se um usuario tentar fazer isto, o gatilho gera um erro.
*/

CREATE OR REPLACE TRIGGER TG_VERIFICA
BEFORE INSERT OR UPDATE OF salary ON employees
FOR EACH ROW
BEGIN
    IF NOT (:NEW.JOB_ID IN ('ST_CLERK', 'IT_PROG'))
    AND :NEW.SALARY<10000 THEN 
    RAISE_APPLICATION_ERROR(-20202, 'Este empregado nao pode ter este salario');
    END IF;
END;

-- criação de tabela

CREATE TABLE auditoria
(usuario varchar2(50),
 data      date,
 nome_antigo varchar2(50),
 nome_novo varchar2(50),
 cargo_antigo varchar2(30),
 cargo_novo varchar2(30),
 salario_antigo number(7,2),
 salario_novo number(7,2));

-- Testando

SELECT * FROM employees WHERE employee_id = 201

UPDATE employees SET salary = 500 WHERE employee_id = 201;

UPDATE employees SET salary = 15000 WHERE employee_id = 201;

DROP TRIGGER tg_verifica;

/*
3.Criar um gatilho TG_AUDITORIA na tabela EMPLOYEES para adicionar linhas a uma tabela de usuário AUDITORIA, fazendo log da atividade com a tabela EMPLOYEES. O gatilho registra os valores de diversas
colunas antes e depois das alterações de dados, usando os
qualificadores OLD e NEW com o respectivo nome de coluna.
*/

CREATE OR REPLACE TRIGGER TG_AUDITORIA
    AFTER DELETE OR INSERT OR UPDATE ON employees
    FOR EACH ROW
BEGIN
    INSERT INTO auditoria
    VALUES (USER, SYSDATE,:OLD.first_name, :NEW.first_name,:OLD.job_id,:NEW.job_id,:OLD.salary,:NEW.salary);
END;

/*
Testar:
Atualizar o salario do empregado com id 123 para que tenha 50% de aumento.*/

UPDATE EMPLOYEES SET SALARY = SALARY * 1.50
WHERE EMPLOYEE_ID = 123

--Consultar a tabela AUDITORIA
SELECT * FROM auditoria

--Consultar a tabela EMPLOYEES
SELECT * FROM employees WHERE EMPLOYEE_ID = 123
 

