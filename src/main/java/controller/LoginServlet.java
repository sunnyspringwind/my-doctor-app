package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import dao.UserDAO;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //get login details from frontend
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String passwordHash = BCrypt.hashpw(password, BCrypt.gensalt()); //hash user input password

        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(username, passwordHash);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("/home");
        }
    }
}