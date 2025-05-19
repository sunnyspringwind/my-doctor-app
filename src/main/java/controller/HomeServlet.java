package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

/**landing page, logs in and redirects to appropriate dashboard if cookies exists*/
@WebServlet(name = "HomeServlet", urlPatterns = {"/", "/home"})
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Object user = session.getAttribute("user");
        String role = (String) session.getAttribute("role");

        if (user != null) {
            switch (role) {
                case "admin":
                    response.sendRedirect(request.getContextPath()+"/admin/dashboard");
                    break;
                case "doctor":
                    response.sendRedirect(request.getContextPath()+"/doctor");
                    break;
                case "patient":
                    response.sendRedirect(request.getContextPath()+"/user");
                    break;
                default:
                    response.sendRedirect(request.getContextPath()+"/login");
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

}