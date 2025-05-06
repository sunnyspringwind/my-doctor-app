package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.DashboardData;
import model.Appointment;
import model.DoctorData;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // In a real application, this data would come from a database
        DashboardData dashData = new DashboardData();
        dashData.setDoctors(25);
        dashData.setAppointments(150);
        dashData.setPatients(500);

        // Create sample latest appointments
        List<Appointment> latestAppointments = new ArrayList<>();
        
        // Sample appointment 1
        Appointment app1 = new Appointment();
        DoctorData doc1 = new DoctorData();
        doc1.setName("Dr. John Smith");
        doc1.setImage("doc1.png");
        app1.setDocData(doc1);
        app1.setSlotDate("2024-04-25T10:00");
        app1.setCancelled(false);
        app1.setId("1");
        latestAppointments.add(app1);

        // Sample appointment 2
        Appointment app2 = new Appointment();
        DoctorData doc2 = new DoctorData();
        doc2.setName("Dr. Sarah Johnson");
        doc2.setImage("doc2.png");
        app2.setDocData(doc2);
        app2.setSlotDate("2024-04-26T14:30");
        app2.setCancelled(true);
        app2.setId("2");
        latestAppointments.add(app2);

        // Sample appointment 3
        Appointment app3 = new Appointment();
        DoctorData doc3 = new DoctorData();
        doc3.setName("Dr. Michael Brown");
        doc3.setImage("doc3.png");
        app3.setDocData(doc3);
        app3.setSlotDate("2024-04-27T09:15");
        app3.setCancelled(false);
        app3.setId("3");
        latestAppointments.add(app3);

        dashData.setLatestAppointments(latestAppointments);

        request.setAttribute("dashData", dashData);
        request.getRequestDispatcher("/WEB-INF/view/Admin/admin-dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("cancelAppointment".equals(action)) {
            @SuppressWarnings("unused")
            String appointmentId = request.getParameter("appointmentId");
            // In a real application, you would update the database here
            response.sendRedirect("admin");
            return;
        }
        doGet(request, response);
    }
} 