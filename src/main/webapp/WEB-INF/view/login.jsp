<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | MyDoctor</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        html, body {
            height: 100%;
            overflow: hidden;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 0;
        }
        .container {
            width: 100%;
            max-width: 460px;
            background: white;
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #4a4a4a;
            margin: 0 0 8px 0;
            font-size: 24px;
            font-weight: 500;
        }
        p {
            color: #666;
            margin: 0 0 24px 0;
            font-size: 14px;
        }
        .form-group {
            margin-bottom: 16px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #4a4a4a;
            font-size: 14px;
        }
        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #20B2AA;
            box-shadow: 0 0 0 2px rgba(32,178,170,0.2);
        }
        button {
            width: 100%;
            padding: 12px;
            background-color: #20B2AA;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            margin: 24px 0 16px 0;
            font-weight: 500;
        }
        button:hover {
            background-color: #1a9690;
        }
        .register-link {
            text-align: left;
            font-size: 14px;
            color: #666;
        }
        .register-link a {
            color: #20B2AA;
            text-decoration: none;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: #dc3545;
            background-color: #f8d7da;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 16px;
            font-size: 14px;
        }
        .remember-container {
            display: flex;
            align-items: center;
            margin-bottom: 16px;
        }
        .remember-container input {
            width: auto;
            margin-right: 8px;
        }
        .remember-container label {
            margin-bottom: 0;
        }
        .home-link {
            text-align: center;
            margin-top: 16px;
        }
        .home-link a {
            color: #666;
            text-decoration: none;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }
        .home-link a:hover {
            color: #20B2AA;
        }
    </style>
</head>
<body>
    <jsp:include page="../components/message.jsp"/>
    
    <div class="container">
        <h1>Login</h1>
        <p>Please log in to access your account</p>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>

        <form name="loginForm" action="<c:url value='/login' />" method="POST" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <div class="form-group">
                <label for="role">Role</label>
                <select id="role" name="role" required>
                    <option value="">Select a role</option>
                    <option value="admin">Admin</option>
                    <option value="doctor">Doctor</option>
                    <option value="patient">Patient</option>
                </select>
            </div>

            <div class="remember-container">
                <input type="checkbox" id="remember" name="remember">
                <label for="remember">Remember Me</label>
            </div>

            <button type="submit">Login</button>

            <div class="register-link">
                Don't have an account? <a href="<c:url value='/register' />">Create Account</a>
            </div>
        </form>
        <div class="home-link">
            <a href="<c:url value='/' />">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                    <polyline points="9 22 9 12 15 12 15 22"></polyline>
                </svg>
                Return to Homepage
            </a>
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

            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(email.value)) {
                alert("Please enter a valid email address");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
