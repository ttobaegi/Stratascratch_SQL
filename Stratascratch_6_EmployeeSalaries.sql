-- Q6. Employee Salaries
-- top 3 departments by the highest percentage of employees making over 100,000$ salary at least 10 employees
-- Department name, Percentage of employees
-- Order by percentage desc

/** DEVELOPING THE SOLUTION FRAMEWORK 
1. Identify employees making over $100k in salary 
2. Map the employee to department name using left join > numerator 
3. Map all employees with their department > denominator
4. numerator/denominator using a left join
5. WHERE clause to filter departments with 10 employees
6. sort department with highest percentage to lowest 
6. take top 3 departments
**/

-- Testdb 데이터로 연습 
WITH A AS 
( 
	select dept, d.dname, count(distinct e.id) total from emp e left join dept d on e.dept = d.id
     group by dept having total >= 49
),
	B AS
(
	select e.dept, d.dname, sum(case when e.salary > 600 then 1 else 0 end) cnt
    from emp e
    left join dept d on e.dept = d.id
    group by 1
    
)
select 
	A.dname
	, cast(cnt / total as float)*100 as percentage			-- MySQL format설정 CAST( column AS 형태 )
from A
left join B on B.dept = A.dept 
Order by percentage desc
Limit 3;