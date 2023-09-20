<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<%@include file="component/header.jsp" %>
<%@include file="component/nav.jsp" %>
<div class="row justify-content-center mb-4">
    <div class="col-6">
        <div class="card p-3">
            <form action="/login" method="post">
                <div class="input-group mb-3">
                    <span class="input-group-text">이메일</span>
                    <input class="form-control" id="memberEmail" name="memberEmail" placeholder="이름" onkeyup="check_false()">
                </div>
                <div id="check-email-aria" class="mb-3"></div>
                <div class="input-group mb-3">
                    <span class="input-group-text">비밀번호</span>
                    <input class="form-control" id="memberPassword" name="memberPassword" placeholder="비밀번호">
                </div>
                <div class="text-center">
                    <button class="btn btn-primary">로그인</button>
                    <button type="button" class="btn btn-secondary" onclick="home()">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@include file="component/footer.jsp" %>
<script>
    const home = () => {
        location.href = "/";
    }
</script>
</body>
</html>

