
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="nav" class="mb-4">
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">Home</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <c:if test="${sessionScope.loginEmail == 'admin'}">
                            <a class="nav-link active" aria-current="page" href="/member/list">회원목록</a>
                        </c:if>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/board/list">게시판</a>
                    </li>
                </ul>
                <ul class="navbar-nav justify-content-end mb-2 mb-lg-0">
                    <c:if test="${sessionScope.loginEmail == null}">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/member/save">회원가입</a>
                    </li>
                    </c:if>
                    <c:if test="${sessionScope.loginEmail == null}">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/member/login">로그인</a>
                    </li>
                    </c:if>
                    <c:if test="${sessionScope.loginEmail != null}">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="/member/logout">로그아웃</a>
                    </li>
                    </c:if>
                    <c:if test="${sessionScope.loginEmail != null}">
                    <li class="nav-item">
                        <a class="nav-link active me-2" aria-current="page"
                           href="/member/detail">${sessionScope.loginName}님</a>
                    </li>
                    </c:if>
            </div>
        </div>
        </ul>
    </nav>
</div>
