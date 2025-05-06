<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | MyDoctor</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            width: 90%;
            max-width: 600px;
            background-color: white;
            padding: 32px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: left;
            color: #4a4a4a;
            margin: 0 0 8px 0;
            font-size: 24px;
            font-weight: 500;
        }
        .subtitle {
            color: #666;
            margin: 0 0 24px 0;
            font-size: 14px;
            text-align: left;
        }
        .form-group {
            margin-bottom: 16px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #4a4a4a;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
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
            background-color: #20B2AA;
            color: white;
            border: none;
            padding: 12px;
            font-size: 14px;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-weight: 500;
            margin: 24px 0 16px 0;
        }
        button:hover {
            background-color: #1a9690;
        }
        .login-link {
            text-align: left;
            font-size: 14px;
            color: #666;
        }
        .login-link a {
            color: #20B2AA;
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: #dc3545;
            margin-bottom: 16px;
            padding: 12px;
            background-color: #f8d7da;
            border-radius: 8px;
            font-size: 14px;
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
    <div class="container">
        <h1>Create an Account</h1>
        <p class="subtitle">Please sign up to access your account</p>

        <!-- This div will display both client and server-side errors -->
        <c:if test="${not empty error}">
            <div id="validationError" class="error-message">
                ${error}
            </div>
        </c:if>

        <form name="registerForm" action="<c:url value="/register" />" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" placeholder="Enter your full name">
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="example@example.com">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="********">
            </div>

            <div class="form-group">
                <label for="role">Role</label>
                <select id="role" name="role">
                    <option value="">Select role</option>
                    <option value="DOCTOR">Doctor</option>
                    <option value="PATIENT">Patient</option>
                </select>
            </div>

            <button type="submit">Register</button>

            <div class="login-link">
                Already have an account? <a href="<c:url value='/login' />">Login</a>
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
            const errorDiv = document.getElementById("validationError");
            if (!errorDiv) {
                errorDiv = document.createElement('div');
                errorDiv.id = 'validationError';
                errorDiv.className = 'error-message';
                document.querySelector('.container').insertBefore(errorDiv, document.querySelector('form'));
            }

            const name = document.forms["registerForm"]["name"].value.trim();
            const email = document.forms["registerForm"]["email"].value.trim();
            const password = document.forms["registerForm"]["password"].value.trim();
            const role = document.forms["registerForm"]["role"].value;

            if (!name || !email || !password || !role) {
                errorDiv.style.display = "block";
                errorDiv.innerHTML = "Please fill in all fields.";
                return false;
            }

            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailRegex.test(email)) {
                errorDiv.style.display = "block";
                errorDiv.innerHTML = "Please enter a valid email.";
                return false;
            }

            errorDiv.style.display = "none";
            return true;
        }

        // Check for server-side errors on page load
        window.onload = function() {
            const errorDiv = document.getElementById("validationError");
            if (errorDiv && errorDiv.innerHTML.trim() === "") {
                errorDiv.style.display = "none";
            }
        }
    </script>
</body>
</html>