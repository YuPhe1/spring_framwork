<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>홈</title>
</head>
<body>
    <c:forEach items="${demoList}" var="demo">
        ${demo.name} : ${demo.age} <hr>
    </c:forEach>
</body>
<script>
</script>
</html>