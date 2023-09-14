<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>홈</title>
</head>
<body>
<h2>홈페이지</h2>
<a href="/member/save">회원가입</a>
<span id="login-area"></span>
<br>
loginEmail: ${sessionScope.loginEmail}<br>
loginName: ${sessionScope.loginName}
</body>
<script>
    const loginArea = document.getElementById("login-area");
    const loginEmail = '${sessionScope.loginEmail}';
    if (loginEmail.length == 0) {
        loginArea.innerHTML = "<a href='/member/login'>로그인</a>";
    } else {
        loginArea.innerHTML = "<a href='/member/logout'>로그아웃</a>";
    }
</script>
</html>
