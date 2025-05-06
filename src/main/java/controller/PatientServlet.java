package controller;

import dao.IPatientDAO;
import dao.PatientDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Patient;
import service.IPatientService;
import service.PatientService;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "PatientServlet", urlPatterns = {"/user", "/user/*"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,     // 1MB
        maxFileSize = 1024 * 1024 * 5,       // 5MB
        maxRequestSize = 1024 * 1024 * 10    // 10MB
)
public class PatientServlet extends HttpServlet {
    IPatientDAO patientDAO = new PatientDAO();
    IPatientService patientService = new PatientService(patientDAO);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Patient patient = (Patient) session.getAttribute("user");
        System.out.println(patient.toString());
        request.setAttribute("user", patient);
        response.sendRedirect(request.getContextPath() + "/");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Patient patient = (Patient) session.getAttribute("user");

        String patientId = patient.getPatientId().toString();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String dobStr = request.getParameter("dob");
        String registrationDateStr = request.getParameter("registrationDate");
        boolean isActive = Boolean.parseBoolean(request.getParameter("isActive"));

        // Convert date strings to java.util.Date
        java.util.Date dob = null;
        java.util.Date registrationDate = null;

        try {
            java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
            if (dobStr != null && !dobStr.isEmpty()) {
                dob = formatter.parse(dobStr);
            }
            if (registrationDateStr != null && !registrationDateStr.isEmpty()) {
                registrationDate = formatter.parse(registrationDateStr);
            }
        } catch (java.text.ParseException e) {
            e.printStackTrace(); // or log the error
        }

        byte[] imageBytes = null;
        Part imagePart = request.getPart("pfp");
        if (imagePart != null && imagePart.getSize() > 0) {
            imageBytes = imagePart.getInputStream().readAllBytes();
        }

        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect("user-dashboard.jsp?error=Missing+email");
            return;
        }

        patient.setPatientId(UUID.fromString(patientId));
        patient.setName(name);
        patient.setEmail(email);
        patient.setPhone(phone);
        patient.setGender(gender);
        patient.setAddress(address);
        patient.setDateOfBirth((java.sql.Date) dob);
        patient.setActive(isActive);
        patient.setRegistrationDate((java.sql.Date) registrationDate);
        patient.setPfp(imageBytes);

        boolean isUpdated = patientService.updatePatientProfile(patient);
        if (isUpdated) {
            System.out.println("Patient profile updated");
            session.setAttribute("user", patient);
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

}
