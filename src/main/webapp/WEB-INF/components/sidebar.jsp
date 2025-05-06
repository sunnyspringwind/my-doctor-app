<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: white;
            border-right: 1px solid #e5e7eb;
        }
        .nav-list {
            color: #515151;
            margin-top: 1.25rem;
        }
        .nav-link {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.875rem 0.75rem;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }
        .nav-link:hover {
            background-color: #F2F3FF;
        }
        .nav-link.active {
            background-color: #F2F3FF;
            border-right: 4px solid #4F46E5;
        }
        @media (min-width: 768px) {
            .nav-link {
                padding-left: 2.25rem;
                padding-right: 2.25rem;
                min-width: 18rem;
            }
            .nav-text {
                display: block;
            }
        }
        @media (max-width: 767px) {
            .nav-text {
                display: none;
            }
        }
        .icon {
            width: 1.5rem;
            height: 1.5rem;
            fill: currentColor;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <c:if test="${sessionScope.role eq 'admin'}">
            <ul class="nav-list">
                <a href="admin-dashboard" class="nav-link ${pageContext.request.servletPath eq '/admin-dashboard' ? 'active' : ''}">
                    <img class="icon" src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt="Dashboard" />
                    <span class="nav-text">Dashboard</span>
                </a>
                <a href="all-appointments" class="nav-link ${pageContext.request.servletPath eq '/all-appointments' ? 'active' : ''}">
                    <img class="icon" src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt="Appointments" />
                    <span class="nav-text">Appointments</span>
                </a>
                <a href="add-doctor" class="nav-link ${pageContext.request.servletPath eq '/add-doctor' ? 'active' : ''}">
                    <img class="icon" src="${pageContext.request.contextPath}/assets/images/add_icon.svg" alt="Add Doctor" />
                    <span class="nav-text">Add Doctor</span>
                </a>
                <a href="doctor-list" class="nav-link ${pageContext.request.servletPath eq '/doctor-list' ? 'active' : ''}">
                    <img class="icon" src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt="Doctor List" />
                    <span class="nav-text">Doctor List</span>
                </a>
            </ul>
        </c:if>
        
        <c:if test="${sessionScope.role eq 'doctor'}">
            <ul class="nav-list">
                <a href="doctor-dashboard" class="nav-link ${pageContext.request.servletPath eq '/doctor-dashboard' ? 'active' : ''}">
                    <img class="icon" src="${pageContext.request.contextPath}/assets/images/home_icon.svg" alt="Dashboard" />
                    <span class="nav-text">Dashboard</span>
                </a>
                <a href="doctor-appointments" class="nav-link ${pageContext.request.servletPath eq '/doctor-appointments' ? 'active' : ''}">
                    <img class="icon" src="${pageContext.request.contextPath}/assets/images/appointment_icon.svg" alt="Appointments" />
                    <span class="nav-text">Appointments</span>
                </a>
                <a href="doctor-profile" class="nav-link ${pageContext.request.servletPath eq '/doctor-profile' ? 'active' : ''}">
                    <img class="icon" src="${pageContext.request.contextPath}/assets/images/people_icon.svg" alt="Profile" />
                    <span class="nav-text">Profile</span>
                </a>
            </ul>
        </c:if>
    </div>
</body>
</html>
