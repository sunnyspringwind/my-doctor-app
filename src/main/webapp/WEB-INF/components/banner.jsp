<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.banner-container {
    display: flex;
    background-color: rgb(32 178 170);
    border-radius: 0.5rem;
    padding: 0 3.5rem;
    margin: 5rem 2.5rem;
    font-family: 'Outfit', sans-serif;
}

.banner-left {
    flex: 1;
    padding: 4rem 0;
}

.banner-text {
    color: white;
    font-size: 2.8rem;
    font-weight: 600;
    line-height: 1.2;
}

.banner-button {
    display: inline-block;
    background-color: white;
    color: #4B5563;
    text-decoration: none;
    padding: 0.75rem 2rem;
    border-radius: 9999px;
    margin-top: 2rem;
    font-size: 1rem;
    transition: transform 0.2s;
    cursor: pointer;
    font-family: inherit;
}

.banner-button:hover {
    transform: scale(1.05);
}

.banner-right {
    display: none;
    width: 50%;
    position: relative;
}

.banner-image {
    width: 100%;
    position: absolute;
    bottom: 0;
    right: 0;
    max-width: 28rem;
}

@media (min-width: 768px) {
    .banner-container {
        padding: 0 2.5rem;
    }
    
    .banner-right {
        display: block;
    }
}

@media (min-width: 1024px) {
    .banner-container {
        padding: 0 3.5rem;
    }
    
    .banner-left {
        padding: 5rem 0;
    }
    
    .banner-right {
        width: 370px;
    }
}
</style>

<div class="banner-container">
    <!-- Left Side -->
    <div class="banner-left">
        <div class="banner-text">
            Book Appointment<br>
            With 100+ Trusted Doctors
        </div>
        <a href="${pageContext.request.contextPath}/register" class="banner-button" onclick="window.scrollTo(0, 0)">
            Create account
        </a>
    </div>

    <!-- Right Side -->
    <div class="banner-right">
        <img 
            class="banner-image"
            src="${pageContext.request.contextPath}/assets/images/appointment_img.png"
            alt="Appointment illustration"
        />
    </div>
</div>
