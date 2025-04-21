<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register | MyDoctor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .register-container {
            background: #fff;
            padding: 2rem 3rem;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
            width: 400px;
        }

        h2 {
            text-align: center;
            margin-bottom: 1rem;
            color: #333;
        }

        label {
            display: block;
            margin-bottom: 0.3rem;
            font-weight: 600;
        }

        input, select {
            width: 100%;
            padding: 0.6rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .error {
            color: red;
            margin-bottom: 1rem;
            text-align: center;
        }

        button {
            width: 100%;
            padding: 0.6rem;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        button:hover {
            background: #0056b3;
        }
    </style>
    <script>
        function validateForm() {
            const errorDiv = document.getElementById("validationError");
            errorDiv.innerHTML = ""; // Clear any previous errors

            const name = document.forms["registerForm"]["name"].value.trim();
            const email = document.forms["registerForm"]["email"].value.trim();
            const password = document.forms["registerForm"]["password"].value.trim();
            const role = document.forms["registerForm"]["role"].value;

            if (!name || !email || !password || !role) {
                errorDiv.innerHTML = "Please fill in all fields.";
                return false;
            }

            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailRegex.test(email)) {
                errorDiv.innerHTML = "Please enter a valid email.";
                return false;
            }

            return true;
        }

        // Check for server-side errors on page load
        window.onload = function() {
            const serverError = document.getElementById("serverError");
            const validationError = document.getElementById("validationError");

            // If there's a server error, copy it to the validation error div
            if (serverError && serverError.innerHTML.trim() !== "") {
                validationError.innerHTML = serverError.innerHTML;
            }
        }
    </script>
</head>
<body>

<div class="register-container">
    <h2>Create an Account</h2>

    <!-- Hidden div to store server-side errors -->
    <div id="serverError" style="display: none;">
        <c:if test="${not empty error}">${error}</c:if>
    </div>

    <!-- This div will display both client and server-side errors -->
    <div id="validationError" class="error"></div>

    <form name="registerForm" action="<c:url value="/register" />" method="post" onsubmit="return validateForm()">
        <label for="name">Full Name</label>
        <input type="text" id="name" name="name" placeholder="Enter your full name">

        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="example@example.com">

        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="********">

        <label for="role">Role</label>
        <select id="role" name="role">
            <option value="">Select role</option>
            <option value="DOCTOR">Doctor</option>
            <option value="PATIENT">Patient</option>
        </select>

        <button type="submit">Register</button>
    </form>
</div>
</body>
</html>