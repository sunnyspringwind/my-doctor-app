package controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import dao.UserDAO;
import utils.UserStatus;

import java.io.IOException;
import java.util.UUID;

/**Handles users registration*/
@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get user details from frontend
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        byte[] pfp = request.getParameter("pfp").getBytes();
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        java.sql.Date dateOfBirth = java.sql.Date.valueOf(request.getParameter("dateOfBirth"));
        String degree = request.getParameter("degree");
        String specialization = request.getParameter("specialization");
        Float fee = Float.valueOf(request.getParameter("fee"));
        Boolean isAvailable = Boolean.valueOf(request.getParameter("isAvailable"));

        // handles data validations with proper response code and error message
        if (firstName == null || firstName.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("error", "First name is required.");
            return;
        }

        if (lastName == null || lastName.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("error", "Last name is required.");
            return;
        }
        //regex to check valid email format
        if (email == null || email.isEmpty() || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("error", "Valid email is required.");
            return;
        }

        if (phone == null || !phone.matches("\\d+")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("error", "Valid phone number is required.");
            return;
        }

        if (password == null || password.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("error", "Password is required.");
            return;
        }

        if (role == null || role.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("error", "Role is required.");
            return;
        }

        if (dateOfBirth == null || dateOfBirth.after(new java.util.Date())) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("error", "Date of birth must be a valid past date.");
            return;
        }

        if (degree != null && degree.length() > 50) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("error", "Degree should not exceed 50 characters.");
            return;
        }


        //Generate UUID for user
        UUID id = UUID.randomUUID();

        // Create user instance
        User user = new User(
                id,
                firstName,
                lastName,
                email,
                null, // Password hash will be set in the DAO while saving
                address,
                phone,
                role,
                pfp,
                gender,
                dateOfBirth,
                (degree != null && !degree.isEmpty()) ? degree : null,
                (specialization != null && !specialization.isEmpty()) ? specialization : null,
                (fee != null) ? fee : null,
                isAvailable
        );

        // Save user to the database
        UserDAO userDAO = new UserDAO();
        UserStatus status = userDAO.addUser(user);

        // Set appropriate response
        response.setContentType("text/plain");
            if (status == UserStatus.SUCCESS) {
                request.setAttribute("result", "User added successfully!");
                response.sendRedirect("/login");
            } else if (status == UserStatus.EMAIL_ALREADY_EXISTS) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                request.setAttribute("error", "Email already exists!");
            } else if (status == UserStatus.PHONE_ALREADY_EXISTS) {
                response.setStatus(HttpServletResponse.SC_CONFLICT);
                request.setAttribute("error", "Phone already exists!");
            } else if (status == UserStatus.INTERNAL_SERVER_ERROR) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                request.setAttribute("error", "Internal server error!");
            }


    }
}