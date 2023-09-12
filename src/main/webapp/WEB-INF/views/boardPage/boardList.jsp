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
    </div>
</div>
<div class="row justify-content-center">
    <div class="col-10">
        <div class="row justify-content-end">
            <div class="col-4">
                <form name="search">
                    <div class="input-group mb-3">
                        <select class="form-select" name="searchType">
                            <option value="boardTitle" selected>글제목</option>
                            <option value="boardWriter">작성자</option>
                        </select>
                        <input name="q" class="form-control">&nbsp;
                        <button class="btn btn-primary">검색</button>
                    </div>
                </form>
            </div>
        </div>
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
        <div class="text-end">
            <button class="btn btn-primary" onclick="board_save()">글작성</button>
        </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
<script>
    const board_save = () => {
        location.href = "/board/save";
    }

    const board_detail = (id) => {
        location.href = "/board?id="+id;
    }
    document.search.addEventListener("submit", (e) => {
        e.preventDefault();
        const searchType = document.search.searchType.value;
        const q = document.search.q.value;
        $.ajax({
            type:"get",
            url:"/board/search",
            data:{"searchType":searchType, "q":q},
            success:function (res){
                const resultArea = document.getElementById("list");
                if(res.length > 0){
                    let result = "<table class='table'> <tr class='table-dark'> <th>Id</th>";
                    result += "<th>글제목</th><th>작성자</th><th>조회수</th><th>작성일</th> </tr>";
                    for(let i in res){
                        result += "<tr class='table-hover' onclick=board_detail("+res[i].id+")>";
                        result += "<td>" + res[i].id + "</td>";
                        result += "<td>" + res[i].boardTitle + "</td>";
                        result += "<td>" + res[i].boardWriter + "</td>";
                        result += "<td>" + res[i].boardHits + "</td>";
                        result += "<td>" + res[i].createdAt + "</td>";
                        result += "</tr>";
                    }
                    result += "</table>";
                    resultArea.innerHTML = result;
                } else {
                    resultArea.innerHTML = "<h4 class='text-center'>검색결과가 없습니다.</h4>";
                }
            }
        })
    })
</script>
</body>
</html>