package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Appointment;
import model.DoctorData;
import com.google.gson.Gson;
import dao.AppointmentDAO;
import service.AppointmentService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AdminAppointmentsServlet", value = "/admin/appointments")
public class AdminAppointmentsServlet extends HttpServlet {
        private final AppointmentService appointmentService = new AppointmentService(new AppointmentDAO());

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                String uri = request.getRequestURI();
                if (uri.endsWith("/admin/appointments/data")) {
                        handleDataRequest(request, response);
                        return;
                }
                // Check if user is logged in and is an admin
                HttpSession session = request.getSession(false);
                if (session == null || session.getAttribute("user") == null
                                || !"admin".equals(session.getAttribute("role"))) {
                        response.sendRedirect(request.getContextPath() + "/login");
                        return;
                }

                // Fetch appointments from the database
                List<Appointment> appointments = appointmentService.getAllAppointments().getData();
                request.setAttribute("appointments", appointments);
                request.setAttribute("currentPage", "appointments");
                request.getRequestDispatcher("/WEB-INF/view/Admin/appointments.jsp").forward(request, response);
        }

        private void handleDataRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try {
                        // Fetch all appointments from the database
                        List<Appointment> appointments = appointmentService.getAllAppointments().getData();
                        java.util.Map<String, Object> result = new java.util.HashMap<>();
                        result.put("appointments", appointments);
                        result.put("totalPages", 1); // Update this if you add pagination
                        String json = new Gson().toJson(result);
                        response.getWriter().write(json);
                } catch (Exception e) {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write("{\"error\": \"Server error: " + e.getMessage() + "\"}");
                } finally {
                        response.getWriter().flush();
                        response.getWriter().close();
                }
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                try {
                        String appointmentId = request.getParameter("appointmentId");
                        String status = request.getParameter("status");

                        if (appointmentId == null || status == null) {
                                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                                response.getWriter().write("{\"success\": false, \"message\": \"Appointment ID and status are required\"}");
                                return;
                        }

                        System.out.println("Updating appointment " + appointmentId + " to status: " + status);
                        boolean success = appointmentService.updateAppointmentStatus(Integer.parseInt(appointmentId), status);

                        if (success) {
                                response.getWriter().write("{\"success\": true}");
                        } else {
                                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                                response.getWriter().write("{\"success\": false, \"message\": \"Failed to update appointment status\"}");
                        }
                } catch (NumberFormatException e) {
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().write("{\"success\": false, \"message\": \"Invalid appointment ID format\"}");
                } catch (Exception e) {
                        System.err.println("Error updating appointment: " + e.getMessage());
                        e.printStackTrace();
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        response.getWriter().write("{\"success\": false, \"message\": \"Server error: " + e.getMessage() + "\"}");
                }
        }
}