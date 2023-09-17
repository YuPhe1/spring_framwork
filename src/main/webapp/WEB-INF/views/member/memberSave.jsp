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
                        <img src="https://via.placeholder.com/100x100" alt="" width="180px" id="profile-image">
                    </div>
                    <div class="col-10">
                        <div class="input-group mb-3">
                            <span class="input-group-text">이메일</span>
                            <input class="form-control" type="text" id="memberEmail" name="memberEmail"
                                   onkeyup="check_false()">
                            <button class="btn btn-secondary" type="button" onclick="check_email()">중복체크</button>
                        </div>
                        <div id="check-email-aria"></div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">비밀번호</span>
                            <input class="form-control" type="password" name="memberPassword">
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">이름</span>
                            <input class="form-control" type="text" name="memberName">
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">휴대폰</span>
                            <input class="form-control" type="text" name="memberMobile" placeholder="010-0000-0000">
                        </div>
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
        } else if (password.value == "") {
            alert("비밀번호를 입력해주새요")
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
