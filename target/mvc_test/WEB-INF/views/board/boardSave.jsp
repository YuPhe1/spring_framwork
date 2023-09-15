<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글쓰기</title>
</head>
<body>
<form action="/board/save" method="post" name="boardSave" enctype="multipart/form-data">
    제목 : <input type="text" name="boardTitle"> <br>
    작성자 : <input type="text" name="boardWriter" value="${sessionScope.loginName}" readonly> <br>
    <input type="hidden" name="boardWriterId" value="${sessionScope.loginId}"> <br>
    <textarea cols="50" rows="10" name="boardContents" placeholder="내용"></textarea> <br>
    <input type="file" name="boardFile" multiple accept="image/*"> <br>
    <button>작성</button>
    <button type="button">취소</button>
</form>
</body>
<script>
    document.boardSave.addEventListener("submit", (e) => {
        e.preventDefault();
        const titleArea = document.boardSave.boardTitle;
        const contentsArea = document.boardSave.boardContents;
        if(titleArea.value == ""){
            alert("제목을 작성하세요.");
            titleArea.focus();
        } else if(contentsArea.value == ""){
            alert("내용을 작성하세요");
            contentsArea.focus();
        } else {
            document.boardSave.submit();
        }
    });
</script>
</html>
