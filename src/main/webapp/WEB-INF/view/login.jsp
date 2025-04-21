<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | MyDoctor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #eef2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background: #fff;
            padding: 2rem 3rem;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #333;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        label {
            display: block;
            margin-bottom: 0.3rem;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 0.6rem;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .remember-container {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .remember-container input {
            width: auto;
            margin-right: 0.5rem;
        }

        button {
            width: 100%;
            padding: 0.7rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 0.75rem;
            border: 1px solid #f5c6cb;
            border-radius: 6px;
            margin-bottom: 1rem;
            text-align: center;
        }

        .register-link {
            margin-top: 1rem;
            text-align: center;
        }

        .register-link a {
            color: #007bff;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Login</h2>

    <!-- Display error message if any -->
    <c:if test="${not empty error}">
        <div class="error-message">${error}</div>
    </c:if>

    <form name="loginForm" action="<c:url value='/login' />" method="POST" onsubmit="return validateForm()">
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>
        </div>

        <div class="form-group">
            <label for="role">Role:</label>
            <select id="role" name="role" required>
                <option value="">Select a role</option>
                <option value="doctor">Doctor</option>
                <option value="patient">Patient</option>
            </select>
        </div>

        <div class="remember-container">
            <input type="checkbox" id="remember" name="remember">
            <label for="remember">Remember Me</label>
        </div>

        <div class="form-group">
            <button type="submit">Login</button>
        </div>
    </form>

    <div class="register-link">
        <p>Don't have an account? <a href="<c:url value='/register' />">Register here</a></p>
    </div>
</div>

<script>
    function validateForm() {
        const email = document.getElementById("email");
        const password = document.getElementById("password");
        const role = document.getElementById("role").value;

        if (!email || !password || !role) {
            alert("All fields are required.");
            return false;
        }

        return true;
    }
</script>
</body>
</html>
