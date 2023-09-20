<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>홈</title>
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
        <form action="/board/update" method="post" name="boardUpdate" enctype="multipart/form-data">
            <input type="hidden" name="id" value="${board.id}">
            <div class="input-group mb-3">
                <span class="input-group-text">제목</span>
                <input class="form-control" type="text" name="boardTitle" value="${board.boardTitle}">
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">작성자</span>
                <input class="form-control" type="text" name="boardWriter" value="${sessionScope.loginName}" readonly>
            </div>
            <div class="input-group mb-3">
                <textarea class="form-control" cols="10" name="boardContents" placeholder="내용">${board.boardContents}</textarea>
            </div>
            <c:if test="${board.fileAttached == 1}">
                <div class="input-group mb-3">
                    <span class="input-group-text">지울 파일 선택</span>
                    <span class="form-control">
                    <c:forEach items="${boardFileList}" var="file">
                        <input type="checkbox" name="deleteFile" value="${file.storedFileName}">${file.originalFileName}&nbsp;
                    </c:forEach>
                    </span>
                </div>
            </c:if>
            <input type="hidden" name="fileAttached" value="${board.fileAttached}">
            <div class="input-group mb-3">
                <input class="form-control" type="file" name="boardFile" multiple accept="image/*">
            </div>
            <div class="text-center">
                <button class="btn btn-primary px-3">수정</button>
                <button class="btn btn-secondary px-3" onclick="cancel_fn()" type="button">취소</button>
            </div>
        </form>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
</body>
<script>
    const cancel_fn = () => {
        location.href = "/board?id=" + ${board.id};
    }
</script>
</html>
