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

/*"Using a subquery, identify the rows in the Students table that have no matching records in the Enrollments table."*/
Select
s.student_id , s.student_name
from students s
where not exists
(select 1 from enrollment e
where s.student_id = e.student_id);

/*How would you find the latest record of each employess/customer*/

with cte as 
(select
*,
row_number() over (partition by employee order by update_date desc) as rn
from employees)
select * from 
cte where rn = 1;


