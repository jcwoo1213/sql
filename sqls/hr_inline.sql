SELECT * FROM jobs;

SELECT * FROM DEPARTMENTS d;


SELECT /*+ INDEX (e EMP_EMP_ID_PK)*/e.rowid,e.* FROM EMPLOYEES e;
--employee_id 컬럼의 인덱스 테이블에 저장.

SELECT /*+ INDEX (e EMP_EMP_ID_PK)*/e.rowid,e.* FROM EMPLOYEES e ORDER BY e.EMPLOYEE_ID desc;

SELECT e.rowid,e.* FROM EMPLOYEES e ORDER BY 3;

CREATE INDEX emp_hiredate_ix
ON employees(hire_date);

SELECT * FROM EMPLOYEES e;

CREATE OR replace VIEW EMPLOYEES_V
AS
SELECT 
	employee_id
	,first_name
	,last_name
	,email
	,hire_date
	,job_title
	,department_name
FROM EMPLOYEES e
JOIN jobs j ON e.job_id =j.job_id
JOIN departments d ON e.department_id=d.department_id;

SELECT * FROM EMPLOYEES_V WHERE job_title ='Programmer';

SELECT * FROM tab;

--inline view
SELECT e.DEPARTMENT_ID,d.DEPARTMENT_NAME,e.MAX_SAL
FROM (
	SELECT department_id,MAX(salary) max_sal
	FROM employees 
	GROUP BY DEPARTMENT_ID)e
JOIN departments d ON e.department_id=d.department_id;

