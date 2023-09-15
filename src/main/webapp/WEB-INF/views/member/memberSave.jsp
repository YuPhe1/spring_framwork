<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<h2>회원가입</h2>
<form action="/member/save" method="post" name="memberSave" enctype="multipart/form-data">
    <img src="https://via.placeholder.com/100x100" alt="" width="100" height="100" id="profile-image"><br>
    이메일: <input type="text" id="memberEmail" name="memberEmail" onkeyup="check_false()"><button type="button" onclick="check_email()">중복체크</button> <br>
    <div id="check-email-aria"></div>
    비밀번호: <input type="password" name="memberPassword"><br>
    이름: <input type="text" name="memberName"><br>
    휴대폰: <input type="text" name="memberMobile" placeholder="010-0000-0000"><br>
    <input type="file" id="profile" name="memberProfile" accept="image/*" style="display:none;"><br>
    <button>회원가입</button>
    <button type="button">취소</button>
</form>
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
        if(email == ""){
            checkEmailAria.innerHTML = "이메일을 입력하세요.";
            checkEmailAria.style.color = "red";
            checkEmail= false;
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
                    checkEmail= false;
                }
            })
        }
    }

    document.memberSave.addEventListener("submit", function (e) {
        e.preventDefault()
        let password = this.memberPassword;
        let name = this.memberName;
        if(!checkEmail){
            alert("이메일을 확인해 주세요")
            this.memberEmail.focus();
        } else if (password.value == ""){
            alert("비밀번호를 입력해주새요")
            password.focus();
        } else if (name.value == ""){
            alert("이름을 입력해주새요")
            name.focus();
        } else {
            this.submit();
        }
    })
</script>
</html>
