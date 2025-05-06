<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <% 
            // Clear any session messages
            session.removeAttribute("message");
            session.removeAttribute("messageType");
        %>

            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>My Appointments</title>
                <style>
                    @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap');

                    * {
                        font-family: 'Outfit', sans-serif;
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                        scrollbar-width: none; /* Firefox */
                        -ms-overflow-style: none; /* IE and Edge */
                    }

                    /* Hide all session messages on this page */
                    .message, 
                    div[class*="success"],
                    div[class*="error"] {
                        display: none !important;
                    }

                    *::-webkit-scrollbar {
                        display: none; /* Chrome, Safari, Opera */
                    }

                    html, body {
                        overflow-x: hidden;
                        scrollbar-width: none;
                        -ms-overflow-style: none;
                    }

                    html::-webkit-scrollbar, 
                    body::-webkit-scrollbar {
                        display: none;
                    }

                    body {
                        background-color: #f8fafc;
                    }

                    .main-container {
                        max-width: 1200px;
                        margin: 2rem auto;
                        padding: 0;
                    }

                    .appointments-container {
                        background-color: white;
                        border-radius: 0.75rem;
                        padding: 1.5rem 0;
                    }

                    .appointments-title {
                        font-size: 1.25rem;
                        font-weight: 500;
                        color: #334155;
                        margin-bottom: 1.5rem;
                        padding-left: 1rem;
                    }

                    .appointments-list {
                        display: flex;
                        flex-direction: column;
                        gap: 1rem;
                    }

                    .appointment-card {
                        display: flex;
                        align-items: flex-start;
                        padding: 1.25rem 5rem 1.25rem 0.25rem;
                        border: 1px solid #e2e8f0;
                        border-radius: 0.5rem;
                        background-color: white;
                        position: relative;
                        margin: 0 0.25rem;
                    }

                    .doctor-image {
                        width: 120px;
                        height: 120px;
                        border-radius: 0.5rem;
                        object-fit: cover;
                        margin-right: 1rem;
                        background-color: #f1f5f9;
                    }

                    .appointment-info {
                        flex: 1;
                        padding-right: 100px;
                        min-height: 120px;
                        display: flex;
                        flex-direction: column;
                        justify-content: space-between;
                    }

                    .doctor-name {
                        font-size: 1.125rem;
                        font-weight: 500;
                        color: #1e293b;
                        margin-bottom: 0.5rem;
                    }

                    .doctor-speciality {
                        font-size: 0.9375rem;
                        color: #64748b;
                        margin-bottom: 1rem;
                    }

                    .address-label {
                        font-size: 0.8125rem;
                        color: #475569;
                        font-weight: 500;
                        margin-bottom: 0.125rem;
                    }

                    .doctor-address {
                        font-size: 0.8125rem;
                        color: #64748b;
                        margin-bottom: 0.75rem;
                        line-height: 1.4;
                    }

                    .date-time-label {
                        font-size: 0.8125rem;
                        color: #475569;
                        font-weight: 500;
                        margin-bottom: 0.125rem;
                    }

                    .appointment-time {
                        color: #64748b;
                        font-size: 0.8125rem;
                    }

                    .action-buttons {
                        position: absolute;
                        top: 1.25rem;
                        right: 0.5rem;
                        display: flex;
                        flex-direction: column;
                        gap: 0.75rem;
                        min-width: 120px;
                    }

                    .pay-online-btn {
                        padding: 0.5rem 1rem;
                        background-color: transparent;
                        color: #64748b;
                        border: 1px solid #cbd5e1;
                        border-radius: 0.375rem;
                        font-size: 0.875rem;
                        font-weight: 500;
                        cursor: pointer;
                        transition: all 0.2s;
                        text-align: center;
                        white-space: nowrap;
                    }

                    .pay-online-btn:hover {
                        background-color: #f1f5f9;
                        border-color: #94a3b8;
                        color: #475569;
                    }

                    .cancel-btn {
                        padding: 0.5rem 1rem;
                        background-color: transparent;
                        color: #64748b;
                        border: 1px solid #cbd5e1;
                        border-radius: 0.375rem;
                        font-size: 0.875rem;
                        font-weight: 500;
                        cursor: pointer;
                        transition: all 0.2s;
                        text-align: center;
                        white-space: nowrap;
                    }

                    .cancel-btn:hover {
                        background-color: #f1f5f9;
                        border-color: #94a3b8;
                        color: #475569;
                    }

                    .appointment-cancelled {
                        position: absolute;
                        top: 1.25rem;
                        right: 0.5rem;
                        padding: 0.5rem 1rem;
                        background-color: #fef2f2;
                        color: #ef4444;
                        border: 1px solid #fee2e2;
                        border-radius: 0.375rem;
                        font-size: 0.875rem;
                        font-weight: 500;
                        white-space: nowrap;
                    }

                    .fade-out {
                        animation: fadeOut 0.5s ease-in-out forwards;
                    }

                    @keyframes fadeOut {
                        from {
                            opacity: 1;
                            transform: translateY(0);
                        }
                        to {
                            opacity: 0;
                            transform: translateY(-10px);
                        }
                    }

                    .no-appointments {
                        text-align: center;
                        padding: 2rem;
                        color: #64748b;
                    }

                    @media (max-width: 768px) {
                        .main-container {
                            padding: 0;
                            margin: 1rem auto;
                        }

                        .appointments-container {
                            padding: 1rem 0;
                        }

                        .appointment-card {
                            padding: 1rem 0.5rem;
                            margin: 0 0.25rem;
                        }

                        .doctor-image {
                            width: 100px;
                            height: 100px;
                        }

                        .appointment-info {
                            min-height: 100px;
                        }

                        .action-buttons {
                            position: static;
                            flex-direction: row;
                            justify-content: flex-end;
                            margin-top: 1rem;
                            width: 100%;
                            gap: 2.5rem;
                            padding-right: 0;
                            min-width: auto;
                        }

                        .appointment-cancelled {
                            position: static;
                            display: inline-block;
                            margin-top: 1rem;
                        }
                    }

                    .modal-overlay {
                        position: fixed;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background-color: rgba(0, 0, 0, 0.5);
                        z-index: 1000;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .modal-content {
                        background-color: white;
                        padding: 2rem;
                        border-radius: 0.5rem;
                        max-width: 400px;
                        width: 90%;
                        position: relative;
                    }

                    .modal-title {
                        font-size: 1.25rem;
                        font-weight: 600;
                        color: #1f2937;
                        margin-bottom: 1rem;
                    }

                    .modal-message {
                        color: #4b5563;
                        margin-bottom: 1.5rem;
                    }

                    .modal-buttons {
                        display: flex;
                        gap: 1rem;
                        justify-content: flex-end;
                    }

                    .modal-button {
                        padding: 0.5rem 1rem;
                        border-radius: 0.375rem;
                        font-size: 0.875rem;
                        font-weight: 500;
                        cursor: pointer;
                        transition: all 0.2s;
                    }

                    .modal-button.confirm {
                        background-color: #ef4444;
                        color: white;
                        border: none;
                    }

                    .modal-button.confirm:hover {
                        background-color: #dc2626;
                    }

                    .modal-button.cancel {
                        background-color: #f3f4f6;
                        color: #4b5563;
                        border: 1px solid #e5e7eb;
                    }

                    .modal-button.cancel:hover {
                        background-color: #e5e7eb;
                    }
                </style>
                <script>
                    // Function to handle cancellation
                    function handleCancellation(button) {
                        console.log('Cancel button clicked');
                        
                        // Get the appointment ID from the parent card
                        const appointmentId = button.closest('.appointment-card').getAttribute('data-appointment-id');
                        console.log('Appointment ID:', appointmentId);
                        
                        // Store in localStorage
                        localStorage.setItem('cancelled_' + appointmentId, 'true');
                        console.log('Stored in localStorage:', 'cancelled_' + appointmentId);
                        
                        // Update UI
                        button.parentElement.outerHTML = '<div class="appointment-cancelled">Cancelled</div>';
                    }

                    // Check for cancelled appointments on page load
                    document.addEventListener('DOMContentLoaded', function() {
                        console.log('Page loaded, checking localStorage');
                        
                        // Get all appointment cards
                        const appointmentCards = document.querySelectorAll('.appointment-card');
                        appointmentCards.forEach(card => {
                            const appointmentId = card.getAttribute('data-appointment-id');
                            console.log('Checking appointment:', appointmentId);
                            
                            if (localStorage.getItem('cancelled_' + appointmentId) === 'true') {
                                console.log('Found cancelled appointment:', appointmentId);
                                const actionButtonsDiv = card.querySelector('.action-buttons');
                                if (actionButtonsDiv) {
                                    actionButtonsDiv.outerHTML = '<div class="appointment-cancelled">Cancelled</div>';
                                }
                            }
                        });
                    });
                </script>
            </head>

            <body>
                <!-- Include the Navbar -->
                <jsp:include page="/WEB-INF/components/navbar.jsp" />

                <div class="main-container">
                    <div class="appointments-container">
                        <h1 class="appointments-title">My appointments</h1>

                        <c:if test="${not empty param.success}">
                            <div class="success-message"
                                style="background-color: #D1FAE5; color: #065F46; padding: 1rem; border-radius: 0.5rem; margin-bottom: 1.5rem;">
                                Appointment booked successfully!
                            </div>
                        </c:if>

                        <div class="appointments-list">
                            <c:choose>
                                <c:when test="${not empty appointments}">
                                    <c:forEach items="${appointments}" var="appointment">
                                        <div class="appointment-card" data-appointment-id="${appointment.appointmentId}">
                                            <img class="doctor-image"
                                                src="data:image/jpeg;base64,${appointment.docData.image}"
                                                alt="${appointment.docData.name}">

                                            <div class="appointment-info">
                                                <h3 class="doctor-name">${appointment.docData.name}</h3>
                                                <p class="doctor-speciality">${appointment.docData.speciality}</p>
                                                
                                                <p class="address-label">Address:</p>
                                                <p class="doctor-address">${appointment.docData.address}</p>
                                                
                                                <p class="date-time-label">Date & Time:</p>
                                                <p class="appointment-time">${appointment.slotDate}</p>
                                            </div>

                                            <c:choose>
                                                <c:when test="${appointment.status eq 'CANCELLED'}">
                                                    <div class="appointment-cancelled">
                                                        Cancelled
                                                    </div>
                                                </c:when>
                                                <c:when test="${appointment.status eq 'CONFIRMED'}">
                                                    <div class="appointment-cancelled" style="background-color: #d1fae5; color: #10b981; border: 1px solid #a7f3d0;">
                                                        Confirmed
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="action-buttons">
                                                        <button class="pay-online-btn">Pay Online</button>
                                                        <button class="cancel-btn" onclick="handleCancellation(this)">Cancel appointment</button>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-appointments">
                                        <p>You don't have any appointments yet.</p>
                                        <p>Book your first appointment with our trusted doctors!</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Include the Footer -->
                <div class="footer-wrapper">
                    <jsp:include page="/WEB-INF/components/footer.jsp" />
                </div>
            </body>

            </html>
