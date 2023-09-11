<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>홈</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
</head>
<body>
<div class="row justify-content-center">
    <div class="col-10">
        <%@include file="component/header.jsp" %>
        <%@include file="component/nav.jsp" %>
        <h2 class="text-center">게시판 사이트입니다.</h2>
        <%@include file="component/footer.jsp" %>
    </div>
</div>
</body>
</html>
