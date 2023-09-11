<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시글 목록</title>
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-10">
        <%@include file="../component/header.jsp" %>
        <%@include file="../component/nav.jsp" %>
        <h3 class="text-center mb-3">게시판</h3>
        <div class="text-end">
            <button class="btn btn-primary" onclick="board_save()">글작성</button>
        </div>
    </div>
</div>
<div class="row justify-content-center">
    <div class="col-10">
        <div id="list" class="m-3">
            <table class="table">
                <tr class="table-dark">
                    <th>Id</th>
                    <th>글제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                </tr>
                <c:forEach items="${boardList}" var="board">
                    <tr class="table-hover" onclick="board_detail('${board.id}')">
                        <td>${board.id}</td>
                        <td>${board.boardTitle}</td>
                        <td>${board.boardWriter}</td>
                        <td>${board.boardHits}</td>
                        <td>${board.createdAt}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
<script>
    const board_save = () => {
        location.href = "/board/save";
    }

    const board_detail = (id) => {
        location.href = "/board/detail?id="+id;
    }
</script>
</body>
</html>