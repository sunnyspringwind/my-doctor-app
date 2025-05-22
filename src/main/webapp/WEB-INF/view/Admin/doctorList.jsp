<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page import="java.util.Base64" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Admin - Doctor List</title>
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

                    /* Sidebar Styles */
                    .main-container {
                        display: flex;
                        min-height: calc(100vh - 70px);
                    }

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
                        font-size: 1.125rem;
                        font-weight: 500;
                        margin-bottom: 20px;
                    }

                    .doctors-grid {
                        width: 100%;
                        display: flex;
                        flex-wrap: wrap;
                        gap: 16px;
                        padding-top: 20px;
                    }

                    .doctor-card {
                        border: 1px solid #c7d2fe;
                        border-radius: 12px;
                        max-width: 224px;
                        overflow: hidden;
                        cursor: pointer;
                        transition: all 0.3s ease;
                    }

                    .doctor-card:hover {
                        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                    }

                    .doctor-image {
                        width: 100%;
                        height: 200px;
                        object-fit: cover;
                        background-color: #eef2ff;
                        transition: background-color 0.5s ease;
                    }

                    .doctor-card:hover .doctor-image {
                        background-color: #20B2AA;
                    }

                    .doctor-info {
                        padding: 16px;
                    }

                    .doctor-name {
                        color: #262626;
                        font-size: 1.125rem;
                        font-weight: 500;
                        margin: 0;
                    }

                    .doctor-speciality {
                        color: #525252;
                        font-size: 0.875rem;
                        margin: 0;
                    }

                    .availability-container {
                        margin-top: 8px;
                        display: flex;
                        align-items: center;
                        gap: 4px;
                        font-size: 0.875rem;
                    }

                    .availability-checkbox {
                        margin: 0;
                        cursor: pointer;
                    }

                    .action-buttons {
                        display: flex;
                        gap: 8px;
                        margin-top: 12px;
                    }

                    .edit-button, .delete-button {
                        padding: 6px 12px;
                        border: none;
                        border-radius: 4px;
                        cursor: pointer;
                        font-size: 0.875rem;
                        transition: all 0.3s ease;
                    }

                    .edit-button {
                        background-color: #20B2AA;
                        color: white;
                    }

                    .delete-button {
                        background-color: #ff4444;
                        color: white;
                    }

                    .edit-button:hover {
                        background-color: #1a9c96;
                    }

                    .delete-button:hover {
                        background-color: #ff0000;
                    }

                    /* Hide scrollbar for Chrome, Safari and Opera */
                    .content-container::-webkit-scrollbar {
                        display: none;
                    }

                    /* Hide scrollbar for IE, Edge and Firefox */
                    .content-container {
                        -ms-overflow-style: none;
                        scrollbar-width: none;
                    }

                    /* Modal Styles */
                    .modal-overlay {
                        display: none;
                        position: fixed;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        background-color: rgba(0, 0, 0, 0.5);
                        z-index: 1000;
                        justify-content: center;
                        align-items: center;
                    }

                    .modal-content {
                        background-color: white;
                        padding: 30px;
                        border-radius: 12px;
                        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                        max-width: 400px;
                        width: 90%;
                        text-align: center;
                    }

                    .modal-title {
                        font-size: 1.25rem;
                        font-weight: 600;
                        color: #1F2937;
                        margin-bottom: 15px;
                    }

                    .modal-message {
                        color: #4B5563;
                        margin-bottom: 25px;
                        line-height: 1.5;
                    }

                    .modal-buttons {
                        display: flex;
                        justify-content: center;
                        gap: 12px;
                    }

                    .modal-button {
                        padding: 10px 20px;
                        border: none;
                        border-radius: 6px;
                        cursor: pointer;
                        font-size: 0.875rem;
                        font-weight: 500;
                        transition: all 0.3s ease;
                    }

                    .modal-button.confirm {
                        background-color: #EF4444;
                        color: white;
                    }

                    .modal-button.confirm:hover {
                        background-color: #dc2626;
                    }

                    .modal-button.cancel {
                        background-color: #E5E7EB;
                        color: #4B5563;
                    }

                    .modal-button.cancel:hover {
                        background-color: #D1D5DB;
                    }

                    .doctor-name {
                        font-weight: 600;
                    }
                </style>
            </head>

            <body>
                <!-- Delete Confirmation Modal -->
                <div id="deleteModal" class="modal-overlay">
                    <div class="modal-content">
                        <h2 class="modal-title">Delete Doctor</h2>
                        <p class="modal-message">Are you sure you want to delete <span class="doctor-name" id="doctorName"></span>? This action cannot be undone.</p>
                        <div class="modal-buttons">
                            <button class="modal-button cancel" onclick="closeDeleteModal()">Cancel</button>
                            <button class="modal-button confirm" onclick="confirmDelete()">Delete</button>
                        </div>
                    </div>
                </div>

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

                    <!-- Content -->
                    <div class="content-container">
                        <h1 class="title">All Doctors</h1>
                        <div class="doctors-grid">
                            <c:forEach items="${doctors}" var="doctor" varStatus="status">
                                <div class="doctor-card">
                                    <c:choose>
                                        <c:when test="${not empty doctor.pfp}">
                                            <img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(doctor.pfp)}"
                                                alt="${doctor.name}" class="doctor-image">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png"
                                                alt="${doctor.name}" class="doctor-image"
                                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/default-doctor.png'">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="doctor-info">
                                        <p class="doctor-name">${doctor.name}</p>
                                        <p class="doctor-speciality">${doctor.speciality}</p>
                                        <div class="availability-container">
                                            <input type="checkbox" id="available-${doctor.doctorId}"
                                                class="availability-checkbox"
                                                onchange="changeAvailability('${doctor.doctorId}')" <c:if
                                                test="${doctor.available}">checked</c:if>>
                                            <label for="available-${doctor.doctorId}">Available</label>
                                        </div>
                                        <div class="action-buttons">
                                            <button class="edit-button" onclick="editDoctor('${doctor.doctorId}')">Edit</button>
                                            <button class="delete-button" onclick="showDeleteModal('${doctor.doctorId}', '${doctor.name}')">Delete</button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <script>
                    let doctorToDelete = null;

                    function showDeleteModal(doctorId, doctorName) {
                        doctorToDelete = doctorId;
                        document.getElementById('doctorName').textContent = doctorName;
                        document.getElementById('deleteModal').style.display = 'flex';
                    }

                    function closeDeleteModal() {
                        document.getElementById('deleteModal').style.display = 'none';
                        doctorToDelete = null;
                    }

                    function confirmDelete() {
                        if (!doctorToDelete) return;

                        fetch('${pageContext.request.contextPath}/admin/delete-doctor', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({
                                doctorId: doctorToDelete
                            })
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                // Remove the doctor card from the UI
                                const doctorCard = document.querySelector(`[data-doctor-id="${doctorToDelete}"]`);
                                if (doctorCard) {
                                    doctorCard.remove();
                                }
                                closeDeleteModal();
                            } else {
                                alert('Failed to delete doctor: ' + (data.error || 'Unknown error'));
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('An error occurred while deleting the doctor');
                        });
                    }

                    function changeAvailability(doctorId) {
                        fetch('${pageContext.request.contextPath}/admin/change-availability', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({
                                doctorId: doctorId
                            })
                        })
                            .then(response => response.json())
                            .then(data => {
                                if (data.success) {
                                    console.log('Availability updated successfully');
                                } else {
                                    console.error('Failed to update availability');
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                            });
                    }

                    function editDoctor(doctorId) {
                        window.location.href = '${pageContext.request.contextPath}/admin/edit-doctor?id=' + doctorId;
                    }
                </script>
            </body>

            </html>