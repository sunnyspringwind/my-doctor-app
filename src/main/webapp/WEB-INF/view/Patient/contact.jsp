<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyDoctorApp - Contact Us</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap');

        :root {
            --primary-color: #20B2AA;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
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
            background-color: #f8fafc;
            color: #64748b;
            line-height: 1.6;
            overflow-x: hidden;
            -ms-overflow-style: none;  /* IE and Edge */
            scrollbar-width: none;  /* Firefox */
        }

        /* Hide scrollbar for Chrome, Safari and Opera */
        body::-webkit-scrollbar {
            display: none;
        }

        .main-content {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            min-height: calc(100vh - 200px);
            overflow-x: hidden;
        }

        .contact-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .contact-header h1 {
            font-size: 2rem;
            color: #64748b;
            font-weight: 400;
            letter-spacing: 1px;
        }

        .contact-header h1 span {
            color: #334155;
            font-weight: 600;
        }

        .contact-container {
            display: flex;
            gap: 40px;
            align-items: flex-start;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 60px;
        }

        .contact-image {
            flex: 1;
            max-width: 400px;
            min-width: 280px;
        }

        .contact-image img {
            width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 4px -1px rgb(0 0 0 / 0.1);
        }

        .contact-info {
            flex: 1;
            max-width: 400px;
            min-width: 280px;
            padding: 10px;
        }

        .section-title {
            font-size: 1.1rem;
            color: #334155;
            font-weight: 600;
            margin-bottom: 0.8rem;
            letter-spacing: 0.5px;
        }

        .contact-text {
            color: #64748b;
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
            line-height: 1.7;
        }

        .contact-text a {
            color: inherit;
            text-decoration: none;
        }

        .contact-text a:hover {
            color: var(--primary-color);
        }

        .explore-button {
            display: inline-block;
            padding: 0.8rem 1.8rem;
            border: 1px solid #334155;
            color: #334155;
            font-size: 0.875rem;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
            background: transparent;
            letter-spacing: 0.5px;
        }

        .explore-button:hover {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }

        @media (max-width: 768px) {
            .contact-container {
                gap: 30px;
            }
            
            .contact-header h1 {
                font-size: 1.75rem;
            }
            
            .contact-info {
                padding: 0 15px;
            }

            .section-title {
                font-size: 1rem;
            }

            .contact-text {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <!-- Include the Navbar -->
    <jsp:include page="../components/navbar.jsp" />
    
    <div class="main-content">
        <div class="contact-header">
            <h1>CONTACT <span>US</span></h1>
        </div>

        <div class="contact-container">
            <div class="contact-image">
                <img src="${pageContext.request.contextPath}/assets/images/contact_image.png" alt="Contact Us" />
            </div>

            <div class="contact-info">
                <h2 class="section-title">OUR OFFICE</h2>
                <p class="contact-text">
                    44600 Himalayan Plaza Patan Road<br>
                    Suite 302, Kathmandu, Nepal
                </p>

                <p class="contact-text">
                    Tel: <a href="tel:+977-1-5543210">+977-1-5543210</a><br>
                    Email: <a href="mailto:info@docappnepal.com">info@mydoctorappnepal.com</a>
                </p>

                <h2 class="section-title">Careers at MyDoctorApp</h2>
                <p class="contact-text">
                    Learn more about our teams and job openings.
                </p>

                <button class="explore-button">
                    Explore Jobs
                </button>
            </div>
        </div>
    </div>

    <!-- Include the Footer -->
    <div class="footer-wrapper">
        <jsp:include page="../components/footer.jsp" />
    </div>
</body>
</html>
