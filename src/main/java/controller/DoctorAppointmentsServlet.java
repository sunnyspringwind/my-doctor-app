package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Appointment;
import service.AppointmentService;
import utils.ServiceResponse;
import utils.StatusCode;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import dao.AppointmentDAO;
import jakarta.servlet.http.HttpSession;
import model.Doctor;

@WebServlet("/doctor/appointments/*")
public class DoctorAppointmentsServlet extends HttpServlet {
    private AppointmentService appointmentService;

    @Override
    public void init() throws ServletException {
        appointmentService = new AppointmentService(new AppointmentDAO());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            Doctor doctor = (Doctor) session.getAttribute("user");
            String role = (String) session.getAttribute("role");
            
            System.out.println("Debug - Session attributes:");
            System.out.println("user: " + (doctor != null ? doctor.getDoctorId() : "null"));
            System.out.println("role: " + role);
            
            if (doctor == null || !"doctor".equals(role)) {
                System.out.println("Debug - Redirecting to login because:");
                System.out.println("doctor is null: " + (doctor == null));
                System.out.println("role is not doctor: " + !"doctor".equals(role));
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            ServiceResponse<List<Appointment>> serviceResponse = appointmentService.getAppointmentsByDoctorId(doctor.getDoctorId().toString());
            if (serviceResponse.getStatus() == StatusCode.SUCCESS) {
                request.setAttribute("appointments", serviceResponse.getData());
            } else {
                request.setAttribute("appointments", new ArrayList<>());
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/Doctor/doctor-appointments.jsp");
            if (dispatcher != null) {
                dispatcher.forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Could not find the appointments page");
            }
        } catch (Exception e) {
            System.err.println("Error in DoctorAppointmentsServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request");
        } finally {
            response.getWriter().flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        String appointmentId = request.getParameter("appointmentId");
        
        if (appointmentId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Appointment ID is required");
            return;
        }

        try {
            int id = Integer.parseInt(appointmentId);
            
            // Get the current appointment to check its status
            ServiceResponse<Appointment> serviceResponse = appointmentService.getAppointmentById(id);
            if (serviceResponse.getStatus() != StatusCode.SUCCESS || serviceResponse.getData() == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Appointment not found");
                return;
            }
            
            Appointment appointment = serviceResponse.getData();
            
            // Don't allow changing status of paid appointments
            if ("PAID".equals(appointment.getStatus())) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cannot change status of paid appointments");
                return;
            }
            
            if ("/cancel".equals(action)) {
                appointmentService.updateAppointmentStatus(id, "CANCELLED");
            } else if ("/complete".equals(action)) {
                appointmentService.updateAppointmentStatus(id, "COMPLETED");
            }
            
            // Redirect back to appointments page
            response.sendRedirect(request.getContextPath() + "/doctor/appointments");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid appointment ID");
        }
    }
} 