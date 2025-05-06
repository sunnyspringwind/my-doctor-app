package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.Gson;

@WebServlet("/check-session")
public class SessionCheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(new SessionResponse(isLoggedIn));
        
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }
    
    private static class SessionResponse {
        @com.google.gson.annotations.SerializedName("loggedIn")
        private boolean loggedIn;
        
        public SessionResponse(boolean loggedIn) {
            this.loggedIn = loggedIn;
        }
    }
} 