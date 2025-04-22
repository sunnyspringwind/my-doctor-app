<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .top-doctors-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 1rem;
        margin: 4rem 0;
        color: #111827;
    }

    .top-doctors-title {
        font-size: 1.875rem;
        font-weight: 500;
    }

    .top-doctors-description {
        text-align: center;
        font-size: 0.875rem;
    }

    .doctors-grid {
        width: 100%;
        display: grid;
        grid-template-columns: repeat(5, 1fr);
        gap: 1rem;
        padding: 1.25rem 0.75rem;
    }

    .doctor-card {
        background: #F8FAFC;
        border-radius: 1rem;
        overflow: hidden;
        text-decoration: none;
        transition: transform 0.3s ease;
        border: 1px solid #E2E8F0;
        width: 100%;
        cursor: pointer;
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

    .more-button {
        background-color: #eff6ff;
        color: #4b5563;
        padding: 0.75rem 3rem;
        border-radius: 9999px;
        margin-top: 2.5rem;
        border: none;
        cursor: pointer;
    }

    .more-button:hover {
        background-color: #dbeafe;
    }

    @media (max-width: 1200px) {
        .doctors-grid {
            grid-template-columns: repeat(3, 1fr);
        }
    }

    @media (max-width: 768px) {
        .doctors-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 480px) {
        .doctors-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="top-doctors-container">
    <h1 class="top-doctors-title">Top Doctors to Book</h1>
    <p class="top-doctors-description">
        Simply browse through our extensive list of trusted doctors.
    </p>
    
    <div class="doctors-grid">
        <!-- Doctor 1 - General physician -->
        <a href="${pageContext.request.contextPath}/appointment/doc1" class="doctor-card">
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

        <!-- Doctor 2 - Gynecologist -->
        <a href="${pageContext.request.contextPath}/appointment/doc2" class="doctor-card">
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

        <!-- Doctor 3 - Dermatologist -->
        <a href="${pageContext.request.contextPath}/appointment/doc3" class="doctor-card">
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

        <!-- Doctor 4 - Pediatricians -->
        <a href="${pageContext.request.contextPath}/appointment/doc4" class="doctor-card">
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

        <!-- Doctor 5 - Neurologist -->
        <a href="${pageContext.request.contextPath}/appointment/doc5" class="doctor-card">
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

        <!-- Doctor 6 - Gastroenterologist -->
        <a href="${pageContext.request.contextPath}/appointment/doc6" class="doctor-card">
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

        <!-- Doctor 7 - General physician -->
        <a href="${pageContext.request.contextPath}/appointment/doc7" class="doctor-card">
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

        <!-- Doctor 8 - Gynecologist -->
        <a href="${pageContext.request.contextPath}/appointment/doc8" class="doctor-card">
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

        <!-- Doctor 9 - Dermatologist -->
        <a href="${pageContext.request.contextPath}/appointment/doc9" class="doctor-card">
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

        <!-- Doctor 10 - Pediatricians -->
        <a href="${pageContext.request.contextPath}/appointment/doc10" class="doctor-card">
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
    </div>

    <button class="more-button" onclick="window.location.href='${pageContext.request.contextPath}/doctors'">
        MORE
    </button>
</div>
