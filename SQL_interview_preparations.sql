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


/*Find employees who department contains Engineering*/
select *
from employees
where department LIKE '%Engineering%';

/*Categorize based on status*/
select 
employee_id, status ,
Case 
when status = 'Active' then 'Working'
when status = 'Inactive' then 'Not working'
else 'Unknown'
end as category
from employees;

/*Count of total employees*/
select
count(*) as total_employees
from employees;

/*count distinct location*/
select count(distinct location) as location_count
from employees;

/*count employees by department*/
select 
count(*) as employees_count,
department
from employees
group by department;

/*Find department with having more than 20 employees*/
select
count(*) as employees_count,
department
from employees
group by department
having count(*) > 20;

/*Calculate average productivity by department*/
select 
e.department,
avg(p.productivty) as avg_productivity
from employees e 
join productivity 
on 
e.employee_id = p.employee_id
group by e.department;

/*Calcuate achievmeent percentage against target*/
select
kpi_name,
sum(actual_value) as actual,
sum(target_value) as target,
sum(actual_value) / nullif(sum(target_value)) * 100 as achievment_percentage
from kpi_metrics;

/*Count High severity incidents and total incidents*/
Select 
count(*) as total_icidents,
sum(case 
when severity = 'High' then 1 else 0 end) as hihg_severity_incidents
from incidents;

/*Calculate average productivity and utilization by department.*/

select
department,
avg(p.productivity) as avg_productivity,
avg(utilization) as avg_utilization
from employees e
join productivity p
on
e.employee_id = p.employee_id
group by e,department;

/*Get employee details and their performance*/
SELECT
    e.employee_id,
    e.department,
    p.report_date,
    p.productivity
FROM employees e
INNER JOIN performance p
    ON e.employee_id = p.employee_id;
    
    
/*Find employees who dont have performance records*/
select
e.employee_id,
p.productivity,
e.department
from employees e
left join productivity p
on e.employee_id = p.employee_id
where p.employee_id is null;

/*Identify records existing in one dataset but not the other.*/
select
e.employee_id,
p.employee_id
from employees e
full outer join performance p
on e.employee_id = p.employee_id
where
e.employee_id is null
p.employee_id is null;

/*Find employees working in same department - use Self Join*/

select 
e1.employee_id,
e2.employee_id,
e1.department
from employees e1
join employees e2
on
e1.department = e2.department
where
e1.employee_id <> e2.employee_id;

/*Employees above average productivity*/
select *
from employees 
where productivity >
(select avg(productivity) from performance);

/*Departments with above-average employee count*/

with cte as
(select
department,
count(*) as total_employee_count
from employees
group by department)
select
department , 
total_employee_count
from cte where
total_employee_count > (select avg(total_employee_count) from cte);

/*Employees with at least one incident*/
select
e.employee_id
from employees e
where exists (select 1 from incodents i where e.employee_id = i.employee_id);


/*employee with no incident*/
select
e.employee_id,
i.incident_id
from employees e
where not exists 
(select 1 from incidents i where e.employee_id = i.employee_id);

/*Calculate department performance adn then filter it*/

with cte as (
select
e.department,
avg(p.productivity) as avg_productivity
from employees e
join performance p
on e.employee_id = p.employee_id
group by department)

select avg_productivity
from cte where avg_productivity > 80;

/*Calculate total incidents and high-severity incidents by department.*/
select
e.department,
count(*) as total_incidents,
sum( case when i.severity = 'High' then 1 else 0 end) as high_severity_incidents
from employees e join incidents i on e.employee_id = i.employee_id
group by department;

/*Give each employee's performance records a sequence number.*/
select
employee_id,
productivity,
report_date,
row_number() over (partition by employee_id order by report_date desc) as rn
from performance;

/*Find latest record per employee*/

with cte as 
(select
employee_id,
joining_date,
row_number() over (partition by employee_id order by joining_date desc) as rn
from employees)
select * from cte
where rn = 1;

/*Rank departments based on productivity*/

select 
e.department,
sum(p.productivity) as total_prod,
dense_rank() over (partition by e.department order by sum(p.productivity) desc) as rn
from employees e join performance p on e.employee_id = p.employee_id
group by department;




