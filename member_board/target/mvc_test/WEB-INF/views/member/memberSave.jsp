<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
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
            <form action="/member/save" method="post" name="memberSave" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-2 text-center mb-3">
                        <img src="https://via.placeholder.com/100x100" alt="" width="90%" id="profile-image">
                    </div>
                    <div class="col-10">
                        <div class="input-group">
                            <span class="input-group-text">이메일</span>
                            <input class="form-control" type="text" id="memberEmail" name="memberEmail"
                                   onkeyup="check_false()">
                            <button class="btn btn-secondary" type="button" onclick="check_email()">중복체크</button>
                        </div>
                        <div id="check-email-aria" class="mb-3"></div>
                        <div class="input-group">
                            <span class="input-group-text">비밀번호</span>
                            <input class="form-control" type="password" name="memberPassword" onkeyup="check_password(this.value)">
                        </div>
                        <div id="check-password-aria" class="mb-3"></div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">이름</span>
                            <input class="form-control" type="text" name="memberName">
                        </div>
                        <div class="input-group">
                            <span class="input-group-text">휴대폰</span>
                            <input class="form-control" type="text" name="memberMobile" placeholder="010-0000-0000" onkeyup="check_mobile(this.value)">
                        </div>
                        <div id="check-mobile-aria" class="mb-3"></div>
                        <input type="file" id="profile" name="memberProfile" accept="image/*" style="display:none;">
                    </div>
                    <div class="text-center">
                        <button class="btn btn-primary px-3">회원가입</button>
                        <button class="btn btn-secondary px-3" type="button" onclick="cancel_fn()">취소</button>
                    </div>
                </div>
            </form>
        </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
</body>
<script>
    let checkEmail = false;

    const passwordReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$!%*?&])[A-Za-z\d@#$!%*?&]{8,15}$/;
    let checkPassword = false;
    let checkPasswordArea = document.querySelector("#check-password-aria");

    const mobileReg = /^(010)-\d{3,4}-\d{4}$/;
    let checkMobileArea = document.querySelector("#check-mobile-aria");
    let checkMobile = false;

    const check_mobile = (mobile) => {
        if(!mobileReg.test(mobile)){
            checkMobileArea.innerHTML = "휴대폰은 010-0000-0000 형식입니다.";
            checkMobileArea.style.color = "red";
            checkMobile = false;
        } else {
            checkMobileArea.innerHTML = "올바른 형식입니다.";
            checkMobileArea.style.color = "green";
            checkMobile = true;
        }
    };

    const check_password = (password) => {
        if(!passwordReg.test(password)){
            checkPasswordArea.innerHTML = "비밀번호는 8~15글자이며, 숫자, 영어, 특수문자를 포함해야 됩니다.";
            checkPasswordArea.style.color = "red";
            checkPassword = false;
        } else {
            checkPasswordArea.innerHTML = "올바른 비밀번호 입니다.";
            checkPasswordArea.style.color = "green";
            checkPassword = true;
        }
    };
    const checkEmailAria = document.getElementById("check-email-aria");
    document.getElementById("profile-image").addEventListener("click", () => {
        document.getElementById("profile").click();
    })
    document.getElementById("profile").addEventListener("change", (e) => {
        document.getElementById("profile-image").src = URL.createObjectURL(e.target.files[0]);
    })
    const check_false = () => {
        checkEmail = false;
        checkEmailAria.innerHTML = "";
    }
    const check_email = () => {
        const email = document.getElementById("memberEmail").value;
        if (email == "") {
            checkEmailAria.innerHTML = "이메일을 입력하세요.";
            checkEmailAria.style.color = "red";
            checkEmail = false;
        } else {
            $.ajax({
                type: "post",
                url: "/member/duplicate-check",
                data: {memberEmail: email},
                success: function () {
                    checkEmail = true;
                    checkEmailAria.innerHTML = "사용가능한 이메일 입니다."
                    checkEmailAria.style.color = "green";
                }, error: function () {
                    checkEmailAria.innerHTML = "이미 사용중인 이메일 입니다."
                    checkEmailAria.style.color = "red";
                    checkEmail = false;
                }
            })
        }
    }

    document.memberSave.addEventListener("submit", function (e) {
        e.preventDefault()
        let password = this.memberPassword;
        let name = this.memberName;
        if (!checkEmail) {
            alert("이메일을 확인해 주세요")
            this.memberEmail.focus();
        } else if (!checkPassword) {
            alert("비밀번호를 확인해 주세요")
            password.focus();
        } else if (name.value == "") {
            alert("이름을 입력해주새요")
            name.focus();
        } else {
            this.submit();
        }
    })

    const cancel_fn = () => {
        location.href = "/";
    }
</script>
</html>
