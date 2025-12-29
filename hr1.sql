select * from tab;

SELECT * FROM employees 
--WHERE job_id ='IT_PROG';
WHERE employee_id = 103;
select * from jobs;

select * from departments
;

select * from employees;

SELECT * FROM employees
WHERE department_id = 50 
AND salary >= 3000;

SELECT * FROM employees
WHERE salary +(salary * nvl(commission_pct,0)) >10000
and department_id in(20,80);