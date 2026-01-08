const data = {
  board_no: 30,
  title: "test",
  content: "test",
  writer: "user01",
};
//서버 전달시 text로 전달 필요
//그래서 JSON.stringify 이용해서 json으로 변경
const json = JSON.stringify(data);
console.log(json);
console.log(data);
//post요청
//url,option객체
document.querySelector("form").addEventListener("submit", (e) => {
  e.preventDefault(); //이전 이벤트 없애기
  const board_no = document.querySelector("#board_no").value;
  const writer = document.querySelector("#writer").value;
  const title = document.querySelector("#title").value;
  const content = document.querySelector("#content").value;
  const data = { board_no, writer, title, content };
  if (!writer || !title || !content) {
    alert("필수입력");
    return;
  }
  fetch("add_board", {
    method: "post",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  })
    .then((data) => {
      console.log(data);
      return data.json();
    })
    .then((result) => {
      console.log(result);
      // const insertHtml = `<tr>
      // <td>${result.board_no}</td>
      //       <td><a class="title" href="/board/${result.board_no}" value="${result.board_no}">${result.title}</a></td>
      //       <td>${result.writer}</td>
      //       <td>new</td>
      //       <td><button type="button" onclick='deleteRow(result.board_no)' class="delete">삭제</button></td>
      //     </tr>`;
      // const subject = document.querySelector("tbody");
      // subject.insertAdjacentHTML("afterbegin", insertHtml);
    }) //fetch실행이 성공이면..
    .catch((err) => {
      console.log("ddd");
      console.log(err);
    }); //fetch실행이 에러면;

  board_list();
});

board_list();

function board_list() {
  fetch("boards", {})
    .then((res) => {
      return res.json();
    })
    .then((result) => {
      const tbody = document.querySelector("tbody");
      result.forEach((board) => {
        const tr = document.createElement("tr");
        for (const key in board) {
          const td = document.createElement("td");
          const element = board[key];
          td.innerText = element;
          tr.appendChild(td);
          if (key == "TITLE") {
            td.addEventListener("click", (e) => {
              const board_no = e.target.previousSibling.innerText;

              fetch(`board/${board_no}`)
                .then((res) => {
                  return res.json();
                })
                .then((result) => {
                  console.log(result);
                });
            });
          }
        }
        tbody.append(tr);
      });
      console.log(result);
    })
    // .then((result) => {
    //   console.log(result);
    //   const subject = document.querySelector("tbody");
    //   subject.innerHTML = "";
    //   result.forEach((board) => {
    //     const insertHtml = `<tr>
    //   <td>${board.BOARD_NO}</td>
    //         <td><a class="title" href="/board/${board.BOARD_NO}">${
    //       board.TITLE
    //     }</a></td>
    //         <td>${board.WRITER}</td>
    //         <td>${new Date(board.WRITE_DATE).toLocaleString()}</td>
    //         <td><button type="button"  class="delete" onClick='deleteRow(${
    //           board.BOARD_NO
    //         })'>삭제</button></td>
    //       </tr>`;
    //     subject.insertAdjacentHTML("afterbegin", insertHtml);
    //   });
    // const insertHtml = `<tr>
    //   <td>14</td>
    //         <td><a class="title" href="/board/14">오라클 연결 질문</a></td>
    //         <td>찬우</td>
    //       </tr>`;
    // const subject = document.querySelector("tbody");
    // subject.insertAdjacentHTML("afterbegin", insertHtml);
    // subject.insertAdjacentHTML("beforeend", insertHtml);
    // })
    .catch((err) => {
      console.log(err);
    });
}
function deleteRow(board_no) {
  fetch(`delete/${board_no}`, {
    method: "delete",
  })
    .then((res) => {
      console.log(res);
      return res.json();
    })
    .then((result) => {
      console.log(result);
      if (result.result == "success") {
        alert(`${result.board_no}번이 삭제되었습니다`);
      } else {
        alert("삭제실패");
      }
    })
    .catch((err) => {
      console.log(err);
    });
  board_list();
}
