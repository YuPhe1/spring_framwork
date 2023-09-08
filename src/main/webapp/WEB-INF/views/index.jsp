<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
</head>
<body>
<%@include file="component/header.jsp" %>
<%@include file="component/nav.jsp" %>
<div class="row justify-content-center text-center">
    <h2>Member Project</h2>
    <div class="col-6">
        <div class="card">
            로그인이메일: ${sessionScope.loginEmail} <br>
            model에 담은 이메일: ${email} <br>
        </div>
    </div>
</div>
<%@include file="component/footer.jsp" %>
</body>
</html>
