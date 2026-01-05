SELECT 
	name
	,jumin
	,decode(MOD(TO_NUMBER(SUBSTR(jumin,7,1)),2),1,'MAN',0,'WOMAN') "Gender"
	--CASE는 타입 일치 필요
	,CASE TO_NUMBER(SUBSTR(jumin,7,1))
	WHEN 1 THEN 'MAN'
	WHEN 2 THEN 'WOMAN'
	END
FROM student
WHERE deptno1=101;

SELECT 
	name
	,tel
	,decode(substr(tel,1,INSTR(tel,')')-1),
		'02','SEOUL',
		'031','GYEONGGI',
		'051','BUSAN',
		'052','ULSAN',
		'055','GYEONGNAM','ETC') loc
		--CASE문
	,CASE substr(tel,1,INSTR(tel,')')-1) 
	WHEN '02' THEN 'SEOUL'
	WHEN '031' THEN 'GYEONGGI'
	WHEN '051' THEN 'BUSAN'
	WHEN '052' THEN 'ULSAN'
	WHEN '055' THEN 'GYEONGNAM'
	ELSE 'ETC'
	END "CASE문"
FROM student
--WHERE deptno1=101;

--CASE 구문을 활용 조건의 범위를 지정
--1~3 =>1/4 4~6 =>2/4 7~9=>3/4 10~12 =>4/4
SELECT
	NAME
	,substr(jumin,3,2) MONTH
	,CASE WHEN substr(jumin,3,2)BETWEEN '01' AND '03' THEN '1/4'
		  WHEN substr(jumin,3,2)BETWEEN '04' AND '06' THEN '2/4'
		  WHEN substr(jumin,3,2)BETWEEN '07' AND '09' THEN '3/4'
		  WHEN substr(jumin,3,2)BETWEEN '10' AND '12' THEN '4/4'
		  ELSE 'err'
		  end
FROM student;

SELECT 
	empno
	,ename
	,sal
	,CASE WHEN sal BETWEEN 1 AND 1000 THEN 'LEVEL1'
		  WHEN sal BETWEEN 1001 AND 2000 THEN 'LEVEL2'
		  WHEN sal BETWEEN 2001 AND 3000 THEN 'LEVEL3'
		  WHEN sal BETWEEN 3001 AND 4000 THEN 'LEVEL4'
	ELSE 'LEVEL5' 
	END AS "LEVEL"
FROM emp;

--group
SELECT DEPTNO,ename,COUNT(*) "인원",sum(sal) "부서별 급여"
FROM emp
GROUP BY DEPTNO,ename; -- 부서 번호와 이름으로 그룹을 만듬

--emp -> 사원정보
SELECT job
,count(1) "건수"--첫번째 칼럼의 갯수
,sum(sal +nvl(comm,0)) "직무별 급여합" 
,round(sum(sal +nvl(comm,0))/count(1)) "평균 급여"
,round(avg(sal+nvl(comm,0))) "avg()"
,min(sal+nvl(comm,0)) "각 직무별 최소값"
,max(sal+nvl(comm,0)) "각 직무별 최고값"
--,stddev(sal) "표준편차"
--,VARIANCE(sal) "분산"
FROM emp 
--WHERE sal>1500
GROUP BY deptno,job; --부서로 한 다음에 직무로

SELECT * FROM emp ORDER BY sal;
--직무별로 묶기
SELECT
	job
	,sum(sal) 
	,round(avg(sal))
	,min(sal)
FROM emp
--WHERE sal>1500			--묶을 데이터들의 조건
GROUP BY rollup (job)
having avg(sal) > 1500;	--묶은 그룹의 조건

--부서 /직무 /정보 조회(평균급여,사원수)



--union all
--roll up
-- 1.부서별 직무별 평균 급여,사원수
SELECT 
	deptno||''
	,job
	,round(AVG(sal)) "평균급여"
	,count(1) "사원수"
FROM emp
GROUP BY DEPTNO,JOB
union ALL
-- 2.직무별 평균급여, 사원수
SELECT 
	deptno||''
	,'소계'
	,round(avg(sal))
	,count(1)
FROM emp
GROUP BY deptno
UNION ALL
-- 3. 전체 평균급여,사원수
SELECT '전체','소계',round(avg(sal)),count(1)
FROM emp
ORDER BY 1,2;

SELECT 
	nvl(TO_CHAR(deptno),'전체') dept
	,decode(deptno,NULL,'총합',nvl(job,'소계')) job
	,round(avg(sal)) avg_sal
	,count(1) cnt_emp
FROM emp
GROUP BY ROLLUP (deptno,job)
ORDER BY nvl(deptno,1),2;

--emp,dept 테이블

SELECT empno,ename,e.DEPTNO,d.DNAME,d.LOC 
FROM emp e --driving 테이블
JOIN dept d ON e.DEPTNO=d.DEPTNO
WHERE d.DNAME='ACCOUNTING'; --ANSI 조인

