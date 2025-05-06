<!-- Patient Dashboard - main.jsp -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard</title>
    <style>
        :root {
            --primary-color: #5a8dee;
            --secondary-color: #38cfd9;
            --tertiary-color: #67d391;
            --dark-color: #2a3f54;
            --light-color: #f8f9fa;
            --danger-color: #f55c7a;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --text-color: #333;
            --border-radius: 8px;
            --box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f0f3f9;
            color: var(--text-color);
        }

        .wrapper {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background-color: var(--dark-color);
            color: white;
            padding: 20px 0;
            transition: all 0.3s;
        }

        .sidebar-header {
            padding: 15px 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center;
        }

        .profile-image {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-bottom: 10px;
            object-fit: cover;
            border: 3px solid var(--primary-color);
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-item {
            padding: 12px 20px;
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s;
        }

        .menu-item:hover, .menu-item.active {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border-left: 4px solid var(--primary-color);
        }

        .menu-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .main-content {
            flex: 1;
            padding: 20px;
            transition: all 0.3s;
        }

        .top-bar {
            background-color: white;
            padding: 15px 20px;
            border-radius: var(--border-radius);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            box-shadow: var(--box-shadow);
        }

        .search-bar {
            display: flex;
            align-items: center;
        }

        .search-bar input {
            padding: 8px 15px;
            border: 1px solid #ddd;
            border-radius: 20px;
            outline: none;
            width: 250px;
        }

        .user-menu {
            display: flex;
            align-items: center;
        }

        .user-menu .notification {
            margin-right: 20px;
            position: relative;
        }

        .badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: var(--danger-color);
            color: white;
            border-radius: 50%;
            width: 18px;
            height: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-image {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            object-fit: cover;
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: white;
            min-width: 160px;
            box-shadow: var(--box-shadow);
            z-index: 1;
            border-radius: var(--border-radius);
        }

        .dropdown-content a {
            color: var(--text-color);
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            transition: all 0.3s;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .card {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 20px;
            margin-bottom: 20px;
        }

        .card-header {
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-title {
            font-size: 18px;
            color: var(--dark-color);
        }

        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .stat-card {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 20px;
            display: flex;
            align-items: center;
        }

        .stat-icon {
            background-color: rgba(90, 141, 238, 0.2);
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            color: var(--primary-color);
            font-size: 24px;
        }

        .stat-icon.green {
            background-color: rgba(103, 211, 145, 0.2);
            color: var(--tertiary-color);
        }

        .stat-icon.blue {
            background-color: rgba(56, 207, 217, 0.2);
            color: var(--secondary-color);
        }

        .stat-icon.red {
            background-color: rgba(245, 92, 122, 0.2);
            color: var(--danger-color);
        }

        .stat-info h3 {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .stat-info p {
            font-size: 14px;
            color: #777;
        }

        .appointment-list {
            width: 100%;
            border-collapse: collapse;
        }

        .appointment-list th, .appointment-list td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .appointment-list tr:hover {
            background-color: #f9f9f9;
        }

        .status {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
        }

        .status.confirmed {
            background-color: rgba(40, 167, 69, 0.2);
            color: var(--success-color);
        }

        .status.pending {
            background-color: rgba(255, 193, 7, 0.2);
            color: var(--warning-color);
        }

        .status.cancelled {
            background-color: rgba(245, 92, 122, 0.2);
            color: var(--danger-color);
        }

        .action {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-danger {
            background-color: var(--danger-color);
            color: white;
        }

        .btn:hover {
            opacity: 0.8;
        }

        .medical-history, .medication {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .history-card, .medication-card {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 15px;
        }

        .history-card h4, .medication-card h4 {
            margin-bottom: 10px;
            color: var(--dark-color);
        }

        .history-card p, .medication-card p {
            color: #666;
            margin-bottom: 5px;
        }

        .medication-card .dosage {
            color: var(--primary-color);
            font-weight: bold;
        }

        .tab-container {
            display: none;
        }

        .tab-container.active {
            display: block;
        }

        @media (max-width: 768px) {
            .wrapper {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
                margin-bottom: 20px;
            }
            .dashboard-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="sidebar">
        <div class="sidebar-header">
            <c:choose>
                <c:when test="${not empty patient.pfp}">
                    <img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(patient.pfp)}" class="profile-image" alt="Profile Image">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/assets/default-avatar.jpg" class="profile-image" alt="Default Profile">
                </c:otherwise>
            </c:choose>
            <h4>${patient.name}</h4>
            <p>Patient</p>
        </div>
        <div class="sidebar-menu">
            <a href="#" class="menu-item active" onclick="showTab('dashboard')">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a href="#" class="menu-item" onclick="showTab('appointments')">
                <i class="fas fa-calendar-check"></i> Appointments
            </a>
            <a href="#" class="menu-item" onclick="showTab('medicalRecords')">
                <i class="fas fa-notes-medical"></i> Medical Records
            </a>
            <a href="#" class="menu-item" onclick="showTab('medications')">
                <i class="fas fa-pills"></i> Medications
            </a>
            <a href="#" class="menu-item" onclick="showTab('profile')">
                <i class="fas fa-user"></i> Profile
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="menu-item">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
    <div class="main-content">
        <div class="top-bar">
            <div class="search-bar">
                <input type="text" placeholder="Search...">
            </div>
            <div class="user-menu">
                <div class="notification">
                    <i class="fas fa-bell"></i>
                    <span class="badge">3</span>
                </div>
                <div class="dropdown">
                    <div class="user-info">
                        <c:choose>
                            <c:when test="${not empty patient.pfp}">
                                <img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(patient.pfp)}" class="user-image" alt="User Image">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/assets/default-avatar.jpg" class="user-image" alt="Default User">
                            </c:otherwise>
                        </c:choose>
                        <span>${patient.name} <i class="fas fa-chevron-down"></i></span>
                    </div>
                    <div class="dropdown-content">
                        <a href="#" onclick="showTab('profile')">Profile</a>
                        <a href="#">Settings</a>
                        <a href="${pageContext.request.contextPath}/logout">Logout</a>
                    </div>
                </div>
            </div>
        </div>

        <div id="dashboard" class="tab-container active">
            <div class="dashboard-stats">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-info">
                        <h3>8</h3>
                        <p>Total Appointments</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon green">
                        <i class="fas fa-notes-medical"></i>
                    </div>
                    <div class="stat-info">
                        <h3>5</h3>
                        <p>Medical Records</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <i class="fas fa-pills"></i>
                    </div>
                    <div class="stat-info">
                        <h3>3</h3>
                        <p>Current Medications</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon red">
                        <i class="fas fa-file-medical-alt"></i>
                    </div>
                    <div class="stat-info">
                        <h3>2</h3>
                        <p>Pending Reports</p>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Upcoming Appointments</h2>
                    <button class="btn btn-primary">Book New</button>
                </div>
                <table class="appointment-list">
                    <thead>
                    <tr>
                        <th>Doctor</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="appointment" items="${upcomingAppointments}">
                        <tr>
                            <td>Dr. ${appointment.doctorName}</td>
                            <td>${appointment.date}</td>
                            <td>${appointment.time}</td>
                            <td><span class="status ${appointment.status.toLowerCase()}">${appointment.status}</span></td>
                            <td class="action">
                                <button class="btn btn-primary">View</button>
                                <button class="btn btn-danger">Cancel</button>
                            </td>
                        </tr>
                    </c:forEach>
                    <!-- Sample data if no appointments -->
                    <c:if test="${empty upcomingAppointments}">
                        <tr>
                            <td>Dr. John Smith</td>
                            <td>25 Apr 2025</td>
                            <td>10:30 AM</td>
                            <td><span class="status confirmed">Confirmed</span></td>
                            <td class="action">
                                <button class="btn btn-primary">View</button>
                                <button class="btn btn-danger">Cancel</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Dr. Sarah Johnson</td>
                            <td>30 Apr 2025</td>
                            <td>3:15 PM</td>
                            <td><span class="status pending">Pending</span></td>
                            <td class="action">
                                <button class="btn btn-primary">View</button>
                                <button class="btn btn-danger">Cancel</button>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>

            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Recent Medical History</h2>
                </div>
                <div class="medical-history">
                    <c:forEach var="record" items="${recentMedicalRecords}">
                        <div class="history-card">
                            <h4>${record.diagnosis}</h4>
                            <p><strong>Date:</strong> ${record.date}</p>
                            <p><strong>Doctor:</strong> Dr. ${record.doctorName}</p>
                            <p><strong>Notes:</strong> ${record.notes}</p>
                        </div>
                    </c:forEach>
                    <!-- Sample data if no records -->
                    <c:if test="${empty recentMedicalRecords}">
                        <div class="history-card">
                            <h4>Seasonal Allergies</h4>
                            <p><strong>Date:</strong> 10 Apr 2025</p>
                            <p><strong>Doctor:</strong> Dr. Jane Wilson</p>
                            <p><strong>Notes:</strong> Prescribed antihistamines for seasonal allergies. Follow-up in 2 weeks if symptoms persist.</p>
                        </div>
                        <div class="history-card">
                            <h4>Annual Check-up</h4>
                            <p><strong>Date:</strong> 15 Mar 2025</p>
                            <p><strong>Doctor:</strong> Dr. John Smith</p>
                            <p><strong>Notes:</strong> All vitals normal. Recommended regular exercise and balanced diet.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <div id="appointments" class="tab-container">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">All Appointments</h2>
                    <button class="btn btn-primary">Book New</button>
                </div>
                <table class="appointment-list">
                    <thead>
                    <tr>
                        <th>Doctor</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- Appointments would be populated here with JSTL -->
                    <tr>
                        <td>Dr. John Smith</td>
                        <td>25 Apr 2025</td>
                        <td>10:30 AM</td>
                        <td><span class="status confirmed">Confirmed</span></td>
                        <td class="action">
                            <button class="btn btn-primary">View</button>
                            <button class="btn btn-danger">Cancel</button>
                        </td>
                    </tr>
                    <tr>
                        <td>Dr. Sarah Johnson</td>
                        <td>30 Apr 2025</td>
                        <td>3:15 PM</td>
                        <td><span class="status pending">Pending</span></td>
                        <td class="action">
                            <button class="btn btn-primary">View</button>
                            <button class="btn btn-danger">Cancel</button>
                        </td>
                    </tr>
                    <tr>
                        <td>Dr. David Lee</td>
                        <td>15 Mar 2025</td>
                        <td>9:00 AM</td>
                        <td><span class="status confirmed">Completed</span></td>
                        <td class="action">
                            <button class="btn btn-primary">View</button>
                        </td>
                    </tr>
                    <tr>
                        <td>Dr. Jessica Taylor</td>
                        <td>10 Feb 2025</td>
                        <td>2:45 PM</td>
                        <td><span class="status cancelled">Cancelled</span></td>
                        <td class="action">
                            <button class="btn btn-primary">View</button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div id="medicalRecords" class="tab-container">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Medical Records</h2>
                </div>
                <div class="medical-history">
                    <!-- Medical records would be populated here with JSTL -->
                    <div class="history-card">
                        <h4>Seasonal Allergies</h4>
                        <p><strong>Date:</strong> 10 Apr 2025</p>
                        <p><strong>Doctor:</strong> Dr. Jane Wilson</p>
                        <p><strong>Notes:</strong> Prescribed antihistamines for seasonal allergies. Follow-up in 2 weeks if symptoms persist.</p>
                    </div>
                    <div class="history-card">
                        <h4>Annual Check-up</h4>
                        <p><strong>Date:</strong> 15 Mar 2025</p>
                        <p><strong>Doctor:</strong> Dr. John Smith</p>
                        <p><strong>Notes:</strong> All vitals normal. Recommended regular exercise and balanced diet.</p>
                    </div>
                    <div class="history-card">
                        <h4>Flu Treatment</h4>
                        <p><strong>Date:</strong> 20 Jan 2025</p>
                        <p><strong>Doctor:</strong> Dr. Sarah Johnson</p>
                        <p><strong>Notes:</strong> Diagnosed with seasonal flu. Prescribed rest, fluids, and over-the-counter medication.</p>
                    </div>
                </div>
            </div>
        </div>

        <div id="medications" class="tab-container">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Current Medications</h2>
                </div>
                <div class="medication">
                    <!-- Medications would be populated here with JSTL -->
                    <div class="medication-card">
                        <h4>Antihistamine</h4>
                        <p><strong>Prescribed:</strong> 10 Apr 2025</p>
                        <p><strong>Doctor:</strong> Dr. Jane Wilson</p>
                        <p class="dosage">10mg, once daily for 30 days</p>
                        <p><strong>Notes:</strong> Take with food. Avoid driving if experiencing drowsiness.</p>
                    </div>
                    <div class="medication-card">
                        <h4>Vitamin D</h4>
                        <p><strong>Prescribed:</strong> 15 Mar 2025</p>
                        <p><strong>Doctor:</strong> Dr. John Smith</p>
                        <p class="dosage">1000 IU, once daily</p>
                        <p><strong>Notes:</strong> Take with a meal for better absorption.</p>
                    </div>
                    <div class="medication-card">
                        <h4>Ibuprofen</h4>
                        <p><strong>Prescribed:</strong> 20 Jan 2025</p>
                        <p><strong>Doctor:</strong> Dr. Sarah Johnson</p>
                        <p class="dosage">400mg, as needed for pain, not to exceed 1200mg per day</p>
                        <p><strong>Notes:</strong> Take with food to reduce stomach irritation.</p>
                    </div>
                </div>
            </div>
        </div>

        <div id="profile" class="tab-container">
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Profile Information</h2>
                </div>
                <div class="profile-content">
                    <form action="${pageContext.request.contextPath}/user" method="post" enctype="multipart/form-data">
                        <div style="display: flex; margin-bottom: 20px;">
                            <div style="margin-right: 30px; text-align: center;">
                                <c:choose>
                                    <c:when test="${not empty user.pfp}">
                                        <img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(user.pfp)}"
                                             style="width: 150px; height: 150px; border-radius: 50%; object-fit: cover; margin-bottom: 10px;"
                                             alt="Profile Image">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/assets/default-avatar.jpg"
                                             style="width: 150px; height: 150px; border-radius: 50%; object-fit: cover; margin-bottom: 10px;"
                                             alt="Default Profile">
                                    </c:otherwise>
                                </c:choose>
                                <div>
                                    <input type="file" name="profilePicture" id="profilePicture" style="display: none;" accept="image/*">
                                    <label for="profilePicture" class="btn btn-primary" style="cursor: pointer;">Change Photo</label>
                                </div>
                            </div>
                            <div style="flex-grow: 1;">
                                <div style="margin-bottom: 15px;">
                                    <label for="name" style="display: block; margin-bottom: 5px; font-weight: bold;">Full Name</label>
                                    <input type="text" id="name" name="name" value="${user.name}"
                                           style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: var(--border-radius);">
                                </div>
                                <div style="margin-bottom: 15px;">
                                    <label for="email" style="display: block; margin-bottom: 5px; font-weight: bold;">Email</label>
                                    <input type="email" id="email" name="email" value="${user.email}"
                                           style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: var(--border-radius);">
                                </div>
                                <div style="margin-bottom: 15px;">
                                    <label for="phone" style="display: block; margin-bottom: 5px; font-weight: bold;">Phone Number</label>
                                    <input type="tel" id="phone" name="phone" value="${user.phone}"
                                           style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: var(--border-radius);">
                                </div>
                            </div>
                        </div>

                        <div style="margin-bottom: 15px;">
                            <label for="address" style="display: block; margin-bottom: 5px; font-weight: bold;">Address</label>
                            <textarea id="address" name="address"
                                      style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: var(--border-radius); min-height: 80px;">${user.address}</textarea>
                        </div>

                        <div style="display: flex; gap: 20px; margin-bottom: 15px;">
                            <div style="flex: 1;">
                                <label for="gender" style="display: block; margin-bottom: 5px; font-weight: bold;">Gender</label>
                                <select id="gender" name="gender"
                                        style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: var(--border-radius);">
                                    <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                            <div style="flex: 1;">
                                <label for="dateOfBirth" style="display: block; margin-bottom: 5px; font-weight: bold;">Date of Birth</label>
                                <input type="date" id="dateOfBirth" name="dateOfBirth" value="${user.dateOfBirth}"
                                       style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: var(--border-radius);">
                            </div>
                        </div>

                        <input type="hidden" name="isActive" value="true">
                        <input type="hidden" name="registrationDate" value="${user.registrationDate}">

                        <h3 style="margin: 20px 0 15px;">Change Password</h3>
                        <div style="margin-bottom: 15px;">
                            <label for="currentPassword" style="display: block; margin-bottom: 5px; font-weight: bold;">Current Password</label>
                            <input type="password" id="currentPassword" name="currentPassword"
                                   style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: var(--border-radius);">
                        </div>
                        <div style="display: flex; gap: 20px; margin-bottom: 20px;">
                            <div style="flex: 1;">
                                <label for="newPassword" style="display: block; margin-bottom: 5px; font-weight: bold;">New Password</label>
                                <input type="password" id="newPassword" name="newPassword"
                                       style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: var(--border-radius);">
                            </div>
                            <div style="flex: 1;">
                                <label for="confirmPassword" style="display: block; margin-bottom: 5px; font-weight: bold;">Confirm New Password</label>
                                <input type="password" id="confirmPassword" name="confirmPassword"
                                       style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: var(--border-radius);">
                            </div>
                        </div>

                        <div style="text-align: right;">
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>
<script>
    function showTab(tabId) {
        // Hide all tab containers
        const tabContainers = document.querySelectorAll('.tab-container');
        tabContainers.forEach(tab => {
            tab.classList.remove('active');
        });

        // Show the selected tab
        document.getElementById(tabId).classList.add('active');

        // Update active menu item
        const menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(item => {
            item.classList.remove('active');
        });

        // Find the menu item that triggered this and set it as active
        const activeMenuItem = document.querySelector(`.menu-item[onclick="showTab('${tabId}')"]`);
        if (activeMenuItem) {
            activeMenuItem.classList.add('active');
        }
    }

    // Preview profile picture before upload
    document.getElementById('profilePicture').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                const profileImages = document.querySelectorAll('.profile-image');
                profileImages.forEach(img => {
                    img.src = event.target.result;
                });

                const userImages = document.querySelectorAll('.user-image');
                userImages.forEach(img => {
                    img.src = event.target.result;
                });
            }
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>