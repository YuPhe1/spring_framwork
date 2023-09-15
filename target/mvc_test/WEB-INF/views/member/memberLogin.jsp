<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
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
            <div class="input-group mb-3">
                <span class="input-group-text">이메일</span>
                <input class="form-control" type="text" id="memberEmail">
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">비밀번호</span>
                <input class="form-control" type="password" id="memberPassword">
            </div>
            <div id="login-aria"></div>
            <div class="text-center">
                <button class="btn btn-primary px-3" onclick="login()">로그인</button>
                <button class="btn btn-secondary px-3" onclick="cancel_fn()">취소</button>
            </div>
        </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
</body>
<script>
    const target = '${target}';
    const login = () => {
        const login_aria = document.getElementById("login-aria");
        const email = document.getElementById("memberEmail").value;
        const password = document.getElementById("memberPassword").value;
        console.log(email + " : " + password);
        if (email == "") {
            document.getElementById("memberEmail").focus();
            login_aria.innerHTML = "이메일을 입력하세요";
            login_aria.style.color = "red";
        } else if (password == "") {
            document.getElementById("memberPassword").focus();
            login_aria.innerHTML = "비밀번호를 입력하세요";
            login_aria.style.color = "red";
        } else {
            $.ajax({
                type: "post",
                url: "/member/login",
                data: {memberEmail: email, memberPassword: password},
                success: function () {
                    if (target.length == 0) {
                        location.href = "/";
                    } else {
                        location.href = target;
                    }
                }, error: function () {
                    login_aria.innerHTML = "이메일 또는 비밀번호가 틀렸습니다.";
                    login_aria.style.color = "red";
                }
            })
        }
    }

    const cancel_fn = () => {
        location.href = "/";
    }
</script>
</html>
