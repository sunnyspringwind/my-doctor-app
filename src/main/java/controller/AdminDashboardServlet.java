package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.DashboardService;
import model.DashboardStats;
import java.io.IOException;

@WebServlet(name = "AdminDashboardServlet", value = "/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Set the current page for sidebar highlighting
        request.setAttribute("currentPage", "dashboard");

        // Create service and get dashboard stats
        DashboardService dashboardService = new DashboardService();
        DashboardStats stats = dashboardService.getDashboardStats();
        
        // Set stats in request attribute
        request.setAttribute("dashboardStats", stats);

        // Forward to the admin dashboard JSP
        request.getRequestDispatcher("/WEB-INF/view/Admin/admin-dashboard.jsp").forward(request, response);
    }
} 