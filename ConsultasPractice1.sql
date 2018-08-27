select projects.id, projects.code, employees.name from employees, projects where employees.id = projects.manager_id;

select projects.id, projects.code from assignments inner join projects on assignments.id = projects.manager_id;

