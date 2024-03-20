-- aula 3 : subqueries
-- 19 / 03 / 2024

/*
Exibir o sobrenome e o salário de quem ganha mais que o Abel
a)Quanto Abel ganha?
*/

SELECT salary 
    FROM employees 
WHERE last_name = 'Abel'

SELECT last_name, salary
    FROM employees
WHERE salary > (SELECT salary FROM employees 
WHERE last_name = 'Abel')

-- b) atualizar salário do Abel para 18000

UPDATE employees SET salary = 18000 WHERE last_name = 'Abel'

SELECT last_name, salary
    FROM employees
WHERE salary > (SELECT salary FROM employees 
WHERE last_name = 'Abel')

/*
Exibir o sobrenome e o id do cargo dos empregados que 
possuem o MESMO CARGO (=) que o empregado com id 141 
(last_name, job_id, employee_id na EMPLOYEES):
*/

DESC employees

SELECT last_name, job_id
    FROM employees
WHERE job_id = (SELECT job_id FROM employees 
WHERE employee_id = 141)

/*
Exibir o sobrenome, o id do cargo e o salario de 
quem tem o mesmo cargo do empregado com id 141 e o 
salario maior que o do empregado com id 143
*/

SELECT last_name, job_id, salary
    FROM employees
WHERE job_id = (SELECT job_id FROM employees  WHERE employee_id = 141)
AND salary > (SELECT salary FROM employees  WHERE employee_id = 143) 

/*
SUBCONSULTAS TAMBÉM PODEM SER USADAS COM FUNÇÕES DE GRUPO E JUNÇÃO DE TABELAS

Exibir o sobrenome, o título do cargo e o salário dos 
empregados que recebem o salário mínimo da empresa.
*/

-- a) descobrir qual o salario minímo? MIN

SELECT MIN(salary) "Salário minimo" FROM employees

-- continuação

SELECT last_name, job_title, salary FROM employees, jobs
WHERE salary = (SELECT MIN(salary) "Salário minimo" FROM employees)
AND jobs.job_id = employees.job_id

/*
Exibir o id do cargo e a média salarial somente de quem ganha 
igual ao menor salário médio da empresa
*/

-- a)Qual é a média salarial POR cargo na empresa? AVG

SELECT AVG(salary) FROM employees

SELECT job_id, AVG(salary) 
    FROM employees
GROUP BY job_id
ORDER BY 2

-- qual é o menor valor médio
-- |    PU_CLERK    |	2780    |

SELECT job_id, AVG(salary) 
    FROM employees
GROUP BY job_id
HAVING AVG(salary) = (SELECT MIN(AVG(salary)) FROM employees GROUP BY job_id)


/*
--
OPERADORES QUE RETORNAM MAIS DE UM REGISTRO
MAIS DE UM REGISTRO 
(OPERADORES: IN, <ANY, >ANY, <ALL, >ALL)
  <ANY - menos que o máximo
      >ANY - mais que o mínimo
      >ALL - mais que o máximo
      <ALL - menos que o mínimo
       IN - conjunto de valores 
Exemplo: ORACLE = {10,20,30}
--
*/

/*
Exibir o nome, o salário e o id do depto. 
dos empregados que ganham salário mínimo, independente do depto. (IN)
*/

-- a)Qual o menor salário por depto.

SELECT department_id, MIN(salary) FROM employees GROUP BY department_id  
SELECT MIN(salary) FROM employees GROUP BY department_id  

SELECT first_name, salary, department_id FROM employees
    WHERE salary IN (SELECT MIN(salary) FROM employees GROUP BY department_id )
ORDER BY salary desc

/*
Exibir o id do  empregado, o sobrenome, o id do cargo e o salario 
dos funcionários que ganham menos que o maior salário do empregado 
com id de programador (IT_PROG) e que não tenha esta função na empresa
*/

-- a)Quais sao os salarios de programadores de TI na empresa?

SELECT salary FROM employees WHERE job_id = 'IT_PROG'

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY (SELECT salary FROM employees WHERE job_id = 'IT_PROG')
AND job_id != 'IT_PROG'

/*
Alterar o exercicio anterior, para exibir os funcionários com 
salário menor que o menor salário de todos os funcionários que 
são programadores e que o cargo não seja programador.
*/

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ALL (SELECT salary FROM employees WHERE job_id = 'IT_PROG')
AND job_id != 'IT_PROG'