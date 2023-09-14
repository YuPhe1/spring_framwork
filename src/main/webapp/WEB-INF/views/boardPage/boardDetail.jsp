<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 조회</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="row justify-content-center">
    <div class="col-10">
        <%@include file="../component/header.jsp" %>
        <%@include file="../component/nav.jsp" %>
    </div>
    <div class="col-10 card p-3">
        <h5 class="card-title">${board.boardTitle}</h5>
        <hr>
        <h6 class="card-subtitle mb-2 text-body-secondary text-end">작성자: ${board.boardWriter}
            조회수: ${board.boardHits}</h6>
        <p class="card-text">${board.boardContents}</p>
        <c:if test="${board.fileAttached == 1}">
            <c:forEach items="${boardFileList}" var="boardFile">
                <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}" alt="" width="100"
                     height="100">
            </c:forEach>
        </c:if>
        <h6 class="card-subtitle mb-2 text-body-secondary text-end">작성일: ${board.createdAt}</h6>
        <div class="text-center">
            <button class="btn btn-primary px-3" onclick="update_fn('${board.id}')">수정</button>
            <button class="btn btn-secondary px-3" onclick="list_fn()">목록</button>
            <button class="btn btn-danger px-3" onclick="delete_fn('${board.id}')">삭제</button>
        </div>
        <hr>
        <div id="comment-writer-area">
            <input type="text" class="form-control" id="comment-writer" placeholder="작성자"> <br>
            <input type="text" class="form-control" id="comment-contents" placeholder="내용"> <br>
            <div class="text-end mb-2">
                <button class="btn btn-secondary" onclick="comment_write()">댓글작성</button>
            </div>
        </div>
        <div id="comment-list-area">
            <c:choose>
                <c:when test="${commentList == null}">
                    <h4>작성된 댓글이 없습니다.</h4>
                </c:when>
                <c:otherwise>
                    <table class="table" id="comment-list">
                    <tr class="table-dark">
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성시간</th>
                    </tr>
                    <c:forEach items="${commentList}" var="comment">
                        <tr>
                            <td>${comment.commentWriter}</td>
                            <td>${comment.commentContents}</td>
                            <td>${comment.createdAt}</td>
                        </tr>
                    </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="col-10">
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
<script>
    const comment_write = () => {
        const commentWriter = document.getElementById("comment-writer").value;
        const commentContents = document.querySelector("#comment-contents").value;
        const boardId = '${board.id}';
        const result = document.querySelector("#comment-list-area");
        $.ajax({
            type: "post",
            url: "/comment/save",
            data: {
                commentWriter: commentWriter,
                commentContents: commentContents,
                boardId: boardId
            },
            success: function (res) {
                document.getElementById("comment-writer").value = "";
                document.querySelector("#comment-contents").value = "";
                let output = "<table class=\"table\" id=\"comment-list\">\n" +
                    "    <tr class=\"table-dark\">\n" +
                    "        <th>작성자</th>\n" +
                    "        <th>내용</th>\n" +
                    "        <th>작성시간</th>\n" +
                    "    </tr>\n";
                for (let i in res) {
                    output += "    <tr>\n";
                    output += "        <td>" + res[i].commentWriter + "</td>\n";
                    output += "        <td>" + res[i].commentContents + "</td>\n";
                    output += "        <td>" + res[i].createdAt + "</td>\n";
                    output += "    </tr>\n";
                }
                output += "</table>";
                result.innerHTML = output;
            },
            error: function () {
                console.log("댓글 작성 실패")
            }
        })
    }
    const update_fn = (id) => {
        location.href = "/board/update?id=" + id;
    }
    const delete_fn = (id) => {
        location.href = "/board/delete?id=" + id;
    }
    const list_fn = () => {
        const page = '${page}';
        const type = '${type}';
        const q = '${q}';
        location.href = "/board/list?page=" + page + "&type=" + type + "&q=" + q;
    }

    get_content();
</script>
</body>
</html>
