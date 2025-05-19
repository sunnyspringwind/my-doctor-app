<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ page import="java.util.Base64" %>

                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Book Appointment</title>
                    <style>
                        @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap');

                        * {
                            font-family: 'Outfit', sans-serif;
                        }

                        html,
                        body {
                            margin: 0;
                            padding: 0;
                            overflow-x: hidden;
                            height: 100%;
                        }

                        html::-webkit-scrollbar,
                        body::-webkit-scrollbar {
                            display: none;
                        }

                        html,
                        body {
                            -ms-overflow-style: none;
                            scrollbar-width: none;
                        }

                        .main-container {
                            max-width: 1000px;
                            margin: 2rem auto;
                            padding: 0 1rem;
                        }

                        .doctor-container {
                            display: flex;
                            gap: 2rem;
                            background-color: white;
                            border-radius: 1rem;
                            overflow: hidden;
                            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                            margin-bottom: 2rem;
                        }

                        .doctor-image-container {
                            width: 300px;
                            height: 300px;
                            background-color: #20B2AA;
                            flex-shrink: 0;
                        }

                        .doctor-image {
                            width: 100%;
                            height: 100%;
                            object-fit: cover;
                        }

                        .doctor-info {
                            flex: 1;
                            padding: 1.5rem;
                        }

                        .doctor-name {
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                            font-size: 1.5rem;
                            font-weight: 600;
                            color: #1F2937;
                            margin-bottom: 0.5rem;
                        }

                        .verified-icon {
                            width: 20px;
                            height: 20px;
                            color: #26B99A;
                        }

                        .doctor-credentials {
                            display: flex;
                            align-items: center;
                            gap: 1rem;
                            color: #6B7280;
                            margin-bottom: 1.5rem;
                            font-size: 0.9rem;
                        }

                        .experience-badge {
                            padding: 0.25rem 0.75rem;
                            border: 1px solid #E5E7EB;
                            border-radius: 9999px;
                            font-size: 0.8rem;
                        }

                        .about-section {
                            margin-bottom: 1.5rem;
                        }

                        .about-title {
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                            font-weight: 500;
                            color: #1F2937;
                            margin-bottom: 0.5rem;
                            font-size: 0.9rem;
                        }

                        .about-text {
                            color: #6B7280;
                            line-height: 1.4;
                            font-size: 0.9rem;
                        }

                        .fees-text {
                            color: #6B7280;
                            font-weight: 500;
                            font-size: 0.9rem;
                        }

                        .booking-section {
                            background-color: white;
                            border-radius: 1rem;
                            padding: 1.5rem;
                            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                        }

                        .booking-title {
                            font-size: 1.1rem;
                            font-weight: 500;
                            color: #1F2937;
                            margin-bottom: 1rem;
                        }

                        .days-container {
                            display: flex;
                            gap: 0.75rem;
                            margin-bottom: 1.25rem;
                            overflow-x: auto;
                            scrollbar-width: none;
                            -ms-overflow-style: none;
                            padding-bottom: 0.5rem;
                            -ms-overflow-style: none;
                            scrollbar-width: none;
                        }

                        .days-container::-webkit-scrollbar {
                            display: none;
                            width: 0;
                            height: 0;
                        }

                        .day-slot {
                            display: flex;
                            flex-direction: column;
                            align-items: center;
                            min-width: 56px;
                            padding: 0.75rem 0;
                            border-radius: 0.75rem;
                            cursor: pointer;
                            transition: all 0.2s;
                        }

                        .day-slot.selected {
                            background-color: #20B2AA;
                            color: white;
                        }

                        .day-slot.unselected {
                            border: 1px solid #E5E7EB;
                            color: #6B7280;
                        }

                        .day-name {
                            font-weight: 500;
                            font-size: 0.8rem;
                        }

                        .day-date {
                            font-size: 0.9rem;
                        }

                        .time-slots {
                            display: flex;
                            flex-wrap: wrap;
                            gap: 0.75rem;
                            margin-bottom: 1.5rem;
                        }

                        .time-slot {
                            padding: 0.5rem 1rem;
                            border-radius: 0.75rem;
                            cursor: pointer;
                            font-size: 0.8rem;
                            transition: all 0.2s;
                        }

                        .time-slot.selected {
                            background-color: #20B2AA;
                            color: white;
                        }

                        .time-slot.unselected {
                            border: 1px solid #E5E7EB;
                            color: #6B7280;
                        }

                        .book-button {
                            background-color: #20B2AA;
                            color: white;
                            padding: 0.75rem 1.5rem;
                            border-radius: 0.75rem;
                            border: none;
                            font-size: 0.9rem;
                            cursor: pointer;
                            transition: background-color 0.2s;
                            width: 100%;
                            max-width: 200px;
                        }

                        .book-button:hover {
                            background-color: #219681;
                        }

                        @media (max-width: 768px) {
                            .doctor-container {
                                flex-direction: column;
                            }

                            .doctor-image-container {
                                width: 100%;
                                height: 250px;
                            }

                            .doctor-info {
                                padding: 1rem;
                            }

                            .doctor-name {
                                font-size: 1.25rem;
                            }

                            .time-slots {
                                gap: 0.5rem;
                            }

                            .time-slot {
                                padding: 0.4rem 0.8rem;
                            }
                        }

                        /* Add modal styles */
                        .modal-overlay {
                            display: none;
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background-color: rgba(0, 0, 0, 0.5);
                            z-index: 1000;
                            align-items: center;
                            justify-content: center;
                        }

                        .modal-content {
                            background-color: white;
                            padding: 2rem;
                            border-radius: 1rem;
                            max-width: 400px;
                            width: 90%;
                            text-align: center;
                            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                        }

                        .modal-title {
                            font-size: 1.25rem;
                            font-weight: 600;
                            color: #1F2937;
                            margin-bottom: 1rem;
                        }

                        .modal-message {
                            color: #6B7280;
                            margin-bottom: 1.5rem;
                            line-height: 1.5;
                        }

                        .modal-buttons {
                            display: flex;
                            gap: 1rem;
                            justify-content: center;
                        }

                        .modal-button {
                            padding: 0.75rem 1.5rem;
                            border-radius: 0.75rem;
                            font-size: 0.9rem;
                            cursor: pointer;
                            transition: all 0.2s;
                            border: none;
                        }

                        .modal-button.confirm {
                            background-color: #20B2AA;
                            color: white;
                        }

                        .modal-button.confirm:hover {
                            background-color: #219681;
                        }

                        .modal-button.cancel {
                            background-color: #F3F4F6;
                            color: #6B7280;
                        }

                        .modal-button.cancel:hover {
                            background-color: #E5E7EB;
                        }

                        .related-doctors-container {
                            display: flex;
                            flex-direction: column;
                            align-items: center;
                            margin: 3rem 0 2rem 0;
                        }
                        .related-doctors-title {
                            font-size: 2rem;
                            font-weight: 600;
                            text-align: center;
                            margin-bottom: 0.5rem;
                        }
                        .related-doctors-description {
                            text-align: center;
                            font-size: 1rem;
                            color: #64748B;
                            margin-bottom: 2rem;
                        }
                        .related-doctors-grid {
                            width: 100%;
                            display: grid;
                            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                            gap: 1.5rem;
                            justify-items: center;
                        }
                        .related-doctor-card {
                            background: #F8FAFC;
                            border-radius: 1.25rem;
                            overflow: hidden;
                            text-decoration: none;
                            transition: box-shadow 0.3s, transform 0.3s;
                            border: 1px solid #E2E8F0;
                            width: 100%;
                            max-width: 260px;
                            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
                            display: flex;
                            flex-direction: column;
                            align-items: center;
                        }
                        .related-doctor-card:hover {
                            box-shadow: 0 8px 24px rgba(32,178,170,0.12);
                            transform: translateY(-4px) scale(1.03);
                        }
                        .related-doctor-image {
                            width: 120px;
                            height: 120px;
                            object-fit: cover;
                            border-radius: 50%;
                            margin-top: 1.5rem;
                            border: 3px solid #e0f2fe;
                            background: #e3f2fd;
                        }
                        .related-doctor-info {
                            padding: 1.25rem 1rem 1.5rem 1rem;
                            text-align: center;
                        }
                        .related-doctor-name {
                            color: #1E293B;
                            font-size: 1.1rem;
                            font-weight: 600;
                            margin: 0.75rem 0 0.25rem 0;
                        }
                        .related-doctor-speciality {
                            color: #64748B;
                            font-size: 0.95rem;
                            margin-bottom: 0.5rem;
                        }
                        .related-availability {
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            gap: 0.5rem;
                            margin-bottom: 0.5rem;
                        }
                        .related-availability-dot {
                            width: 0.7rem;
                            height: 0.7rem;
                            border-radius: 50%;
                            background-color: #9CA3AF;
                        }
                        .related-availability-dot[data-available="true"] {
                            background-color: #22C55E;
                        }
                        .related-availability-text[data-available="true"] {
                            color: #22C55E;
                        }
                        .related-availability-text[data-available="false"] {
                            color: #9CA3AF;
                        }
                    </style>
                </head>

                <body>
                    <!-- Add modal HTML -->
                    <div class="modal-overlay" id="confirmationModal">
                        <div class="modal-content">
                            <h3 class="modal-title">Confirm Appointment</h3>
                            <p class="modal-message">Are you sure you want to book this appointment?</p>
                            <div class="modal-buttons">
                                <button class="modal-button confirm" onclick="confirmBooking()">Yes, Book Now</button>
                                <button class="modal-button cancel" onclick="closeModal()">Cancel</button>
                            </div>
                        </div>
                    </div>

                    <!-- Include the Navbar -->
                    <jsp:include page="/WEB-INF/components/navbar.jsp" />

                    <!-- Include the Message Component -->
                    <jsp:include page="/WEB-INF/components/message.jsp" />

                    <div class="main-container">
                        <div class="doctor-container">
                            <!-- Doctor Image -->
                            <div class="doctor-image-container">
                                <c:choose>
                                    <c:when test="${not empty doctor.pfp}">
                                        <img class="doctor-image"
                                            src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(doctor.pfp)}"
                                            alt="${doctor.name}">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="doctor-image"
                                            src="${pageContext.request.contextPath}/assets/images/profile_pic.png"
                                            alt="${doctor.name}">
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Doctor Information -->
                            <div class="doctor-info">
                                <h1 class="doctor-name">
                                    ${doctor.name}
                                    <img class="verified-icon"
                                        src="${pageContext.request.contextPath}/assets/images/verified_icon.svg"
                                        alt="Verified">
                                </h1>

                                <div class="doctor-credentials">
                                    <span>${doctor.degree} - ${doctor.speciality}</span>
                                    <span class="experience-badge">${doctor.experience} Years</span>
                                </div>

                                <div class="about-section">
                                    <p class="about-title">
                                        About
                                        <img src="${pageContext.request.contextPath}/assets/images/info_icon.svg"
                                            alt="Info" width="16" height="16">
                                    </p>
                                    <p class="about-text">${doctor.about}</p>
                                </div>

                                <p class="fees-text">
                                    Appointment fee: <span>${currencySymbol}${doctor.fees}</span>
                                </p>
                            </div>
                        </div>

                        <!-- Booking Slots -->
                        <div class="booking-section">
                            <h2 class="booking-title">Booking slots</h2>

                            <!-- Days Selection -->
                            <div class="days-container">
                                <c:forEach items="${availableSlots}" var="daySlots" varStatus="dayStatus">
                                    <div class="day-slot <c:if test=" ${selectedDayIndex==dayStatus.index}">selected
                                        </c:if>
                                        <c:if test="${selectedDayIndex != dayStatus.index}">unselected</c:if>"
                                        onclick="selectDay(${dayStatus.index})">
                                        <span class="day-name">${daySlots[0].dayOfWeek}</span>
                                        <span class="day-date">${daySlots[0].date}</span>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Time Slots -->
                            <div class="time-slots">
                                <c:forEach items="${availableSlots[selectedDayIndex]}" var="slot">
                                    <span class="time-slot ${selectedTime == slot.time ? 'selected' : 'unselected'}"
                                        onclick="this.classList.toggle('selected'); this.classList.toggle('unselected'); document.querySelector('input[name=selectedTime]').value = '${slot.time}';">
                                        ${slot.time}
                                    </span>
                                </c:forEach>
                            </div>

                            <input type="hidden" name="selectedDayIndex" value="${selectedDayIndex}">
                            <input type="hidden" name="selectedTime" value="${selectedTime}">

                            <button class="book-button" onclick="bookAppointment()">
                                Book an appointment
                            </button>
                        </div>
                    </div>

                    <!-- Related Doctors Section -->
                    <div class="related-doctors-container">
                        <div class="related-doctors-title">Related Doctors</div>
                        <div class="related-doctors-description">
                            Simply browse through our extensive list of related doctors.
                        </div>
                        <div class="related-doctors-grid">
                            <c:forEach var="doctor" items="${relatedDoctors}">
                                <a href="${pageContext.request.contextPath}/appointment?id=${doctor.doctorId}" class="related-doctor-card">
                                    <img src="${pageContext.request.contextPath}/pfp?role=doctor&userId=${doctor.doctorId}"
                                         alt="${doctor.name}"
                                         class="related-doctor-image"
                                         onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                                    <div class="related-doctor-info">
                                        <div class="related-availability">
                                            <div class="related-availability-dot" data-available="${doctor.available}"></div>
                                            <span class="related-availability-text" data-available="${doctor.available}">
                                                ${doctor.available ? 'Available' : 'Not Available'}
                                            </span>
                                        </div>
                                        <div class="related-doctor-name">${doctor.name}</div>
                                        <div class="related-doctor-speciality">${doctor.speciality}</div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Include the Footer -->
                    <div class="footer-wrapper">
                        <jsp:include page="/WEB-INF/components/footer.jsp" />
                    </div>

                    <script>
                        // Initialize the selected state when the page loads
                        document.addEventListener('DOMContentLoaded', function () {
                            // Set initial day selection
                            const initialDayIndex = <c:out value="${selectedDayIndex}" default="-1" />;
                            if (initialDayIndex >= 0) {
                                selectDay(initialDayIndex);
                            }

                            // Set initial time selection
                            const initialTime = '<c:out value="${selectedTime}" default=""/>';
                            if (initialTime) {
                                selectTime(initialTime);
                            }
                        });

                        function selectDay(index) {
                            console.log('Selecting day:', index);
                            // Remove selected class from all day slots
                            document.querySelectorAll('.day-slot').forEach(slot => {
                                slot.classList.remove('selected');
                                slot.classList.add('unselected');
                            });

                            // Add selected class to clicked day slot
                            const selectedSlot = document.querySelectorAll('.day-slot')[index];
                            if (selectedSlot) {
                                selectedSlot.classList.remove('unselected');
                                selectedSlot.classList.add('selected');

                                // Update selectedDayIndex
                                document.querySelector('input[name="selectedDayIndex"]').value = index;

                                // Clear time selection when changing days
                                document.querySelector('input[name="selectedTime"]').value = '';
                                document.querySelectorAll('.time-slot').forEach(slot => {
                                    slot.classList.remove('selected');
                                    slot.classList.add('unselected');
                                });
                            }
                        }

                        function selectTime(time) {
                            console.log('Selecting time:', time);
                            // Remove selected class from all time slots
                            document.querySelectorAll('.time-slot').forEach(slot => {
                                slot.classList.remove('selected');
                                slot.classList.add('unselected');
                            });

                            // Add selected class to clicked time slot
                            const selectedSlot = document.querySelector(`.time-slot[data-time="${time}"]`);
                            if (selectedSlot) {
                                selectedSlot.classList.remove('unselected');
                                selectedSlot.classList.add('selected');

                                // Update selectedTime
                                document.querySelector('input[name="selectedTime"]').value = time;
                                console.log('Updated selected time to:', time);
                            }
                        }

                        function bookAppointment() {
                            const selectedDayIndex = document.querySelector('input[name="selectedDayIndex"]').value;
                            const selectedTime = document.querySelector('input[name="selectedTime"]').value;

                            console.log('Booking appointment - Day:', selectedDayIndex, 'Time:', selectedTime);

                            if (!selectedDayIndex || !selectedTime) {
                                alert('Please select both date and time before booking');
                                return;
                            }

                            // Check if user is logged in
                            fetch('${pageContext.request.contextPath}/check-session')
                                .then(response => response.json())
                                .then(data => {
                                    if (data.loggedIn) {
                                        // Show the confirmation modal if user is logged in
                                        document.getElementById('confirmationModal').style.display = 'flex';
                                    } else {
                                        // Redirect to login page if not logged in
                                        window.location.href = '${pageContext.request.contextPath}/login?redirect=appointment&doctorId=${doctor.doctorId}';
                                    }
                                })
                                .catch(error => {
                                    console.error('Error checking session:', error);
                                    alert('An error occurred. Please try again.');
                                });
                        }

                        function closeModal() {
                            document.getElementById('confirmationModal').style.display = 'none';
                        }

                        function confirmBooking() {
                            const selectedDayIndex = document.querySelector('input[name="selectedDayIndex"]').value;
                            const selectedTime = document.querySelector('input[name="selectedTime"]').value;

                            // Create appointment data
                            const appointmentData = {
                                action: 'create',
                                doctorId: '${doctor.doctorId}',
                                patientId: '${sessionScope.user.patientId}',
                                appointmentTime: getAppointmentTimestamp(selectedDayIndex, selectedTime),
                                status: 'PENDING',
                                reason: 'Regular Checkup',
                                payment: parseFloat('${doctor.fees}')
                            };

                            // Send POST request to save appointment
                            fetch('${pageContext.request.contextPath}/appointment', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: new URLSearchParams(appointmentData)
                            })
                                .then(response => {
                                    if (response.ok) {
                                        // Close the modal and redirect to my-appointments
                                        closeModal();
                                        window.location.href = '${pageContext.request.contextPath}/my-appointments?success=true';
                                    } else {
                                        throw new Error('Failed to book appointment');
                                    }
                                })
                                .catch(error => {
                                    console.error('Error booking appointment:', error);
                                    alert('Failed to book appointment. Please try again.');
                                });
                        }

                        function getAppointmentTimestamp(dayIndex, time) {
                            // Create a date object for the selected day
                            const date = new Date();
                            date.setDate(date.getDate() + parseInt(dayIndex));

                            // Parse the time string (format: "hh:mm am/pm")
                            const [timeStr, period] = time.split(' ');
                            const [hours, minutes] = timeStr.split(':').map(Number);

                            // Set hours and minutes
                            date.setHours(period.toLowerCase() === 'pm' ? hours + 12 : hours);
                            date.setMinutes(minutes);
                            date.setSeconds(0);
                            date.setMilliseconds(0);

                            // Format as SQL timestamp
                            return date.toISOString().slice(0, 19).replace('T', ' ');
                        }
                    </script>
                </body>

                </html>