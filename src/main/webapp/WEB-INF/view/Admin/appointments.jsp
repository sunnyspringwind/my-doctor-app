<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <title>All Appointments - MyDoctorApp</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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

                /* Main Container */
                .main-container {
                    display: flex;
                    flex: 1;
                }

                /* Sidebar Styles */
                .sidebar {
                    width: 250px;
                    background-color: white;
                    border-right: 1px solid #e5e7eb;
                    min-height: calc(100vh - 70px);
                    padding-top: 20px;
                    position: fixed;
                    left: 0;
                    top: 70px;
                    bottom: 0;
                    overflow-y: auto;
                }

                .sidebar-link {
                    display: flex;
                    align-items: center;
                    gap: 12px;
                    padding: 14px 36px;
                    color: #515151;
                    text-decoration: none;
                    cursor: pointer;
                    white-space: nowrap;
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
                    margin-left: 250px;
                    max-width: calc(100vw - 250px);
                }

                .appointments-container {
                    width: 100%;
                    max-width: 1200px;
                    margin: 0 auto;
                }

                .appointments-header {
                    margin-bottom: 12px;
                    font-size: 18px;
                    font-weight: 500;
                }

                .appointments-table {
                    background: white;
                    border: 1px solid #e5e7eb;
                    border-radius: 8px;
                    max-height: 80vh;
                    min-height: 60vh;
                    overflow-y: auto;
                }

                .table-header {
                    display: grid;
                    grid-template-columns: 0.5fr 3fr 1fr 3fr 3fr 1fr 1fr;
                    padding: 12px 24px;
                    border-bottom: 1px solid #e5e7eb;
                    font-weight: 500;
                    color: #374151;
                }

                .appointment-row {
                    display: grid;
                    grid-template-columns: 0.5fr 3fr 1fr 3fr 3fr 1fr 1fr;
                    padding: 12px 24px;
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
                    gap: 8px;
                }

                .profile-img {
                    width: 32px;
                    height: 32px;
                    border-radius: 50%;
                    object-fit: cover;
                }

                .cancelled {
                    color: #ef4444;
                    font-size: 12px;
                    font-weight: 500;
                }

                .cancel-icon {
                    width: 40px;
                    height: 40px;
                    cursor: pointer;
                    transition: transform 0.2s ease;
                }

                .cancel-icon:hover {
                    transform: scale(1.1);
                }

                .action-buttons {
                    display: flex;
                    gap: 8px;
                    align-items: center;
                }

                .pay-online-btn {
                    padding: 8px 16px;
                    background-color: #5C2D91;
                    color: white;
                    border: none;
                    border-radius: 4px;
                    font-size: 14px;
                    font-weight: 500;
                    cursor: pointer;
                    transition: background-color 0.2s;
                }

                .pay-online-btn:hover {
                    background-color: #4A2474;
                }

                @media (max-width: 640px) {
                    .table-header {
                        display: none;
                    }

                    .appointment-row {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 8px;
                        padding: 12px;
                    }

                    .patient-info,
                    .doctor-info {
                        width: 100%;
                    }
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
                    <div class="appointments-container">
                        <p class="appointments-header">All Appointments</p>

                        <div class="appointments-table">
                            <div class="table-header">
                                <p>#</p>
                                <p>Patient</p>
                                <p>Age</p>
                                <p>Date & Time</p>
                                <p>Doctor</p>
                                <p>Fees</p>
                                <p>Action</p>
                            </div>

                            <c:forEach items="${appointments}" var="appointment" varStatus="status">
                                <div class="appointment-row">
                                    <p class="max-sm:hidden">${status.index + 1}</p>
                                    <div class="patient-info">
                                        <c:choose>
                                            <c:when test="${not empty appointment.patientData.image}">
                                                <img class="profile-img"
                                                    src="data:image/jpeg;base64,${appointment.patientData.image}"
                                                    alt="Patient">
                                            </c:when>
                                            <c:otherwise>
                                                <img class="profile-img"
                                                    src="${pageContext.request.contextPath}/assets/images/profile_pic.png"
                                                    alt="Patient">
                                            </c:otherwise>
                                        </c:choose>
                                        <p>${appointment.patientData.name}</p>
                                    </div>
                                    <p class="max-sm:hidden">${appointment.patientData.age}</p>
                                    <p>${appointment.slotDate}</p>
                                    <div class="doctor-info">
                                        <c:choose>
                                            <c:when test="${not empty appointment.docData.image}">
                                                <img class="profile-img"
                                                    src="data:image/jpeg;base64,${appointment.docData.image}"
                                                    alt="Doctor">
                                            </c:when>
                                            <c:otherwise>
                                                <img class="profile-img"
                                                    src="${pageContext.request.contextPath}/assets/images/default-doctor.png"
                                                    alt="Doctor">
                                            </c:otherwise>
                                        </c:choose>
                                        <p>${appointment.docData.name}</p>
                                    </div>
                                    <p>₹1200</p>
                                    <c:choose>
                                        <c:when test="${appointment.cancelled}">
                                            <p class="cancelled">Cancelled</p>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="action-buttons">
                                                <button type="button" class="pay-online-btn"
                                                    data-appointment-id="${appointment.appointmentId}">Pay
                                                    Online</button>
                                                <img onclick="cancelAppointment('${appointment.appointmentId}')"
                                                    class="cancel-icon"
                                                    src="${pageContext.request.contextPath}/assets/images/cancel_icon.svg"
                                                    alt="Cancel">
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

            <script>
                // Khalti is initialized directly since the script is inline
                // No longer needed for server-initiated flow
                // let khaltiCheckout = null;
                let khaltiInitialized = true; // Assume backend is ready to initiate

                // Dynamic script loading is no longer needed
                // function loadKhaltiScript() { ... }

                // Khalti is initialized directly since the script is inline
                // No longer needed for server-initiated flow
                // try {
                //     khaltiCheckout = new KhaltiCheckout({ ... });
                //      khaltiInitialized = true;
                //      console.log('Khalti initialized successfully');
                // } catch(error) { ... }

                function initiateKhaltiPayment(appointmentId, amount) {
                    console.log('Entering initiateKhaltiPayment function', { appointmentId, amount });
                    if (!khaltiInitialized) {
                        alert('Payment system is not initialized. Please check for errors or contact support.');
                        return;
                    }

                    console.log('Payment initiation requested for appointment:', appointmentId, 'amount:', amount);

                    // Call backend endpoint to initiate payment with Khalti
                    fetch('${pageContext.request.contextPath}/admin/initiate-khalti-payment', { // **POINTING TO A NEW BACKEND ENDPOINT**
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: new URLSearchParams({
                            'appointmentId': appointmentId,
                            'amount': amount * 100 // Amount in paisa
                        })
                    })
                        .then(response => {
                            console.log('Received response from backend initiate endpoint', response);
                            if (!response.ok) {
                                // Handle HTTP errors, e.g., 400, 500
                                return response.json().then(errorData => {
                                    throw new Error(errorData.message || `HTTP error! status: ${response.status}`);
                                }).catch(() => {
                                    throw new Error(`HTTP error! status: ${response.status}`);
                                });
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log('Payment initiation response from backend:', data);
                            if (data.success && data.payment_url) {
                                console.log('Redirecting to payment URL:', data.payment_url);
                                // Redirect user to Khalti payment page
                                window.location.href = data.payment_url;
                            } else {
                                // Handle backend errors or missing payment_url
                                throw new Error(data.message || 'Payment initiation failed: Invalid response from server.');
                            }
                        })
                        .catch(error => {
                            console.error('Error initiating payment:', error);
                            alert('An error occurred while initiating payment: ' + error.message);
                        });
                }

                // Add click handler to all pay online buttons
                document.addEventListener('DOMContentLoaded', function () {
                    console.log('DOMContentLoaded event fired. Attaching button listeners.');
                    document.querySelectorAll('.pay-online-btn').forEach(button => {
                        button.addEventListener('click', function (e) {
                            console.log('Pay online button clicked.');
                            e.preventDefault();
                            const appointmentId = this.getAttribute('data-appointment-id');
                            console.log('Calling initiateKhaltiPayment for appointment:', appointmentId);
                            // Pass the amount dynamically if needed, currently hardcoded as 1200
                            initiateKhaltiPayment(appointmentId, 1200);
                        });
                    });
                });

                // This function seems to handle payment verification after callback, which aligns with the documentation
                function verifyPayment(token, paymentId) {
                    console.log('Entering verifyPayment function', { token, paymentId });
                    fetch('${pageContext.request.contextPath}/payment/verify', { // **ENSURE THIS ENDPOINT HANDLES KHALTI CALLBACK AND VERIFICATION**
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: new URLSearchParams({
                            'token': token,
                            'paymentId': paymentId
                        })
                    })
                        .then(response => {
                            console.log('Received response from verify endpoint', response);
                            if (!response.ok) {
                                return response.json().then(errorData => {
                                    throw new Error(errorData.message || `HTTP error! status: ${response.status}`);
                                }).catch(() => {
                                    throw new Error(`HTTP error! status: ${response.status}`);
                                });
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log('Payment verification data:', data);
                            if (data.success) {
                                alert('Payment successful!');
                                location.reload();
                            } else {
                                throw new Error(data.message || 'Payment verification failed');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Payment verification failed: ' + error.message);
                        });
                }

                // Keep existing cancel appointment logic
                function cancelAppointment(appointmentId) {
                    console.log('Attempting to cancel appointment', appointmentId);
                    if (confirm('Are you sure you want to cancel this appointment?')) {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/admin/appointments',
                            method: 'POST',
                            data: {
                                appointmentId: appointmentId
                            },
                            success: function (response) {
                                console.log('Cancel appointment response', response);
                                if (response.success) {
                                    location.reload();
                                } else {
                                    alert('Failed to cancel appointment');
                                }
                            },
                            error: function (xhr, status, error) {
                                console.error('Cancel appointment AJAX error', status, error);
                                alert('An error occurred while cancelling the appointment');
                            }
                        });
                    }
                }
            </script>
        </body>

        </html>