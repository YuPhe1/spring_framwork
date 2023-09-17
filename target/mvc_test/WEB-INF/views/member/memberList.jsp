<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원목록</title>
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
        <table class="table">
            <tr class="table-dark">
                <th>Id</th>
                <th>이메일</th>
                <th>비밀번호</th>
                <th>이름</th>
                <th>휴대폰</th>
                <th>삭제</th>
            </tr>
            <c:forEach items="${memberList}" var="member">
                <tr>
                    <td>${member.id}</td>
                    <td>${member.memberEmail}</td>
                    <td>${member.memberPassword}</td>
                    <td>${member.memberName}</td>
                    <td>${member.memberMobile}</td>
                    <td>
                        <button class="btn btn-danger btn-sm" onclick="delete_fn(${member.id})">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
</body>
<script>
    const delete_fn = (id) => {
        if (confirm("해당회원을 삭제하시겠습니까?")) {
            location.href = "/member/delete?id=" + id;
        }
    }
</script>
</html>
