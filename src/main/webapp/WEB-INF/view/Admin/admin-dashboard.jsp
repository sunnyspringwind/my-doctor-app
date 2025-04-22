<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("user");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial; padding: 20px; background: #f7f7f7; }
        h2, h3 { margin-top: 30px; }
        .container { max-width: 1000px; margin: auto; background: #fff; padding: 20px; border-radius: 8px; }
        .form-group { margin-bottom: 15px; }
        input, select { padding: 8px; width: 100%; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: left; }
        .btn { padding: 6px 12px; background: #007bff; color: white; border: none; cursor: pointer; }
        .btn-danger { background: #dc3545; }
    </style>
</head>
<body>
<div class="container">
    <h2>Welcome, <c:out value="${admin.email}"/> (Admin)</h2>

    <!-- Add Doctor -->
    <h3>Add Doctor</h3>
    <form action="addDoctor" method="post">
        <div class="form-group"><input name="name" placeholder="Name" required></div>
        <div class="form-group"><input name="email" type="email" placeholder="Email" required></div>
        <div class="form-group"><input name="password" type="password" placeholder="Password" required></div>
        <div class="form-group"><input name="speciality" placeholder="Speciality" required></div>
        <div class="form-group"><input name="experience" type="number" placeholder="Experience (years)" required></div>
        <div class="form-group"><input name="fees" type="number" step="0.1" placeholder="Fees" required></div>
        <div class="form-group"><input name="degree" placeholder="Degree" required></div>
        <button type="submit" class="btn">Add Doctor</button>
    </form>

    <!-- Add Patient -->
    <h3 style="margin-top:40px;">Add Patient</h3>
    <form action="addPatient" method="post">
        <div class="form-group"><input name="name" placeholder="Name" required></div>
        <div class="form-group"><input name="email" type="email" placeholder="Email" required></div>
        <div class="form-group"><input name="password" type="password" placeholder="Password" required></div>
        <div class="form-group"><input name="phone" placeholder="Phone" required></div>
        <div class="form-group"><input name="address" placeholder="Address" required></div>
        <div class="form-group">
            <select name="gender" required>
                <option value="">Select Gender</option>
                <option>Male</option><option>Female</option><option>Other</option>
            </select>
        </div>
        <div class="form-group"><input name="dateOfBirth" type="date" required></div>
        <button type="submit" class="btn">Add Patient</button>
    </form>

    <!-- List Users -->
    <h3 style="margin-top:40px;">All Doctors</h3>
    <table>
        <tr>
            <th>Name</th><th>Email</th><th>Speciality</th><th>Action</th>
        </tr>
        <c:forEach var="doc" items="${doctorList}">
            <tr>
                <td>${doc.name}</td>
                <td>${doc.email}</td>
                <td>${doc.speciality}</td>
                <td>
                    <form action="deleteDoctor" method="post" style="display:inline;">
                        <input type="hidden" name="doctorId" value="${doc.doctorId}"/>
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

    <h3>All Patients</h3>
    <table>
        <tr>
            <th>Name</th><th>Email</th><th>Phone</th><th>Action</th>
        </tr>
        <c:forEach var="p" items="${patientList}">
            <tr>
                <td>${p.name}</td>
                <td>${p.email}</td>
                <td>${p.phone}</td>
                <td>
                    <form action="deletePatient" method="post" style="display:inline;">
                        <input type="hidden" name="patientId" value="${p.patientId}"/>
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

    <!-- Appointments -->
    <h3>Appointments</h3>
    <table>
        <tr>
            <th>Doctor</th><th>Patient</th><th>Time</th><th>Status</th><th>Action</th>
        </tr>
        <c:forEach var="a" items="${appointmentList}">
            <tr>
                <td>${a.doctorName}</td>
                <td>${a.patientName}</td>
                <td>${a.appointmentTime}</td>
                <td>${a.status}</td>
                <td>
                    <form action="deleteAppointment" method="post" style="display:inline;">
                        <input type="hidden" name="appointmentId" value="${a.appointmentId}"/>
                        <button type="submit" class="btn btn-danger">Cancel</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>
