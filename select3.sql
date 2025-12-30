SELECT * FROM tab;

SELECT empno,ename,sal,nvl(comm,0) AS commission FROM emp;

--initcap->첫글자는 대문자
SELECT initcap(POSITION) AS"initcap",position FROM professor;

--upper->대문자 lower->소문자
SELECT initcap(POSITION) AS"initcap"
,lower(upper(POSITION)) AS"upper" 
,length(position) AS "length"--길이
,LENGTHB('가나다') AS "lengthb"--바이트수
FROM professor
WHERE LENGTH(name)<10;

--concat 2개만 가능
SELECT ENAME ||JOB AS "Name And Job"
,concat(CONCAT(ename,','),job) AS "concat"
,SUBSTR(e.JOB ,1,3) AS "short job"
FROM emp e;

--substr(자를문자,시작,갯수)dual->더미테이블
SELECT SUBSTR('abcde',3,3),
SUBSTR('hello,world',-3,3)FROM dual; 

SELECT * FROM  emp
WHERE SUBSTR(ename,1,1)='J';

--전공1(201) 연락처에 tel컬럼 ')'
SELECT tel
,INSTR(tel,')') AS "location of )"
,substr(tel,1,INSTR(tel,')')-1) AS "local number"FROM student;

SELECT name
,tel
,substr(tel,1,INSTR(tel,')')-1) AS "AREA CODE" 
,deptno1
,substr(tel,INSTR(tel,')')+1,(INSTR(tel,'-')-(INSTR(tel,')')+1)))AS "국번"
FROM  student
WHERE DEPTNO1 = 201
AND substr(tel,1,INSTR(tel,')')-1)='02';

--lpad(컬럼,자리수,채울값)공백을 3번째꺼로 채우기
SELECT LPAD('abc',5,'-')
FROM dual;

SELECT name
,id
,lpad(id,10,'*') FROM student
WHERE DEPTNO1 =201;

SELECT 
lpad(ename,9,'123456789') AS lpad
FROM emp
WHERE deptno =10;

--rpad()우측에서 채우기
SELECT 
RPAD(ename,9,SUBSTR('123456789',LENGTH(ename)+1)) AS rpad
FROM emp
WHERE deptno=10;

--ltrim(a,b)a에서 b를 찾아 삭제(안나올때까지) 2번째 값 생략시 공백 삭제
--repalce(a,b,c)a에서 b를찾아c로 변경해라
SELECT LTRIM('abcde','abc'),RTRIM('abcdecde','cde')
	,LTRIM(RTRIM(' abc '))
	,REPLACE(' hello ',' ','*')
FROM dual;

SELECT REPLACE(ename,SUBSTR(ename,2,2),'**')
FROM emp
WHERE deptno=10;

SELECT NAME 
,JUMIN 
,REPLACE(jumin,SUBSTR(jumin,7),'-/-/-/-') AS replace
FROM student
WHERE DEPTNO1 =101;

SELECT
	name,
	tel,
	REPLACE(tel, SUBSTR(tel, instr(tel, ')')+ 1, instr(tel, '-')-(instr(tel, ')')+ 1)), '***') AS REPLACE
FROM
	student
WHERE
	deptno1 = 102;

SELECT
	name,
	tel,
	REPLACE(tel, substr(tel, instr(tel, '-')+ 1), '****') AS REPLACE
FROM
	student
WHERE
	deptno1 = 101;

--숫자함수
--round(수,n) 소수점n자리까지 표시 n생략시 0
--trunc() 버림
SELECT round(12.345,1),--12.3
	round(12.345,2),--12.34
	round(12.3456,3),--12.346
	round(12.345,0),--12
	round(12.345,-1),
	trunc(12.345,2),
	mod(12,5),--12%5
	ceil(12/5),--ceil 올림(정수화)
	floor(12/5),--floor 내림(정수화)
	power(3,3)--power(a,b) a의b승
FROM dual;

--날짜
--
SELECT 
--	hiredate,
	sysdate, --현재시간
	MONTHS_BETWEEN(sysdate,HIREDATE), --두시간 사이 몇달 지났는지
	ADD_MONTHS(sysdate,-1),--지금으로부터 n달뒤
	NEXT_DAY(sysdate-7,'화'),-- 다음 해당요일
	LAST_DAY(ADD_MONTHS(sysdate,-1)),--해당달의 마지막날
	round(sysdate-(3/24)),--시 기준으로 반올림
	trunc(sysdate,'mm')--버림
FROM emp;
--근무년수 20년 넘는 교수 번호,이름,급여,보너스,근무년수
SELECT * FROM professor

SELECT profno,
	name,
	pay,
	bonus,
	floor(MONTHS_BETWEEN(sysdate,hiredate)/12)||'년'||floor(mod(MONTHS_BETWEEN(sysdate,hiredate),12))||'개월' AS "근무년수"
FROM professor 
--WHERE ADD_MONTHS(hiredate,12*20)<=sysdate ;
WHERE MONTHS_BETWEEN(sysdate,hiredate) BETWEEN 120 AND 240;

SELECT 2+'2',2 + TO_NUMBER('2')
FROM dual;

SELECT sysdate
	,TO_CHAR(sysdate,'yyyy"년"mm"월" dd"일" day HH24"시"MI"분"SS"초"') --varchar2
	,to_char(123456789.12,'00,999,999,999.99')
	,TO_DATE('2025-12-30 101010','yyyy-mm-dd HHMISS')
FROM dual
WHERE TO_DATE('2025/12/31','yyyy/mm/dd') < sysdate+1;

SELECT nvl2(null,10,'0')
FROM dual;

SELECT ename
	,sal +nvl(comm,0) AS "nvl"--
	,sal + nvl2(comm,comm,0) AS "nvl2"--null이면 3번째 null이 아니면 2번째
	,nvl2(comm,sal+comm,sal)
	,sal +comm AS "not"
FROM emp;

--decode(a,b,c,d) a가 b인경우 c 아니면 d

SELECT decode(null,'null','같다','다르다')
FROM dual;
/*
 * 101 computer engineering
 * 102 multimedia engineering
 * 103 software engineering
 * */
SELECT name
,studno 
--,DECODE(deptno1,101,'computer engineering',DECODE(deptno1,102,'multimedia engineering',DECODE(deptno1,103,'software engineering','etc'))) "학과"
,DECODE(deptno1,101,'computer engineering',
				102,'multimedia engineering',
				103,'software engineering','etc') AS "decode1"
FROM student;

