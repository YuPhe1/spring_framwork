<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h2>req5</h2>
    <c:forEach items="${studyDTOList}" var="dto">
        ${dto.p1}, ${dto.p2}, ${dto.p3} <br>
    </c:forEach>
</body>
</html>
