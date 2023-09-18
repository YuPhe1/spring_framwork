<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>게시글 목록</title>
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
        <h3 class="text-center mb-3">게시판</h3>
    </div>
</div>
<div class="row justify-content-center">
    <div class="col-10">
        <form action="/board/list">
            <div class="row justify-content-end">
                <div class="col-2">
                    <div class="input-group mb-3">
                        <select class="form-select" name="limit" onchange="change_limit(this.value)">
                            <option value="5" <c:if test="${limit == 5}"> selected</c:if>>5개씩</option>
                            <option value="10" <c:if test="${limit == 10}"> selected</c:if>>10개씩</option>
                            <option value="15" <c:if test="${limit == 15}"> selected</c:if>>15개씩</option>
                        </select>
                    </div>
                </div>
                <div class="col-2">
                    <div class="input-group mb-3">
                        <select class="form-select" name="order" onchange="change_order(this.value)">
                            <option value="id" <c:if test="${order == 'id'}"> selected</c:if>>최신글</option>
                            <option value="boardHits" <c:if test="${order == 'boardHits'}"> selected</c:if>>조회수순</option>
                        </select>
                    </div>
                </div>
                <div class="col-4"></div>
                <div class="col-4">
                    <div class="input-group mb-3">
                        <select class="form-select" name="searchType">
                            <option value="boardTitle" selected>글제목</option>
                            <option value="boardWriter">작성자</option>
                        </select>
                        <input name="q" class="form-control">&nbsp;
                        <button class="btn btn-primary">검색</button>
                    </div>
                </div>
            </div>
        </form>
        <div id="list" class="m-3">
            <table class='table'>
                <tr class='table-dark'>
                    <th>Id</th>
                    <th>글제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                </tr>
                <c:forEach items="${boardList}" var="board">
                    <tr>
                        <td>${board.id}</td>
                        <td>
                            <a href="/board?id=${board.id}&page=${paging.page}&searchType=${type}&q=${q}&limit=${limit}&order=${order}">${board.boardTitle}</a>
                        </td>
                        <td>${board.boardWriter}</td>
                        <td>${board.boardHits}</td>
                        <td>${board.createdAt}</td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="text-end">
            <button class="btn btn-primary" onclick="board_save_fn()">글작성</button>
        </div>
        <div class="container">
            <ul class="pagination justify-content-center">
                <c:choose>
                    <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
                    <c:when test="${paging.page<=1}">
                        <li class="page-item disabled">
                            <a class="page-link">[이전]</a>
                        </li>
                    </c:when>
                    <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link"
                               href="/board/list?page=${paging.page-1}&searchType=${type}&q=${q}&limit=${limit}&order=${order}">[이전]</a>
                        </li>
                    </c:otherwise>
                </c:choose>

                <%--  for(int i=startPage; i<=endPage; i++)      --%>
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                    <c:choose>
                        <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
                        <c:when test="${i eq paging.page}">
                            <li class="page-item active">
                                <a class="page-link">${i}</a>
                            </li>
                        </c:when>

                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link"
                                   href="/board/list?page=${i}&searchType=${type}&q=${q}&limit=${limit}&order=${order}">${i}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:choose>
                    <c:when test="${paging.page>=paging.maxPage}">
                        <li class="page-item disabled">
                            <a class="page-link">[다음]</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link"
                               href="/board/list?page=${paging.page+1}&searchType=${type}&q=${q}&limit=${limit}&order=${order}">[다음]</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
</body>
<script>
    const page = '${paging.page}';
    const searchType = '${type}';
    const q = '${q}';
    const order = '${order}';
    const limit = '${limit}';

    const change_limit = (limit) => {
        location.href = "/board/list?page=1&searchType=" + searchType + "&q=" + q + "&limit=" + limit + "&order=" + order;
    }

    const change_order = (order) => {
        location.href = "/board/list?page=1&searchType=" + searchType + "&q=" + q + "&limit=" + limit + "&order=" + order;
    }

    const board_save_fn = () => {
        const loginEmail = '${sessionScope.loginEmail}';
        if (loginEmail.length == 0) {
            location.href = "/member/login?target=/board/save";
        } else {
            location.href = "/board/save";
        }
    }
</script>
</html>
