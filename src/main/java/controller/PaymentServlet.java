package controller;

// This project is a demo project. The payment integration is mocked for demonstration purposes.

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.AppointmentService;
import dao.AppointmentDAO;
import dao.PaymentDAO;
import model.Appointment;
import model.Payment;
import utils.PaymentMode;
import utils.PaymentStatus;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.sql.Date;
import java.time.LocalDate;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

@WebServlet("/initiate-payment")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AppointmentService appointmentService;
    private final PaymentDAO paymentDAO;
    private final Gson gson = new Gson();
    private final HttpClient httpClient = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_1_1)
            .connectTimeout(Duration.ofSeconds(10))
            .build();

    // TODO: Replace with your actual Khalti Test Secret Key
    private static final String KHALTI_SECRET_KEY = "5012e30be0ba4e679a95c6eeb9d2d10b"; 
    private static final String KHALTI_INITIATE_URL = "https://dev.khalti.com/api/v2/epayment/initiate/";

    public PaymentServlet() {
        this.appointmentService = new AppointmentService(new AppointmentDAO());
        this.paymentDAO = new PaymentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            sendErrorResponse(response, "User not logged in");
            return;
        }

        String appointmentId = request.getParameter("appointmentId");
        if (appointmentId == null || appointmentId.trim().isEmpty()) {
            sendErrorResponse(response, "Appointment ID is required");
            return;
        }

        try {
            // Get appointment details
            Appointment appointment = appointmentService.getAppointmentById(Integer.parseInt(appointmentId)).getData();
            if (appointment == null) {
                sendErrorResponse(response, "Appointment not found");
                return;
            }

            // Create payment record in database
            Payment payment = new Payment();
            payment.setAppointmentId(appointment.getAppointmentId());
            payment.setAmount(appointment.getFees());
            payment.setPaymentMode(PaymentMode.KHALTI);
            payment.setStatus(PaymentStatus.PENDING);
            payment.setDate(Date.valueOf(LocalDate.now()));
            
            boolean paymentCreated = paymentDAO.makePayment(payment);
            if (!paymentCreated) {
                sendErrorResponse(response, "Failed to create payment record");
                return;
            }

            // Construct the Khalti payment initiation request body
            Map<String, Object> khaltiRequestBody = new HashMap<>();
            // Amount in Paisa (multiply by 100)
            khaltiRequestBody.put("amount", (int) (appointment.getFees() * 100)); 
            khaltiRequestBody.put("purchase_order_id", "APPOINTMENT-" + appointment.getAppointmentId()); // Unique identifier
            khaltiRequestBody.put("purchase_order_name", "Doctor Appointment");
            
            // Set the correct return URL with port 8081 and context path
            khaltiRequestBody.put("return_url", "http://localhost:8081/MyDoctorApp_war_exploded/payment-callback"); 
            khaltiRequestBody.put("website_url", "http://localhost:8081/MyDoctorApp_war_exploded/"); 

            String jsonRequestBody = gson.toJson(khaltiRequestBody);

            // Build the HTTP request to Khalti API
            HttpRequest khaltiRequest = HttpRequest.newBuilder()
                    .uri(URI.create(KHALTI_INITIATE_URL))
                    .header("Authorization", "Key " + KHALTI_SECRET_KEY)
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(jsonRequestBody))
                    .build();

            // Send the request and get the response
            HttpResponse<String> khaltiResponse = httpClient.send(khaltiRequest, HttpResponse.BodyHandlers.ofString());

            // Process the response from Khalti
            if (khaltiResponse.statusCode() == 200) {
                Map<String, Object> khaltiResponseData = gson.fromJson(khaltiResponse.body(), new com.google.gson.reflect.TypeToken<Map<String, Object>>(){}.getType());
                Map<String, Object> responseData = new HashMap<>();
                responseData.put("success", true);
                responseData.put("payment_url", khaltiResponseData.get("payment_url")); 

                response.getWriter().write(gson.toJson(responseData));
            } else {
                // Handle error response from Khalti
                System.err.println("Error initiating Khalti payment: " + khaltiResponse.body());
                sendErrorResponse(response, "Failed to initiate payment with Khalti");
            }

        } catch (Exception e) {
            System.err.println("Error processing payment initiation: " + e.getMessage());
            e.printStackTrace();
            sendErrorResponse(response, "Error processing payment");
        }
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        Map<String, Object> errorResponse = new HashMap<>();
        errorResponse.put("success", false);
        errorResponse.put("message", message);
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        response.getWriter().write(gson.toJson(errorResponse));
    }
} 