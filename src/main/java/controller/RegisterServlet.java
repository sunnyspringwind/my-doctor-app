package controller;

import dao.PatientDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import service.PatientService;
import service.IPatientService;
import utils.StatusCode;

import java.io.IOException;

/**Handles patient registration*/
@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    IPatientService patientService = new PatientService(new PatientDAO());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user details
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();

        // Validation for fields
        if (name == null || name.isEmpty()) {
            session.setAttribute("message", "Name is required.");
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }
        if (email == null || email.isEmpty() || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) {
            session.setAttribute("message", "Valid email is required.");
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }
        if (password == null || password.isEmpty()) {
            session.setAttribute("message", "Password is required.");
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        // Register patient
        StatusCode registerStatus = patientService.registerPatient(name, email, password);

        // Set appropriate response based on the operation status
        if (registerStatus == StatusCode.SUCCESS) {
            session.setAttribute("message", "Registration successful! Please login to continue.");
            session.setAttribute("messageType", "success");
            response.sendRedirect(request.getContextPath() + "/login");
        } else if (registerStatus == StatusCode.EMAIL_ALREADY_EXISTS) {
            session.setAttribute("message", "Email already exists.");
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/register");
        } else {
            session.setAttribute("message", "Internal server error occurred. Please try again.");
            session.setAttribute("messageType", "error");
            response.sendRedirect(request.getContextPath() + "/register");
        }
    }
}