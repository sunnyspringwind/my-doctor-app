<!-- doctor-dashboard.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Doctor Dashboard</title>
  <style>
    .form-container { width: 50%; margin: auto; padding: 1rem; border: 1px solid #ccc; border-radius: 8px; }
    input, select { width: 100%; padding: 0.5rem; margin: 0.5rem 0; }
    button { padding: 0.5rem 1rem; background: #4CAF50; color: white; border: none; cursor: pointer; }
    button:hover { background: #45a049; }
  </style>
  <script>
    function validateForm() {
      const name = document.forms["updateForm"]["name"].value;
      const email = document.forms["updateForm"]["email"].value;
      if (!name || !email.includes('@')) {
        alert("Valid name and email are required.");
        return false;
      }
      return true;
    }
  </script>
</head>
<body>

<h2>Welcome, Dr. <c:out value="${user.name}" /></h2>

<img src="pfp?userId=<c:out value='${user.doctorId}' />&role=doctor" width="100" height="100" alt="Profile Picture"/>

<div class="form-container">
  <form name="updateForm" action="<c:url value='/doctor' />" method="POST" enctype="multipart/form-data" onsubmit="return validateForm()">
    <input type="hidden" name="role" value="doctor" />
    <input type="hidden" name="id" value="<c:out value='${user.doctorId}' />" />

    <label>Name:</label>
    <input type="text" name="name" value="<c:out value='${user.name}' />" required />

    <label>Email:</label>
    <input type="email" name="email" value="<c:out value='${user.email}' />" required />

    <label>Speciality:</label>
    <input type="text" name="speciality" value="<c:out value='${user.speciality}' />" />

    <label>Experience:</label>
    <input type="number" name="experience" value="<c:out value='${user.experience}' />" />

    <label>Fees:</label>
    <input type="number" name="fees" step="0.01" value="<c:out value='${user.fees}' />" />

    <label>Degree:</label>
    <input type="text" name="degree" value="<c:out value='${user.degree}' />" />

    <label>Update Profile Picture:</label>
    <input type="file" name="pfp" accept="image/*" />

    <button type="submit">Update Profile</button>
  </form>
</div>

</div>
<a href="<c:url value='/logout' />">Logout</a>
</body>
</html>