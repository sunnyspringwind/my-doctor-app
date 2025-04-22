<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    :root {
        /* Toastify Variables */
        --toastify-color-light: #fff;
        --toastify-color-dark: #121212;
        --toastify-color-info: #3498db;
        --toastify-color-success: #07bc0c;
        --toastify-color-warning: #f1c40f;
        --toastify-color-error: #e74c3c;
        --toastify-color-transparent: rgba(255, 255, 255, 0.7);
        --toastify-toast-width: 320px;
        --toastify-toast-min-height: 64px;
        --toastify-toast-max-height: 800px;
        --toastify-z-index: 9999;
        --toastify-text-color-light: #757575;
        
        /* Tailwind Variables */
        --tw-border-spacing-x: 0;
        --tw-border-spacing-y: 0;
        --tw-translate-x: 0;
        --tw-translate-y: 0;
        --tw-rotate: 0;
        --tw-skew-x: 0;
        --tw-skew-y: 0;
        --tw-scale-x: 1;
        --tw-scale-y: 1;
        --tw-ring-offset-width: 0px;
        --tw-ring-offset-color: #fff;
        --tw-ring-color: rgb(59 130 246 / 0.5);
        --tw-ring-offset-shadow: 0 0 #0000;
        --tw-ring-shadow: 0 0 #0000;
        --tw-shadow: 0 0 #0000;
        --tw-shadow-colored: 0 0 #0000;
        --primary-color: rgb(32, 178, 170);
        --highlight-color: rgba(79, 70, 229, 0.1);
    }

    .navbar-container {
        -webkit-text-size-adjust: 100%;
        tab-size: 4;
        font-feature-settings: normal;
        font-variation-settings: normal;
        -webkit-tap-highlight-color: transparent;
        box-sizing: border-box;
        border-width: 0;
        border-style: solid;
        border-color: #e5e7eb;
        font-family: 'Outfit', sans-serif;
        top: 0;
        z-index: 10;
        width: 100%;
        margin-bottom: 1.25rem;
        border-bottom-width: 1px;
        --tw-border-opacity: 1;
        border-bottom-color: rgb(156 163 175 / var(--tw-border-opacity));
        background-color: white;
        -webkit-backdrop-filter: blur(8px);
        backdrop-filter: blur(8px);
        padding: 1rem 0;
        font-size: 0.875rem;
        line-height: 1.25rem;
    }

    .navbar {
        max-width: 1280px;
        margin: 0 auto;
        padding: 0 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 2rem;
    }

    .logo-section {
        display: flex;
        align-items: center;
        text-decoration: none;
    }

    .logo-section img {
        height: 2.5rem;
        transition: transform 0.2s;
    }

    .logo-section:hover img {
        transform: scale(1.05);
    }

    .nav-menu {
        -webkit-text-size-adjust: 100%;
        tab-size: 4;
        font-feature-settings: normal;
        font-variation-settings: normal;
        -webkit-tap-highlight-color: transparent;
        box-sizing: border-box;
        border-width: 0;
        border-style: solid;
        border-color: #e5e7eb;
        font-family: 'Outfit', sans-serif;
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        font-size: 0.875rem;
        line-height: 1.25rem;
        font-weight: 500;
    }

    .nav-link {
        text-decoration: none;
        color: #4B5563;
        font-size: 0.875rem;
        font-weight: 500;
        padding: 0.5rem 1rem;
        transition: all 0.2s ease;
        font-family: 'Outfit', sans-serif;
        position: relative;
    }

    .nav-link:hover, .nav-link.active {
        color: #20B2AA;
    }

    .nav-link.active::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 30%;
        height: 2px;
        background-color: #20B2AA;
    }

    .create-account-btn {
        background-color: var(--primary-color);
        color: white;
        padding: 0.75rem 1.5rem;
        border-radius: 9999px;
        text-decoration: none;
        font-size: 0.875rem;
        font-weight: 500;
        transition: all 0.2s ease;
        font-family: 'Outfit', sans-serif;
        white-space: nowrap;
    }

    .create-account-btn:hover {
        opacity: 0.9;
        transform: translateY(-1px);
    }

    .menu-icon {
        display: none;
        width: 1.5rem;
        cursor: pointer;
        transition: transform 0.2s;
    }

    .menu-icon:hover {
        transform: scale(1.1);
    }

    @media (max-width: 768px) {
        .nav-menu {
            display: none;
        }
        .menu-icon {
            display: block;
        }
        .navbar {
            padding: 0 1rem;
        }
    }

    .mobile-menu {
        display: none;
        position: fixed;
        width: 100%;
        height: 100%;
        right: 0;
        top: 0;
        bottom: 0;
        z-index: 20;
        background-color: white;
        transform: translateX(100%);
        transition: transform 0.3s ease-in-out;
    }

    .mobile-menu.show {
        display: block;
        transform: translateX(0);
    }

    .mobile-menu-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 1rem 2rem;
        border-bottom: 1px solid #e5e7eb;
    }

    .mobile-menu ul {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 1rem;
        margin-top: 2rem;
        padding: 0;
        list-style: none;
    }

    .mobile-menu .nav-link {
        font-size: 1rem;
        padding: 0.75rem 1.5rem;
    }
