<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 목록</title>
</head>
<body>
<button onclick="board_save_fn()">글작성</button>
</body>
<script>
    const board_save_fn = () => {
        const loginEmail = '${sessionScope.loginEmail}';
        if(loginEmail.length == 0){
            location.href = "/member/login?target=/board/save";
        } else {
            location.href = "/board/save";
        }
    }
</script>
</html>
