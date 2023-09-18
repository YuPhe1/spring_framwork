<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글쓰기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-10">
        <%@include file="../component/header.jsp" %>
        <%@include file="../component/nav.jsp" %>
        <div class="card p-3">
            <form action="/board/save" method="post" name="boardSave" enctype="multipart/form-data">
                <div class="input-group mb-3">
                    <span class="input-group-text">제목</span>
                    <input class="form-control" type="text" name="boardTitle">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text">작성자</span>
                    <input class="form-control" type="text" name="boardWriter" value="${sessionScope.loginName}" readonly>
                </div>
                <input type="hidden" name="boardWriterId" value="${sessionScope.loginId}">
                <div class="input-group mb-3">
                    <textarea class="form-control" cols="50" rows="10" name="boardContents" placeholder="내용"></textarea>
                </div>
                <div class="input-group mb-3">
                    <input class="form-control" type="file" name="boardFile" multiple accept="image/*"> <br>
                </div>
                <div class="text-center mb-3">
                    <button class="btn btn-primary px-3">작성</button>
                    <button class="btn btn-secondary px-3" type="button">취소</button>
                </div>
            </form>
        </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
</body>
<script>
    document.boardSave.addEventListener("submit", (e) => {
        e.preventDefault();
        const titleArea = document.boardSave.boardTitle;
        const contentsArea = document.boardSave.boardContents;
        if (titleArea.value == "") {
            alert("제목을 작성하세요.");
            titleArea.focus();
        } else if (contentsArea.value == "") {
            alert("내용을 작성하세요");
            contentsArea.focus();
        } else {
            document.boardSave.submit();
        }
    });
</script>
</html>
