package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.AppointmentService;
import dao.AppointmentDAO;
import model.Appointment;
import java.io.IOException;
import java.util.List;

@WebServlet("/my-appointments")
public class MyAppointmentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AppointmentService appointmentService;

    public MyAppointmentsServlet() {
        this.appointmentService = new AppointmentService(new AppointmentDAO());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get patient from session
        model.Patient patient = (model.Patient) session.getAttribute("user");
        String patientId = patient.getPatientId().toString();
        System.out.println("Fetching appointments for patient ID: " + patientId);
        
        // Fetch user's appointments
        List<Appointment> appointments = appointmentService.getAppointmentsByPatientId(patientId).getData();
        System.out.println("Found " + appointments.size() + " appointments");

        // Sort: PENDING first (newest first), then others (newest first)
        appointments.sort((a, b) -> {
            boolean aPending = a.getStatus().equals("PENDING");
            boolean bPending = b.getStatus().equals("PENDING");
            if (aPending && !bPending) return -1;
            if (!aPending && bPending) return 1;
            // Within same status, sort by appointment time descending (newest first)
            return b.getAppointmentTime().compareTo(a.getAppointmentTime());
        });
        
        // Set appointments in request attribute
        request.setAttribute("appointments", appointments);
        
        // Forward to myAppointments.jsp
        request.getRequestDispatcher("/WEB-INF/view/Patient/myAppointments.jsp").forward(request, response);
    }
} 