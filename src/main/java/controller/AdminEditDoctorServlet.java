package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.DoctorDAO;
import dao.IDoctorDAO;
import model.Doctor;
import utils.StatusCode;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "AdminEditDoctorServlet", urlPatterns = {"/admin/edit-doctor"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,     // 1MB threshold before writing to disk
    maxFileSize = 1024 * 1024 * 5,       // 5MB max per file
    maxRequestSize = 1024 * 1024 * 10    // 10MB total for request
)
public class AdminEditDoctorServlet extends HttpServlet {
    private final IDoctorDAO doctorDAO = new DoctorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String doctorId = request.getParameter("id");
        if (doctorId == null || doctorId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Doctor ID is required");
            return;
        }

        try {
            Doctor doctor = doctorDAO.getDoctorById(UUID.fromString(doctorId));
            if (doctor != null) {
                request.setAttribute("doctor", doctor);
                request.getRequestDispatcher("/WEB-INF/view/Admin/editDoctor.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Doctor not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving doctor information");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get form data
            String doctorId = request.getParameter("doctorId");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String speciality = request.getParameter("speciality");
            String experienceStr = request.getParameter("experience").split(" ")[0]; // Convert "X Years" to X
            int experience = Integer.parseInt(experienceStr);
            float fees = Float.parseFloat(request.getParameter("fees"));
            String degree = request.getParameter("education");
            String address = request.getParameter("address");
            String about = request.getParameter("about");
            boolean isAvailable = "on".equals(request.getParameter("available"));
            
            // Get existing doctor
            Doctor existingDoctor = doctorDAO.getDoctorById(UUID.fromString(doctorId));
            if (existingDoctor == null) {
                throw new ServletException("Doctor not found");
            }

            // Handle image upload
            Part imagePart = request.getPart("image");
            byte[] imageData = existingDoctor.getPfp(); // Keep existing image by default
            if (imagePart != null && imagePart.getSize() > 0) {
                imageData = imagePart.getInputStream().readAllBytes();
            }
            
            // Update doctor object
            existingDoctor.setName(name);
            existingDoctor.setEmail(email);
            existingDoctor.setSpeciality(speciality);
            existingDoctor.setExperience(experience);
            existingDoctor.setFees(fees);
            existingDoctor.setDegree(degree);
            existingDoctor.setAvailable(isAvailable);
            existingDoctor.setPfp(imageData);
            existingDoctor.setAddress(address);
            existingDoctor.setAbout(about);
            
            // Update doctor in database
            boolean success = doctorDAO.updateDoctor(existingDoctor);
            
            if (success) {
                session.setAttribute("message", "Doctor updated successfully!");
                session.setAttribute("messageType", "success");
            } else {
                session.setAttribute("message", "Error updating doctor!");
                session.setAttribute("messageType", "error");
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/doctor-list");
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Error updating doctor: " + e.getMessage());
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/admin/doctor-list");
        }
    }
} 