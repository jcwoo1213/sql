//express ->서버모듈
const express = require("express"); //모듈 임포트
const { getConnection } = require("oracledb");
const db = require("./db");
const app = express(); //인스턴스 생성.
console.log(db);
//주소-실행함수 =>라우팅
// "/"
app.get("/", (req, res) => {
  res.send("/ 홈에 오신것을 환영합니다");
});
// "/customer" ->
app.get("/customer", (req, res) => {
  res.send("/customer 경로 호출");
});
app.get("/product", (req, res) => {
  res.send("/product경로 호출");
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

app.listen(3000, () => {
  console.log("server실행. http://localhost:3000");
});

// let name = "Hong";
// console.log(`name=>${name}`);

//외부js 익스포트
