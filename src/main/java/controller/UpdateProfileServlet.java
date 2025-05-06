package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.regex.Pattern;

import dao.PatientDAO;
import model.Patient;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/update-profile"})
@MultipartConfig
public class UpdateProfileServlet extends HttpServlet {
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[0-9]{10}$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Patient patient = (Patient) session.getAttribute("user");
        
        if (patient == null) {
            System.out.println("No user found in session");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            System.out.println("Updating profile for user: " + patient.getEmail());
            
            // Log current values
            System.out.println("Current values:");
            System.out.println("Name: " + patient.getName());
            System.out.println("Phone: " + patient.getPhone());
            System.out.println("Address: " + patient.getAddress());
            System.out.println("Gender: " + patient.getGender());
            System.out.println("DOB: " + patient.getDateOfBirth());

            // Get new values from request
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String address = request.getParameter("addressLine1");
            String gender = request.getParameter("gender");
            String dobStr = request.getParameter("dob");

            System.out.println("New values from form:");
            System.out.println("Name: " + name);
            System.out.println("Phone: " + phone);
            System.out.println("Address: " + address);
            System.out.println("Gender: " + gender);
            System.out.println("DOB: " + dobStr);

            // Validate phone number
            if (phone != null && !phone.isEmpty() && !PHONE_PATTERN.matcher(phone).matches()) {
                session.setAttribute("message", "Please enter a valid 10-digit phone number");
                session.setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/profile");
                return;
            }

            // Update basic information
            patient.setName(name);
            patient.setPhone(phone);
            patient.setAddress(address);
            patient.setGender(gender);
            if (dobStr != null && !dobStr.isEmpty()) {
                patient.setDateOfBirth(Date.valueOf(dobStr));
            }

            // Handle image upload
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                System.out.println("Image file received, size: " + imagePart.getSize());
                InputStream imageStream = imagePart.getInputStream();
                byte[] imageBytes = imageStream.readAllBytes();
                patient.setPfp(imageBytes);
            }

            // Update in database
            PatientDAO patientDAO = new PatientDAO();
            boolean success = patientDAO.updatePatient(patient);

            System.out.println("Update result: " + success);

            if (success) {
                // Refresh user data from database
                Patient updatedPatient = patientDAO.getPatientById(patient.getPatientId().toString());
                if (updatedPatient != null) {
                    session.setAttribute("user", updatedPatient);
                    session.setAttribute("message", "Profile updated successfully");
                    session.setAttribute("messageType", "success");
                } else {
                    session.setAttribute("message", "Profile updated but failed to refresh data");
                    session.setAttribute("messageType", "warning");
                }
            } else {
                session.setAttribute("message", "Failed to update profile");
                session.setAttribute("messageType", "error");
            }

            response.sendRedirect(request.getContextPath() + "/profile");
        } catch (Exception e) {
            System.err.println("Error updating profile: " + e.getMessage());
            e.printStackTrace();
            session.setAttribute("message", "An error occurred while updating profile: " + e.getMessage());
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
} 