<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Healthcare System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 500px;
            margin: 80px auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #34495e;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .btn-submit {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 12px 25px;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            display: block;
            width: 100%;
            font-weight: 600;
        }
        .btn-submit:hover {
            background-color: #2980b9;
        }
        .error-message {
            color: #e74c3c;
            margin-top: 20px;
            padding: 10px;
            background-color: #fadbd8;
            border-radius: 4px;
            display: none;
        }
        .switch-register {
            text-align: center;
            margin-top: 20px;
        }
        .switch-register a {
            color: #3498db;
            text-decoration: none;
        }
        .switch-register a:hover {
            text-decoration: underline;
        }
        .forgot-password {
            text-align: right;
            margin-top: 5px;
        }
        .forgot-password a {
            color: #7f8c8d;
            text-decoration: none;
            font-size: 14px;
        }
        .forgot-password a:hover {
            text-decoration: underline;
        }
        .logo {
            text-align: center;
            margin-bottom: 20px;
        }
        .logo img {
            max-width: 150px;
            height: auto;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="logo">
        <!-- Replace with your logo -->
        <h2>Healthcare System</h2>
    </div>

    <h1>Log In</h1>

    <% if(request.getAttribute("error") != null) { %>
    <div class="error-message" style="display: block;">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="<%=request.getContextPath()%>/login" method="post" id="loginForm">
        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
            <div class="forgot-password">
                <a href="<%=request.getContextPath()%>/reset-password">Forgot Password?</a>
            </div>
        </div>

        <button type="submit" class="btn-submit">Login</button>

        <div class="switch-register">
            Don't have an account? <a href="<%=request.getContextPath()%>/register">Register here</a>
        </div>
    </form>
</div>

<script>
    document.getElementById('loginForm').addEventListener('submit', function(event) {
        var email = document.getElementById('email').value;
        var password = document.getElementById('password').value;

        // Basic validation
        if (!email || !password) {
            event.preventDefault();
            var errorDiv = document.querySelector('.error-message');
            if (!errorDiv) {
                errorDiv = document.createElement('div');
                errorDiv.className = 'error-message';
                this.insertBefore(errorDiv, this.firstChild);
            }
            errorDiv.textContent = "Please enter both email and password";
            errorDiv.style.display = "block";
            return false;
        }

        // Email validation
        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailPattern.test(email)) {
            event.preventDefault();
            var errorDiv = document.querySelector('.error-message');
            if (!errorDiv) {
                errorDiv = document.createElement('div');
                errorDiv.className = 'error-message';
                this.insertBefore(errorDiv, this.firstChild);
            }
            errorDiv.textContent = "Please enter a valid email address";
            errorDiv.style.display = "block";
            return false;
        }

        return true;
    });

    // Show error message if there's an error parameter in the URL
    window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const errorMsg = urlParams.get('error');

        if (errorMsg) {
            var errorDiv = document.querySelector('.error-message');
            if (!errorDiv) {
                errorDiv = document.createElement('div');
                errorDiv.className = 'error-message';
                document.getElementById('loginForm').insertBefore(errorDiv, document.getElementById('loginForm').firstChild);
            }
            errorDiv.textContent = decodeURIComponent(errorMsg);
            errorDiv.style.display = "block";
        }
    };
</script>
</body>
</html>