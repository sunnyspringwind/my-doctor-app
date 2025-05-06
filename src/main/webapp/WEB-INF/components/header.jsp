<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
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
        -ms-overflow-style: none;  /* IE and Edge */
        scrollbar-width: none;  /* Firefox */
    }

    .hero-section {
        background-color: rgb(32, 178, 170);
        max-width: 1280px;
        margin: 2rem auto;
        padding: 2rem 4rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 2rem;
        border-radius: 1rem;
        position: relative;
        overflow: hidden;
    }

    .hero-content {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        gap: 1.5rem;
        width: 50%;
        padding: 2rem 0;
    }

    .hero-title {
        font-size: 3rem;
        font-weight: 600;
        line-height: 1.2;
        color: white;
        margin: 0;
    }

    .doctor-profiles {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .doctor-avatars {
        display: flex;
        align-items: center;
    }

    .doctor-avatars img {
        width: 6rem;
        height: auto;
    }

    .doctor-text {
        font-size: 0.875rem;
        line-height: 1.5;
        color: white;
        opacity: 0.9;
    }

    .book-btn {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        background-color: white;
        color: #4B5563;
        padding: 0.75rem 1.5rem;
        border-radius: 9999px;
        text-decoration: none;
        font-size: 0.875rem;
        font-weight: 500;
        transition: transform 0.2s;
    }

    .book-btn:hover {
        transform: scale(1.05);
    }

    .book-btn img {
        width: 0.75rem;
        height: 0.75rem;
    }

    .hero-image {
        width: 50%;
        display: flex;
        align-items: flex-end;
        justify-content: flex-end;
    }

    .hero-image img {
        width: 100%;
        max-width: 500px;
        height: auto;
        display: block;
        object-fit: contain;
        margin-bottom: -2rem;
        margin-right: -2rem;
    }

    @media (max-width: 1024px) {
        .hero-section {
            padding: 2rem;
            margin: 1rem;
        }
    }

    @media (max-width: 768px) {
        .hero-section {
            flex-direction: column;
            text-align: center;
            padding: 2rem 1.5rem;
        }

        .hero-content {
            width: 100%;
            align-items: center;
            padding: 1rem 0;
        }

        .hero-title {
            font-size: 2.5rem;
            text-align: center;
        }

        .doctor-text {
            text-align: center;
        }

        .hero-image {
            width: 100%;
            justify-content: center;
            order: -1;
        }

        .hero-image img {
            max-width: 100%;
            margin-right: 0;
        }
    }
</style>

<section class="hero-section">
    <div class="hero-content">
        <h1 class="hero-title">
            Book Appointment<br>
            With Trusted Doctors
        </h1>
        
        <div class="doctor-profiles">
            <div class="doctor-avatars">
                <img src="<%=request.getContextPath()%>/assets/images/group_profiles.png" alt="Doctor Profiles">
            </div>
            <p class="doctor-text">
                Simply browse through our list of trusted healthcare professionals,
                and book appointments seamlessly.
            </p>
        </div>

        <a href="#speciality" class="book-btn">
            Book appointment
            <img src="<%=request.getContextPath()%>/assets/images/arrow_icon.svg" alt="Arrow">
        </a>
    </div>

    <div class="hero-image">
        <img src="<%=request.getContextPath()%>/assets/images/header_img.png" alt="Doctors Group">
    </div>
</section>

<script>
    document.querySelector('.book-btn').addEventListener('click', function(e) {
        e.preventDefault();
        const specialitySection = document.querySelector('.speciality-container');
        if (specialitySection) {
            specialitySection.scrollIntoView({ behavior: 'smooth' });
        }
    });
</script>
