<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<%@include file="component/header.jsp" %>
<%@include file="component/nav.jsp" %>
<div class="row justify-content-center mb-4">
    <div class="col-6">
        <div class="card p-3">
            <form id="form" name="frm" action="/save" method="post" onsubmit="return check()" >
                <div class="input-group mb-3">
                    <span class="input-group-text">이메일</span>
                    <input class="form-control" id="memberEmail" name="memberEmail" placeholder="이름" onkeyup="check_false()">
                    <button class="btn btn-outline-secondary" type="button" id="check-email" onclick="check_email()">중복체크</button>
                </div>
                <div id="check-email-aria" class="mb-3"></div>
                <div class="input-group mb-3">
                    <span class="input-group-text">비밀번호</span>
                    <input class="form-control" id="memberPassword" name="memberPassword" placeholder="비밀번호">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text">이름</span>
                    <input class="form-control" id="memberName" name="memberName" placeholder="이름">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text">생년월일</span>
                    <input class="form-control" id="memberBirth" name="memberBirth" placeholder="YYYYMMDD">
                </div>
                <div class="input-group mb-3">
                    <span class="input-group-text">휴대폰</span>
                    <input class="form-control" name="memberMobile" placeholder="010-0000-0000">
                </div>
                <div class="text-center">
                    <button class="btn btn-primary">회원가입</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%@include file="component/footer.jsp" %>
<script>
    var checkEmail = false;
    const checkEmailAria = document.getElementById("check-email-aria");
    const check_false = () => {
        checkEmail = false;
        checkEmailAria.innerHTML = "";
    }
    const check_email = () => {
        const email = document.getElementById("memberEmail").value;
        if(email == ""){
            checkEmailAria.innerHTML = "이미 사용중인 이메일 입니다."
            checkEmailAria.style.color = "red";
            checkEmail= false;
        } else {
            $.ajax({
                type: "post",
                url: "/duplicate-check",
                data: {memberEmail: email},
                success: function () {
                    checkEmail = true;
                    checkEmailAria.innerHTML = "사용가능한 이메일 입니다."
                    checkEmailAria.style.color = "green";
                }, error: function () {
                    checkEmailAria.innerHTML = "이미 사용중인 이메일 입니다."
                    checkEmailAria.style.color = "red";
                    checkEmail= false;
                }
            })
        }
    }

    document.frm.addEventListener("submit", function (e) {
        e.preventDefault()
        var password = this.memberPassword;
        var name = this.memberName;
        var birth = this.memberBirth;
        var mobile = this.memberMobile;
        if(!checkEmail){
            alert("이메일을 확인해 주세요")
            this.memberEmail.focus();
        } else if (password.value == ""){
            alert("비밀번호를 입력해주새요")
            password.focus();
        } else if (name.value == ""){
            alert("이름을 입력해주새요")
            name.focus();
        } else if (birth.value == ""){
            alert("생년월일을 입력해주새요")
            birth.focus();
        } else if (mobile.value == ""){
            alert("전화번호를 입력해주새요")
            mobile.focus();
        } else {
            this.submit();
        }
    })

</script>
</body>
</html>

