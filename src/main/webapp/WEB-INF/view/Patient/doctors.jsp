<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

        .doctors-container > p {
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

        .availability p {
            color: #22C55E;  
            font-size: 0.875rem;
            margin: 0;
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
                    <!-- Row 1 -->
                    <!-- Doctor 1 - General physician -->
                    <c:if test="${empty param.speciality || param.speciality == 'General physician'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc1" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc1.png" 
                                alt="Dr. Ganesh Lama" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Ganesh Lama</h3>
                                <p class="doctor-speciality">General physician</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 2 - Gynecologist -->
                    <c:if test="${empty param.speciality || param.speciality == 'Gynecologist'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc2" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc2.png" 
                                alt="Dr. Bandana Khanal" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Bandana Khanal</h3>
                                <p class="doctor-speciality">Gynecologist</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 3 - Dermatologist -->
                    <c:if test="${empty param.speciality || param.speciality == 'Dermatologist'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc3" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc3.png" 
                                alt="Dr. Anil Kumar Bhatta" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Anil Kumar Bhatta</h3>
                                <p class="doctor-speciality">Dermatologist</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 4 - Pediatricians -->
                    <c:if test="${empty param.speciality || param.speciality == 'Pediatricians'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc4" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc4.png" 
                                alt="Dr. Arnav Shrestha" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Arnav Shrestha</h3>
                                <p class="doctor-speciality">Pediatricians</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Row 2 -->
                    <!-- Doctor 5 - Neurologist -->
                    <c:if test="${empty param.speciality || param.speciality == 'Neurologist'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc5" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc5.png" 
                                alt="Dr. Isha Dhungana" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Isha Dhungana</h3>
                                <p class="doctor-speciality">Neurologist</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 6 - Gastroenterologist -->
                    <c:if test="${empty param.speciality || param.speciality == 'Gastroenterologist'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc6" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc6.png" 
                                alt="Dr. Shekhar Poudel" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Shekhar Poudel</h3>
                                <p class="doctor-speciality">Gastroenterologist</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 7 - General physician -->
                    <c:if test="${empty param.speciality || param.speciality == 'General physician'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc7" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc7.png" 
                                alt="Dr. Kovid Nepal" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Kovid Nepal</h3>
                                <p class="doctor-speciality">General physician</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 8 - Gynecologist -->
                    <c:if test="${empty param.speciality || param.speciality == 'Gynecologist'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc8" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc8.png" 
                                alt="Dr. Parag karki" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Parag karki</h3>
                                <p class="doctor-speciality">Gynecologist</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 9 - Dermatologist -->
                    <c:if test="${empty param.speciality || param.speciality == 'Dermatologist'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc9" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc9.png" 
                                alt="Dr. Subekcha Karki" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Subekcha Karki</h3>
                                <p class="doctor-speciality">Dermatologist</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 10 - Pediatricians -->
                    <c:if test="${empty param.speciality || param.speciality == 'Pediatricians'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc10" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc10.png" 
                                alt="Dr. Poonam Sharma" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Poonam Sharma</h3>
                                <p class="doctor-speciality">Pediatricians</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 11 - Neurologist -->
                    <c:if test="${empty param.speciality || param.speciality == 'Neurologist'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc11" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc11.png" 
                                alt="Dr. Babu Ram Pokharel" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Babu Ram Pokharel</h3>
                                <p class="doctor-speciality">Neurologist</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 12 - Gastroenterologist -->
                    <c:if test="${empty param.speciality || param.speciality == 'Gastroenterologist'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc12" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc12.png" 
                                alt="Dr. Neeraj Joshi" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Neeraj Joshi</h3>
                                <p class="doctor-speciality">Gastroenterologist</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 13 - General physician -->
                    <c:if test="${empty param.speciality || param.speciality == 'General physician'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc13" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc13.png" 
                                alt="Dr. Priyanka Tripathi" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Priyanka Tripathi</h3>
                                <p class="doctor-speciality">General physician</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 14 - Gynecologist -->
                    <c:if test="${empty param.speciality || param.speciality == 'Gynecologist'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc14" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc14.png" 
                                alt="Dr. Basant Sharma" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Basant Sharma</h3>
                                <p class="doctor-speciality">Gynecologist</p>
                            </div>
                        </a>
                    </c:if>

                    <!-- Doctor 15 - Dermatologist -->
                    <c:if test="${empty param.speciality || param.speciality == 'Dermatologist'}">
                        <a href="${pageContext.request.contextPath}/appointment?id=doc15" class="doctor-card">
                            <img src="${pageContext.request.contextPath}/assets/images/doc15.png" 
                                alt="Dr. Siree Thapa" 
                                class="doctor-image"
                                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                            <div class="doctor-info">
                                <div class="availability">
                                    <div class="availability-dot" data-available="true"></div>
                                    <p>Available</p>
                                </div>
                                <h3 class="doctor-name">Dr. Siree Thapa</h3>
                                <p class="doctor-speciality">Dermatologist</p>
                            </div>
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Include the Footer -->
    <div class="footer-wrapper">
        <jsp:include page="/WEB-INF/components/footer.jsp" />
    </div>
</body>
</html>
