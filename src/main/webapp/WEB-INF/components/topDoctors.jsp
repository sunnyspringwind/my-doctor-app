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

    .doctor-card.unavailable {
        position: relative;
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

    .doctor-card.unavailable .availability p[data-available="false"] {
        color: #9CA3AF !important;
    }
    .doctor-card.unavailable .availability-dot[data-available="false"] {
        background-color: #9CA3AF !important;
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
        <c:forEach var="doctor" items="${topDoctors}" varStatus="status">
            <a href="${pageContext.request.contextPath}/appointment?id=${doctor.doctorId}"
               class="doctor-card ${!doctor.available ? 'unavailable' : ''}"
               data-available="${doctor.available}"
               onclick="return checkTopDoctorAvailability(event, '${doctor.available}', '${doctor.name}')">
                <img src="${pageContext.request.contextPath}/pfp?role=doctor&userId=${doctor.doctorId}" 
                    alt="${doctor.name}" 
                    class="doctor-image"
                    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/profile_pic.png';">
                <div class="doctor-info">
                    <div class="availability">
                        <div class="availability-dot" data-available="${doctor.available}"></div>
                        <p data-available="${doctor.available}">${doctor.available ? 'Available' : 'Not Available'}</p>
                    </div>
                    <h3 class="doctor-name">${doctor.name}</h3>
                    <p class="doctor-speciality">${doctor.speciality}</p>
                </div>
            </a>
        </c:forEach>
    </div>

    <button class="more-button" onclick="window.location.href='${pageContext.request.contextPath}/doctors'">
        MORE
    </button>
</div>

<script>
function checkTopDoctorAvailability(event, isAvailable, doctorName) {
    if (isAvailable === 'false') {
        event.preventDefault();
        alert(doctorName + " is currently unavailable. Please try another doctor.");
        return false;
    }
    return true;
}
</script>
