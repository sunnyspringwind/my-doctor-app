package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import utils.CookieChief;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", value = "/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        performLogout(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        performLogout(request, response);
    }

    private void performLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Delete all cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                // Delete role-specific cookies
                if (cookie.getName().contains("_email") || cookie.getName().contains("_role")) {
                    Cookie deleteCookie = CookieChief.deleteCookie(cookie);
                    response.addCookie(deleteCookie);
                }
            }
        }

        // Invalidate the session
        if (session != null) {
            session.invalidate();
        }

        // Add a message to the new session
        HttpSession newSession = request.getSession();
        newSession.setAttribute("message", "You have been successfully logged out");
        newSession.setAttribute("messageType", "success");

        // Redirect to home page
        response.sendRedirect(request.getContextPath() + "/");
    }
}
