<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>비밀번호 확인</title>
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
            <form name="deleteCheck" method="post" action="/member/delete-check">
                <input type="hidden" name="id" value="${member.id}">
                <div class="input-group">
                    <span class="input-group-text">비밀번호</span>
                    <input type="password" class="form-control" id="check-password">
                </div>
            </form>
        </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
</body>
<script>
    document.deleteCheck.addEventListener("submit", (e) => {
        e.preventDefault();
        const loginPassword = '${member.memberPassword}';
        const checkPassword = document.querySelector("#check-password").value;
        if(loginPassword == checkPassword){
            if(confirm("탈퇴하시겠습니까?")){
                document.deleteCheck.submit();
            }
        } else {
            alert("비밀번호가 틀렸습니다.");
        }
    })
</script>
</html>
