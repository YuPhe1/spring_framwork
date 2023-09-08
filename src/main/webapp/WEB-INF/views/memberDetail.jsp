<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원목록</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<%@include file="component/header.jsp" %>
<%@include file="component/nav.jsp" %>
<div class="mb-4"></div>
<div class="row justify-content-center">
    <div class="col-8 card p-3 text-center">
        id : ${member.id} <br>
        Email : ${member.memberEmail} <br>
        name : ${member.memberName} <br>
        birth : ${member.memberBirth} <br>
        mobile : ${member.memberMobile} <br>
        <div>
            <button class="btn btn-secondary" onclick="update_fn(${member.id})">수정</button>
        </div>
    </div>
</div>
<%@include file="component/footer.jsp" %>
<script>
    const update_fn = (id) => {
        location.href = "/update?id=" + id;
    }
</script>
</body>
</html>
