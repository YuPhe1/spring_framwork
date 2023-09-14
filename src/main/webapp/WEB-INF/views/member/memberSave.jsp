<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
</head>
<body>
<h2>회원가입</h2>
<form action="/member/save" method="post" enctype="multipart/form-data">
    이메일: <input type="text" name="memberEmail"><button type="button">중복체크</button> <br>
    비밀번호: <input type="password" name="memberPassword"><br>
    이름: <input type="text" name="memberName"><br>
    휴대폰: <input type="text" name="memberMobile"><br>
    이미지: <input type="file" name="memberProfile" accept="image/*"><br>
    <button>회원가입</button>
    <button type="button">취소</button>
</form>
</body>
</html>
