<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>정보수정</title>
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
            <form action="/member/update" method="post" name="memberUpdate" enctype="multipart/form-data">
                <div class="row justify-content-center">
                    <div class="col-2 text-center mb-3">
                        <c:if test="${member.profileAttached == 1}">
                            <img src="${pageContext.request.contextPath}/member_upload/${memberProfile.storedFileName}"
                                 alt=""
                                 width="180px"
                                 id="profile-image">
                        </c:if>
                        <c:if test="${member.profileAttached == 0}">
                            <img src="https://via.placeholder.com/100x100" alt="" width="90%"
                                 id="profile-image">
                        </c:if>
                    </div>
                    <div class="col-10">
                        <input type="hidden" name="id" value="${member.id}">
                        <div class="input-group mb-3">
                            <span class="input-group-text">이메일</span>
                            <input type="text" class="form-control" name="memberEmail" value="${member.memberEmail}"
                                   readonly>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">비밀번호</span>
                            <input type="password" class="form-control" name="memberPassword" id="member-password">
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">이름</span>
                            <input type="text" class="form-control" name="memberName" value="${member.memberName}">
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text">휴대폰</span>
                            <input type="text" id="mobile" class="form-control" name="memberMobile" value="${member.memberMobile}"
                                   placeholder="010-0000-0000">
                        </div>
                        <input type="hidden" name="profileAttached" value="${member.profileAttached}"
                               id="profileAttached">
                        <div class="input-group mb-3">
                            <input type="file" class="form-control" name="memberProfile" accept="image/*" id="profile"
                                   style="display: none">
                        </div>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-primary px-3">수정</button>
                        <button class="btn btn-secondary px-3" type="button" onclick="cancel_fn()">취소</button>
                    </div>
                </div>
            </form>
        </div>
        <%@include file="../component/footer.jsp" %>
    </div>
</div>
</body>
<script>
    document.getElementById("profile-image").addEventListener("click", () => {
        document.getElementById("profile").click();
    })
    document.memberUpdate.addEventListener("submit", (e) => {
        e.preventDefault();
        const loginPassword = '${member.memberPassword}';
        const password = document.getElementById("member-password").value;
        const mobileReg = /^(010)-\d{3,4}-\d{4}$/;
        const mobile = document.getElementById("mobile").value;
        if (loginPassword != password) {
            alert("비밀번호가 틀렸습니다.");
        } else if(!mobileReg.test(mobile)){
            alert("휴대폰 번호의 형식은 010-0000-0000 입니다.")
        } else {
            document.memberUpdate.submit();
        }
    })
    document.getElementById("profile").addEventListener("change", (e) => {
        document.getElementById("profile-image").src = URL.createObjectURL(e.target.files[0]);
        document.getElementById("profile-name").innerHTML = "";
        document.getElementById("profileAttached").value = 1;
    })

    const cancel_fn = () => {
        location.href = "/member/detail";
    }
</script>
</html>
