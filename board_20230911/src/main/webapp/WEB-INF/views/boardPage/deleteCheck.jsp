<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>홈</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-10">
        <%@include file="../component/header.jsp" %>
        <%@include file="../component/nav.jsp" %>
    </div>
    <div class="col-10 card p-3">
        <form name="deleteCheck" action="/board/delete" method="post">
            <input name="id" value="${board.id}" type="hidden">
            <div class="input-group mb-3">
                <span class="input-group-text">비밀번호</span>
                <input type="password" class="form-control" name="boardPass">
            </div>
            <div class="text-center">
                <button class="btn btn-danger px-3">삭제</button>
                <button class="btn btn-secondary px-3" type="button" onclick="cancel()">취소</button>
            </div>
        </form>
    </div>
    <div class="col-10">
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
<script>
    document.deleteCheck.addEventListener("submit", (e) => {
        e.preventDefault();
        const pass = document.deleteCheck.boardPass.value;
        if (pass == ${board.boardPass})
            document.deleteCheck.submit();
        else {
            alert("비밀번호가 틀렸습니다.");
        }
    })

    const cancel = () => {
        location.href = "/board/list";
    }
</script>
</body>
</html>
