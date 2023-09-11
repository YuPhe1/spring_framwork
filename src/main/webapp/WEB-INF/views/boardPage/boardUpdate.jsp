<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>게시글 작성</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>
<body>
<div class="row justify-content-center">
  <div class="col-10">
    <%@include file="../component/header.jsp" %>
    <%@include file="../component/nav.jsp" %>
  </div>
  <div class="col-10 card p-3">
    <form name="boardUpdate" action="/board/update" method="post">
      <input type="hidden" value="${board.id}" name="id">
      <div class="input-group mb-3">
        <span class="input-group-text">글제목</span>
        <input type="text" class="form-control" name="boardTitle" value="${board.boardTitle}">
      </div>
      <div class="input-group mb-3">
        <span class="input-group-text">작성자</span>
        <input type="text" class="form-control" name="boardWriter" value="${board.boardWriter}">
        <span class="input-group-text">비밀번호</span>
        <input type="password" class="form-control" name="boardPass">
      </div>
      <div class="input-group mb-3">
        <textarea class="form-control" size="5" name="boardContents">${board.boardContents}</textarea>
      </div>
      <div class="text-center">
      <button class="btn btn-primary">저장</button>
      <button type="button" class="btn btn-secondary" onclick="save_cancel()">취소</button>
      </div>
    </form>
  </div>
<%@include file="../component/footer.jsp" %>
</div>
<script>
  document.boardUpdate.addEventListener("submit", (e)=> {
    e.preventDefault();
    const passDB = ${board.boardPass};
    const title = document.boardUpdate.boardTitle;
    const writer = document.boardUpdate.boardWriter;
    const pass = document.boardUpdate.boardPass;
    const contents = document.boardUpdate.boardContents;
    if (pass.value != passDB){
      alert("비밀번호가 틀립니다.")
      pass.focus();
    }
    else if(title.value == ""){
      alert("제목을 입력하세요");
      title.focus();
    } else if (writer.value == ""){
      alert("작성자를 입력하세요");
      writer.focus();
    } else if (contents.value == ""){
      alert("글 내용을 입력하세요");
      contents.focus();
    } else {
      document.boardUpdate.submit();
    }
  });

  const save_cancel = () => {
    location.href = "/board/list";
  }
</script>
</body>
</html>