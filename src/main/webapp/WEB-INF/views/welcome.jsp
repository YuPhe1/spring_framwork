<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>홈</title>
</head>
<body>
    <h1>안녕하세요~ 반갑습니다!</h1>
    <!-- 페이지 이동 -->
    <!-- req1 주소를 요청하는 링크 -->
    <a href="/req1">req1 주소 요청</a>
    <br>
    <br>

    <!-- query string(주소값에 파라미터 전달하기) -->
    <a href="/req2?q1=안녕&q2=10">query string</a>
    <br>

    <!-- form 태그로 파라미터 보내기 -->
    <form action="/req3">
        p1: <input type="text" name="p1"><br>
        p2: <input type="text" name="p2"><br>
        <input type="submit" value="전송">
    </form>
</body>
</html>