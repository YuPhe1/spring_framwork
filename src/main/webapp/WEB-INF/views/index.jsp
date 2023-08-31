<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>홈</title>
</head>
<body>
    <h1>index.jsp</h1>
    <a href="/req1">req1</a>
    <a href="/req2?q1=안녕&q2=1234">req2</a>
    <!-- 아래 form에서 입력한 값을 DTO에 담아
        서비스 클래스의 req3() 메서드에서 DTO 값을 출력 -->
    <form action="/req3" method="post">
    p1 : <input type="text" name="p1"> <br>
    p2 : <input type="text" name="p2"> <br>
    p3 : <input type="text" name="p3" oninput="isNumber(this)"> <br>
    <input type="submit" value="제출">
    </form>
</body>
<script>
    function isNumber(item){
		item.value = item.value.replace(/[^0-9]/g, '');
	}
</script>
</html>