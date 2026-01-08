SELECT ename
,sal as "인상전 급여" 
,comm as "인상전 보너스"
, sal + comm as "인상전 총급여"
, sal *1.1 as "인상된 급여"
, comm *1.1 as "인상된 보너스"
, (sal + comm) *1.1 as "인상된 총급여"

FROM emp WHERE sal<3000 and job = 'SALESMAN' 
ORDER BY ename desc; --조건절 where 조건 a와b 둘다 만족

SELECT * FROM emp where comm>2000 OR job ='SALESMAN';--a나b 둘중하나만 만족해도 출력

SELECT * FROM emp WHERE sal <=3000 and sal>=2000;

SELECT * FROM emp WHERE sal BETWEEN 2000 AND 3000;--두 값의 사이

SELECT * FROM emp WHERE hiredate BETWEEN '81/01/01' and  '81/12/31' order by hiredate;

SELECT * FROM emp WHERE deptno in(10,20) AND ename in ('SMITH','FORD'); --deptno = 10 OR deptno = 20

SELECT * FROM emp WHERE comm is null;--NULL인지 확인


SELECT * FROM emp WHERE ename like '%B%';--LIKE %->몇글자라도 대체 가능 _->하나만 대체가능

SELECT * FROM professor;--prfono 기본키 중복x

SELECT * FROM department;

SELECT * FROM professor where deptno in (101,103) and position != 'a full professor'; 

SELECT * FROM professor
--where name LIKE '%an%';
--WHERE bonus is not null;
WHERE pay + nvl(bonus,0) >= 300 ;-- nvl(항목,null일때의값)

SELECT * FROM student;

SELECT * FROM professor;

SELECT profno,name,deptno FROM professor
UNION all --중복된 값 출력 union -- 중복된 값은 제거
SELECT studno,name,deptno1 from student;

SELECT studno,name FROM student
where deptno1=101
minus
select studno,name from student
where deptno2=201
order by 1
;