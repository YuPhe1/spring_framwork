<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원목록</title>
</head>
<body>
<table>
  <tr>
    <th>Id</th>
    <th>이메일</th>
    <th>비밀번호</th>
    <th>이름</th>
    <th>휴대폰</th>
  </tr>
  <c:forEach items="${memberList}" var="member">
    <tr>
      <td>${member.id}</td>
      <td>${member.memberEmail}</td>
      <td>${member.memberPassword}</td>
      <td>${member.memberName}</td>
      <td>${member.memberMobile}</td>
    </tr>
  </c:forEach>
</table>
</body>
</html>
