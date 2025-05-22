<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Edit Doctor</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
        }

        body {
            background-color: #f4f7fa;
            min-height: 100vh;
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

        /* Main Container */
        .main-container {
            display: flex;
            min-height: calc(100vh - 70px);
        }

        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            background-color: white;
            padding: 20px;
            box-shadow: 2px 0 4px rgba(0, 0, 0, 0.1);
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px;
            text-decoration: none;
            color: #4B5563;
            border-radius: 8px;
            margin-bottom: 8px;
            transition: all 0.3s ease;
        }

        .sidebar-link:hover {
            background-color: #F3F4F6;
        }

        .sidebar-link.active {
            background-color: #E5E7EB;
            color: #111827;
        }

        .sidebar-icon {
            width: 20px;
            height: 20px;
        }

        /* Content Styles */
        .content-container {
            flex: 1;
            padding: 20px;
            max-height: calc(100vh - 70px);
            overflow-y: auto;
        }

        .title {
            font-size: 1.5rem;
            font-weight: 500;
            margin-bottom: 20px;
            color: #1F2937;
        }

        /* Form Styles */
        .edit-form {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #374151;
        }

        .form-input {
            width: 100%;
            padding: 10px;
            border: 1px solid #D1D5DB;
            border-radius: 6px;
            font-size: 1rem;
        }

        .form-input:focus {
            outline: none;
            border-color: #20B2AA;
            box-shadow: 0 0 0 3px rgba(32, 178, 170, 0.1);
        }

        .form-textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #D1D5DB;
            border-radius: 6px;
            font-size: 1rem;
            min-height: 100px;
            resize: vertical;
        }

        .form-checkbox {
            margin-right: 8px;
        }

        .current-image {
            max-width: 200px;
            max-height: 200px;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .submit-button {
            background-color: #20B2AA;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
        }

        .cancel-button {
            background-color: #EF4444;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1rem;
        }

        .submit-button:hover {
            background-color: #1a9c96;
        }

        .cancel-button:hover {
            background-color: #dc2626;
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
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link ${currentPage eq 'dashboard' ? 'active' : ''}">
                <img src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt="" class="sidebar-icon">
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/appointments" class="sidebar-link ${currentPage eq 'appointments' ? 'active' : ''}">
                <img src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt="" class="sidebar-icon">
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/add-doctor" class="sidebar-link ${currentPage eq 'add-doctor' ? 'active' : ''}">
                <img src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt="" class="sidebar-icon">
                <span>Add Doctor</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/doctor-list" class="sidebar-link ${currentPage eq 'doctor-list' ? 'active' : ''}">
                <img src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt="" class="sidebar-icon">
                <span>Doctor List</span>
            </a>
        </div>

        <!-- Content -->
        <div class="content-container">
            <h1 class="title">Edit Doctor</h1>
            <form class="edit-form" action="${pageContext.request.contextPath}/admin/edit-doctor" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="doctorId" value="${doctor.doctorId}">
                
                <div class="form-group">
                    <label class="form-label">Current Profile Picture</label>
                    <c:choose>
                        <c:when test="${not empty doctor.pfp}">
                            <img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(doctor.pfp)}" 
                                 alt="${doctor.name}" class="current-image">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/assets/images/default-doctor.png" 
                                 alt="${doctor.name}" class="current-image">
                        </c:otherwise>
                    </c:choose>
                    <input type="file" name="image" class="form-input" accept="image/*">
                </div>

                <div class="form-group">
                    <label class="form-label">Name</label>
                    <input type="text" name="name" class="form-input" value="${doctor.name}" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-input" value="${doctor.email}" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Speciality</label>
                    <input type="text" name="speciality" class="form-input" value="${doctor.speciality}" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Experience (Years)</label>
                    <input type="text" name="experience" class="form-input" value="${doctor.experience} Years" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Fees</label>
                    <input type="number" name="fees" class="form-input" value="${doctor.fees}" step="0.01" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Education</label>
                    <input type="text" name="education" class="form-input" value="${doctor.degree}" required>
                </div>

                <div class="form-group">
                    <label class="form-label">Address</label>
                    <textarea name="address" class="form-textarea" required>${doctor.address}</textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">About</label>
                    <textarea name="about" class="form-textarea" required>${doctor.about}</textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">
                        <input type="checkbox" name="available" class="form-checkbox" ${doctor.available ? 'checked' : ''}>
                        Available for Appointments
                    </label>
                </div>

                <div class="button-group">
                    <button type="submit" class="submit-button">Update Doctor</button>
                    <a href="${pageContext.request.contextPath}/admin/doctor-list" class="cancel-button">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html> 