package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Payment;
import dao.PaymentDAO;
import dao.AppointmentDAO;
import utils.PaymentMode;
import utils.PaymentStatus;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.sql.Date;
import java.time.LocalDate;

@WebServlet("/payment/*")
public class PaymentController extends HttpServlet {
    private static final String KHALTI_SECRET_KEY = "5012e30be0ba4e679a95c6eeb9d2d10b"; // Your live secret key
    private static final String KHALTI_VERIFY_URL = "https://khalti.com/api/v2/payment/verify/";
    private PaymentDAO paymentDAO;

    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getPathInfo();
        
        if ("/initiate".equals(action)) {
            initiatePayment(request, response);
        } else if ("/verify".equals(action)) {
            verifyPayment(request, response);
        } else if ("/callback".equals(action)) {
            handleCallback(request, response);
        }
    }

    private void initiatePayment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            float amount = Float.parseFloat(request.getParameter("amount"));
            
            // Create payment record
            Payment payment = new Payment();
            payment.setAppointmentId(appointmentId);
            payment.setAmount(amount);
            payment.setPaymentMode(PaymentMode.KHALTI);
            payment.setStatus(PaymentStatus.PENDING);
            payment.setDate(Date.valueOf(LocalDate.now()));
            
            boolean success = paymentDAO.makePayment(payment);
            
            if (success) {
                // Return success response with payment details
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":true,\"paymentId\":" + payment.getPaymentId() + "}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\":false,\"message\":\"Failed to create payment\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    private void verifyPayment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String token = request.getParameter("token");
            int paymentId = Integer.parseInt(request.getParameter("paymentId"));
            
            // Verify payment with Khalti
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest verifyRequest = HttpRequest.newBuilder()
                .uri(URI.create(KHALTI_VERIFY_URL))
                .header("Authorization", "Key " + KHALTI_SECRET_KEY)
                .POST(HttpRequest.BodyPublishers.ofString("token=" + token))
                .build();

            HttpResponse<String> verifyResponse = client.send(verifyRequest, 
                HttpResponse.BodyHandlers.ofString());

            if (verifyResponse.statusCode() == 200) {
                // Update payment status
                Payment payment = new Payment();
                payment.setPaymentId(paymentId);
                payment.setStatus(PaymentStatus.PAID);
                payment.setTransactionId(token);
                
                boolean success = paymentDAO.updatePayment(payment);
                
                if (success) {
                    // Get the appointment ID from the payment
                    Payment updatedPayment = paymentDAO.getPaymentByAppointmentId(payment.getAppointmentId());
                    if (updatedPayment != null) {
                        // Update appointment status to PAID
                        AppointmentDAO appointmentDAO = new AppointmentDAO();
                        appointmentDAO.updateAppointmentStatus(updatedPayment.getAppointmentId(), "PAID");
                    }
                    
                    // Set success message in session
                    HttpSession session = request.getSession();
                    session.setAttribute("message", "Payment successful!");
                    session.setAttribute("messageType", "success");
                    
                    // Redirect to my-appointments
                    response.sendRedirect(request.getContextPath() + "/my-appointments");
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("{\"success\":false,\"message\":\"Failed to update payment\"}");
                }
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\":false,\"message\":\"Payment verification failed\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    private void handleCallback(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String pidx = request.getParameter("pidx");
            String transactionId = request.getParameter("transaction_id");
            String status = request.getParameter("status");
            String purchaseOrderId = request.getParameter("purchase_order_id");
            
            if ("Completed".equals(status)) {
                // Extract appointment ID from purchase_order_id (format: APPOINTMENT-{id})
                String[] parts = purchaseOrderId.split("-");
                if (parts.length == 2) {
                    int appointmentId = Integer.parseInt(parts[1]);
                    
                    // Get payment by appointment ID
                    Payment payment = paymentDAO.getPaymentByAppointmentId(appointmentId);
                    if (payment != null) {
                        // Update payment status
                        payment.setStatus(PaymentStatus.PAID);
                        payment.setTransactionId(transactionId);
                        boolean success = paymentDAO.updatePayment(payment);
                        
                        if (success) {
                            // Update appointment status
                            AppointmentDAO appointmentDAO = new AppointmentDAO();
                            appointmentDAO.updateAppointmentStatus(appointmentId, "PAID");
                            
                            // Set success message
                            HttpSession session = request.getSession();
                            session.setAttribute("message", "Payment successful!");
                            session.setAttribute("messageType", "success");
                            
                            // Redirect to my-appointments
                            response.sendRedirect(request.getContextPath() + "/my-appointments");
                            return;
                        }
                    }
                }
            }
            
            // If we reach here, something went wrong
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false,\"message\":\"Payment verification failed\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }
} 