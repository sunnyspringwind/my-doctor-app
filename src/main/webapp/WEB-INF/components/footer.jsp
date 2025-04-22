<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.footer-container {
    margin: 0 2.5rem;
    font-family: 'Outfit', sans-serif;
}

.footer-content {
    display: flex;
    flex-direction: column;
    gap: 3.5rem;
    margin: 2.5rem 0;
    font-size: 0.875rem;
}

.footer-left {
    margin-bottom: 1.25rem;
}

.footer-logo {
    margin-bottom: 1.25rem;
    width: 10rem;
}

.footer-description {
    width: 100%;
    color: #4B5563;
    line-height: 1.5;
}

.footer-section-title {
    font-size: 1.25rem;
    font-weight: 500;
    margin-bottom: 1.25rem;
}

.footer-list {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    color: #4B5563;
    padding: 0;
    margin: 0;
    list-style: none;
}

.footer-list li {
    cursor: pointer;
}

.footer-list a {
    text-decoration: none;
    color: #4B5563;
}

.footer-list a:hover {
    color: #374151;
}

.footer-copyright {
    border-top: 1px solid #E5E7EB;
    padding: 1.25rem 0;
    text-align: center;
    font-size: 0.875rem;
    color: #4B5563;
}

@media (min-width: 640px) {
    .footer-content {
        display: grid;
        grid-template-columns: 3fr 1fr 1fr;
    }
}

@media (min-width: 768px) {
    .footer-container {
        margin: 0 2.5rem;
    }
    
    .footer-description {
        width: 66.666667%;
    }
}
</style>

<div class="footer-container">
    <div class="footer-content">
        <!-- Left Section -->
        <div class="footer-left">
            <img 
                class="footer-logo"
                src="${pageContext.request.contextPath}/assets/images/mainlogo.svg"
                alt="Company Logo"
            />
            <p class="footer-description">
                MyDoctorApp is trusted platform for managing doctor appointments
                efficiently and securely. We are committed to improving healthcare
                access by connecting patients with trusted doctors and ensuring a
                seamless experience for everyone.
            </p>
        </div>

        <!-- Center Section -->
        <div>
            <p class="footer-section-title">COMPANY</p>
            <nav>
                <ul class="footer-list">
                    <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/doctors">Doctors</a></li>
                    <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                </ul>
            </nav>
        </div>

        <!-- Right Section -->
        <div>
            <p class="footer-section-title">GET IN TOUCH</p>
            <ul class="footer-list">
                <li>+977-1-5543210</li>
                <li>info@mydoctorappnepal.com</li>
            </ul>
        </div>
    </div>

    <!-- Copyright Text -->
    <div class="footer-copyright">
        Copyright 2025 @supportMyDoctorApp - All Rights Reserved.
    </div>
</div>
