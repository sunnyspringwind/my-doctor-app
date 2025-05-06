<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Test Page</title>
</head>
<body>
<h2>EL Test</h2>

<!-- JSTL way -->
<p><strong>Using JSTL:</strong> <c:out value="${message}" /></p>

<!-- EL Directly -->
<p><strong>Using EL:</strong> ${message}</p>

<!-- Just to confirm scriptlets also work -->
<p><strong>Scriptlet echo:</strong> <%=(request.getAttribute("message")) %></p>
</body>
</html>
