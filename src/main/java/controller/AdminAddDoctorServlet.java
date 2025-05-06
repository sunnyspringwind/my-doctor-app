package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import dao.DoctorDAO;
import service.DoctorService;
import service.IDoctorService;
import model.Doctor;
import utils.StatusCode;

@WebServlet(name = "AdminAddDoctorServlet", value = "/admin/add-doctor")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class AdminAddDoctorServlet extends HttpServlet {
    private final IDoctorService doctorService = new DoctorService(new DoctorDAO());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Set the current page for sidebar highlighting
        request.setAttribute("currentPage", "add-doctor");

        // Forward to the add doctor JSP
        request.getRequestDispatcher("/WEB-INF/view/Admin/addDoctors.jsp").forward(request, response);
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
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String speciality = request.getParameter("speciality");
            String experienceStr = request.getParameter("experience").split(" ")[0]; // Convert "X Years" to X
            int experience = Integer.parseInt(experienceStr);
            float fees = Float.parseFloat(request.getParameter("fees"));
            String degree = request.getParameter("education");
            String address = request.getParameter("address");
            String about = request.getParameter("about");
            
            // Handle image upload
            Part imagePart = request.getPart("image");
            byte[] imageData = null;
            if (imagePart != null && imagePart.getSize() > 0) {
                imageData = imagePart.getInputStream().readAllBytes();
            }
            
            // Create doctor object with all fields
            Doctor doctor = Doctor.createFromRegistration(
                name, 
                email, 
                password, 
                speciality, 
                experience, 
                fees, 
                degree,
                true, // isAvailable
                imageData,
                address,
                about
            );
            
            // Register doctor with all information
            StatusCode status = doctorService.registerDoctor(doctor);
            
            if (status == StatusCode.SUCCESS) {
                session.setAttribute("message", "Doctor added successfully!");
                session.setAttribute("messageType", "success");
            } else if (status == StatusCode.EMAIL_ALREADY_EXISTS) {
                session.setAttribute("message", "Email already exists!");
                session.setAttribute("messageType", "error");
            } else {
                session.setAttribute("message", "Error adding doctor!");
                session.setAttribute("messageType", "error");
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log the error
            session.setAttribute("message", "Error adding doctor: " + e.getMessage());
            session.setAttribute("messageType", "error");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/add-doctor");
    }
} 