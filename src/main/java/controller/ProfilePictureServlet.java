package controller;

import dao.DoctorDAO;
import dao.IDoctorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Doctor;

import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

@WebServlet(name = "ProfilePictureServlet", urlPatterns = {"/pfp"})
public class ProfilePictureServlet extends HttpServlet {
    IDoctorDAO doctorDAO = new DoctorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("role");
        String userIdParam = request.getParameter("userId");

        if (role == null || userIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing role or userId parameter");
            return;
        }

        try {
            UUID userId = UUID.fromString(userIdParam);

            if (role.equals("doctor")) {
                Doctor doctor = doctorDAO.getDoctorById(userId);
                if (doctor != null && doctor.getPfp() != null) {
                    byte[] imageData = doctor.getPfp();
                    response.setContentType("image/jpeg");
                    response.setContentLength(imageData.length);
                    OutputStream out = response.getOutputStream();
                    out.write(imageData);
                    out.flush();
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Doctor or image not found");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid role");
            }
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid UUID format");
        }
    }
}
