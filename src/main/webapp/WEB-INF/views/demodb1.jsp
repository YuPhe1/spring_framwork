<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>홈</title>
</head>
<body>
    <h1>demodb1.jsp</h1>
    <form action="/reqdb1" method="post">
    name : <input type="text" name="name"> <br>
    age : <input type="text" name="age" oninput="inNumber(this)"> <br>
    <input type="submit" value="제출">
    </form>
</body>
<script>
    function isNumber(item){
		item.value = item.value.replace(/[^0-9]/g, '');
	}
</script>
</html>