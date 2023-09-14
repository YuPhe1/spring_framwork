<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>정보수정</title>
</head>
<body>
    <form action="/member/update" method="post" name="memberUpdate" enctype="multipart/form-data">
        <c:if test="${member.profileAttached == 1}">
            <img src="${pageContext.request.contextPath}/member_upload/${memberProfile.storedFileName}" alt="" width="100"
                 height="100" id="profile-image">
        </c:if>
        <div id="profile-name">
        <c:if test="${member.profileAttached == 1}">
            ${memberProfile.originalFileName}
        </c:if>
        </div>
        <c:if test="${member.profileAttached == 0}">
            <img src="https://via.placeholder.com/100x100" alt="" width="100" height="100" id="profile-image">
        </c:if>
        <input type="hidden" name="id" value="${member.id}">
        이메일: <input type="text" name="memberEmail" value="${member.memberEmail}" readonly><br>
        비밀번호: <input type="password" name="memberPassword" id="member-password"> <br>
        이름: <input type="text" name="memberName" value="${member.memberName}"><br>
        휴대폰: <input type="text" name="memberMobile" value="${member.memberMobile}" placeholder="010-0000-0000"><br>
        <input type="hidden" name="profileAttached" value="${member.profileAttached}" id="profileAttached">
        <input type="file" name="memberProfile" accept="image/*" id="profile"><br>
        <button>수정</button> <button type="button" onclick="cancel_fn()">취소</button>
    </form>
</body>
<script>
    document.memberUpdate.addEventListener("submit", (e) => {
        e.preventDefault();
        const loginPassword = '${member.memberPassword}';
        const password = document.getElementById("member-password").value;
        if(loginPassword == password){
            document.memberUpdate.submit();
        } else {
            alert("비밀번호가 틀렸습니다.");
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
