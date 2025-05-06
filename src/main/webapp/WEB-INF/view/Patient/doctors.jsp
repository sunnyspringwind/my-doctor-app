<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ page import="java.util.Base64" %>

                <!DOCTYPE html>
                <html>

                <head>
                    <title>MyDoctorApp - Doctors</title>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <style>
                        @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap');

                        :root {
                            --primary-color: #20B2AA;
                        }

                        html {
                            scroll-behavior: smooth;
                        }

                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                            font-family: 'Outfit', sans-serif;
                        }

                        /* Hide scrollbar for Chrome, Safari and Opera */
                        ::-webkit-scrollbar {
                            display: none;
                        }

                        /* Hide scrollbar for IE, Edge and Firefox */
                        body {
                            -ms-overflow-style: none;
                            scrollbar-width: none;
                            background-color: #f4f7fa;
                            min-height: 100vh;
                        }

                        .main-container {
                            max-width: 1280px;
                            margin: 0 auto;
                            padding: 0 2rem;
                            min-height: calc(100vh - 200px);
                        }

                        .doctors-container {
                            padding: 2rem 0;
                        }

                        .doctors-container>p {
                            color: #64748B;
                            margin-bottom: 2rem;
                            font-size: 0.95rem;
                        }

                        .flex {
                            display: flex;
                            gap: 3rem;
                        }

                        .filters-container {
                            display: flex;
                            flex-direction: column;
                            gap: 0.75rem;
                            min-width: 220px;
                        }

                        .filter-item {
                            display: block;
                            padding: 0.875rem 1.25rem;
                            border: 1px solid #E2E8F0;
                            border-radius: 0.5rem;
                            color: #64748B;
                            text-decoration: none;
                            transition: all 0.2s;
                            background: white;
                            font-size: 0.95rem;
                        }

                        .filter-item:hover {
                            transform: translateY(-1px);
                        }

                        .filter-item.active {
                            background-color: #C5CAE9;
                            color: #1F2937;
                            border-color: #C5CAE9;
                        }

                        .doctors-grid {
                            flex: 1;
                            display: grid;
                            grid-template-columns: repeat(4, 1fr);
                            gap: 1.5rem;
                        }

                        .doctor-card {
                            background: #F8FAFC;
                            border-radius: 1rem;
                            overflow: hidden;
                            text-decoration: none;
                            transition: transform 0.3s ease;
                            border: 1px solid #E2E8F0;
                            width: 100%;
                        }

                        .doctor-card.unavailable {
                            cursor: pointer;
                        }

                        .doctor-card.unavailable::after {
                            content: "Unavailable";
                            position: absolute;
                            top: 50%;
                            left: 50%;
                            transform: translate(-50%, -50%);
                            background-color: rgba(0, 0, 0, 0.7);
                            color: white;
                            padding: 8px 16px;
                            border-radius: 4px;
                            font-size: 0.875rem;
                            display: none;
                            z-index: 1;
                        }

                        .doctor-card.unavailable:hover::after {
                            display: block;
                        }

                        .doctor-card:hover {
                            transform: translateY(-5px);
                            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                        }

                        .doctor-image {
                            width: 100%;
                            height: 240px;
                            object-fit: cover;
                            background-color: #E3F2FD;
                        }

                        .doctor-info {
                            padding: 1.25rem;
                        }

                        .availability {
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                            margin-bottom: 0.75rem;
                        }

                        .availability-dot {
                            width: 0.5rem;
                            height: 0.5rem;
                            border-radius: 50%;
                        }

                        .availability-dot[data-available="true"] {
                            background-color: #22C55E;
                        }

                        .availability-dot[data-available="false"] {
                            background-color: #9CA3AF;
                        }

                        .availability p {
                            color: #4B5563;
                            font-size: 0.875rem;
                            margin: 0;
                        }

                        .availability p[data-available="true"] {
                            color: #22C55E;
                        }

                        .availability p[data-available="false"] {
                            color: #9CA3AF;
                        }

                        .doctor-name {
                            color: #1E293B;
                            font-size: 1.125rem;
                            font-weight: 500;
                            margin-bottom: 0.5rem;
                        }

                        .doctor-speciality {
                            color: #64748B;
                            font-size: 0.875rem;
                        }

                        @media (max-width: 1200px) {
                            .doctors-grid {
                                grid-template-columns: repeat(3, 1fr);
                            }
                        }

                        @media (max-width: 992px) {
                            .doctors-grid {
                                grid-template-columns: repeat(2, 1fr);
                            }
                        }

                        @media (max-width: 768px) {
                            .flex {
                                flex-direction: column;
                                gap: 2rem;
                            }

                            .filters-container {
                                flex-direction: row;
                                flex-wrap: wrap;
                                gap: 0.5rem;
                            }

                            .filter-item {
                                padding: 0.5rem 1rem;
                            }

                            .doctors-grid {
                                grid-template-columns: repeat(2, 1fr);
                            }
                        }

                        @media (max-width: 576px) {
                            .doctors-grid {
                                grid-template-columns: 1fr;
                            }
                        }

                        /* Footer spacing */
                        .footer-wrapper {
                            margin-top: 4rem;
                        }
                    </style>
                </head>

                <body>
                    <!-- Include the Navbar -->
                    <jsp:include page="/WEB-INF/components/navbar.jsp" />

                    <div class="main-container">
                        <div class="doctors-container">
                            <p>Browse through the doctors specialist.</p>

                            <div class="flex">
                                <div class="filters-container">
                                    <a href="${pageContext.request.contextPath}/doctors${param.speciality == 'General physician' ? '' : '?speciality=General physician'}"
                                        class="filter-item ${param.speciality == 'General physician' ? 'active' : ''}">
                                        General physician
                                    </a>
                                    <a href="${pageContext.request.contextPath}/doctors${param.speciality == 'Gynecologist' ? '' : '?speciality=Gynecologist'}"
                                        class="filter-item ${param.speciality == 'Gynecologist' ? 'active' : ''}">
                                        Gynecologist
                                    </a>
                                    <a href="${pageContext.request.contextPath}/doctors${param.speciality == 'Dermatologist' ? '' : '?speciality=Dermatologist'}"
                                        class="filter-item ${param.speciality == 'Dermatologist' ? 'active' : ''}">
                                        Dermatologist
                                    </a>
                                    <a href="${pageContext.request.contextPath}/doctors${param.speciality == 'Pediatricians' ? '' : '?speciality=Pediatricians'}"
                                        class="filter-item ${param.speciality == 'Pediatricians' ? 'active' : ''}">
                                        Pediatricians
                                    </a>
                                    <a href="${pageContext.request.contextPath}/doctors${param.speciality == 'Neurologist' ? '' : '?speciality=Neurologist'}"
                                        class="filter-item ${param.speciality == 'Neurologist' ? 'active' : ''}">
                                        Neurologist
                                    </a>
                                    <a href="${pageContext.request.contextPath}/doctors${param.speciality == 'Gastroenterologist' ? '' : '?speciality=Gastroenterologist'}"
                                        class="filter-item ${param.speciality == 'Gastroenterologist' ? 'active' : ''}">
                                        Gastroenterologist
                                    </a>
                                </div>

                                <div class="doctors-grid">
                                    <c:forEach var="doctor" items="${doctors}">
                                        <a href="${pageContext.request.contextPath}/appointment?id=${doctor.doctorId}"
                                            class="doctor-card ${!doctor.available ? 'unavailable' : ''}"
                                            data-available="${doctor.available}"
                                            onclick="return checkAvailability(event, '${doctor.available}', '${doctor.name}')">
                                            <c:choose>
                                                <c:when test="${not empty doctor.pfp}">
                                                    <img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(doctor.pfp)}"
                                                        alt="${doctor.name}" class="doctor-image">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/assets/images/profile_pic.png"
                                                        alt="${doctor.name}" class="doctor-image">
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="doctor-info">
                                                <div class="availability">
                                                    <div class="availability-dot" data-available="${doctor.available}">
                                                    </div>
                                                    <p>${doctor.available ? 'Available' : 'Not Available'}</p>
                                                </div>
                                                <h3 class="doctor-name">${doctor.name}</h3>
                                                <p class="doctor-speciality">${doctor.speciality}</p>
                                            </div>
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Include the Footer -->
                    <div class="footer-wrapper">
                        <jsp:include page="/WEB-INF/components/footer.jsp" />
                    </div>

                    <script>
                        function checkAvailability(event, isAvailable, doctorName) {
                            if (isAvailable === 'false') {
                                event.preventDefault();
                                alert(doctorName + " is currently unavailable. Please try another doctor.");
                                return false;
                            }
                            return true;
                        }
                    </script>
                </body>

                </html>