</style>

<div class="navbar-container">
    <nav class="navbar">
        <a href="<%=request.getContextPath()%>/" class="logo-section">
            <img src="<%=request.getContextPath()%>/assets/images/mainlogo.svg" alt="DocApp Logo">
        </a>

        <div class="nav-menu">
            <a href="<%=request.getContextPath()%>/" class="nav-link ${pageContext.request.servletPath == '/' ? 'active' : ''}">HOME</a>
            <a href="<%=request.getContextPath()%>/doctors" class="nav-link ${pageContext.request.servletPath == '/doctors' || fn:startsWith(pageContext.request.servletPath, '/doctors/') ? 'active' : ''}">ALL DOCTORS</a>
            <a href="<%=request.getContextPath()%>/about" class="nav-link ${pageContext.request.servletPath == '/about' ? 'active' : ''}">ABOUT</a>
            <a href="<%=request.getContextPath()%>/contact" class="nav-link ${pageContext.request.servletPath == '/contact' ? 'active' : ''}">CONTACT</a>
        </div>

        <a href="<%=request.getContextPath()%>/register" class="create-account-btn">Create Account</a>
        <img class="menu-icon" src="<%=request.getContextPath()%>/assets/images/menu_icon.png" alt="Menu" onclick="toggleMobileMenu()">
    </nav>
</div>

<div class="mobile-menu" id="mobileMenu">
    <div class="mobile-menu-header">
        <img src="<%=request.getContextPath()%>/assets/images/mainlogo.svg" alt="Logo" style="height: 2.5rem;">
        <img class="menu-icon" src="<%=request.getContextPath()%>/assets/images/cross_icon.png" alt="Close" onclick="toggleMobileMenu()">
    </div>
    <ul>
        <li><a href="<%=request.getContextPath()%>/" class="nav-link ${pageContext.request.servletPath == '/' ? 'active' : ''}" onclick="toggleMobileMenu()">HOME</a></li>
        <li><a href="<%=request.getContextPath()%>/doctors" class="nav-link ${pageContext.request.servletPath == '/doctors' || fn:startsWith(pageContext.request.servletPath, '/doctors/') ? 'active' : ''}" onclick="toggleMobileMenu()">ALL DOCTORS</a></li>
        <li><a href="<%=request.getContextPath()%>/about" class="nav-link ${pageContext.request.servletPath == '/about' ? 'active' : ''}" onclick="toggleMobileMenu()">ABOUT</a></li>
        <li><a href="<%=request.getContextPath()%>/contact" class="nav-link ${pageContext.request.servletPath == '/contact' ? 'active' : ''}" onclick="toggleMobileMenu()">CONTACT</a></li>
        <li><a href="<%=request.getContextPath()%>/register" class="create-account-btn" onclick="toggleMobileMenu()">Create Account</a></li>
    </ul>
</div>

<script>
    function toggleMobileMenu() {
        const mobileMenu = document.getElementById('mobileMenu');
        mobileMenu.classList.toggle('show');
    }

    // Hide navbar on login and register pages
    const hideNavbarPaths = ['/login', '/register'];
    const currentPath = window.location.pathname;
    const contextPath = '<%=request.getContextPath()%>';
    const pathWithoutContext = currentPath.startsWith(contextPath) ? currentPath.substring(contextPath.length) : currentPath;
    
    if (hideNavbarPaths.includes(pathWithoutContext)) {
        document.querySelector('.navbar-container').style.display = 'none';
    }
</script>
