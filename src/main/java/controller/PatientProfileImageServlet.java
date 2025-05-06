package controller;

import dao.PatientDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Patient;

import java.io.IOException;
import java.io.OutputStream;

@WebServlet(name = "PatientProfileImageServlet", urlPatterns = {"/patient-profile-image"})
public class PatientProfileImageServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String patientId = request.getParameter("id");
        
        if (patientId == null || patientId.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Patient ID is required");
            return;
        }

        PatientDAO patientDAO = new PatientDAO();
        Patient patient = patientDAO.getPatientById(patientId);

        if (patient != null && patient.getPfp() != null) {
            response.setContentType("image/jpeg");
            response.setContentLength(patient.getPfp().length);
            
            try (OutputStream out = response.getOutputStream()) {
                out.write(patient.getPfp());
                out.flush();
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
        }
    }
} 