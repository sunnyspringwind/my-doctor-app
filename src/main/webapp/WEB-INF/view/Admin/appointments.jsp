<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <title>All Appointments - MyDoctorApp</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
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
                    font-size: 24px;
                    font-weight: 500;
                    color: #111827;
                }

                /* Appointments Table Styles */
                .appointments-table {
                    background: white;
                    border-radius: 8px;
                    border: 1px solid #e5e7eb;
                    overflow: hidden;
                }

                .table-header {
                    display: grid;
                    grid-template-columns: 0.5fr 3fr 1fr 2fr 3fr 1fr 1fr;
                    padding: 16px 24px;
                    border-bottom: 1px solid #e5e7eb;
                    font-weight: 500;
                    color: #374151;
                }

                .appointment-row {
                    display: grid;
                    grid-template-columns: 0.5fr 3fr 1fr 2fr 3fr 1fr 1fr;
                    padding: 16px 24px;
                    border-bottom: 1px solid #e5e7eb;
                    align-items: center;
                    color: #4b5563;
                }

                .appointment-row:hover {
                    background-color: #f9fafb;
                }

                .patient-info,
                .doctor-info {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                }

                .profile-img {
                    width: 32px;
                    height: 32px;
                    border-radius: 50%;
                    background-color: #e5e7eb;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    overflow: hidden;
                }

                .profile-img img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .default-avatar {
                    width: 20px;
                    height: 20px;
                    color: #9ca3af;
                }

                .cancelled {
                    color: #ef4444;
                    font-size: 14px;
                    font-weight: 500;
                }

                .cancel-icon {
                    width: 32px;
                    height: 32px;
                    cursor: pointer;
                    color: #ef4444;
                    padding: 4px;
                    transition: transform 0.2s ease;
                }

                .cancel-icon:hover {
                    transform: scale(1.1);
                }

                .rupee {
                    font-family: system-ui;
                }

                @media (max-width: 768px) {
                    .content-container {
                        padding: 10px;
                    }

                    .table-header {
                        display: none;
                    }

                    .appointment-row {
                        display: flex;
                        flex-direction: column;
                        gap: 8px;
                        padding: 12px;
                    }

                    .patient-info,
                    .doctor-info {
                        width: 100%;
                    }
                }

                /* New Dynamic Features Styles */
                .filters-container {
                    background: white;
                    padding: 20px;
                    border-radius: 8px;
                    margin-bottom: 20px;
                    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
                }

                .search-box {
                    width: 100%;
                    padding: 8px 12px;
                    border: 1px solid #e5e7eb;
                    border-radius: 4px;
                    margin-bottom: 10px;
                }

                .filter-group {
                    display: flex;
                    gap: 15px;
                    margin-bottom: 10px;
                }

                .filter-select {
                    flex: 1;
                    padding: 8px;
                    border: 1px solid #e5e7eb;
                    border-radius: 4px;
                }

                .pagination {
                    display: flex;
                    justify-content: center;
                    margin-top: 20px;
                    gap: 5px;
                }

                .pagination button {
                    padding: 8px 12px;
                    border: 1px solid #e5e7eb;
                    background: white;
                    border-radius: 4px;
                    cursor: pointer;
                }

                .pagination button.active {
                    background: #20B2AA;
                    color: white;
                    border-color: #20B2AA;
                }

                .loading-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: rgba(255,255,255,0.8);
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    z-index: 1000;
                }

                .sort-header {
                    cursor: pointer;
                    display: flex;
                    align-items: center;
                    gap: 5px;
                }

                .sort-icon {
                    width: 16px;
                    height: 16px;
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
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">
                        <img src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt=""
                            class="sidebar-icon">
                        <span>Dashboard</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/appointments" class="sidebar-link active">
                        <img src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt=""
                            class="sidebar-icon">
                        <span>Appointments</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/add-doctor" class="sidebar-link">
                        <img src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt=""
                            class="sidebar-icon">
                        <span>Add Doctor</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/doctor-list" class="sidebar-link">
                        <img src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt=""
                            class="sidebar-icon">
                        <span>Doctor List</span>
                    </a>
                </div>

                <!-- Content -->
                <div class="content-container">
                    <h1 class="content-header">All Appointments</h1>

                    <!-- Filters Section -->
                    <div class="filters-container">
                        <input type="text" id="searchInput" class="search-box" placeholder="Search appointments...">
                        <div class="filter-group">
                            <select id="statusFilter" class="filter-select">
                                <option value="">All Status</option>
                                <option value="active">Active</option>
                                <option value="cancelled">Cancelled</option>
                            </select>
                            <select id="doctorFilter" class="filter-select">
                                <option value="">All Doctors</option>
                                <c:forEach items="${doctors}" var="doctor">
                                    <option value="${doctor.id}">${doctor.name}</option>
                                </c:forEach>
                            </select>
                            <select id="dateFilter" class="filter-select">
                                <option value="">All Dates</option>
                                <option value="today">Today</option>
                                <option value="week">This Week</option>
                                <option value="month">This Month</option>
                            </select>
                        </div>
                    </div>

                    <div class="appointments-table">
                        <div class="table-header">
                            <div class="sort-header" data-sort="id"># <span class="sort-icon">↕</span></div>
                            <div class="sort-header" data-sort="patient">Patient <span class="sort-icon">↕</span></div>
                            <div class="sort-header" data-sort="age">Age <span class="sort-icon">↕</span></div>
                            <div class="sort-header" data-sort="date">Date & Time <span class="sort-icon">↕</span></div>
                            <div class="sort-header" data-sort="doctor">Doctor <span class="sort-icon">↕</span></div>
                            <div class="sort-header" data-sort="fees">Fees <span class="sort-icon">↕</span></div>
                            <div>Action</div>
                        </div>

                        <div id="appointmentsList">
                            <!-- Appointments will be loaded dynamically here -->
                        </div>
                    </div>

                    <div class="pagination" id="pagination">
                        <!-- Pagination will be loaded dynamically here -->
                    </div>
                </div>
            </div>

            <div class="loading-overlay" style="display: none;">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
            <script>
                let currentPage = 1;
                let currentSort = { field: 'appointmentTime', direction: 'desc' };
                let currentFilters = {};

                $(document).ready(function() {
                    loadAppointments();

                    // Initialize filters
                    $('.filter-select').on('change', function() {
                        currentFilters[$(this).attr('id')] = $(this).val();
                        loadAppointments();
                    });

                    // Initialize search
                    $('#searchInput').on('input', debounce(function() {
                        currentFilters.search = $(this).val();
                        loadAppointments();
                    }, 500));

                    // Initialize sorting
                    $('.sort-header').on('click', function() {
                        const field = $(this).data('sort');
                        if (currentSort.field === field) {
                            currentSort.direction = currentSort.direction === 'asc' ? 'desc' : 'asc';
                        } else {
                            currentSort.field = field;
                            currentSort.direction = 'asc';
                        }
                        loadAppointments();
                    });
                });

                function loadAppointments() {
                    showLoading();
                    
                    const params = new URLSearchParams({
                        page: currentPage,
                        sortField: currentSort.field,
                        sortDirection: currentSort.direction,
                        ...currentFilters
                    });

                    fetch(`${pageContext.request.contextPath}/admin/appointments/data?${params}`)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log('Received appointments:', data);
                            if (Array.isArray(data.appointments)) {
                                renderAppointments(data.appointments);
                                renderPagination(data.totalPages);
                            } else {
                                console.error('Invalid appointments data:', data);
                                throw new Error('Invalid appointments data');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            $('#appointmentsList').html('<div class="error-message">Failed to load appointments. Please try again.</div>');
                        })
                        .finally(() => {
                            hideLoading();
                        });
                }

                function renderAppointments(appointments) {
                    const container = $('#appointmentsList');
                    container.empty();

                    if (!appointments || appointments.length === 0) {
                        container.html('<div class="no-appointments">No appointments found</div>');
                        return;
                    }

                    appointments.forEach(appointment => {
                        const row = `
                            <div class="appointment-row">
                                <div>${appointment.appointmentId}</div>
                                <div class="patient-info">
                                    <div class="profile-img">
                                        <img src="${pageContext.request.contextPath}/assets/images/default-avatar.svg" alt="Patient">
                                    </div>
                                    <div>
                                        <div class="name">${appointment.patientName || 'N/A'}</div>
                                    </div>
                                </div>
                                <div>${appointment.patientAge || 'N/A'}</div>
                                <div>${appointment.slotDate || 'N/A'}</div>
                                <div class="doctor-info">
                                    <div class="profile-img">
                                        <img src="${appointment.docData && appointment.docData.image ? 'data:image/jpeg;base64,' + appointment.docData.image : pageContext.request.contextPath + '/assets/images/default-avatar.svg'}" alt="${appointment.docData && appointment.docData.name ? appointment.docData.name : 'Doctor'}">
                                    </div>
                                    <div>
                                        <div class="name">${appointment.docData && appointment.docData.name ? appointment.docData.name : 'N/A'}</div>
                                        <div class="speciality">${appointment.docData && appointment.docData.speciality ? appointment.docData.speciality : 'N/A'}</div>
                                    </div>
                                </div>
                                <div>रू${appointment.payment || 0}</div>
                                <div>
                                    <select class="status-select" onchange="updateStatus(${appointment.appointmentId}, this.value)">
                                        <option value="PENDING" ${appointment.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                        <option value="CONFIRMED" ${appointment.status == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                                        <option value="CANCELLED" ${appointment.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                    </select>
                                </div>
                            </div>
                        `;
                        container.append(row);
                    });
                }

                function updateStatus(appointmentId, newStatus) {
                    if (!confirm('Are you sure you want to update this appointment status?')) {
                        return;
                    }

                    showLoading();
                    fetch('${pageContext.request.contextPath}/admin/appointments', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `appointmentId=${appointmentId}&status=${newStatus}`
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            loadAppointments();
                        } else {
                            alert('Failed to update appointment status');
                            loadAppointments();
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('An error occurred while updating the appointment status');
                        loadAppointments();
                    })
                    .finally(() => {
                        hideLoading();
                    });
                }

                function renderPagination(totalPages) {
                    const container = $('#pagination');
                    container.empty();

                    // Previous button
                    const prevDisabled = currentPage === 1 ? 'disabled' : '';
                    container.append(`
                        <button onclick="changePage(${currentPage - 1})" ${prevDisabled}>
                            Previous
                        </button>
                    `);

                    // Page numbers
                    for (let i = 1; i <= totalPages; i++) {
                        const activeClass = i === currentPage ? 'active' : '';
                        container.append(`
                            <button onclick="changePage(${i})" class="${activeClass}">
                                ${i}
                            </button>
                        `);
                    }

                    // Next button
                    const nextDisabled = currentPage === totalPages ? 'disabled' : '';
                    container.append(`
                        <button onclick="changePage(${currentPage + 1})" ${nextDisabled}>
                            Next
                        </button>
                    `);
                }

                function changePage(page) {
                    if (page >= 1 && page <= $('#pagination button').length - 2) {
                        currentPage = page;
                        loadAppointments();
                    }
                }

                function showLoading() {
                    $('.loading-overlay').show();
                }

                function hideLoading() {
                    $('.loading-overlay').hide();
                }

                function debounce(func, wait) {
                    let timeout;
                    return function executedFunction(...args) {
                        const later = () => {
                            clearTimeout(timeout);
                            func(...args);
                        };
                        clearTimeout(timeout);
                        timeout = setTimeout(later, wait);
                    };
                }

                function cancelAppointment(appointmentId) {
                    if (confirm('Are you sure you want to cancel this appointment?')) {
                        showLoading();
                        fetch('${pageContext.request.contextPath}/admin/appointments', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'appointmentId=' + appointmentId
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                loadAppointments();
                            } else {
                                alert('Failed to cancel appointment');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('An error occurred while cancelling the appointment');
                        })
                        .finally(() => {
                            hideLoading();
                        });
                    }
                }
            </script>
        </body>

        </html>