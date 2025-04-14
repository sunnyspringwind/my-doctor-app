package controller;

import dao.AppointmentDAO;
import jakarta.servlet.annotation.WebServlet;
import model.Appointment;
import service.AppointmentService;
import utils.ServiceResponse;
import utils.StatusCode;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(name = "AppointmentServlet", value = "/appointment")
public class AppointmentController extends HttpServlet {
    private AppointmentService appointmentService;

    @Override
    public void init() {
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        appointmentService = new AppointmentService(appointmentDAO);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String forwardPage = "/appointment.jsp"; // default JSP

        if (action == null) {
            // Get all appointments
            ServiceResponse<List<Appointment>> response = appointmentService.getAllAppointments();
            req.setAttribute("status", response.getStatus());
            req.setAttribute("appointments", response.getData());
        } else {
            switch (action) {
                case "byId" -> {
                    int id = Integer.parseInt(req.getParameter("appointment_id"));
                    ServiceResponse<Appointment> response = appointmentService.getAppointmentById(id);
                    req.setAttribute("status", response.getStatus());
                    req.setAttribute("appointment", response.getData());
                }
                case "byDoctor" -> {
                    String doctorId = req.getParameter("doctor_id");
                    ServiceResponse<List<Appointment>> response = appointmentService.getAppointmentsByDoctorId(doctorId);
                    req.setAttribute("status", response.getStatus());
                    req.setAttribute("appointments", response.getData());
                }
                case "byPatient" -> {
                    String patientId = req.getParameter("patient_id");
                    ServiceResponse<List<Appointment>> response = appointmentService.getAppointmentsByPatientId(patientId);
                    req.setAttribute("status", response.getStatus());
                    req.setAttribute("appointments", response.getData());
                }
                default -> {
                    req.setAttribute("status", StatusCode.BAD_REQUEST);
                }
            }
        }

        req.getRequestDispatcher(forwardPage).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String doctorId = req.getParameter("doctor_id");
            String patientId = req.getParameter("patient_id");
            String status = req.getParameter("status");
            String reason = req.getParameter("reason");
            float payment = Float.parseFloat(req.getParameter("payment"));
            Timestamp appointmentTime = Timestamp.valueOf(req.getParameter("appointment_time"));

            Appointment appointment = new Appointment();
            appointment.setDoctorId(doctorId);
            appointment.setPatientId(patientId);
            appointment.setAppointmentTime(appointmentTime);
            appointment.setStatus(status);
            appointment.setReason(reason);
            appointment.setPayment(payment);

            StatusCode code = appointmentService.addAppointment(appointment);
            req.setAttribute("status", code);
        } catch (Exception e) {
            req.setAttribute("status", StatusCode.BAD_REQUEST);
        }

        req.getRequestDispatcher("/appointment.jsp").forward(req, resp);
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int appointmentId = Integer.parseInt(req.getParameter("appointment_id"));
        String newStatus = req.getParameter("status");

        boolean updated = appointmentService.updateAppointmentStatus(appointmentId, newStatus);
        req.setAttribute("status", updated ? StatusCode.SUCCESS : StatusCode.NOT_FOUND);
        req.getRequestDispatcher("/appointment.jsp").forward(req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int appointmentId = Integer.parseInt(req.getParameter("appointment_id"));

        boolean deleted = appointmentService.deleteAppointment(appointmentId);
        req.setAttribute("status", deleted ? StatusCode.SUCCESS : StatusCode.NOT_FOUND);
        req.getRequestDispatcher("/appointment.jsp").forward(req, resp);
    }
}
