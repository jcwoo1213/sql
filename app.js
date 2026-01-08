//express ->서버모듈
const express = require("express"); //모듈 임포트
const { getConnection } = require("oracledb");
const db = require("./db");
const app = express(); //요청처리가능
console.log(db);
const dir = "localhost:3000";
app.use(express.static("public")); //public폴더를 사용한다고 알려줌
app.use(express.json()); //json()
//주소-실행함수 =>라우팅
// "/"
app.get("/", (req, res) => {
  console.log("ddd");
});
//get-> 최대크기2kb정도 그렇기에 사용 제한됨
//post->많이 가능
app.post("/add_board", async (req, res) => {
  console.log(req.body);
  const { board_no, title, content, writer } = req.body;
  const connection = await db.getConnection();
  const qry = `INSERT into board (board_no,title,content,writer) values(,:title,:content,:writer)`;
  try {
    const result = await connection.execute(qry, [
      board_no,
      title,
      content,
      writer,
    ]);
    console.log(result);
    connection.commit();
    // res.send("처리완료");
    res.json({ board_no, title, content, writer });
  } catch (error) {
    console.log(error);
    // res.send("처리중에러");
    res.json({ retCode: "NG", retMsg: "DB에러" });
  }
});
app.get("/board/:board_no", async (req, res) => {
  const connection = await db.getConnection();
  console.log(req.params.board_no);
  try {
    const qry = `select * from board where board_no=${req.params.board_no}`;
    const result = await connection.execute(qry);
    console.log(result.rows);
    res.send(result.rows);
  } catch (error) {
    res.send(error);
  }
});
app.get("/boards", async (req, res) => {
  const connection = await db.getConnection();
  try {
    const qry = `select board_no,title,writer,write_date from board order by 1`;
    const result = await connection.execute(qry);
    console.log(result.rows);
    res.send(result.rows);
  } catch (error) {
    console.log(error);
    res.send("처리중에러");
  }
});
app.get("/student/:studno", async (req, res) => {
  console.log(req.params);
  const connection = await db.getConnection();
  const result = await connection.execute(
    `select * from student where studno=${req.params.studno}`
  );
  res.send(result.rows); //데이터만
});

//employee ->사원목록 출력하는 라우팅
app.get("/employee/:enum", async (req, res) => {
  const connection = await db.getConnection();
  const empno = req.params.enum;
  const result = await connection.execute(
    `select * from emp where empno=${empno}`
  );
  res.send(result.rows);
});

app.delete("/delete/:board_no", async (req, res) => {
  console.log(req.params.board_no);
  const connection = await db.getConnection();
  try {
    const qry = `delete from board where board_no=${req.params.board_no}`;
    const result = await connection.execute(qry);
    connection.commit();
    console.log(result);
    res.json({ result: "success", board_no: req.params.board_no });
  } catch (error) {
    console.log(error);
    res.send(error);
  }
});

app.listen(3000, () => {
  console.log("server실행. http://localhost:3000");
});

// let name = "Hong";
// console.log(`name=>${name}`);

//외부js 익스포트
