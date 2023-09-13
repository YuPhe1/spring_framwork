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
            <table class='table'>
                <tr class='table-dark'>
                    <th>Id</th>
                    <th>글제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                </tr>
                <c:forEach items="${boardList}" var="board">
                    <tr onclick="board_detail('${board.id}')" class="table-hover">
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
                            <a class="page-link" href="/board/list?page=${paging.page-1}">[이전]</a>
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
                                <a class="page-link" href="/board/list?page=${i}">${i}</a>
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
                            <a class="page-link" href="/board/list?page=${paging.page+1}">[다음]</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
<script>
    let searchType = document.search.searchType.value;
    let q = "";
    const board_save = () => {
        location.href = "/board/save";
    }
    const board_detail = (id) => {
        location.href = "/board?id=" + id;
    }
    // 내가 해본 방법
    // const get_list = () => {
    //     document.getElementById(page).style.fontWeight = "bold";
    //     $.ajax({
    //         type:"get",
    //         url:"/board/search",
    //         data:{"searchType":searchType, "q":q, "page":page},
    //         success:function (res){
    //             const resultArea = document.getElementById("list");
    //             if(res.length > 0){
    //                 let result = "<table class='table'> <tr class='table-dark'> <th>Id</th>";
    //                 result += "<th>글제목</th><th>작성자</th><th>조회수</th><th>작성일</th> </tr>";
    //                 for(let i in res){
    //                     result += "<tr class='table-hover' onclick=board_detail("+res[i].id+")>";
    //                     result += "<td>" + res[i].id + "</td>";
    //                     result += "<td>" + res[i].boardTitle + "</td>";
    //                     result += "<td>" + res[i].boardWriter + "</td>";
    //                     result += "<td>" + res[i].boardHits + "</td>";
    //                     result += "<td>" + res[i].createdAt + "</td>";
    //                     result += "</tr>";
    //                 }
    //                 result += "</table>";
    //                 resultArea.innerHTML = result;
    //             } else {
    //                 resultArea.innerHTML = "<h4 class='text-center'>검색결과가 없습니다.</h4>";
    //             }
    //         }
    //     })
    // }
    //
    // const get_page = (resultPage) => {
    //   page = resultPage;
    //     get_paging();
    // }
    // const down_page_ten = () => {
    //     page = (Math.floor(page/10)-1)*10 + 1;
    //     get_paging();
    // }
    // const down_page_one = () => {
    //     page = page - 1;
    //     get_paging();
    // }
    // const up_page_ten = () => {
    //     page = (Math.floor(page/10)+1) * 10 + 1;
    //     console.log(page)
    //     get_paging();
    // }
    // const up_page_one = () => {
    //     page = page + 1;
    //     get_paging();
    // }
    // const get_paging = () => {
    //     $.ajax({
    //         type:"get",
    //         url:"/board/getPaging",
    //         data:{"searchType":searchType, "q":q},
    //         success:function (res){
    //             const resultArea = document.getElementById("page");
    //             let result = "";
    //             if(res != 0){
    //                 let maxPage = Math.ceil(res/5);
    //                 if(Math.floor((page-1) / 10) != 0){
    //                     result = "<span class='page' onclick=down_page_ten()><<&nbsp;</span>"
    //                 }
    //                 if(page != 1){
    //                     result += "<span class='page' onclick=down_page_one()><&nbsp;</span>"
    //                 }
    //                 if(Math.floor((page-1) / 10) == Math.floor(maxPage / 10)){
    //                     for(let i = 1; i <= maxPage % 10; i++){
    //                         let resultPage = Math.floor((page-1) / 10) * 10 + i;
    //                         result += "<span class='page' onclick=get_page("+resultPage+") id="+resultPage+">"+resultPage+"&nbsp</span>"
    //                     }
    //                 } else {
    //                     for(let i = 1; i <= 10; i++){
    //                         let resultPage = Math.floor((page-1) / 10) * 10 + i;
    //                         result += "<span class='page' onclick=get_page("+resultPage+") id="+resultPage+">"+resultPage+"&nbsp</span> "
    //                     }
    //                 }
    //                 if(page != maxPage) {
    //                     result += "<span class='page' onclick=up_page_one()>>&nbsp;</span>"
    //                 }
    //                 if(Math.floor((page-1) / 10) != Math.floor(maxPage / 10)){
    //                     result += "<span class='page' onclick=up_page_ten()>>></span> "
    //                 }
    //                 resultArea.innerHTML = result;
    //                 get_list();
    //             } else {
    //                 resultArea.innerHTML = "";
    //             }
    //         }
    //     })
    // }
    //
    document.search.addEventListener("submit", (e) => {
        e.preventDefault();
        //     page = 1;
        searchType = document.search.searchType.value;
        q = document.search.q.value;
        //     get_paging();
    })
    // get_paging();
</script>
</body>
</html>