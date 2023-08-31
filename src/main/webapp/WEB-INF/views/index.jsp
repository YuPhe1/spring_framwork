<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>홈</title>
</head>
<body>
    <h1>안녕하세요</h1>
    <a href="/demo1">demo1 주소 요청</a>
    <br>
    <!-- form 태그로 파라미터 보내기 -->
    <form action="/demo2" method="post">
        param1: <input type="text" name="param1"><br>
        param2: <input type="text" name="param2"><br>
        <input type="submit" value="전송">
    </form>
    <form action="/demo3" method="post">
        param1: <input type="text" name="param1"><br>
        param2: <input type="text" name="param2"><br>
        <input type="submit" value="전송">
    </form>
</body>
</html>