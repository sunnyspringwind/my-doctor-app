<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyDoctorApp - About Us</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap');

        :root {
            --primary-color: #20B2AA;
        }
        
        html {
            scroll-behavior: smooth;
            -ms-overflow-style: none;  /* IE and Edge */
            scrollbar-width: none;  /* Firefox */
        }
        
        /* Hide scrollbar for Chrome, Safari and Opera */
        ::-webkit-scrollbar {
            display: none;
        }
        
        body {
            margin: 0;
            padding: 0;
            font-family: 'Outfit', sans-serif;
            background-color: #f4f7fa;
            min-height: 100vh;
            overflow-x: hidden;
            -ms-overflow-style: none;  /* IE and Edge */
            scrollbar-width: none;  /* Firefox */
        }

        /* Hide scrollbar for Chrome, Safari and Opera */
        body::-webkit-scrollbar {
            display: none;
        }

        .main-content {
            padding: 20px;
            width: 1125.78px;
            margin: 0 auto;
            box-sizing: border-box;
            min-height: calc(100vh - 200px);
            overflow-x: hidden;
        }
        
        /* Responsive margins */
        @media (max-width: 1440px) {
            .main-content {
                width: calc(100% - 2rem);
                max-width: 1125.78px;
                margin-left: 1rem;
                margin-right: 1rem;
                padding-bottom: 3rem;
            }
        }
        
        @media (min-width: 640px) {
            .main-content {
                width: 80%;
                margin-left: auto;
                margin-right: auto;
            }
        }

        /* Footer spacing */
        .footer-wrapper {
            margin-top: 4rem;
        }
        
        /* About page specific styles */
        .about-header {
            text-align: center;
            font-size: 1.5rem;
            padding-top: 2.5rem;
            color: #6b7280;
        }
        
        .about-header span {
            color: #374151;
            font-weight: 500;
        }
        
        .about-content {
            margin: 2.5rem 0;
            display: flex;
            flex-direction: column;
            gap: 3rem;
        }
        
        @media (min-width: 768px) {
            .about-content {
                flex-direction: row;
            }
        }
        
        .about-image {
            width: 100%;
            max-width: 360px;
        }
        
        .about-text {
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 1.5rem;
            font-size: 0.875rem;
            color: #4b5563;
        }
        
        .about-text b {
            color: #1f2937;
        }
        
        .why-choose-us {
            font-size: 1.25rem;
            margin: 1rem 0;
        }
        
        .why-choose-us span {
            color: #374151;
            font-weight: 600;
        }
        
        .features-container {
            display: flex;
            flex-direction: column;
            margin-bottom: 5rem;
        }
        
        @media (min-width: 768px) {
            .features-container {
                flex-direction: row;
            }
        }
        
        .feature-box {
            border: 1px solid #e5e7eb;
            padding: 2rem 2.5rem;
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
            font-size: 0.9375rem;
            color: #4b5563;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .feature-box:hover {
            background-color: var(--primary-color);
            color: white;
        }
        
        .feature-box b {
            color: inherit;
        }
    </style>
</head>
<body>
    <!-- Include the Navbar -->
    <jsp:include page="../components/navbar.jsp" />
    
    <div class="main-content">
        <div class="about-header">
            <p>
                ABOUT <span>US</span>
            </p>
        </div>

        <div class="about-content">
            <img
                class="about-image"
                src="<c:url value='/assets/images/about_image.png'/>"
                alt="About DocApp"
            />
            <div class="about-text">
                <p>
                    Welcome to MyDoctorApp, your trusted partner in managing your healthcare
                    needs conveniently and efficiently. At MyDoctorApp, we understand the
                    challenges individuals face when it comes to scheduling doctor
                    appointments and managing their health records.
                </p>
                <p>
                    MyDoctorApp is committed to excellence in healthcare technology. We
                    continuously strive to enhance our platform, integrating the latest
                    advancements to improve user experience and deliver superior
                    service. Whether you're booking your first appointment or managing
                    ongoing care, MyDoctorApp is here to support you every step of the way
                </p>
                <b>Our Vision</b>
                <p>
                    Our vision at MyDoctorApp is to create a seamless healthcare experience
                    for every user. We aim to bridge the gap between patients and
                    healthcare providers, making it easier for you to access the care
                    you need, when you need it.
                </p>
            </div>
        </div>

        <div class="why-choose-us">
            <p>
                WHY <span>CHOOSE US</span>
            </p>
        </div>

        <div class="features-container">
            <div class="feature-box">
                <b>Efficiency:</b>
                <p>
                    Streamlined appointment scheduling that fits into your busy
                    lifestyle.
                </p>
            </div>
            <div class="feature-box">
                <b>Convenience:</b>
                <p>
                    Access to a network of trusted healthcare professionals in your
                    area.
                </p>
            </div>
            <div class="feature-box">
                <b>Personalization:</b>
                <p>
                    Tailored recommendations and reminders to help you stay on top of
                    your health.
                </p>
            </div>
        </div>
    </div>

    <!-- Include the Footer -->
    <div class="footer-wrapper">
        <jsp:include page="../components/footer.jsp" />
    </div>
</body>
</html>
