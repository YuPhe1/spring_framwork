<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>회원정보</title>
</head>
<body>
<c:if test="${member.profileAttached == 1}">
    <img src="${pageContext.request.contextPath}/member_upload/${memberProfile.storedFileName}" alt="" width="100"
         height="100">
</c:if>
<c:if test="${member.profileAttached == 0}">
    <img src="https://via.placeholder.com/120x174" alt="" width="100" height="100">
</c:if>
<p>
    ${member.id}<br>
    ${member.memberEmail}<br>
    ${member.memberName}<br>
    ${member.memberMobile}
</p>
</body>
</html>
