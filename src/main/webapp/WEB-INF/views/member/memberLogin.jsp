<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
이메일: <input type="text" id="memberEmail"><br>
비밀번호: <input type="password" id="memberPassword"><br>
<div id="login-aria"></div>
<button onclick="login()">로그인</button>
</body>
<script>
    const target = '${target}';
    const login = () => {
        const login_aria = document.getElementById("login-aria");
        const email = document.getElementById("memberEmail").value;
        const password = document.getElementById("memberPassword").value;
        console.log(email+ " : " + password);
        if(email == ""){
            document.getElementById("memberEmail").focus();
            login_aria.innerHTML = "이메일을 입력하세요";
            login_aria.style.color = "red";
        } else if (password == ""){
            document.getElementById("memberPassword").focus();
            login_aria.innerHTML = "비밀번호를 입력하세요";
            login_aria.style.color = "red";
        } else {
            $.ajax({
                type:"post",
                url:"/member/login",
                data:{memberEmail: email, memberPassword:password},
                success:function (){
                    if(target.length == 0) {
                        location.href = "/";
                    } else {
                        location.href = target;
                    }
                }, error: function (){
                    login_aria.innerHTML = "이메일 또는 비밀번호가 틀렸습니다.";
                    login_aria.style.color = "red";
                }
            })
        }
    }
</script>
</html>
