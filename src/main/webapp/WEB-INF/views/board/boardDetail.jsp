<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-10">
        <%@include file="../component/header.jsp" %>
        <%@include file="../component/nav.jsp" %>
        <div class="card p-3">
            <h5 class="card-title">${board.boardTitle}</h5>
            <hr>
            <h6 class="card-subtitle mb-2 text-body-secondary text-end">작성자: ${board.boardWriter}
                조회수: ${board.boardHits}</h6>
            <p class="card-text">${board.boardContents}</p>
            <c:if test="${board.fileAttached == 1}">
                <div class="row">
                <c:forEach items="${boardFileList}" var="boardFile">
                    <div class="col-3 text-center">
                    <img src="${pageContext.request.contextPath}/board_upload/${boardFile.storedFileName}" alt="" width="80%">
                    </div>
                </c:forEach>
                </div>
            </c:if>
            <h6 class="card-subtitle mb-2 text-body-secondary text-end">작성일: ${board.createdAt}</h6>
            <div class="text-center">
                <c:if test="${sessionScope.loginId == board.boardWriterId}">
                    <button class="btn btn-primary px-3" onclick="update_fn('${board.id}')">수정</button>
                </c:if>
                <button class="btn btn-secondary px-3" onclick="list_fn()">목록</button>
                <c:if test="${sessionScope.loginId == board.boardWriterId || sessionScope.loginEmail == 'admin'}">
                    <button class="btn btn-danger px-3" onclick="delete_fn('${board.id}')">삭제</button>
                </c:if>
            </div>
        </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
</body>
<script>
    const page = '${page}';
    const type = '${type}';
    const q = '${q}';
    const update_fn = (id) => {
        location.href = "/board/update?id=" + id;
    }
    const list_fn = () => {
        location.href = "/board/list?page=" + page + "&searchType=" + type + "&q=" + q;
    }
    const delete_fn = (id) => {
        if(confirm("해당 게시글을 삭제하시겠습니까?")) {
            location.href = "/board/delete?id=" + id;
        }
    }
</script>
</html>
