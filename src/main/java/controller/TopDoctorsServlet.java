package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.DoctorDAO;
import dao.IDoctorDAO;
import model.Doctor;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TopDoctorsServlet", urlPatterns = {"/components/topDoctors"})
public class TopDoctorsServlet extends HttpServlet {
    private final IDoctorDAO doctorDAO = new DoctorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("TopDoctorsServlet: Starting doGet method");
        
        try {
            List<Doctor> allDoctors = doctorDAO.getAllDoctors();
            System.out.println("TopDoctorsServlet: Retrieved " + allDoctors.size() + " doctors");
            
            // Get first 10 doctors or all if less than 10
            List<Doctor> topDoctors = allDoctors.subList(0, Math.min(10, allDoctors.size()));
            System.out.println("TopDoctorsServlet: Selected " + topDoctors.size() + " top doctors");
            
            request.setAttribute("topDoctors", topDoctors);
            request.getRequestDispatcher("/WEB-INF/components/topDoctors.jsp").include(request, response);
            
        } catch (Exception e) {
            System.err.println("TopDoctorsServlet: Error occurred: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error retrieving top doctors", e);
        }
    }
} 