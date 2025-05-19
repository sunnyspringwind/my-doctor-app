package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.DoctorDAO;
import dao.IDoctorDAO;
import model.Doctor;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminDoctorListServlet", urlPatterns = {"/admin/doctor-list"})
public class AdminDoctorListServlet extends HttpServlet {
    private final IDoctorDAO doctorDAO = new DoctorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("AdminDoctorListServlet: Starting doGet method");
        
        try {
            List<Doctor> doctors = doctorDAO.getAllDoctors();
            System.out.println("AdminDoctorListServlet: Retrieved " + doctors.size() + " doctors");
            
            request.setAttribute("doctors", doctors);
            request.getRequestDispatcher("/WEB-INF/view/Admin/doctorList.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("AdminDoctorListServlet: Error occurred: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error retrieving doctors list", e);
        }
    }
} 