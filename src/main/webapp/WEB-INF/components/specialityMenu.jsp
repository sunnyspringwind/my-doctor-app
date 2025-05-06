<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <style>
            .speciality-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 2rem;
                padding: 4rem 2rem;
                font-family: 'Inter', sans-serif;
                text-align: center;
            }

            .speciality-title {
                font-size: 2.5rem;
                font-weight: 600;
                color: #2D3748;
                margin: 0;
            }

            .speciality-description {
                text-align: center;
                font-size: 1rem;
                max-width: 600px;
                color: #4A5568;
                line-height: 1.6;
                margin: 0 auto;
            }

            .speciality-list {
                display: flex;
                justify-content: center;
                gap: 2.5rem;
                flex-wrap: wrap;
                max-width: 1200px;
                margin: 0 auto;
                padding-top: 2rem;
            }

            .speciality-item {
                display: flex;
                flex-direction: column;
                align-items: center;
                text-decoration: none;
                transition: transform 0.2s ease;
                width: 120px;
            }

            .speciality-item:hover {
                transform: translateY(-5px);
            }

            .speciality-image-container {
                width: 100px;
                height: 100px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 1rem;
            }

            .speciality-image-container img {
                width: 100%;
                height: 100%;
                object-fit: contain;
            }

            .speciality-item p {
                color: #2D3748;
                font-size: 0.9rem;
                font-weight: 500;
                margin: 0;
                text-align: center;
            }

            @media (max-width: 768px) {
                .speciality-list {
                    gap: 1.5rem;
                }

                .speciality-image-container {
                    width: 80px;
                    height: 80px;
                }

                .speciality-item {
                    width: 100px;
                }
            }
        </style>

        <div class="speciality-container">
            <h1 class="speciality-title">Find by Speciality</h1>
            <p class="speciality-description">
                Search for specialists based on your specific health concerns and preferences.
                Our comprehensive listings make it easy to find the right doctor for you.
            </p>

            <div class="speciality-list">
                <a href="${pageContext.request.contextPath}/doctors?speciality=General physician"
                    class="speciality-item">
                    <div class="speciality-image-container">
                        <img src="${pageContext.request.contextPath}/assets/images/General_physician.svg"
                            alt="General Physician">
                    </div>
                    <p>General physician</p>
                </a>

                <a href="${pageContext.request.contextPath}/doctors?speciality=Gynecologist" class="speciality-item">
                    <div class="speciality-image-container">
                        <img src="${pageContext.request.contextPath}/assets/images/Gynecologist.svg" alt="Gynecologist">
                    </div>
                    <p>Gynecologist</p>
                </a>

                <a href="${pageContext.request.contextPath}/doctors?speciality=Dermatologist" class="speciality-item">
                    <div class="speciality-image-container">
                        <img src="${pageContext.request.contextPath}/assets/images/Dermatologist.svg"
                            alt="Dermatologist">
                    </div>
                    <p>Dermatologist</p>
                </a>

                <a href="${pageContext.request.contextPath}/doctors?speciality=Pediatricians" class="speciality-item">
                    <div class="speciality-image-container">
                        <img src="${pageContext.request.contextPath}/assets/images/Pediatricians.svg"
                            alt="Pediatricians">
                    </div>
                    <p>Pediatricians</p>
                </a>

                <a href="${pageContext.request.contextPath}/doctors?speciality=Neurologist" class="speciality-item">
                    <div class="speciality-image-container">
                        <img src="${pageContext.request.contextPath}/assets/images/Neurologist.svg" alt="Neurologist">
                    </div>
                    <p>Neurologist</p>
                </a>

                <a href="${pageContext.request.contextPath}/doctors?speciality=Gastroenterologist"
                    class="speciality-item">
                    <div class="speciality-image-container">
                        <img src="${pageContext.request.contextPath}/assets/images/Gastroenterologist.svg"
                            alt="Gastroenterologist">
                    </div>
                    <p>Gastroenterologist</p>
                </a>
            </div>
        </div>