<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Appointments - MyDoctorApp</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
        }

        body {
            background-color: #f4f7fa;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
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
            margin-bottom: 20px;
        }

        .content-header h1 {
            font-size: 18px;
            font-weight: 500;
            color: #111827;
        }

        /* Table Styles */
        .appointments-table-container {
            background-color: white;
            border-radius: 8px;
            border: 1px solid #e5e7eb;
            overflow: hidden;
        }

        .appointments-table {
            width: 100%;
            border-collapse: collapse;
        }

        .appointments-table th {
            text-align: left;
            padding: 16px 24px;
            font-size: 12px;
            font-weight: 500;
            color: #6b7280;
            border-bottom: 1px solid #e5e7eb;
        }

        .appointments-table td {
            padding: 12px 24px;
            font-size: 14px;
            color: #374151;
            border-bottom: 1px solid #f3f4f6;
        }

        .appointments-table tr:hover {
            background-color: #f9fafb;
        }

        .patient-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .patient-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #e0f2fe;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0284c7;
            font-size: 18px;
            font-weight: 500;
        }

        .patient-avatar img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
        }

        .payment-badge {
            font-size: 10px;
            border: 1px solid #20B2AA;
            padding: 1px 8px;
            border-radius: 4px;
            color: #6b7280;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .action-button {
            padding: 6px;
            border-radius: 50%;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .cancel-button {
            background-color: #fee2e2;
            color: #dc2626;
        }

        .cancel-button:hover {
            background-color: #fecaca;
        }

        .complete-button {
            background-color: #dcfce7;
            color: #16a34a;
        }

        .complete-button:hover {
            background-color: #bbf7d0;
        }

        .status-text {
            font-size: 12px;
            font-weight: 500;
        }

        .status-cancelled {
            color: #ef4444;
        }

        .status-completed {
            color: #22c55e;
        }

        .no-appointments {
            text-align: center;
            padding: 32px;
            color: #6b7280;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="admin-navbar">
        <div class="admin-navbar-left">
            <img src="${pageContext.request.contextPath}/assets/images/admin_logo.svg" alt="MyDoctorApp"
                class="admin-logo">
            <span class="role-badge">Doctor</span>
        </div>
        <form action="${pageContext.request.contextPath}/logout" method="POST">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </nav>

    <div class="main-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <a href="${pageContext.request.contextPath}/doctor/dashboard"
                class="sidebar-link ${currentPage eq 'dashboard' ? 'active' : ''}">
                <img src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt=""
                    class="sidebar-icon">
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments"
                class="sidebar-link ${currentPage eq 'appointments' ? 'active' : ''}">
                <img src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt=""
                    class="sidebar-icon">
                <span>Appointments</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/profile"
                class="sidebar-link ${currentPage eq 'profile' ? 'active' : ''}">
                <img src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt=""
                    class="sidebar-icon">
                <span>Profile</span>
            </a>
        </div>

        <!-- Content -->
        <div class="content-container">
            <div class="content-header">
                <h1>All Appointments</h1>
            </div>

            <div class="appointments-table-container">
                <table class="appointments-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Patient</th>
                            <th>Payment</th>
                            <th>Age</th>
                            <th>Date & Time</th>
                            <th>Fees</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${appointments}" var="appointment" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>
                                    <div class="patient-info">
                                        <div class="patient-avatar">
                                            <c:choose>
                                                <c:when test="${not empty appointment.patientData.image}">
                                                    <img src="data:image/jpeg;base64,${appointment.patientData.image}" alt="${appointment.patientData.name}">
                                                </c:when>
                                                <c:otherwise>
                                                    ${empty appointment.patientData.name ? '?' : appointment.patientData.name.charAt(0)}
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <p>${empty appointment.patientData.name ? 'N/A' : appointment.patientData.name}</p>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="payment-badge">
                                        ${empty appointment.paymentMode ? 'Cash' : (appointment.paymentMode eq 'online' ? 'Online' : 'Cash')}
                                    </span>
                                </td>
                                <td>${appointment.patientData.age}</td>
                                <td><fmt:formatDate value="${appointment.appointmentTime}" pattern="MMM dd, yyyy hh:mm a"/></td>
                                <td>₹ 1200</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${appointment.cancelled}">
                                            <p class="status-text status-cancelled">Cancelled</p>
                                        </c:when>
                                        <c:when test="${appointment.completed}">
                                            <p class="status-text status-completed">Completed</p>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="action-buttons">
                                                <form action="${pageContext.request.contextPath}/doctor/appointments/cancel" method="POST" style="display: inline;">
                                                    <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
                                                    <button type="submit" class="action-button cancel-button">
                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                            <path d="M18 6L6 18M6 6l12 12"/>
                                                        </svg>
                                                    </button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/doctor/appointments/complete" method="POST" style="display: inline;">
                                                    <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
                                                    <button type="submit" class="action-button complete-button">
                                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                            <path d="M20 6L9 17l-5-5"/>
                                                        </svg>
                                                    </button>
                                                </form>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty appointments}">
                            <tr>
                                <td colspan="7" class="no-appointments">
                                    No appointments found
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html> 