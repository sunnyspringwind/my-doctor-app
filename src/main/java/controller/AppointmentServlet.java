package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.AppointmentService;
import dao.AppointmentDAO;
import model.Appointment;
import utils.StatusCode;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/appointment")
public class AppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AppointmentService appointmentService;

    public AppointmentServlet() {
        this.appointmentService = new AppointmentService(new AppointmentDAO());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            // Default action - show appointment form
            request.getRequestDispatcher("/WEB-INF/view/appointment.jsp").forward(request, response);
            return;
        }

        switch (action) {
            case "view":
                // Handle viewing appointments
                break;
            case "list":
                // Handle listing appointments
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is required");
            return;
        }

        switch (action) {
            case "create":
                createAppointment(request, response);
                break;
            case "update":
                updateAppointment(request, response);
                break;
            case "delete":
                deleteAppointment(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void createAppointment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Appointment appointment = new Appointment();
            appointment.setDoctorId(request.getParameter("doctorId"));
            appointment.setPatientId(request.getParameter("patientId"));
            appointment.setAppointmentTime(Timestamp.valueOf(request.getParameter("appointmentTime")));
            appointment.setStatus("PENDING");
            appointment.setReason(request.getParameter("reason"));
            appointment.setPayment(Float.parseFloat(request.getParameter("payment")));

            StatusCode status = appointmentService.addAppointment(appointment);
            
            if (status == StatusCode.SUCCESS) {
                response.sendRedirect(request.getContextPath() + "/appointment?action=list");
            } else {
                request.setAttribute("error", "Failed to create appointment: " + status);
                request.getRequestDispatcher("/WEB-INF/view/appointment.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error creating appointment: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/appointment.jsp").forward(request, response);
        }
    }

    private void updateAppointment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            String status = request.getParameter("status");
            
            boolean success = appointmentService.updateAppointmentStatus(appointmentId, status);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/appointment?action=list");
            } else {
                request.setAttribute("error", "Failed to update appointment status");
                request.getRequestDispatcher("/WEB-INF/view/appointment.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error updating appointment: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/appointment.jsp").forward(request, response);
        }
    }

    private void deleteAppointment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            
            boolean success = appointmentService.deleteAppointment(appointmentId);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/appointment?action=list");
            } else {
                request.setAttribute("error", "Failed to delete appointment");
                request.getRequestDispatcher("/WEB-INF/view/appointment.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error deleting appointment: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/appointment.jsp").forward(request, response);
        }
    }
} 