SELECT empno,ename,e.DEPTNO,d.DEPTNO,d.DNAME,d.LOC 
FROM emp e ,dept d 
WHERE d.DEPTNO=e.DEPTNO
AND d.DNAME='ACCOUNTING' ; --oracle 조인

SELECT * FROM dept;

--student,professor,학과
SELECT *
FROM student;
SELECT * FROM professor;
SELECT * FROM department;

SELECT s.studno "학번" 
	,s.name "이름"
	,s.DEPTNO1 "학과번호"
	,d.dname "학과명"
	,s.profno "교수번호"
	,p.NAME "교수명"
	,s.DEPTNO2 "부전공"
	,d2.dname "부전공명"
FROM student s
JOIN DEPARTMENT d ON s.DEPTNO1 = d.DEPTNO
left JOIN PROFESSOR p ON s.PROFNO = p.PROFNO
left JOIN DEPARTMENT d2 ON s.DEPTNO2= d2.DEPTNO
ORDER BY nvl(s.DEPTNO2,0) desc,nvl(s.profno,0) desc,1;

SELECT s.studno "학번" 
	,s.name "이름"
	,s.DEPTNO1 "학과번호"
	,d.dname "학과명"
	,s.profno "교수번호"
	,p.NAME "교수명"
	,s.DEPTNO2 "부전공"
	,d2.dname "부전공명"
FROM student s,department d,professor p,department d2
WHERE s.PROFNO =p.PROFNO(+)
AND d.DEPTNO=s.DEPTNO1
AND d2.DEPTNO(+)=s.DEPTNO2
ORDER BY nvl(s.DEPTNO2,0) desc,nvl(s.profno,0) desc,1;

--고객정보
SELECT *
FROM customer;

SELECT *
FROM GIFT g;

SELECT c.gno "고객번호"
	,c.gname "고객명"
	,c.POINT "포인트"
	,g.GNAME "경품"
FROM customer c
JOIN gift g ON c.POINT>=g.g_start AND c.point<=g.g_end;
--JOIN GIFT g ON c.POINT BETWEEN g.g_start AND g.g_end;

SELECT c.gno "고객번호"
	,c.gname "고객명"
	,c.POINT "포인트"
	,g.GNAME "경품"
FROM customer c ,gift g
WHERE c.POINT BETWEEN g.g_start AND g.g_end;

--학생,점수,학점
SELECT * FROM student;
SELECT * FROM score;
SELECT * FROM hakjum;

SELECT 
	stu.studno
	,name
	,id
	,total "점수"
	,g.grade "학점"
FROM STUDENT stu
JOIN score sc ON stu.studno=sc.studno
JOIN hakjum g ON sc.total BETWEEN g.MIN_POINT AND g.max_point;

--stu department join
SELECT * FROM student;
SELECT * FROM department;
--ansi
SELECT
	s.name
	,s.deptno1
	,d.dname
FROM STUDENT s
JOIN department d ON s.deptno1=d.deptno;
--oracle
SELECT
	s.name
	,s.deptno1
	,d.dname
FROM STUDENT s,DEPARTMENT d
WHERE s.deptno1=d.deptno;

--emp2 p_grade 사원 직급 페이 최저 최고
SELECT * FROM emp2;
SELECT * FROM p_grade;
--ansi
SELECT
	e.name
	,e.POSITION
	,e.pay
	,pg.s_pay
	,pg.e_pay
FROM emp2 e
LEFT JOIN p_grade pg ON e.POSITION=pg.POSITION;
--oracle
SELECT
	e.name
	,e.POSITION
	,e.pay
	,pg.s_pay
	,pg.e_pay
FROM emp2 e,p_grade pg
WHERE e.POSITION=pg.POSITION(+);

SELECT name
	,floor(MONTHS_BETWEEN(sysdate,birthday)/12) age
	,e.POSITION curr_position
	,pg.POSITION be_position
FROM emp2 e
JOIN p_grade pg ON floor(MONTHS_BETWEEN(sysdate,e.birthday)/12) BETWEEN pg.s_age AND pg.e_age;

UPDATE EMP2
SET birthday = ADD_MONTHS(BIRTHDAY,-12)
WHERE 1=1;

--outer join(없는거도 보여줌) inner join(있는거만 보여줌)
SELECT * FROM student s;

SELECT 
	s.studno "학번"
	,s.name "학생이름"
	,p.profno "교수번호"
	,p.name "교수명"
FROM student s
FULL OUTER JOIN PROFESSOR p ON s.PROFNO=p.PROFNO;

--self join

SELECT
	e1.empno "사원번호"
	,e1.ename "사원명"
	,e2.empno "관리자번호"
	,e2.ENAME "관리자명"
FROM emp e1
LEFT OUTER JOIN emp e2 ON e1.mgr=e2.empno;

