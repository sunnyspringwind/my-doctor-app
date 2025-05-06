package controller;

import dao.DoctorDAO;
import dao.IDoctorDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Doctor;
import service.DoctorService;
import service.IDoctorService;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "DoctorServlet", urlPatterns = { "/doctor", "/doctor/*"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,     // 1MB threshold before writing to disk
        maxFileSize = 1024 * 1024 * 5,       // 5MB max per file
        maxRequestSize = 1024 * 1024 * 10    // 10MB total for request
)
public class DoctorServlet extends HttpServlet {
    IDoctorDAO doctorDAO = new DoctorDAO();
    IDoctorService doctorService = new DoctorService(doctorDAO);
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Doctor doctor = (Doctor) session.getAttribute("user");
        System.out.println(doctor.toString());
        request.setAttribute("user", doctor);
        request.getRequestDispatcher("/WEB-INF/view/Doctor/doctor-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        Doctor doctor = (Doctor) session.getAttribute("user");
        String doctorId = doctor.getDoctorId().toString();

        // Get form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String speciality = request.getParameter("speciality");
        String experienceStr = request.getParameter("experience");
        boolean isAvailable = Boolean.parseBoolean(request.getParameter("availability"));
        float fees = Float.parseFloat(request.getParameter("fees"));
        String degree = request.getParameter("degree");
        //handling image bytes
        byte[] imageBytes = null;
        Part imagePart = request.getPart("pfp");
        if (imagePart != null) {
            System.out.println("image here");
            imageBytes = imagePart.getInputStream().readAllBytes();
        }
        // Basic validation
        if (email == null) {
            response.sendRedirect("doctor-dashboard.jsp?error=Missing+email");
            return;
        }
        doctor.setDoctorId(UUID.fromString(doctorId));
        doctor.setName(name);
        doctor.setEmail(email);
        doctor.setSpeciality(speciality);
        doctor.setExperience(Integer.parseInt(experienceStr));
        doctor.setAvailable(isAvailable);
        doctor.setFees(fees);
        doctor.setDegree(degree);
        doctor.setPfp(imageBytes);
        System.out.println(doctor);
        boolean isUpdated = doctorService.updateDoctorProfile(doctor);
        if (isUpdated) {
            System.out.println("Doctor profile updated");
            session.setAttribute("user", doctor);
            request.getRequestDispatcher("/WEB-INF/view/Doctor/doctor-dashboard.jsp").forward(request, response);
        }

    }
}
