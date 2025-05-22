<%-- Created by IntelliJ IDEA. User: saksh Date: 6/20/2024 Time: 11:30 PM To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

            <!DOCTYPE html>
            <html>

            <head>
                <title>Doctor Profile - MyDoctorApp</title>
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

                    .content-container {
                        flex: 1;
                        padding: 20px; 
                        max-width: calc(100vw - 250px); 
                    }

                    .profile-page-content {
                        display: flex;
                        flex-direction: column;
                        gap: 16px; 
                        margin: 20px; 
                    }

                    .profile-image-section {
                        flex-shrink: 0;
                        width: 250px; 
                        height: 250px; 
                        overflow: hidden; 
                        border-radius: 8px; 
                        background-color: #20B2AA; 
                    }
                    
                    .profile-image-wrapper {
                        width: 100%;
                        height: 100%;
                        display: flex; 
                        align-items: center;
                        justify-content: center;
                        background-color: rgba(32, 178, 170, 0.8); 
                        border-radius: 8px; 
                    }

                    .profile-image {
                        width: 100%;
                        height: 100%;
                        object-fit: cover; 
                        display: block;
                        border-radius: 0; 
                    }

                    .profile-details-card {
                        flex: 1;
                        border: 1px solid #f3f4f6; 
                        border-radius: 8px; 
                        padding: 32px; 
                        padding-top: 28px; 
                        padding-bottom: 28px; 
                        background-color: white; 
                    }

                    .doctor-name {
                        display: flex;
                        align-items: center;
                        gap: 8px; 
                        font-size: 30px; 
                        font-weight: 500; 
                        color: #4b5563; 
                        margin-bottom: 0; 
                    }

                    .doctor-credentials {
                        display: flex;
                        align-items: center;
                        gap: 8px; 
                        color: #717b8a; 
                        margin-bottom: 0; 
                        font-size: 14px; 
                    }

                    .doctor-credentials .experience-badge {
                        padding-top: 2px; 
                        padding-bottom: 2px; 
                        padding-left: 8px; 
                        padding-right: 8px; 
                        border: 1px solid #d1d5db; 
                        font-size: 12px; 
                        border-radius: 9999px; 
                        background-color: #e5e7eb; 
                        color: #4b5563; 
                        cursor: default; 
                    }

                    .about-section {
                        margin-top: 12px; 
                        margin-bottom: 0;
                    }

                    .about-section p:first-child {
                        display: flex;
                        align-items: center;
                        gap: 4px; 
                        font-size: 14px; 
                        font-weight: 500; 
                        color: #374151; 
                        margin-bottom: 4px; 
                    }

                    .about-section p:last-child {
                        font-size: 14px; 
                        color: #717b8a; 
                        max-width: 700px;
                        margin-top: 4px; 
                        line-height: 1.5; 
                    }

                    .appointment-fee {
                        color: #717b8a; 
                        font-weight: 500; 
                        margin-top: 16px; 
                        margin-bottom: 0;
                        font-size: 14px; 
                    }

                    .appointment-fee span {
                        color: #1f2937; 
                    }

                    .address-section {
                        display: flex;
                        gap: 8px; 
                        padding-top: 8px; 
                        padding-bottom: 8px; 
                        margin-bottom: 0;
                        font-size: 14px; 
                        color: #717b8a; 
                    }

                    .address-section span {
                        font-size: 14px; 
                        color: #1f2937; 
                    }

                    .availability-section {
                        display: flex;
                        align-items: center;
                        gap: 4px; 
                        padding-top: 8px; 
                        margin-top: 0;
                        font-size: 14px; 
                        color: #717b8a; 
                    }

                    .availability-section input[type="checkbox"] {
                        width: 16px;
                        height: 16px;
                        cursor: pointer;
                        appearance: none;
                        -webkit-appearance: none;
                        -moz-appearance: none;
                        border: 2px solid #ccc;
                        border-radius: 4px;
                        outline: none;
                        transition: background-color 0.3s, border-color 0.3s;
                        position: relative;
                    }

                    .availability-section input[type="checkbox"]:checked {
                        background-color: #20B2AA;
                        border-color: #20B2AA;
                    }

                    .availability-section input[type="checkbox"]:checked::after {
                        content: '✓';
                        position: absolute;
                        color: white;
                        font-size: 12px;
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%);
                    }

                    .availability-section input[type="checkbox"]:disabled {
                        opacity: 0.5;
                    }

                    .edit-button {
                        padding: 4px 16px; 
                        border: 1px solid #20B2AA; 
                        color: #20B2AA; 
                        font-size: 12px; 
                        border-radius: 9999px; 
                        margin-top: 20px; 
                        background-color: transparent; 
                        cursor: pointer;
                        transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease; /* transition-all duration-300 */
                    }

                    .edit-button:hover {
                        background-color: #20B2AA; 
                        color: white; 
                        border-color: #20B2AA; 
                    }

                    /* Edit mode button styles */
                    .edit-mode .edit-button {
                        background-color: #10b981; 
                        color: white;
                        border-color: #059669; 
                    }

                    .edit-mode .edit-button:hover {
                        background-color: #059669; 
                        border-color: #059669;
                    }

                    .profile-image-section .profile-image[alt="Default Doctor Profile Picture"] {
                        background-color: #20B2AA; 
                        color: white; 
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        text-align: center;
                        font-size: 14px;
                        padding: 10px;
                        width: 100%; 
                        height: 100%;
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

                    <!-- Profile Content -->
                    <div class="content-container">
                        <div class="profile-container ${isEditing ? 'edit-mode' : ''}">

                            <div class="profile-image-section">
                                <c:choose>
                                    <c:when test="${not empty doctorPfpBase64}">
                                        <img src="data:image/jpeg;base64,${doctorPfpBase64}"
                                            alt="Doctor Profile Picture" class="profile-image">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/images/default-doctor.png"
                                            alt="Default Doctor Profile Picture" class="profile-image">
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <%-- Wrap profile details in a new card container --%>
                            <div class="profile-details-card">
                                <div class="profile-details-section">
                                    <p class="doctor-name">
                                        <c:choose>
                                            <c:when test="${user.name != null && user.name.startsWith('Dr.')}">
                                                <c:out value="${user.name}" />
                                            </c:when>
                                            <c:otherwise>
                                                Dr. <c:out value="${user.name}" />
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <p class="doctor-credentials">
                                        <c:out value="${user.degree}" /> -
                                        <c:out value="${user.speciality}" />
                                        <span class="experience-badge">
                                            <c:out value="${user.experience}" /> Year
                                        </span>
                                    </p>

                                    <div class="about-section">
                                        <p>About:</p>
                                        <p class="text-sm text-gray-600 max-w-[700px] mt-1">
                                            <c:out value="${user.about}" />
                                        </p>
                                    </div>

                                    <div class="appointment-fee">
                                        Appointment fee: ₹
                                        <c:choose>
                                            <c:when test="${isEditing}">
                                                <%-- Removed fees input for simplified editing --%>
                                                    <%-- <input type="number" name="fees"
                                                        value="<c:out value='${user.fees}' />" /> --%>
                                                    <span>
                                                        <c:out value="${user.fees}" />
                                                    </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>
                                                    <c:out value="${user.fees}" />
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="address-section">
                                        Address:
                                        <c:choose>
                                            <c:when test="${isEditing}">
                                                <%-- Removed address input for simplified editing --%>
                                                    <%-- <input type="text" name="address"
                                                        value="<c:out value='${user.address}' />" /> --%>
                                                    <span>
                                                        <c:out value="${user.address}" />
                                                    </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>
                                                    <c:out value="${user.address}" />
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="availability-section">
                                        <c:choose>
                                            <c:when test="${isEditing}">
                                                <input type="checkbox" name="available" <c:if
                                                    test='${user.available}'>checked</c:if>/>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="checkbox" disabled <c:if test='${user.available}'>checked
                                                </c:if>/>
                                            </c:otherwise>
                                        </c:choose>
                                        <label for="">Available</label>
                                    </div>

                                    <%-- Edit/Save Button --%>
                                    <c:choose>
                                        <c:when test="${isEditing}">
                                            <%-- Changed button type to button to prevent direct form submission --%>
                                            <button type="button" class="edit-button" onclick="saveAvailability()">Save</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="edit-button"
                                                onclick="window.location.href='${pageContext.request.contextPath}/doctor/profile?edit=true'">Edit</button>
                                        </c:otherwise>
                                    </c:choose>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <%-- Hidden form for saving availability --%>
                <form id="editProfileForm" method="POST" action="${pageContext.request.contextPath}/doctor/profile" style="display: none;">
                    <input type="hidden" name="available" value="" />
                    <%-- Removed fees and address hidden inputs --%>
                    <%-- <input type="hidden" name="fees" value="" /> --%>
                    <%-- <input type="hidden" name="address" value="" /> --%>
                </form>

                <script>
                    // Function to handle saving only availability
                    function saveAvailability() {
                        const form = document.getElementById('editProfileForm');
                        const availabilityCheckbox = document.querySelector('.profile-container input[name="available"]'); /* Selector might need adjustment based on new structure */
                        form.available.value = availabilityCheckbox.checked;
                        form.submit();
                    }
                </script>

            </body>

            </html>