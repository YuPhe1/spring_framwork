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
<c:if test="${sessionScope.loginEmail == 'admin'}">
    <a href="/member/list">회원목록</a>
</c:if>
<a href="/board/list">글목록</a>
<a href="/board/insert">테스트글작성</a>
<br>
loginEmail: ${sessionScope.loginEmail}<br>
loginName: ${sessionScope.loginName}
</body>
<script>
    const loginArea = document.getElementById("login-area");
    const loginEmail = '${sessionScope.loginEmail}';
    const loginName = '${sessionScope.loginName}';
    if (loginEmail.length == 0) {
        loginArea.innerHTML = "<a href='/member/login'>로그인</a>";
    } else {
        loginArea.innerHTML = "<a href='/member/logout'>로그아웃</a> " + "<a href='/member/detail'>${sessionScope.loginName}님</a>";
    }
</script>
</html>
