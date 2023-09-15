<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원정보</title>
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
            <div class="text-center">
            <c:if test="${member.profileAttached == 1}">
                <img src="${pageContext.request.contextPath}/member_upload/${memberProfile.storedFileName}" alt=""
                     width="180px">
            </c:if>
            <c:if test="${member.profileAttached == 0}">
                <img src="https://via.placeholder.com/100x100" alt="" width="180px">
            </c:if>
            </div>
            <div class="text-center">
            id: ${member.id}<br>
            이메일: ${member.memberEmail}<br>
            이름: ${member.memberName}<br>
            휴대폰: ${member.memberMobile}
            </div>
            <div class="text-center">
                <button class="btn btn-secondary px-3" onclick="home()">홈</button>
                <button class="btn btn-primary px-3" onclick="member_update_fn()">수정</button>
            </div>
        </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
</body>
<script>
    const home = () => {
        location.href = "/";
    }
    const member_update_fn = () => {
        location.href = "/member/update";
    }

</script>
</html>
