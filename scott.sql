
--Structured Query Language
select * from tab;
--table/column

desc customer;--테이블구조
select gno,gname,jumin,point from customer;

--professor의 전체 데이터 출력
select * from professor;

select * from student;
SELECT studno,name FROM student;
SELECT 'hello,' || name as name FROM student;--문자 이을때 || as "별칭" ""->대소문자 구분
SELECT studno||name FROM student;

SELECT * FROM dept;--부서정보

SELECT * FROM department;--학과

SELECT * FROM emp;--사원 테이블

SELECT DISTINCT deptno,ename FROM emp ORDER BY ename ;--distinct 중복제거 orderby column asc 오름차순 desc 내림차순

select '부서번호는'||deptno||',이름은'||ename as "Name with Dept" from emp;
select * from student;
SELECT name||'''s ID:'||id||' , WEIGHT is '||weight||'kg' as "ID AND WEIGHT"  FROM student;
    
SELECT * FROM emp;

SELECT ename||'('||job||'), '||ename || '''' || job || '''' as "NAME AND JOB" FROM emp;