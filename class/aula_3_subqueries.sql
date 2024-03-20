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

-- 😢AVANÇADAS (EMPARELHADAS!)

/*
EMPARELHADA: CONSULTAS COM VÁRIAS COLUNAS 
Exibir o id do empregado, do gerente e do depto. que são gerenciados pelo 
MESMO gerente do MESMO depto. que os funcionários com matrícula 174 ou 178:
*/

SELECT employee_id, manager_id, department_id 
    FROM employees
WHERE (manager_id, department_id) IN (SELECT manager_id, department_id
                                        FROM employees
                                    WHERE employee_id IN (174, 178))

/*
Alterar a query:
acrescentar mais uma linha na query anterior para excluir o id 174 e 178
*/

SELECT employee_id, manager_id, department_id 
    FROM employees
WHERE (manager_id, department_id) IN (SELECT manager_id, department_id
                                        FROM employees
                                    WHERE employee_id IN (174, 178))
AND employee_id NOT IN (174, 178)

/*
ESCALAR E CORRELACIONADA
SUBCONSULTA NA CLÁUSULA FROM (VIEW DE LINHA)
Exibir o sobrenome, o salário, o id do depto e 
a média (salário médio do empregado dentro do seu depto.) 
de quem ganha mais que a média no seu depto.
*/

-- maneira 1:

SELECT e.last_name, e.salary, e.department_id, media
    FROM employees e, 
    (SELECT department_id, AVG(salary) media 
        FROM employees
    GROUP BY department_id) m
    WHERE e.department_id = m.department_id
    AND e.salary > m.media

-- maneira 2:

SELECT 
    EMP.LAST_NAME, 
    EMP.SALARY, 
    EMP.DEPARTMENT_ID,
    EMP_AVG.SALARY
FROM EMPLOYEES EMP
    JOIN (
        SELECT AVG(SALARY) SALARY, DEPARTMENT_ID
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID
    ) EMP_AVG ON EMP_AVG.DEPARTMENT_ID = EMP.DEPARTMENT_ID
WHERE EMP.SALARY > EMP_AVG.SALARY

/*
SUBCONSULTA CORRELACIONADA: 
INSERT, UPDATE, DELETE OU SELECT
DESNORMALIZAÇÃO: ACRESCENTAR A COLUNA 
DEPARTAMENT_NAME VARCHAR(30) NA TABELA EMPLOYEES:
*/

ALTER TABLE employees ADD department_name VARCHAR(30);

DESC employees

-- Atualizar a coluna department_name com o nome do departamento de 
-- acordo com o id do depto. onde o empregado está alocado:

UPDATE employees e SET department_name = (SELECT department_name 
                                            FROM departments d
                                        WHERE e.department_id = d.department_id)

-- a)Consultar os registros da tabela EMPLOYEES
SELECT * FROM employees

-- b)Excluir a coluna department_name da tabela EMPLOYEES
ALTER TABLE employees DROP COLUMN department_name

/*
OPERADOR EXISTS OU NOT EXISTS (FLAG - TRUE OU FALSE)
Exibir as pessoas que tem pelo menos um subordinado.
Obs. 
Podemos usar LITERAL PORQUE NÃO PRECISA COMPARAR COLUNA
Semelhante aos operadores IN e NOT IN
*/

-- Exibir as pessoas que tem pelo menos um subordinado:

SELECT last_name, job_id
    FROM employees e
    WHERE EXISTS (SELECT 'X' FROM employees
                WHERE manager_id = e.employee_id)

-- EXIBIR AS PESSOAS QUE NÃO TEM SUBORDINADO.

SELECT last_name, job_id
    FROM employees e
    WHERE NOT EXISTS (SELECT 'X' FROM employees
                WHERE manager_id = e.employee_id)

/*
1.Crie uma consulta para exibir o sobrenome e a data de admissão de todos 
os funcionários no mesmo departamento do funcionário com sobrenome Zlotkey. 
Exclua Zlotkey. FILEIRA 1

2.Cria uma consulta para exibir o número e o nome de todos os funcionários 
que recebam mais que o salário médio. Classifique os resultados, por salário, 
em ordem decrescente. FILEIRA 3

3.Exiba o sobrenome do funcionário, o número do departamento e o cargo 
de todos os funcionários cuja localização do departamento seja 1700. FILEIRA 2

4. Exiba o sobrenome e o salário dos funcionários que se reportam a King. FILEIRA 4

5. Exibir o nome do departamento somente quando o menor salario for maior que o do 
depto. 50. FILEIRA 5

6.Exibir todos os funcionarios que nao tenham NENHUM SUBORDINADO, 
utilizando subquerie (utilizar NOT IN) FILEIRA 3

7.Exibir id, nome, nome do departamento de quem tem o mesmo carg 
*/

-- RECUPERAÇÃO HIERÁRQUICA
-- Obs. só tem no Oracle

/*
Recuperar dados baseados em uma hierarquia.
- LEVEL             -   nível de raiz (retorna 1 para o primeiro nível, 2 para o segundo e assim por diante
- START WITH        -   condição inicial da hierarquia
- CONNECT BY PRIOR  -   join hierarquico
*/

/*
Exibir o id do empregado, o sobrenome, o id do cargo e o id do 
gerente iniciando pelo empregado com id 101
*/

-- a)Baixo para Cima

SELECT employee_id, last_name, job_id, manager_id
    FROM employees
CONNECT BY PRIOR manager_id = employee_id
START WITH employee_id = 101

-- b)Alto para Cima

SELECT employee_id, last_name, job_id, manager_id
    FROM employees
CONNECT BY PRIOR employee_id = manager_id
START WITH employee_id = 101

-- Exibir os subordinados ao Kochhar, eliminando UM funcionario: Higgins:

SELECT employee_id, last_name, job_id, manager_id
    FROM employees
WHERE last_name != 'Higgins'
START WITH last_name = 'Kochhar'
CONNECT BY PRIOR employee_id = manager_id

SELECT employee_id, last_name, job_id, manager_id
    FROM employees
START WITH last_name = 'Kochhar'
CONNECT BY PRIOR employee_id = manager_id
AND last_name != 'Higgins'

/*
Exibir o sobrenome dos empregados em uma árvore hierárquica
FUNÇÕES
A) LPAD(COLUNA,TAMANHO,CARACTERE) - LEFT (FUNÇÃO DE LINHA EM BANCO DE DADOS)
B) LENGTH (COLUNA) - QTDE DE CARACTERES DE UMA COLUNA
C) LEVEL - MOSTRA O NÍVEL HIERÁRQUICO (RAIZ 1, 2...)
*/

SELECT LPAD(last_name, LENGTH(last_name)+(LEVEL*2)-2, '-') "Arvore"
    FROM employees
    START WITH last_name = 'King'
    CONNECT BY PRIOR employee_id = manager_id