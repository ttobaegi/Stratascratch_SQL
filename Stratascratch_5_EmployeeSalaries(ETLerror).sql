-- Q5.  Employee Salaries (ETL Error)
-- Due to an ETL eror : instead of updating the salaries of employees, did an insert for some emploeyees  > Duplicates employees but different salaries
-- Assuming the salaries increase every year 
-- find the current salary for each employee

select 
	id
    , first_name
    , last_name
    , department_id
    , max(salary) as current_salary 
from ms_employee_salary
group by 1,2,3,4
order by id asc;

