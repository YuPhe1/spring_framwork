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
    <img src="https://via.placeholder.com/100x100" alt="" width="100" height="100">
</c:if>
<p>
    id: ${member.id}<br>
    이메일: ${member.memberEmail}<br>
    이름: ${member.memberName}<br>
    휴대폰: ${member.memberMobile}
</p>
<button onclick="home()">홈</button>
<button onclick="member_update_fn('${member.id}')">수정</button>
</body>
<script>
    const home = () => {
        location.href = "/";
    }
    const member_update_fn = (id) => {
        location.href = "/member/update?id=" + id;
    }

</script>
</html>
