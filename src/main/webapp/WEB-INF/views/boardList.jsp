<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 목록</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</head>
<body>
<%@include file="component/header.jsp" %>
<%@include file="component/nav.jsp" %>
<div class="row justify-content-center">
    <div class="col-10">
        <h4 class="text-center">게시판</h4>
        <div class="text-end">
            <button class="btn btn-primary">글작성</button>
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
                </tr>
                <c:forEach items="${boardList}" var="board">
                    <tr>
                        <td>${board.id}</td>
                        <td>${board.boardTitle}</td>
                        <td>${board.boardWriter}</td>
                        <td>${board.boardHits}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
<%@include file="component/footer.jsp" %>
</body>
</html>