<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <title>Add Doctor - MyDoctorApp</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
        }

        /* Hide welcome back message */
        .message:contains("Welcome back"),
        div[class*="success"]:contains("Welcome back") {
            display: none !important;
        }

        body {
            background-color: #f4f7fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }

        ::-webkit-scrollbar-track {
            background: transparent;
        }

        ::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }

        /* Hide scrollbar for Firefox */
        * {
            scrollbar-width: thin;
            scrollbar-color: #cbd5e1 transparent;
        }

        /* Hide scrollbar for IE/Edge */
        * {
            -ms-overflow-style: none;
        }

        /* Navbar Styles */
        .admin-navbar {
            background-color: #ffffff;
            padding: 15px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }

        .admin-navbar-left {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .admin-logo {
            height: 40px;
            width: auto;
        }

        .role-badge {
            background-color: #f3f4f6;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
        }

        .logout-button {
            background-color: #20B2AA;
            color: white;
            padding: 8px 20px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
        }

        /* Sidebar Styles */
        .main-container {
            display: flex;
            flex: 1;
        }

        .sidebar {
            width: 250px;
            background-color: white;
            border-right: 1px solid #e5e7eb;
            min-height: calc(100vh - 70px);
            padding-top: 20px;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 36px;
            color: #515151;
            text-decoration: none;
            cursor: pointer;
        }

        .sidebar-link:hover {
            background-color: #F2F3FF;
        }

        .sidebar-link.active {
            background-color: #F2F3FF;
            border-right: 4px solid #20B2AA;
        }

        .sidebar-icon {
            width: 20px;
            height: 20px;
        }

        /* Content Styles */
        .content-container {
            flex: 1;
            padding: 20px;
            max-width: calc(100vw - 250px);
        }

        .content-header {
            margin-bottom: 32px;
            font-size: 28px;
            font-weight: 600;
            color: #111827;
        }

        /* Form Styles */
        .form-container {
            background: white;
            padding: 40px;
            border-radius: 16px;
            border: none;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            max-width: 1000px;
            margin: 0 auto;
        }

        .upload-section {
            display: flex;
            align-items: center;
            gap: 24px;
            margin-bottom: 40px;
            padding-bottom: 30px;
            border-bottom: 1px solid #e5e7eb;
        }

        .upload-area {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background-color: #f8fafc;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border: 2px dashed #cbd5e1;
            transition: all 0.3s ease;
            flex-shrink: 0;
            position: relative;
        }

        .upload-area:hover {
            border-color: #20B2AA;
            background-color: #f0fdfb;
        }

        .upload-area img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
        }

        .upload-area img[src*="upload_area.svg"] {
            width: 40px;
            height: 40px;
            object-fit: contain;
        }

        .upload-text h3 {
            font-size: 16px;
            font-weight: 500;
            color: #111827;
            margin-bottom: 4px;
        }

        .upload-hint {
            font-size: 14px;
            color: #6b7280;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 40px;
            margin-bottom: 32px;
        }

        .form-column {
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group label {
            color: #374151;
            font-size: 14px;
            font-weight: 500;
        }

        .form-input {
            padding: 12px 16px;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            background-color: #f9fafb;
        }

        .form-input:focus {
            outline: none;
            border-color: #20B2AA;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(32, 178, 170, 0.1);
        }

        .form-input::placeholder {
            color: #9ca3af;
        }

        .fees-input-group {
            position: relative;
            display: flex;
            align-items: center;
        }

        .currency-symbol {
            position: absolute;
            left: 16px;
            color: #6b7280;
        }

        .fees-input-group .form-input {
            padding-left: 32px;
        }

        select.form-input {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%236b7280'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
            padding-right: 40px;
        }

        textarea.form-input {
            resize: vertical;
            min-height: 120px;
            font-family: inherit;
        }

        .submit-button {
            background-color: #20B2AA;
            color: white;
            padding: 12px 28px;
            border: none;
            border-radius: 30px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
        }

        .submit-button:hover {
            background-color: #1c9e98;
            transform: translateY(-1px);
        }

        .submit-button:active {
            transform: translateY(0);
        }

        .plus-icon {
            font-size: 20px;
            font-weight: 400;
            margin-top: -2px;
        }

        /* Message Styles */
        .message {
            padding: 16px 20px;
            border-radius: 10px;
            margin-bottom: 24px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .message.success {
            background-color: #ecfdf5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .message.error {
            background-color: #fef2f2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 24px;
                margin: 16px;
                border-radius: 12px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 24px;
            }

            .upload-section {
                flex-direction: column;
                text-align: center;
                gap: 16px;
            }

            .upload-area {
                width: 100px;
                height: 100px;
            }
        }

        .button-container {
            margin-top: 40px;
            display: flex;
            justify-content: flex-start;
        }
    </style>
</head>

<body>
    <!-- Navbar -->
    <nav class="admin-navbar">
        <div class="admin-navbar-left">
            <img src="${pageContext.request.contextPath}/assets/images/admin_logo.svg" alt="MyDoctorApp" class="admin-logo">
            <span class="role-badge">Admin</span>
        </div>
        <form action="${pageContext.request.contextPath}/logout" method="POST">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </nav>

    <div class="main-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">
                <img src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt="" class="sidebar-icon">
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/appointments" class="sidebar-link">
                <img src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt="" class="sidebar-icon">
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/add-doctor" class="sidebar-link active">
                <img src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt="" class="sidebar-icon">
                <span>Add Doctor</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/doctor-list" class="sidebar-link">
                <img src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt="" class="sidebar-icon">
                <span>Doctor List</span>
            </a>
        </div>

        <!-- Content -->
        <div class="content-container">
            <h1 class="content-header">Add Doctor</h1>

            <form action="${pageContext.request.contextPath}/admin/add-doctor" method="POST" enctype="multipart/form-data" class="form-container">
                <c:if test="${not empty sessionScope.message}">
                    <div class="message ${sessionScope.messageType}">
                        ${sessionScope.message}
                        <% session.removeAttribute("message"); %>
                        <% session.removeAttribute("messageType"); %>
                    </div>
                </c:if>

                <div class="upload-section">
                    <label for="doctor-image" class="upload-area">
                        <img id="preview-image" src="${pageContext.request.contextPath}/assets/images/upload_area.svg" alt="Upload">
                    </label>
                    <input type="file" id="doctor-image" name="image" accept="image/*" style="display: none;" required>
                    <div class="upload-text">
                        <h3>Upload doctor picture</h3>
                        <p class="upload-hint">Click to browse or drag and drop</p>
                    </div>
                </div>

                <div class="form-grid">
                    <!-- Left Column -->
                    <div class="form-column">
                        <div class="form-group">
                            <label>Doctor name</label>
                            <input type="text" name="name" class="form-input" placeholder="Enter doctor's full name" required>
                        </div>

                        <div class="form-group">
                            <label>Doctor Email</label>
                            <input type="email" name="email" class="form-input" placeholder="Enter doctor's email address" required>
                        </div>

                        <div class="form-group">
                            <label>Doctor Password</label>
                            <input type="password" name="password" class="form-input" placeholder="Create a strong password" required>
                        </div>

                        <div class="form-group">
                            <label>Experience</label>
                            <select name="experience" class="form-input">
                                <c:forEach var="i" begin="1" end="30">
                                    <option value="${i} Year${i > 1 ? 's' : ''}">${i} Year${i > 1 ? 's' : ''}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Fees</label>
                            <div class="fees-input-group">
                                <span class="currency-symbol">रू</span>
                                <input type="number" name="fees" class="form-input" placeholder="Enter consultation fees" required>
                            </div>
                        </div>
                    </div>

                    <!-- Right Column -->
                    <div class="form-column">
                        <div class="form-group">
                            <label>Speciality</label>
                            <select name="speciality" class="form-input">
                                <option value="General physician">General physician</option>
                                <option value="Gynecologist">Gynecologist</option>
                                <option value="Dermatologist">Dermatologist</option>
                                <option value="Pediatricians">Pediatricians</option>
                                <option value="Neurologist">Neurologist</option>
                                <option value="Gastroenterologist">Gastroenterologist</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Education</label>
                            <input type="text" name="education" class="form-input" placeholder="Enter educational qualifications" required>
                        </div>

                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" name="address" class="form-input" placeholder="Enter doctor's address" required>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label>About Doctor</label>
                    <textarea name="about" class="form-input" placeholder="Write a brief description about the doctor's expertise and experience" rows="5" required></textarea>
                </div>

                <div class="button-container">
                    <button type="submit" class="submit-button">
                        Add doctor
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.getElementById('doctor-image').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const preview = document.getElementById('preview-image');
                    preview.src = e.target.result;
                    preview.style.width = '100%';
                    preview.style.height = '100%';
                    preview.style.objectFit = 'cover';
                }
                reader.readAsDataURL(file);
            }
        });

        // Add drag and drop functionality
        const uploadArea = document.querySelector('.upload-area');
        const fileInput = document.getElementById('doctor-image');

        ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, preventDefaults, false);
        });

        function preventDefaults (e) {
            e.preventDefault();
            e.stopPropagation();
        }

        ['dragenter', 'dragover'].forEach(eventName => {
            uploadArea.addEventListener(eventName, highlight, false);
        });

        ['dragleave', 'drop'].forEach(eventName => {
            uploadArea.addEventListener(eventName, unhighlight, false);
        });

        function highlight(e) {
            uploadArea.classList.add('highlight');
        }

        function unhighlight(e) {
            uploadArea.classList.remove('highlight');
        }

        uploadArea.addEventListener('drop', handleDrop, false);

        function handleDrop(e) {
            const dt = e.dataTransfer;
            const files = dt.files;

            fileInput.files = files;
            if (files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const preview = document.getElementById('preview-image');
                    preview.src = e.target.result;
                    preview.style.width = '100%';
                    preview.style.height = '100%';
                    preview.style.objectFit = 'cover';
                }
                reader.readAsDataURL(files[0]);
            }
        }
    </script>
</body>

</html>
