package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Doctor;
import model.Patient;
import model.User;
import dao.UserDAO;
import org.mindrot.jbcrypt.BCrypt;
import utils.UserStatus;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.util.UUID;

/**Handles users registration*/
@WebServlet(name = "RegisterServlet", value = "/register/*")
@MultipartConfig(maxFileSize = 2 * 1024 * 1024)
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String registerPage = "/WEB-INF/view/register.jsp";
        // Get common user details
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        String gender = request.getParameter("gender");
        Date dateOfBirth = (request.getParameter("dateOfBirth") != null) ? Date.valueOf(request.getParameter("dateOfBirth")) : null;

        //handing image blob
        Part part = request.getPart("pfp");
        InputStream inputStream = part.getInputStream();
        Blob pfp;
        try {
            pfp = new javax.sql.rowset.serial.SerialBlob(inputStream.readAllBytes());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // creating hashedPassword
        String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt());


        // Validation for common fields
        if (firstName == null || firstName.isEmpty()) {
            request.setAttribute("error", "First name is required.");
request.getRequestDispatcher(registerPage).forward(request, response);            return;
        }
        if (lastName == null || lastName.isEmpty()) {
            request.setAttribute("error", "Last name is required.");
request.getRequestDispatcher(registerPage).forward(request, response);            return;
        }
        if (email == null || email.isEmpty() || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) {
            request.setAttribute("error", "Valid email is required.");
request.getRequestDispatcher(registerPage).forward(request, response);            return;
        }
        if (phone == null || phone.isEmpty() || !phone.matches("\\d+")) {
            request.setAttribute("error", "Valid phone number is required.");
request.getRequestDispatcher(registerPage).forward(request, response);            return;
        }
        if (role == null || (!role.equalsIgnoreCase("PATIENT") && !role.equalsIgnoreCase("DOCTOR"))) {
            request.setAttribute("error", "Role must be PATIENT or DOCTOR.");
request.getRequestDispatcher(registerPage).forward(request, response);            return;
        }
        if (dateOfBirth == null || dateOfBirth.after(new java.util.Date())) {
            request.setAttribute("error", "Date of Birth must be a valid past date.");
request.getRequestDispatcher(registerPage).forward(request, response);            return;
        }

        // Generate UUID for the user
        UUID id = UUID.randomUUID();

        User user = null; //makes sure user var exists

        // Role-specific logic for Doctor and Patient
        if (role.equalsIgnoreCase("DOCTOR")) {
            String degree = request.getParameter("degree");
            String specialization = request.getParameter("specialization");
            Float fee = (request.getParameter("fee") != null) ? Float.valueOf(request.getParameter("fee")) : null;
            Boolean isAvailable = (request.getParameter("isAvailable") != null) ? Boolean.valueOf(request.getParameter("isAvailable")) : null;

            // Validation for Doctor-specific fields
            if (degree == null || degree.isEmpty()) {
                request.setAttribute("error", "Degree is required for doctors.");
                request.getRequestDispatcher(registerPage).forward(request,response);
                return;
            }
            if (specialization == null || specialization.isEmpty()) {
                request.setAttribute("error", "Specialization is required for doctors.");
                request.getRequestDispatcher(registerPage).forward(request,response);
                return;
            }
            if (fee == null || fee <= 0) {
                request.setAttribute("error", "Valid fee is required.");
                request.getRequestDispatcher(registerPage).forward(request,response);
                return;
            }
            if (isAvailable == null) {
                request.setAttribute("error", "Availability status is required.");
                request.getRequestDispatcher(registerPage).forward(request,response);
                return;
            }

            // Create Doctor object
            user = new Doctor(id, firstName, lastName, email, passwordHash, address, phone, pfp, gender, dateOfBirth, degree, specialization, fee, isAvailable);

        } else if (role.equalsIgnoreCase("PATIENT")) {
            String bloodGroup = request.getParameter("bloodGroup");

            // Create Patient object
            user = new Patient(id, firstName, lastName, email, passwordHash, address, phone, pfp, gender, dateOfBirth, bloodGroup );
        }

        // Save the user to the database
        UserDAO userDAO = new UserDAO();
        if (user == null) {
           System.out.println("user is null");
            return;
        }
        UserStatus status = userDAO.addUser(user);

        // Set appropriate response based on the operation status
        response.setContentType("text/plain");
        if (status == UserStatus.SUCCESS) {
            response.sendRedirect("/login");
        } else if (status == UserStatus.EMAIL_ALREADY_EXISTS) {
            request.setAttribute("error", "Email already exists.");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);

        } else if (status == UserStatus.PHONE_ALREADY_EXISTS) {
            request.setAttribute("error", "Phone number already exists.");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);

        } else {
            request.setAttribute("error", "Internal server error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
        }
    }


}