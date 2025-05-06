package controller;

import dao.AdminDAO;
import dao.DoctorDAO;
import dao.PatientDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Admin;
import model.Doctor;
import model.Patient;
import service.*;
import utils.CookieChief;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    IDoctorService doctorService = new DoctorService(new DoctorDAO());
    IPatientService patientService = new PatientService(new PatientDAO());
    IAdminService adminService = new AdminService(new AdminDAO());

    /** checks session status, redirects to home page or login */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && (session.getAttribute("user") != null)) {
            // Already logged in, redirect to home page
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            // Not logged in, show login page
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
        }
    }

    /**validations, role based login with cookies optional */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get login details from frontend
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String remember = request.getParameter("remember");

        // Input validation
        if (email == null || password == null || role == null) {
            HttpSession session = request.getSession();
            session.setAttribute("message", "Please fill all the fields");
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        //clean inputs
        email = email.trim();
        password = password.trim();
        role = role.trim();
        remember = (remember != null) ? remember.trim() : "";

        Object user = null;

        // Role-based login
        if ("admin".equalsIgnoreCase(role)) {
            user = adminService.login(email, password);
            if (user instanceof Admin admin) {
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(15 * 60); // 15 minutes in seconds
                session.setAttribute("user", admin);
                session.setAttribute("role", role);
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                return;
            }
        } else if ("doctor".equalsIgnoreCase(role)) {
            user = doctorService.loginDoctor(email, password);
            if (user instanceof Doctor doctor) {
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(15 * 60); // 15 minutes in seconds
                session.setAttribute("user", doctor);
                session.setAttribute("role", role);
                session.setAttribute("message", "Welcome back, Dr. " + doctor.getName());
                session.setAttribute("messageType", "success");

                // Always set cookies with 15 minutes expiration
                Cookie emailCookie = CookieChief.makeCookieWithMinutes("doc_email", email, 15);
                Cookie roleCookie = CookieChief.makeCookieWithMinutes("doc_role", role, 15);
                response.addCookie(emailCookie);
                response.addCookie(roleCookie);
                
                response.sendRedirect(request.getContextPath() + "/doctor/dashboard");
                return;
            }
        } else if ("patient".equalsIgnoreCase(role)) {
            user = patientService.loginPatient(email, password);
            if (user instanceof Patient patient) {
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(24 * 60 * 60); // 24 hours in seconds
                session.setAttribute("user", patient);
                session.setAttribute("role", role);
                session.setAttribute("message", "Welcome back, " + patient.getName());
                session.setAttribute("messageType", "success");

                // Set cookies with longer expiration if remember me is checked
                int cookieAge = "on".equals(remember) ? 30 * 24 * 60 : 24 * 60; // 30 days or 24 hours in minutes
                Cookie emailCookie = CookieChief.makeCookieWithMinutes("pat_email", email, cookieAge);
                Cookie roleCookie = CookieChief.makeCookieWithMinutes("pat_role", role, cookieAge);
                response.addCookie(emailCookie);
                response.addCookie(roleCookie);
                
                response.sendRedirect(request.getContextPath() + "/user");
                return;
            }
        }

        // If login fails
        HttpSession session = request.getSession();
        session.setAttribute("message", "Invalid credentials or role");
        session.setAttribute("messageType", "error");
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
