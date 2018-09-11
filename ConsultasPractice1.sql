--Mostrar la identificación del proyecto, el código del proyecto y la cantidad de empleados asociados a cada uno
--proyecto (number_of_employees) orden por (number_of_employees) descendente.

select assignments.project_id, projects.code, count(assignments.employee_id) as cantidad
from assignments 
inner join projects 
on projects.id = assignments.project_id
GROUP BY project_id, assignments.project_id, projects.code
order by count(assignments.employee_id) desc;

--Mostrar la identificación, el nombre y el apellido de los empleados asociados al proyecto con el código
--"d1373b16-b953-48ab-82b0-23ae2c7e4670" (Una consulta)

select employees.id, employees.name, employees.last_name 
from employees
inner join assignments on employees.id = assignments.employee_id
inner join projects on assignments.project_id = projects.id
where projects.code = 'd1373b16-b953-48ab-82b0-23ae2c7e4670';

--Escribir una consulta SQL para buscar nombres de empleados (una columna, no cambiar el alias) con salario
--mayor o igual a 80000 y menor o igual a 120000.

select name 
from employees
where salary between 80000 and 120000;

--Escriba una consulta SQL para buscar a todos los empleados asignados a cualquier proyecto como administradores.
--nombre y apellido deben mostrarse en una sola columna llamada "full_name", no nombres duplicados

select name || ' ' || last_name as full_name
from employees;

