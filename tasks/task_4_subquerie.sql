
-- 1.Crie uma consulta para exibir o sobrenome e a data de admissão de todos os funcionários no mesmo departamento do funcionário com sobrenome Zlotkey. Exclua Zlotkey. FILEIRA 1

SELECT last_name, hire_date
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    WHERE last_name = 'Zlotkey'
)
AND last_name != 'Zlotkey';

-- 2.Cria uma consulta para exibir o número e o nome de todos os funcionários que recebam mais que o salário médio. Classifique os resultados, por salário, em ordem decrescente. FILEIRA 3

SELECT employee_id, last_name
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;

-- 3.Exiba o sobrenome do funcionário, o número do departamento e o cargo de todos os funcionários cuja localização do departamento seja 1700. FILEIRA 2

SELECT e.last_name, e.department_id, e.job_id
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.location_id = 1700;

-- 4. Exiba o sobrenome e o salário dos funcionários que se reportam a King. FILEIRA 4

SELECT e.last_name, e.salary
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE m.last_name = 'King';

-- 5. Exibir o nome do departamento somente quando o menor salario for maior que o do depto. 50. FILEIRA 5

SELECT department_name
FROM departments
WHERE (SELECT MIN(salary) FROM employees WHERE department_id = departments.department_id) > (
    SELECT MAX(salary) FROM employees WHERE department_id = 50
);

-- 6.Exibir todos os funcionarios que nao tenham NENHUM SUBORDINADO, utilizando subquerie (utilizar NOT IN) FILEIRA 3

SELECT employee_id, last_name
FROM employees
WHERE employee_id NOT IN (
    SELECT manager_id
    FROM employees
    WHERE manager_id IS NOT NULL
);

-- 7.Exibir id, nome, nome do departamento de quem tem o mesmo cargo do empregado com id 167. FILEIRA 4

SELECT e.employee_id, e.last_name, e.job_id
FROM employees e
WHERE e.job_id = (
    SELECT job_id
    FROM employees
    WHERE employee_id = 167
);

-- 8. Com subquerie, exibir os deptos que nao tem funcionario. FILEIRA 2

SELECT department_id, department_name
FROM departments
WHERE department_id NOT IN (
    SELECT department_id
    FROM employees
);

-- duvida (todos departamentos possui funcionarios)

SELECT department_id, COUNT(employee_id)
FROM employees
GROUP BY department_id;
