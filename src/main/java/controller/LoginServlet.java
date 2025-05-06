package controller;

import dao.DoctorDAO;
import dao.PatientDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Doctor;
import model.Patient;
import model.User;
import service.DoctorService;
import service.IDoctorService;
import service.IPatientService;
import service.PatientService;
import utils.CookieChief;
import utils.StatusCode;

import java.io.IOException;
import java.sql.Date;
@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    IDoctorService doctorService = new DoctorService(new DoctorDAO());
    IPatientService patientService = new PatientService(new PatientDAO());

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
            request.setAttribute("error", "Please fill all the fields");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return;
        }
        //clean inputs
        email = email.trim();
        password = password.trim();
        role = role.trim();
        remember = remember.trim();

        Object user = null;

        // Login for doctor user
        if ("doctor".equalsIgnoreCase(role)) {
            user = doctorService.loginDoctor(email, password);

            //session and cookie creation
            if (user instanceof Doctor doctor) {  //using Java’s pattern matching for instanceof
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(1500);
                session.setAttribute("user", doctor);
                session.setAttribute("role", role);
                if ("on".equalsIgnoreCase(remember)) {
                    Cookie emailCookie = CookieChief.makeCookie("doc_email", email, 7);
                    Cookie roleCookie = CookieChief.makeCookie("doc_role", role, 7);
                    response.addCookie(emailCookie);
                    response.addCookie(roleCookie);
                }
                response.sendRedirect(request.getContextPath() + "/doctor");
                return; //they said code keep executing if not return
            }
        }
        // Login for patient user
        else if ("patient".equalsIgnoreCase(role)) {
            user = patientService.loginPatient(email, password);

            //session and cookie creation
                if (user instanceof Patient patient) {
                    HttpSession session = request.getSession();
                    session.setMaxInactiveInterval(1500);
                    session.setAttribute("user", patient);
                    session.setAttribute("role", role);

                    //remember me cookie optional
                    if ("on".equalsIgnoreCase(remember)) {
                        Cookie emailCookie = CookieChief.makeCookie("pat_email", email, 7);
                        Cookie roleCookie = CookieChief.makeCookie("pat_role", role, 7);
                        response.addCookie(emailCookie);
                        response.addCookie(roleCookie);
                    }
                    response.sendRedirect(request.getContextPath() + "/user");
                    return;
                }
        }

            // If login fails
            request.setAttribute("error", "Invalid credentials or role");
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
    }
}
