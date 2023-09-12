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
        </div>
        <div class="text-end">
            <button class="btn btn-primary" onclick="board_save()">글작성</button>
        </div>
        <div id="page" class="text-center"> </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
<script>
    let searchType = document.search.searchType.value;
    let q = "";
    let page = 1;
    const board_save = () => {
        location.href = "/board/save";
    }
    const board_detail = (id) => {
        location.href = "/board?id="+id;
    }
    const get_list = () => {
        document.getElementById(page).style.fontWeight = "bold";
        $.ajax({
            type:"get",
            url:"/board/search",
            data:{"searchType":searchType, "q":q, "page":page},
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
    }

    const get_page = (resultPage) => {
      page = resultPage;
        get_paging();
    }
    const down_page_ten = () => {
        page = ((page/10)-1)*10 + 1;
        get_paging();
    }
    const down_page_one = () => {
        page = page - 1;
        get_paging();
    }
    const up_page_ten = () => {
        page = ((page/10)+1)*10 + 1;
        get_paging();
    }
    const up_page_one = () => {
        page = page + 1;
        get_paging();
    }
    const get_paging = () => {
        $.ajax({
            type:"get",
            url:"/board/getPaging",
            data:{"searchType":searchType, "q":q},
            success:function (res){
                const resultArea = document.getElementById("page");
                let result = "";
                if(res != 0){
                    let maxPage = Math.ceil(res/5);
                    console.log((page / 10).toFixed() == (2 / 10).toFixed());
                    console.log(res);
                    if((page / 10).toFixed() != 0){
                        result = "<span onclick=down_page_ten()><<</span>&nbsp;"
                    }
                    if(page != 1){
                        result += "<span onclick=down_page_one()><</span>&nbsp;"
                    }
                    if((page / 10).toFixed() == (maxPage / 10).toFixed()){
                        for(let i = 1; i <= maxPage % 10; i++){
                            let resultPage = (page / 10).toFixed() * 10 + i;
                            result += "<span onclick=get_page("+resultPage+") id="+resultPage+">"+resultPage+"&nbsp</span>"
                        }
                    } else {
                        for(let i = 1; i <= 10; i++){
                            let resultPage = (maxPage / 10).toFixed() * 10 + i;
                            result += "<span onclick=get_page("+resultPage+") id="+resultPage+">"+resultPage+"&nbsp</span> "
                        }
                    }
                    if(page != maxPage) {
                        result += "<span onclick=up_page_one()>></span> "
                    }
                    if((page / 10).toFixed() != (maxPage / 10).toFixed()){
                        result += "<span onclick=up_page_ten()>>></span> "
                    }
                    resultArea.innerHTML = result;
                    get_list();
                } else {
                    resultArea.innerHTML = "";
                }
            }
        })
    }

    document.search.addEventListener("submit", (e) => {
        e.preventDefault();
        page = 1;
        searchType = document.search.searchType.value;
        q = document.search.q.value;
        get_paging();
    })
    get_paging();
</script>
</body>
</html>