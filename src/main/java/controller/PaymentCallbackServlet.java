package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Logger;
import java.util.logging.Level;
import dao.PaymentDAO;
import dao.AppointmentDAO;
import model.Payment;
import utils.PaymentStatus;

@WebServlet("/payment-callback")
public class PaymentCallbackServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(PaymentCallbackServlet.class.getName());
    private PaymentDAO paymentDAO;
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Log the incoming request parameters
        LOGGER.info("Received payment callback with parameters:");
        request.getParameterMap().forEach((key, value) -> 
            LOGGER.info(key + ": " + String.join(", ", value))
        );

        try {
            // Get payment details from request
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
                            appointmentDAO.updateAppointmentStatus(appointmentId, "PAID");
                            
                            // Set success message
                            HttpSession session = request.getSession();
                            session.setAttribute("message", "Payment successful!");
                            session.setAttribute("messageType", "success");
                            
                            // Redirect to my-appointments with correct port and context path
                            response.sendRedirect("http://localhost:8081/MyDoctorApp_war_exploded/my-appointments");
                            return;
                        }
                    }
                }
            }
            
            // If we reach here, something went wrong
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Payment verification failed");
            
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error processing payment callback", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error processing payment callback: " + e.getMessage());
        }
    }
} 