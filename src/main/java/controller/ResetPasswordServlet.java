package controller;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import service.EmailSender;
import utils.UserAuthentication;

import java.io.IOException;

@WebServlet(name = "PasswordServlet", value = "/reset-password")
public class ResetPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get email attribute
        String email = request.getParameter("email");

        //Create user and find user in db
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email);
        if (user != null) {
            EmailSender emailSender = new EmailSender();
            emailSender.passwordResetMail(email);
            response.sendRedirect(request.getContextPath()+"/reset-password");
        }
        else {
            request.setAttribute("error", "Invalid email");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }
    }
}