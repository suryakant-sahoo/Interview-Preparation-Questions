/*SQL Questions Preparation for Interviews*/

/*Give departments where employee status is active and have more than 10 employees*/
select 
department , 
count(*) as employee_count
from employees
where 
status = 'Active'
group by department
having count(*) > 10;


