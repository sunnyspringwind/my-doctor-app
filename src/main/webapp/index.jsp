<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MyDoctorApp - Home</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@100..900&display=swap');

        :root {
            --primary-color: #20B2AA; /* Blue color for the banner background */
        }
        
        body {
            margin: 0;
            padding: 0;
            font-family: 'Outfit', sans-serif;
            background-color: #f4f7fa;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .main-content {
            padding: 20px;
            width: 1125.78px;
            margin: 0 auto;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            gap: 4rem;
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
    </style>
</head>
<body>
    <!-- Include the Navbar -->
    <jsp:include page="/WEB-INF/components/navbar.jsp" />
    
    <!-- Include the Header -->
    <div class="main-content">
        <jsp:include page="/WEB-INF/components/header.jsp" />
        
        <!-- Include the SpecialityMenu -->
        <jsp:include page="/WEB-INF/components/specialityMenu.jsp" />
        
        <!-- Top Doctors Section -->
        <jsp:include page="/components/topDoctors" />
        
        <!-- Include the Banner -->
        <jsp:include page="/WEB-INF/components/banner.jsp" />
    </div>

    <!-- Include the Footer -->
    <div class="footer-wrapper">
        <jsp:include page="/WEB-INF/components/footer.jsp" />
    </div>
</body>
</html>
