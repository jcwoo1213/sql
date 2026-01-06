-- 게시판(제목,내용,작성자,작성시간,조회수,....)
CREATE TABLE board(
	board_no NUMBER PRIMARY KEY 
	,title varchar2(100) NOT NULL
	,content varchar2(1000) NOT NULL
	,writer varchar2(50) NOT NULL
	,write_date DATE DEFAULT sysdate 
);

SELECT * FROM board;

INSERT INTO board (board_no,title,content,writer) values(4,'신규회원등록관련','신규회원 아이디는 50글자 미만으로 작성해주세요','admin');

INSERT INTO board (title,content,writer,write_date) values('신규회원등록관련','신규회원 아이디는 50글자 미만으로 작성해주세요','admin','2026-01-01');

--테이블 컬럼 추가

ALTER TABLE board ADD (click_count NUMBER);--컬럼추가
ALTER TABLE BOARD RENAME COLUMN click_count TO view_cnt; --이름변경
ALTER TABLE board MODIFY writer varchar2(100);-- 타입변경
ALTER TABLE board MODIFY view_cnt DEFAULT 0; --속성추가
--DESC board;

--crud 기능 dat amanage language
--create,read,update,delete

SELECT  * FROM dept2;

INSERT INTO dept2 
values(9000,'temp_1',1006,'temp area');--칼럼명 생략시 전체 다 넣기 칼럼명 기입시 해당칼럼만

SELECT * FROM product;
--999,Potato Chip,1200
INSERT INTO PRODUCT
values(999,'Potato Chip',1200);

--commit->영구적반영,rollback->commit이전까지 취소
--COMMIT
ROLLBACK;

--ctas 테이블 복사
--CREATE TABLE professor2 
--as
SELECT * FROM professor;

--itas 테이블 값만 복사
INSERT INTO professor2
AS 
SELECT * FROM professor2;
DROP TABLE professor2;
DELETE FROM professor2;

--UPDATE
SELECT * FROM professor2;
--pay,bouns 100증가
UPDATE professor2
SET pay=650 
,bonus=200
WHERE profno=1001;

--delete
DELETE FROM professor2
WHERE profno=1001;


SELECT * FROM board;

--5, '게시글 연습입니다','신규글 등록합니다.','user01'
INSERT INTO board(board_no,title,content,writer) values(5, '게시글 연습입니다','신규글 등록합니다.','user01');
--5번 업데이트 제목: 게시글 수정, 내용:신규글을 수정합니다
UPDATE board
SET title='게시글 수정입니다'
,content='신규글을 수정합니다'
WHERE board_no = 5;
--5번글 삭제
DELETE FROM board WHERE board_no=5;

--student 
CREATE TABLE student2
AS
SELECT * FROM student
WHERE 1=2;-- 조건이 만족되지 않아서 데이터는 없고 틀만 복사
SELECT * FROM professor2;
INSERT INTO STUDENT2
SELECT * FROM STUDENT;
DELETE FROM student2;  --Anthony Hopkins 담당교수 Jodie Foster 지정



UPDATE STUDENT2
SET profno=(SELECT profno FROM professor2 WHERE NAME='Jodie Foster')
WHERE name='Anthony Hopkins';

--3학년&2전공이 없는 학생 computer engineering    
SELECT * FROM STUDENT2 s WHERE grade=3;
SELECT * FROM DEPARTMENT d;

UPDATE student2
SET deptno2=(SELECT deptno FROM department WHERE dname='Computer Engineering')
WHERE grade=3
AND deptno2 IS NULL;