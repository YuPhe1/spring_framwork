<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="footer">

</div>
<script>
    const date = new Date();
    const footer = document.getElementById("footer");
    const footer1 = document.querySelector("#footer");
    footer.innerHTML = "<p class='text-center'>&copy;  " + date.getFullYear() + "&nbsp; codingrecipe All rights reserved. </p>";
</script>