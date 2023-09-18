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
                            <img src="${pageContext.request.contextPath}/board_upload/${boardFile.storedFileName}"
                                 alt="" width="80%">
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
            <hr>
            <h4>댓글 목록</h4>
            <div>
                <c:if test="${sessionScope.loginEmail != null}">
                    <div class="card p-3 mb-3">
                        <div class="row">
                            <input type="hidden" value="${board.id}" name="boardId">
                            <input type="hidden" value="${sessionScope.loginId}" name="commentWriterId">
                            <div class="col-3 input-group mb-3">
                                <span class="input-group-text">작성자</span>
                                <input class="form-control" type="text" value="${sessionScope.loginName}" readonly>
                            </div>
                            <div class="input-group mb-3">
                                <textarea class="form-control" cols="3" id="comment-contents"></textarea>
                            </div>
                            <div class="text-end">
                                <button class="btn btn-primary px-3" onclick="comment_write()">작성</button>
                                <button onclick="comment_reset()" class="btn btn-secondary px-3">취소</button>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
            <div id="comment-list-area">
                <c:choose>
                    <c:when test="${commentList == null}">
                        <h4>작성된 댓글이 없습니다.</h4>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${commentList}" var="comment">
                            <div class="comment mb-3">
                                작성자: ${comment.commentWriter} 작성일: ${comment.createdAt}
                                <hr>
                                    ${comment.commentContents}
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
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
        if (confirm("해당 게시글을 삭제하시겠습니까?")) {
            location.href = "/board/delete?id=" + id;
        }
    }
    const comment_write = () => {
        const commentWriter = '${sessionScope.loginName}';
        const commentWriterId = '${sessionScope.loginId}';
        const commentContents = document.querySelector("#comment-contents").value;
        const boardId = '${board.id}';
        const result = document.querySelector("#comment-list-area");
        if (commentContents == "") {
            alert("내용을 입력하세요");
            document.querySelector("#comment-contents").focus();
        } else {
            $.ajax({
                type: "post",
                url: "/comment/save",
                data: {
                    commentWriterId: commentWriterId,
                    commentWriter: commentWriter,
                    commentContents: commentContents,
                    boardId: boardId
                },
                success: function (res) {
                    document.querySelector("#comment-contents").value = "";
                    let output = "";
                    for (let i in res) {
                        output = "<div class='comment mb-3'>";
                        output += "작성자:" + res[i].commentWriter + " 작성일:" + res[i].createdAt;
                        output += "<hr>";
                        output += res[i].commentContents;
                        output += "</div>";
                    }
                    result.innerHTML = output;
                },
                error: function () {
                    console.log("댓글 작성 실패")
                }
            })
        }
    }

    const comment_reset = () => {
        document.querySelector("#comment-contents").value = "";
    }
</script>
</html>
