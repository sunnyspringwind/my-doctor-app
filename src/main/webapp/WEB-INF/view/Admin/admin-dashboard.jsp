<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <title>Admin Dashboard - MyDoctorApp</title>
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

                /* Dashboard Content Styles */
                .content-container {
                    flex: 1;
                    padding: 20px;
                    max-width: calc(100vw - 250px);
                }

                .dashboard-header {
                    margin-bottom: 30px;
                }

                .dashboard-header h1 {
                    color: #1a1a1a;
                    font-size: 24px;
                    margin-bottom: 10px;
                }

                .stats-grid {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 12px;
                    margin-bottom: 40px;
                }

                .stat-card {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    background: white;
                    padding: 16px;
                    min-width: 208px;
                    border-radius: 8px;
                    border: 2px solid #f3f4f6;
                    cursor: pointer;
                    transition: transform 0.2s;
                }

                .stat-card:hover {
                    transform: scale(1.05);
                }

                .stat-icon {
                    width: 56px;
                    height: 56px;
                }

                .stat-info {
                    display: flex;
                    flex-direction: column;
                }

                .stat-number {
                    font-size: 20px;
                    font-weight: 600;
                    color: #4b5563;
                }

                .stat-label {
                    color: #9ca3af;
                }

                .bookings-section {
                    background: white;
                    border-radius: 8px;
                    overflow: hidden;
                }

                .bookings-header {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    padding: 16px;
                    border: 1px solid #e5e7eb;
                }

                .bookings-header img {
                    width: 20px;
                    height: 20px;
                }

                .bookings-header p {
                    font-weight: 600;
                }

                .bookings-list {
                    border: 1px solid #e5e7eb;
                    border-top: none;
                    padding-top: 16px;
                }

                .booking-item {
                    display: flex;
                    align-items: center;
                    padding: 12px 24px;
                    transition: background-color 0.2s;
                }

                .booking-item:hover {
                    background-color: #f9fafb;
                }

                .doctor-image {
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    object-fit: cover;
                }

                .booking-info {
                    flex: 1;
                    font-size: 14px;
                    margin-left: 12px;
                }

                .doctor-name {
                    color: #1f2937;
                    font-weight: 500;
                }

                .booking-date {
                    color: #6b7280;
                }

                .booking-status {
                    color: #f87171;
                    font-size: 12px;
                    font-weight: 500;
                }

                .cancel-icon {
                    width: 40px;
                    height: 40px;
                    cursor: pointer;
                }

                /* Update quick actions section */
                .quick-actions {
                    display: none;
                    /* Hide the quick actions section as it's not in the reference */
                }
            </style>
        </head>

        <body>
            <!-- Navbar -->
            <nav class="admin-navbar">
                <div class="admin-navbar-left">
                    <img src="${pageContext.request.contextPath}/assets/images/admin_logo.svg" alt="MyDoctorApp"
                        class="admin-logo">
                    <span class="role-badge">Admin</span>
                </div>
                <form action="${pageContext.request.contextPath}/logout" method="POST">
                    <button type="submit" class="logout-button">Logout</button>
                </form>
            </nav>

            <div class="main-container">
                <!-- Sidebar -->
                <div class="sidebar">
                    <a href="${pageContext.request.contextPath}/admin/dashboard"
                        class="sidebar-link ${currentPage eq 'dashboard' ? 'active' : ''}">
                        <img src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt=""
                            class="sidebar-icon">
                        <span>Dashboard</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/appointments"
                        class="sidebar-link ${currentPage eq 'appointments' ? 'active' : ''}">
                        <img src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt=""
                            class="sidebar-icon">
                        <span>Appointments</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/add-doctor"
                        class="sidebar-link ${currentPage eq 'add-doctor' ? 'active' : ''}">
                        <img src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt=""
                            class="sidebar-icon">
                        <span>Add Doctor</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/doctor-list"
                        class="sidebar-link ${currentPage eq 'doctor-list' ? 'active' : ''}">
                        <img src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt=""
                            class="sidebar-icon">
                        <span>Doctor List</span>
                    </a>
                </div>

                <!-- Dashboard Content -->
                <div class="content-container">
                    <div class="dashboard-header">
                        
                    </div>

                    <!-- Statistics Cards -->
                    <div class="stats-grid">
                        <div class="stat-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doctor_icon.svg" alt=""
                                class="stat-icon">
                            <div class="stat-info">
                                <span class="stat-number">${dashboardStats.totalDoctors}</span>
                                <span class="stat-label">Doctors</span>
                            </div>
                        </div>
                        <div class="stat-card">
                            <img src="${pageContext.request.contextPath}/assets/images/appointments_icon.svg" alt=""
                                class="stat-icon">
                            <div class="stat-info">
                                <span class="stat-number">${dashboardStats.totalAppointments}</span>
                                <span class="stat-label">Appointments</span>
                            </div>
                        </div>
                        <div class="stat-card">
                            <img src="${pageContext.request.contextPath}/assets/images/patients_icon.svg" alt=""
                                class="stat-icon">
                            <div class="stat-info">
                                <span class="stat-number">${dashboardStats.totalPatients}</span>
                                <span class="stat-label">Patients</span>
                            </div>
                        </div>
                    </div>

                    <!-- Latest Bookings -->
                    <div class="bookings-section">
                        <div class="bookings-header">
                            <img src="${pageContext.request.contextPath}/assets/images/list_icon.svg" alt="">
                            <p>Latest Bookings</p>
                        </div>
                        <div class="bookings-list">
                            <c:forEach items="${dashboardStats.latestBookings}" var="booking">
                                <div class="booking-item">
                                    <c:choose>
                                        <c:when test="${not empty booking.doctorImage}">
                                            <img loading="lazy" src="data:image/jpeg;base64,${booking.doctorImage}" alt="Doctor" class="doctor-image">
                                        </c:when>
                                        <c:otherwise>
                                            <img loading="lazy" src="${pageContext.request.contextPath}/assets/images/default-doctor.png" alt="Doctor" class="doctor-image">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="booking-info">
                                        <p class="doctor-name">${booking.doctorName}</p>
                                        <p class="booking-date">${booking.date}</p>
                                    </div>
                                    <c:choose>
                                        <c:when test="${booking.status eq 'CANCELLED'}">
                                            <span class="booking-status" style="color: #f87171;">Cancelled</span>
                                        </c:when>
                                        <c:when test="${booking.status eq 'COMPLETED'}">
                                            <span class="booking-status" style="color: #10b981;">Completed</span>
                                        </c:when>
                                        <c:when test="${booking.status eq 'PENDING'}">
                                            <div style="display: flex; gap: 16px; align-items: center;">
                                                <form method="post" action="${pageContext.request.contextPath}/admin/booking-action" style="display:inline;">
                                                    <input type="hidden" name="appointmentId" value="${booking.id}" />
                                                    <input type="hidden" name="action" value="accept" />
                                                    <button type="submit" title="Accept" style="background:none;border:none;cursor:pointer;">
                                                        <img src="${pageContext.request.contextPath}/assets/images/tick_icon.svg" alt="Accept" style="width:28px;height:28px;"/>
                                                    </button>
                                                </form>
                                                <form method="post" action="${pageContext.request.contextPath}/admin/booking-action" style="display:inline;">
                                                    <input type="hidden" name="appointmentId" value="${booking.id}" />
                                                    <input type="hidden" name="action" value="cancel" />
                                                    <button type="submit" title="Cancel" style="background:none;border:none;cursor:pointer;">
                                                        <img src="${pageContext.request.contextPath}/assets/images/cross_icon.svg" alt="Cancel" style="width:28px;height:28px;"/>
                                                    </button>
                                                </form>
                                            </div>
                                        </c:when>
                                        <c:when test="${booking.status eq 'CONFIRMED'}">
                                            <span class="booking-status" style="color: #10b981;">Confirmed</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="booking-status">${booking.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>