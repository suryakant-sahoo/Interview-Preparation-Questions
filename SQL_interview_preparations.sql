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

/*How would ypu check NULL using SQL*/
SELECT
    COUNT(*) AS total_records,
    SUM(CASE WHEN employee_id IS NULL THEN 1 ELSE 0 END) AS missing_employee_id,
    SUM(CASE WHEN department IS NULL THEN 1 ELSE 0 END) AS missing_department
FROM employee_data;



-----------------------------------------------------/*50 Interview SQL Questions*/---------------------------------------------------------------

--Sample tables
1.employees(employee_id, department, location, status, joining_date)
2.incidents(incident_id, employee_id, incident_date, incident_type, severity, location, status)
3.performance(employee_id, report_date, productivity, utilization, aht, target)
4.sales(employee_id, sale_date, revenue, region, product)
5.kpi_metrics(kpi_id, kpi_name, actual_value, target_value, metric_date, department)
6.employees_history(employee_id, department, status, effective_date, updated_date)

/*Get employee ID, department and location for all employees.*/
select employee_ID,
department , 
location
from employees;

/*find active employees*/
select *
from employees
where
status = 'Active';

/*Find Active employees in Hyderabad*/
select *
from employees
where
status = 'Active' and location = 'Hyderabad';

/*Find incidents between Jan 2026 and March 2026*/
select *
from incidents
where incident_date between '01-01-2026' and '01-03-2026';

/*Find employees from Hyderabd , Bangalore or Chennai*/
select *
from employees 
where 
location in ('Hyderabda','Bangalore','Chennai');


