--CONSULTA 1
--Show id of the project, code of the project and the number of employees associated to each
--project (number_of_employees) order by number_of_employees descending
select pro.id, pro.code, count(assi.employee_id) as cantidad
from projects pro inner join assignments assi on (pro.id = assi.project_id)
group by pro.id, pro.code
order by count(assi.employee_id) desc;

--CONSULTA 2
--Show the id, name and last name of the employees associated to the project with code
--"d1373b16-b953-48ab-82b0-23ae2c7e4670" (One query)
select emp.id, emp.name, emp.last_name
from employees emp inner join assignments assi on (emp.id = assi.employee_id)
                   inner join projects pro on (assi.project_id = pro.id)
where pro.code = 'd1373b16-b953-48ab-82b0-23ae2c7e4670';

--CONSULTA 3
--Write a SQL query to fetch employee names (one column, don't change the alias) having salary
--greater than or equal to 80000 and less than or equal 120000
select name
from employees
where salary between 80000 and 120000;

--CONSULTA 4
--Write a SQL query to fetch all the Employees who are assigned to any project as managers.
--name and last name should be displayed in one single column named "full_name", don't
--duplicate names.
select emp.name || ' ' || emp.last_name as full_name
from employees emp inner join projects pro on (emp.id = pro.manager_id)
group by emp.id, emp.name, emp.last_name;

--CONSULTA 5
--Write a SQL query to fetch each employee with the name of his/her boss in one column named
--"employee_boss" separated by ' - ' (don't forget the spaces). Example: "Drew Rosario - Holmes
--Manning", "Emery Kelley - Holmes Manning" (employee name - manager name)
select emp.name || ' ' || emp.last_name || ' - ' || boss.name || ' ' || boss.last_name as employee_boss
from employees emp inner join employees boss on (emp.manager_id = boss.id);

--CONSULTA 6
--Write a SQL query to fecth the id, name, last name, date_of_joining and employees_in_charge
--(employees_in_charge is the counter of employees for whom each boss is in charge). You
--should order the results by the oldest employee in the company.
select boss.id, boss.name, boss.last_name, boss.date_of_joining, count(emp.manager_id) as cantidad
from employees boss inner join employees emp on (boss.id = emp.manager_id)
group by boss.id, boss.name, boss.last_name, boss.date_of_joining
order by boss.date_of_joining asc;

