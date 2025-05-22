package controller;

import dao.DoctorDAO;
import dao.DoctorDashboardDAO;
import dao.IDoctorDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Doctor;
import model.DashboardStats;
import service.DoctorService;
import service.IDoctorService;

import java.io.IOException;
import java.sql.SQLException;
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
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Doctor doctor = (Doctor) session.getAttribute("user");
        String path = request.getPathInfo();
        
        // Check for edit mode request parameter only once
        boolean isEditing = "true".equalsIgnoreCase(request.getParameter("edit"));
        request.setAttribute("isEditing", isEditing);

        if (path == null || path.equals("/") || path.equals("/dashboard")) {
            try {
                // Get dashboard stats for this doctor
                DoctorDashboardDAO dashboardDAO = new DoctorDashboardDAO();
                DashboardStats stats = dashboardDAO.getDoctorDashboardStats(doctor.getDoctorId().toString());
                
                // Set the current page for sidebar highlighting
                request.setAttribute("currentPage", "dashboard");
                request.setAttribute("user", doctor);
                request.setAttribute("dashboardStats", stats);
                request.getRequestDispatcher("/WEB-INF/view/Doctor/doctor-dashboard.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching dashboard data");
            }
        } else if (path.equals("/appointments")) {
            // Set the current page for sidebar highlighting
            request.setAttribute("currentPage", "appointments");
            request.setAttribute("user", doctor);
            request.getRequestDispatcher("/WEB-INF/view/Doctor/doctor-appointments.jsp").forward(request, response);
        } else if (path.equals("/profile")) {
            // Set the current page for sidebar highlighting
            request.setAttribute("currentPage", "profile");
            request.setAttribute("user", doctor);

            // Convert doctor's PFP byte array to Base64 string for display
            if (doctor != null && doctor.getPfp() != null && doctor.getPfp().length > 0) {
                // Add printout of byte array info
                byte[] pfpBytes = doctor.getPfp();
                System.out.println("Doctor PFP byte array length: " + pfpBytes.length);
                // Print first 10 bytes as hex for inspection
                StringBuilder hexString = new StringBuilder();
                for (int i = 0; i < Math.min(pfpBytes.length, 10); i++) {
                    hexString.append(String.format("%02X ", pfpBytes[i]));
                }
                System.out.println("First 10 bytes of PFP: " + hexString.toString());

                String base64Image = java.util.Base64.getEncoder().encodeToString(pfpBytes);
                request.setAttribute("doctorPfpBase64", base64Image);
                System.out.println("Doctor PFP data converted to Base64 and set as attribute.");
            } else {
                request.setAttribute("doctorPfpBase64", ""); // Set empty string if no image
                System.out.println("Doctor PFP byte array is NOT available or empty, setting empty Base64 attribute.");
            }

            request.getRequestDispatcher("/WEB-INF/view/Doctor/doctor-profile.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Doctor doctor = (Doctor) session.getAttribute("user");
        // String doctorId = doctor.getDoctorId().toString(); // doctorId is not used in this block

        // Check if this is a profile update request from the profile page (simplified to only check for 'available' parameter)
        String availableParam = request.getParameter("available");

        if (availableParam != null) { // Check if the availability parameter is present
            // Handle simplified profile update (only availability)
            try {
                boolean isAvailable = Boolean.parseBoolean(availableParam);

                // Update only the availability field of the doctor object
                doctor.setAvailable(isAvailable);

                // Call service to update in database
                boolean isUpdated = doctorService.updateDoctorProfile(doctor);

                if (isUpdated) {
                    System.out.println("Doctor availability updated successfully");
                    // Update session attribute with the latest doctor object
                    session.setAttribute("user", doctor);
                    // Redirect back to profile page (GET request) after successful update
                    response.sendRedirect(request.getContextPath() + "/doctor/profile?updateSuccess=true");
                } else {
                    System.out.println("Failed to update doctor availability");
                    // Redirect with error indication
                    response.sendRedirect(request.getContextPath() + "/doctor/profile?updateError=true");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/doctor/profile?updateError=exception&message=" + e.getMessage());
            }
        } else {
            // Existing POST handling (e.g., for full profile update including image, if still needed)
            // You might want to remove or refactor this part if only availability update is desired from the profile page

            // Get form parameters for the full profile update
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
            String about = request.getParameter("about"); // Assuming about is also part of the full update
            String address = request.getParameter("address"); // Assuming address is also part of the full update

            // Basic validation (consider adding more robust validation)
            if (email == null) {
                 response.sendRedirect(request.getContextPath() + "/doctor/profile?updateError=missingEmail"); // Redirect back to profile with error
                return;
            }

            // Update the doctor object from the full form
            // doctor.setDoctorId(UUID.fromString(doctorId)); // Don't change the doctor ID
            doctor.setName(name);
            doctor.setEmail(email);
            doctor.setSpeciality(speciality);
            doctor.setExperience(Integer.parseInt(experienceStr));
            // Use the availability param from the form, not the simplified update logic param
            doctor.setAvailable(Boolean.parseBoolean(request.getParameter("availability")));
            doctor.setFees(fees);
            doctor.setDegree(degree);
            if (imageBytes != null && imageBytes.length > 0) {
                 doctor.setPfp(imageBytes); // Only update PFP if a new one is provided
            }
            doctor.setAbout(about); // Set about field
            doctor.setAddress(address); // Set address field

            System.out.println(doctor);
            boolean isUpdated = doctorService.updateDoctorProfile(doctor);
            if (isUpdated) {
                System.out.println("Doctor profile updated (full form)");
                session.setAttribute("user", doctor); // Update session with latest data
                response.sendRedirect(request.getContextPath() + "/doctor/profile?updateSuccess=true"); // Redirect back to profile
            } else {
                System.out.println("Failed to update doctor profile (full form)");
                 response.sendRedirect(request.getContextPath() + "/doctor/profile?updateError=true"); // Redirect back with error
            }
        }
    }
}