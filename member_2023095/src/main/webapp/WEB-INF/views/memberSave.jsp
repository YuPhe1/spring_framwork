<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/css/main.css">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <style>
    #section {
      margin: auto;
    }
  </style>
</head>
<body>
<%@include file="component/header.jsp"%>
<%@include file="component/nav.jsp"%>
<div id="section">
  <form action="/save" method="post">
    <input class="form-control" type="text" name="memberEmail" id="member-email" onkeyup="email_dup_check()" placeholder="이메일"> <br>
    <div id="check-email"></div>
    <input type="text" name="memberPassword" placeholder="비밀번호"> <br>
    <input type="text" name="memberName" placeholder="이름"> <br>
    <input type="text" name="memberBirth" placeholder="생년월일(YYYYMMDD)"> <br>
    <input type="text" name="memberMobile" placeholder="전화번호"> <br>
    <input type="submit" value="회원가입">
  </form>
</div>
<%@include file="component/footer.jsp"%>
<script>
  const email_dup_check = () => {
    const email = document.getElementById("member-email").value;
    const div = document.getElementById("check-email");
    $.ajax({
      type: "get",
      url: "/checkEmail",
      data: {email: email},
      success: function (){
          div.innerHTML = "사용가능한 이메일입니다.";
      },
      error: function (){
          div.innerHTML = "이미 사용된 이메일입니다."
      }
    })
  }
</script>
</body>
</html>