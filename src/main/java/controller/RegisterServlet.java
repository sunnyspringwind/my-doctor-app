package controller;

import dao.DoctorDAO;
import dao.PatientDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import service.DoctorService;
import service.IDoctorService;
import service.IPatientService;
import service.PatientService;
import utils.StatusCode;

import java.io.IOException;

/**Handles users registration*/
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register", "/register/*"})
public class RegisterServlet extends HttpServlet {

    //using interface helps to:visualise, flexible, test: they said.
    IDoctorService doctorService = new DoctorService(new DoctorDAO());
    IPatientService patientService = new PatientService(new PatientDAO());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String registerPage = "/WEB-INF/view/register.jsp";
        // Get common user details
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Validation for common fields
        if (name == null || name.isEmpty()) {
            request.setAttribute("error", "Name is required.");
request.getRequestDispatcher(registerPage).forward(request, response);            return;
        }
        if (email == null || email.isEmpty() || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) {
            request.setAttribute("error", "Valid email is required.");
request.getRequestDispatcher(registerPage).forward(request, response);            return;
        }
        if (password == null || password.isEmpty()) {
            request.setAttribute("error", "Password is required.");
            request.getRequestDispatcher(registerPage).forward(request, response);
        }
        if (role == null || role.isEmpty()) {
            request.setAttribute("error", "Role is required.");
            request.getRequestDispatcher(registerPage).forward(request, response);
        }
        StatusCode registerStatus = null;
        // Role-specific logic for Doctor and Patient registration
        if (role.equalsIgnoreCase("doctor")) {
            registerStatus = doctorService.registerDoctor(name, email, password);

        } else if (role.equalsIgnoreCase("patient")) {
            registerStatus = patientService.registerPatient(name, email, password);
        }

        // Set appropriate response based on the operation status
        response.setContentType("text/plain");
        if (registerStatus == StatusCode.SUCCESS) {
            response.sendRedirect(request.getContextPath()+"/login");
        } else if (registerStatus == StatusCode.EMAIL_ALREADY_EXISTS) {
            request.setAttribute("error", "Email already exists.");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);

        } else if (registerStatus == StatusCode.PHONE_ALREADY_EXISTS) {
            request.setAttribute("error", "Phone number already exists.");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);

        } else {
            request.setAttribute("error", "Internal server error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
        }
    }


}