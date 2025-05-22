package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.DoctorDAO;
import dao.IDoctorDAO;
import model.Doctor;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "AdminDeleteDoctorServlet", urlPatterns = {"/admin/delete-doctor"})
public class AdminDeleteDoctorServlet extends HttpServlet {
    private final IDoctorDAO doctorDAO = new DoctorDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized access");
            return;
        }

        try {
            // Read the request body
            StringBuilder requestBody = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                requestBody.append(line);
            }
            
            // Parse the JSON request body
            JsonObject jsonRequest = gson.fromJson(requestBody.toString(), JsonObject.class);
            UUID doctorId = UUID.fromString(jsonRequest.get("doctorId").getAsString());
            
            System.out.println("AdminDeleteDoctorServlet: Deleting doctor with ID: " + doctorId);
            
            // Delete the doctor from the database
            boolean success = doctorDAO.deleteDoctor(doctorId);
            
            // Prepare the response
            response.setContentType("application/json");
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", success);
            
            response.getWriter().write(gson.toJson(jsonResponse));
            
            System.out.println("AdminDeleteDoctorServlet: Doctor deletion " + (success ? "successful" : "failed"));
            
        } catch (Exception e) {
            System.err.println("AdminDeleteDoctorServlet: Error occurred: " + e.getMessage());
            e.printStackTrace();
            
            // Send error response
            response.setContentType("application/json");
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("error", e.getMessage());
            
            response.getWriter().write(gson.toJson(jsonResponse));
        }
    }
} 