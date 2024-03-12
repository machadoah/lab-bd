-- 1) Crie uma consulta para exibir o sobrenome do funcionário, sua matrícula e o nome do departamento que ele está alocado.

SELECT e.LAST_NAME AS "Sobrenome",
       e.EMPLOYEE_ID AS "Matrícula",
       d.DEPARTMENT_NAME AS "Departamento"
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- 2) Crie uma lista única de todos os cargos existentes no departamento 80. Inclua a localização deste departamento.

SELECT DISTINCT j.JOB_TITLE AS Cargo,
                l.CITY AS Cidade,
                l.STATE_PROVINCE AS Estado
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID
JOIN JOBS j ON e.JOB_ID = j.JOB_ID
WHERE d.DEPARTMENT_ID = 80;

-- 3) Crie uma consulta para exibir o sobrenome do funcionário, o nome do departamento, a localização e a cidade de todos os funcionários que recebem comissão.

SELECT e.LAST_NAME AS Sobrenome,
       d.DEPARTMENT_NAME AS Departamento,
       l.STREET_ADDRESS AS "Endereço",
       l.CITY AS Cidade
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID
WHERE e.COMMISSION_PCT IS NOT NULL;


-- 4) Exiba o sobrenome do funcionário e o nome do departamento para todos os funcionários que possuem um a em seus sobrenomes.

SELECT e.LAST_NAME AS Sobrenome,
       d.DEPARTMENT_NAME AS Departamento
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE e.LAST_NAME LIKE '%a%';

-- 5) Crie uma consulta para exibir o sobrenome, o cargo, o número e o nome do departamento para todos os funcionários que trabalham em Toronto.

SELECT e.LAST_NAME AS Sobrenome,
       e.JOB_ID AS Cargo,
       e.EMPLOYEE_ID AS Numero,
       d.DEPARTMENT_NAME AS Departamento
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID
WHERE l.CITY = 'Toronto';

-- 6) Exiba o sobrenome e o número do funcionário junto com o sobrenome e o número do gerente. Coloque um label ou apelido nas colunas. 

SELECT 
    e1.LAST_NAME AS Sobrenome_Funcionario,
    e1.EMPLOYEE_ID AS Numero_Funcionario,
    e2.LAST_NAME AS Sobrenome_Gerente,
    e2.EMPLOYEE_ID AS Numero_Gerente
FROM 
    EMPLOYEES e1
JOIN 
    EMPLOYEES e2 ON e1.MANAGER_ID = e2.EMPLOYEE_ID;

-- 7) Exibir todos os funcionários incluindo King, que não tem gerente.
-- obs: Exibir todos os funcionários que possuem "King" no nome, que não tem gerente.
SELECT 
    e1.LAST_NAME AS Sobrenome_Funcionario,
    e1.EMPLOYEE_ID AS Numero_Funcionario
FROM 
    EMPLOYEES e1
LEFT JOIN 
    EMPLOYEES e2 ON e1.MANAGER_ID = e2.EMPLOYEE_ID
WHERE 
    e1.LAST_NAME LIKE '%King%' AND e1.MANAGER_ID IS NULL;

-- 8) Crie uma consulta que exibirá o sobrenome dos funcionários, o número do departamento e todos os funcionários que trabalham no mesmo departamento de um determinado funcionário. Forneça a cada coluna um label apropriado.

-- a) The maximum result size reached.

SELECT 
    e1.LAST_NAME AS Sobrenome_Funcionario,
    e1.DEPARTMENT_ID AS Numero_Departamento,
    e2.LAST_NAME AS Sobrenome_Colega,
    e2.EMPLOYEE_ID AS Numero_Colega
FROM 
    EMPLOYEES e1
JOIN 
    EMPLOYEES e2 ON e1.DEPARTMENT_ID = e2.DEPARTMENT_ID
WHERE 
    e1.EMPLOYEE_ID <> e2.EMPLOYEE_ID;

-- 9) Crie uma consulta que exiba o sobrenome, o cargo, o nome do departamento, o salário e a faixa salarial. DICA: utilize a tabela JOBS.

SELECT 
    e.LAST_NAME AS Sobrenome,
    j.JOB_TITLE AS Cargo,
    d.DEPARTMENT_NAME AS Departamento,
    e.SALARY AS Salario,
    j.MIN_SALARY || ' - ' || j.MAX_SALARY AS Faixa_Salarial
FROM 
    EMPLOYEES e
JOIN 
    JOBS j ON e.JOB_ID = j.JOB_ID
JOIN 
    DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- 10) Crie uma consulta para exibir o sobrenome e a data de admissão de qualquer funcionário admitido após o funcionário Davies

SELECT 
    LAST_NAME AS Sobrenome,
    HIRE_DATE AS Data_Admissao
FROM 
    EMPLOYEES
WHERE 
    HIRE_DATE > (SELECT HIRE_DATE FROM EMPLOYEES WHERE LAST_NAME = 'Davies');
