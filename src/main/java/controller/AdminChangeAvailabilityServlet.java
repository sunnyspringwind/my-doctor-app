package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.DoctorDAO;
import dao.IDoctorDAO;
import model.Doctor;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

@WebServlet(name = "AdminChangeAvailabilityServlet", urlPatterns = {"/admin/change-availability"})
public class AdminChangeAvailabilityServlet extends HttpServlet {
    private final IDoctorDAO doctorDAO = new DoctorDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("AdminChangeAvailabilityServlet: Starting doPost method");
        
        try {
            // Read the request body
            StringBuilder requestBody = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                requestBody.append(line);
            }
            
            // Parse the JSON request body
            JsonObject jsonRequest = JsonParser.parseString(requestBody.toString()).getAsJsonObject();
            UUID doctorId = UUID.fromString(jsonRequest.get("doctorId").getAsString());
            
            System.out.println("AdminChangeAvailabilityServlet: Changing availability for doctor ID: " + doctorId);
            
            // Get the current doctor
            Doctor doctor = doctorDAO.getDoctorById(doctorId);
            if (doctor != null) {
                // Toggle the availability
                doctor.setAvailable(!doctor.isAvailable());
                
                // Update the doctor in the database
                boolean success = doctorDAO.updateDoctor(doctor);
                
                // Prepare the response
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("success", success);
                out.print(gson.toJson(jsonResponse));
                
                System.out.println("AdminChangeAvailabilityServlet: Availability updated successfully");
            } else {
                throw new ServletException("Doctor not found");
            }
            
        } catch (Exception e) {
            System.err.println("AdminChangeAvailabilityServlet: Error occurred: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error updating doctor availability", e);
        }
    }
} 