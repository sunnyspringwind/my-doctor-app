package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter({"/dashboard/*", "/profile/*"}) // Protects these pages
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false);  // Don't create a new session
        if (session == null || session.getAttribute("user") == null) {
            // No session or user is not logged in, redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        } else {
            // User is logged in, allow request to continue
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Cleanup resources if needed
    }
}
