<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>홈</title>
</head>
<body>
    <h1>req2.jsp</h1>
    <c:forEach items="${demoList}" var="demo">
        ${demo} <hr>
        name = ${demo.name} <br>
        age = ${demo.age} <hr>
        <hr>
    </c:forEach>
</body>
</html>