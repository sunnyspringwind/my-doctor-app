package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import dao.AppointmentDAO;
import java.io.IOException;

@WebServlet(name = "AdminBookingActionServlet", value = "/admin/booking-action")
public class AdminBookingActionServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String appointmentIdStr = request.getParameter("appointmentId");
        String action = request.getParameter("action");
        if (appointmentIdStr != null && action != null) {
            int appointmentId = Integer.parseInt(appointmentIdStr);
            String newStatus = "PENDING";
            if ("accept".equals(action)) {
                newStatus = "CONFIRMED";
            } else if ("cancel".equals(action)) {
                newStatus = "CANCELLED";
            }
            appointmentDAO.updateAppointmentStatus(appointmentId, newStatus);
        }
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
} 