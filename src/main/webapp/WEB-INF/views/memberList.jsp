<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원목록</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<%@include file="component/header.jsp" %>
<%@include file="component/nav.jsp" %>
<div class="mb-4"></div>
<div class="row justify-content-center">
    <div class="col-10">
        <table class="table">
            <tr class="table-dark">
                <th>id</th>
                <th>Email</th>
                <th>name</th>
                <th>birth</th>
                <th>mobile</th>
                <th>조회</th>
                <th>삭제</th>
            </tr>
            <c:forEach items="${memberList}" var="member">
                <tr>
                    <td>${member.id}</td>
                    <td onclick="member_detail('${member.id}')">${member.memberEmail}</td>
                    <td>${member.memberName}</td>
                    <td>${member.memberBirth}</td>
                    <td>${member.memberMobile}</td>
                    <td>
                        <button class="btn btn-secondary" onclick="detail_fn('${member.id}')">조회</button>
                    </td>
                    <td>
                        <button class="btn btn-danger" onclick="delete_fn('${member.id}')">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<div id="detail-aria">

</div>
<%@include file="component/footer.jsp" %>
<script>
    const detail_fn = (id) => {
        location.href = "/member?id=" + id;
    }
    const delete_fn = (id) => {
        if(confirm("해당회원을 삭제하겠습니까?")){
            location.href = "/delete?id=" + id;
        }
    }
    const member_detail = (id) => {
        $.ajax({
            type:"post",
            url:"member-ajax",
            data:{id: id},
            success:function (member){
                const aria = document.getElementById("detail-aria");
                let result = "<table class='table'><tr class='table-dark'> <th>id</th> <th>Email</th> <th>name</th> <th>birth</th> <th>mobile</th> </tr>"
                result += "<th>member.id</th> <th>member.memberEmail</th> <th>member.memberName</th> <th>member.memberBirth</th> <th>member.memberMobile</th> </table>"
                aria.innerHTML = result;
            }
        })
    }
</script>
</body>
</html>
