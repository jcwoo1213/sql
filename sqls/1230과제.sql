SELECT 
	NAME 
	,JUMIN 
	,DECODE(MOD(TO_NUMBER( SUBSTR(jumin,7,1)),2),1,'MAN','WOMAN') as gender
FROM student
WHERE deptno1=101

SELECT 
	name
	,tel
	,DECODE(SUBSTR(tel,1,INSTR(tel,')')-1) ,02,'SEOUL',
											031,'GYEONGGI',
											051,'BUSAN',
											052,'ULSAN',
											055,'GYEONGNAM') AS loc
FROM student
WHERE DEPTNO1 =101