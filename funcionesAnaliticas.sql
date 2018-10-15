select id, first_name, last_name, salary, department, 
count(*) over (PARTITION by 
department) department_count
from salaries 
order by department;

select salary,
round(avg(salary) over (PARTITION by
department), 3) salary_average
from salaries
where salary <= 150
order by department;