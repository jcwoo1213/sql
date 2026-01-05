-- customer gift 아래거 선택가능 선택가능 notebook 한지
SELECT * FROM CUSTOMER c;
SELECT * FROM GIFT g;

SELECT
	c.gno
	,c.gname
	,c.point
	,g.gname
FROM CUSTOMER c
JOIN gift g ON c.point >= g.G_END
WHERE g.GNAME='Notebook';


--professor 교수번호,교수이름,입사일,자신보다 빨리 입사한 사람수 
SELECT count(*) FROM PRODUCT p GROUP BY P_CODE;
SELECT count(*) FROM PROFESSOR p ORDER BY HIREDATE;



SELECT
	p1.profno 
	,p1.NAME
	,to_char(p1.HIREDATE,'yyyy/mm/dd')
	,count(p2.profno) count
FROM professor p1
LEFT JOIN professor p2 ON p1.HIREDATE>p2.HIREDATE
GROUP BY p1.PROFNO,p1.NAME,p1.HIREDATE
ORDER BY p1.HIREDATE;

SELECT
	p1.profno 
	,p1.NAME
	,TO_CHAR(p1.HIREDATE,'yyyy/mm/dd') hiredate
	,count(p2.PROFNO) count
FROM professor p1, professor p2
WHERE p1.HIREDATE>p2.HIREDATE(+)
GROUP BY p1.PROFNO,p1.NAME,p1.HIREDATE
ORDER BY p1.HIREDATE;

SELECT 
	e1.empno
	,e1.ename
	,TO_CHAR(e1.hiredate,'yyyy/mm/dd') hiredate
	,count(e2.empno) count
FROM emp e1
left JOIN emp e2 ON e1.hiredate>e2.hiredate
GROUP BY e1.empno , e1.ename, e1.hiredate
ORDER BY e1.hiredate;

SELECT 
	e1.empno
	,e1.ename
	,TO_CHAR(e1.hiredate,'yyyy/mm/dd') hiredate
	,count(e2.empno) count
FROM emp e1, emp e2
WHERE e1.hiredate>e2.hiredate(+)
GROUP BY e1.empno , e1.ename, e1.hiredate
ORDER BY e1.hiredate;