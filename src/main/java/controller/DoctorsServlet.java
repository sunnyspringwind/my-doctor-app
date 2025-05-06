package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.DoctorDAO;
import dao.IDoctorDAO;
import model.Doctor;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DoctorsServlet", urlPatterns = {"/doctors"})
public class DoctorsServlet extends HttpServlet {
    private final IDoctorDAO doctorDAO = new DoctorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("DoctorsServlet: Starting doGet method");
        
        String speciality = request.getParameter("speciality");
        List<Doctor> doctors;
        
        try {
            if (speciality != null && !speciality.isEmpty()) {
                System.out.println("DoctorsServlet: Fetching doctors with speciality: " + speciality);
                doctors = doctorDAO.getDoctorsBySpeciality(speciality);
            } else {
                System.out.println("DoctorsServlet: Fetching all doctors");
                doctors = doctorDAO.getAllDoctors();
            }
            
            System.out.println("DoctorsServlet: Number of doctors found: " + (doctors != null ? doctors.size() : 0));
            if (doctors != null && !doctors.isEmpty()) {
                System.out.println("DoctorsServlet: First doctor: " + doctors.get(0).toString());
                request.setAttribute("doctors", doctors);
            } else {
                System.out.println("DoctorsServlet: No doctors found");
            }
            
            System.out.println("DoctorsServlet: Forwarding to doctors.jsp");
            request.getRequestDispatcher("/WEB-INF/view/Patient/doctors.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("DoctorsServlet: Error occurred: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error retrieving doctors", e);
        }
    }
} 