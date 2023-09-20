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
        <form action="/update" method="post" name="updateForm">
            <div class="input-group mb-3">
                <span class="input-group-text">Id</span>
                <input class="form-control" name="id" value="${member.id}">
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">Email</span>
                <input class="form-control" name="memberEmail" value="${member.memberEmail}">
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">Password</span>
                <input class="form-control" name="memberPassword">
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">Name</span>
                <input class="form-control" name="memberName" value="${member.memberName}">
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">Mobile</span>
                <input class="form-control" name="memberMobile" value="${member.memberMobile}">
            </div>
            <div>
                <button class="btn btn-secondary">수정</button>
            </div>
        </form>
    </div>
</div>
<%@include file="component/footer.jsp" %>
<script>

    document.updateForm.addEventListener("submit", (e) => {
        e.preventDefault();
        const passInput = document.updateForm.memberPassword.value;
        const passDB = ${member.memberPassword};
        var name = document.updateForm.memberName;
        var mobile = document.updateForm.memberMobile;
        if(passInput == passDB)
            if(name.value == ""){
                alert("이름을 입력하세요")
                name.focus();
            } else if(mobile.value == "") {
                alert("전화번호를 입력하세요")
                mobile.focus();
            } else {
                document.updateForm.submit();
            }
        else
            alert("비밀번호가 틀립니다.")
    })


</script>
</body>
</html>
