<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Healthcare System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
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
        input[type="password"],
        input[type="date"],
        input[type="number"],
        select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .inline-radio {
            display: inline-block;
            margin-right: 15px;
        }
        .inline-radio input {
            margin-right: 5px;
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
        .role-fields {
            display: none;
            padding: 15px;
            margin-top: 15px;
            background-color: #f8fafc;
            border-radius: 6px;
            border: 1px solid #e1e4e8;
        }
        .switch-login {
            text-align: center;
            margin-top: 20px;
        }
        .switch-login a {
            color: #3498db;
            text-decoration: none;
        }
        .switch-login a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Create an Account</h1>

    <% if(request.getAttribute("error") != null) { %>
    <div class="error-message" style="display: block;">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>

    <form action="<%=request.getContextPath()%>/register" method="post" enctype="multipart/form-data">
        <!-- Common fields for all users -->
        <div class="form-group">
            <label for="firstName">First Name*</label>
            <input type="text" id="firstName" name="firstName" required>
        </div>

        <div class="form-group">
            <label for="lastName">Last Name*</label>
            <input type="text" id="lastName" name="lastName" required>
        </div>

        <div class="form-group">
            <label for="email">Email Address*</label>
            <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="password">Password*</label>
            <input type="password" id="password" name="password" required>
        </div>

        <div class="form-group">
            <label for="confirmPassword">Confirm Password*</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>

        <div class="form-group">
            <label for="address">Address*</label>
            <input type="text" id="address" name="address" required>
        </div>

        <div class="form-group">
            <label for="phone">Phone Number*</label>
            <input type="text" id="phone" name="phone" required>
        </div>

        <div class="form-group">
            <label>Gender*</label>
            <div>
                <label class="inline-radio">
                    <input type="radio" name="gender" value="Male" required> Male
                </label>
                <label class="inline-radio">
                    <input type="radio" name="gender" value="Female"> Female
                </label>
                <label class="inline-radio">
                    <input type="radio" name="gender" value="Other"> Other
                </label>
            </div>
        </div>

        <div class="form-group">
            <label for="dateOfBirth">Date of Birth*</label>
            <input type="date" id="dateOfBirth" name="dateOfBirth" required>
        </div>

        <div class="form-group">
            <label for="pfp">Profile Picture</label>
            <input type="file" id="pfp" name="pfp" accept="image/*">
        </div>

        <div class="form-group">
            <label>User Role*</label>
            <div>
                <label class="inline-radio">
                    <input type="radio" name="role" value="PATIENT" checked onclick="toggleRoleFields()"> Patient
                </label>
                <label class="inline-radio">
                    <input type="radio" name="role" value="DOCTOR" onclick="toggleRoleFields()"> Doctor
                </label>
            </div>
        </div>

        <!-- Patient-specific fields -->
        <div id="patientFields" class="role-fields" style="display: block;">
            <div class="form-group">
                <label for="bloodGroup">Blood Group</label>
                <select id="bloodGroup" name="bloodGroup">
                    <option value="">Select Blood Group</option>
                    <option value="A+">A+</option>
                    <option value="A-">A-</option>
                    <option value="B+">B+</option>
                    <option value="B-">B-</option>
                    <option value="AB+">AB+</option>
                    <option value="AB-">AB-</option>
                    <option value="O+">O+</option>
                    <option value="O-">O-</option>
                </select>
            </div>
        </div>

        <!-- Doctor-specific fields -->
        <div id="doctorFields" class="role-fields">
            <div class="form-group">
                <label for="degree">Degree*</label>
                <input type="text" id="degree" name="degree">
            </div>

            <div class="form-group">
                <label for="specialization">Specialization*</label>
                <input type="text" id="specialization" name="specialization">
            </div>

            <div class="form-group">
                <label for="fee">Consultation Fee*</label>
                <input type="number" id="fee" name="fee" min="0" step="0.01">
            </div>

            <div class="form-group">
                <label>Availability Status*</label>
                <div>
                    <label class="inline-radio">
                        <input type="radio" name="isAvailable" value="true"> Available
                    </label>
                    <label class="inline-radio">
                        <input type="radio" name="isAvailable" value="false"> Not Available
                    </label>
                </div>
            </div>
        </div>

        <button type="submit" class="btn-submit">Register</button>

        <div class="switch-login">
            Already have an account? <a href="<%=request.getContextPath()%>/login">Login here</a>
        </div>
    </form>
</div>

<script>
    function toggleRoleFields() {
        var patientFields = document.getElementById("patientFields");
        var doctorFields = document.getElementById("doctorFields");
        var role = document.querySelector('input[name="role"]:checked').value;

        if (role === "PATIENT") {
            patientFields.style.display = "block";
            doctorFields.style.display = "none";

            // Make doctor fields not required
            document.getElementById("degree").required = false;
            document.getElementById("specialization").required = false;
            document.getElementById("fee").required = false;

            // Make blood group required
            document.getElementById("bloodGroup").required = true;
        } else {
            patientFields.style.display = "none";
            doctorFields.style.display = "block";

            // Make doctor fields required
            document.getElementById("degree").required = true;
            document.getElementById("specialization").required = true;
            document.getElementById("fee").required = true;

            // Make blood group not required
            document.getElementById("bloodGroup").required = false;
        }
    }

    // Password validation
    document.querySelector('form').addEventListener('submit', function(event) {
        var password = document.getElementById('password').value;
        var confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            event.preventDefault();
            var errorDiv = document.querySelector('.error-message');
            errorDiv.textContent = "Passwords do not match";
            errorDiv.style.display = "block";
            return false;
        }

        // Additional form validation for required fields based on role
        var role = document.querySelector('input[name="role"]:checked').value;

        if (role === "DOCTOR") {
            var degree = document.getElementById('degree').value;
            var specialization = document.getElementById('specialization').value;
            var fee = document.getElementById('fee').value;
            var isAvailable = document.querySelector('input[name="isAvailable"]:checked');

            if (!degree || !specialization || !fee || !isAvailable) {
                event.preventDefault();
                var errorDiv = document.querySelector('.error-message');
                errorDiv.textContent = "Please fill in all required fields for Doctor registration";
                errorDiv.style.display = "block";
                return false;
            }
        }


        return true;
    });

    // Initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        toggleRoleFields();
    });
</script>
</body>
</html>