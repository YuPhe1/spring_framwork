<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>홈</title>
</head>
<body>
    <h1>index.jsp</h1>
    <a href="/req1?name=손흥민&age=31">req1</a>
    <hr>
    <a href="/req2">req2</a>
    <hr>
    <a href="/demodb1">demodb1.jsp로 이동</a>
    <hr>
    <!-- demodb2 주소를 요청하면 DB에서 demo_table의 모든 데이터를 가져와서
        demodb2.jsp로 이동해서  -->
    <a href="/demodb2">demodb2</a>
</body>
</html>