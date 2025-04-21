<html>
<head>
    <title>Landing Page</title>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

</head>
<body>
<h2>Landing Page</h2>
<%--pageContext is implict on jsp pages--%>
<a href="<c:url value='/register/' />">Register</a>
<a href="<c:url value='/login' />">Login</a>
</body>
</html>
