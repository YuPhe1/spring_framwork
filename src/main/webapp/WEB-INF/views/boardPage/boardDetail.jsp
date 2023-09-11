<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 조회</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>
<body>
    <div class="row justify-content-center">
        <div class="col-10">
            <%@include file="../component/header.jsp" %>
            <%@include file="../component/nav.jsp" %>
        </div>
        <div class="col-10 card p-3">
            <h5 class="card-title">${board.boardTitle}</h5>
            <hr>
            <h6 class="card-subtitle mb-2 text-body-secondary text-end">작성자: ${board.boardWriter} 조회수: ${board.boardHits}</h6>
            <p class="card-text">${board.boardContents}</p>
            <h6 class="card-subtitle mb-2 text-body-secondary text-end">작성일: ${board.createdAt}</h6>
            <div class="text-center">
                <button class="btn btn-primary px-3">수정</button>
                <button class="btn btn-danger px-3">삭제</button>
            </div>
        </div>
        <div class="col-10">
            <%@include file="../component/footer.jsp" %>
        </div>
    </div>
</body>
</html>
