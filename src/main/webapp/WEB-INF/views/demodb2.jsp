<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>홈</title>
</head>
<body>
    <table>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>age</th>
        </tr>
        <c:forEach items="${demoList}" var="demo">
        <tr>
            <td>${demo.id}</td>
            <td>${demo.name}</td>
            <td>${demo.age}</td>
        </tr>
        </c:forEach>
    </table>
</body>
<script>
</script>
</html>