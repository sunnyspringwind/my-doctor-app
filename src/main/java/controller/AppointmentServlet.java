package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.AppointmentService;
import service.DoctorService;
import dao.AppointmentDAO;
import dao.DoctorDAO;
import model.Appointment;
import model.Doctor;
import utils.StatusCode;
import utils.ServiceResponse;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.text.SimpleDateFormat;

@WebServlet("/appointment")
public class AppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AppointmentService appointmentService;
    private final DoctorService doctorService;
    private static final String[] DAYS = {"SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"};

    public AppointmentServlet() {
        this.appointmentService = new AppointmentService(new AppointmentDAO());
        this.doctorService = new DoctorService(new DoctorDAO());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // Store the current URL in session for redirect after login
            String redirectUrl = request.getRequestURI() + "?" + request.getQueryString();
            session = request.getSession(true);
            session.setAttribute("redirectAfterLogin", redirectUrl);
            
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String doctorId = request.getParameter("id");
        String dayIndexParam = request.getParameter("dayIndex");
        String selectedTime = request.getParameter("time");
        
        System.out.println("AppointmentServlet: Received doctor ID: " + doctorId);
        
        int selectedDayIndex = 0;
        if (dayIndexParam != null) {
            selectedDayIndex = Integer.parseInt(dayIndexParam);
        }

        if (doctorId != null) {
            try {
                // Fetch doctor details
                System.out.println("AppointmentServlet: Fetching doctor details for ID: " + doctorId);
                Doctor doctor = doctorService.getDoctorById(doctorId);
                
                if (doctor != null) {
                    System.out.println("AppointmentServlet: Found doctor: " + doctor.toString());
                    request.setAttribute("doctor", doctor);
                    // Fetch related doctors (same speciality, excluding current doctor)
                    List<Doctor> relatedDoctors = doctorService.getDoctorsBySpeciality(doctor.getSpeciality());
                    relatedDoctors.removeIf(d -> d.getDoctorId().equals(doctor.getDoctorId()));
                    request.setAttribute("relatedDoctors", relatedDoctors);
                    
                    // Generate available slots for next 7 days
                    List<List<TimeSlot>> availableSlots = generateAvailableSlots(doctorId);
                    request.setAttribute("availableSlots", availableSlots);
                    request.setAttribute("selectedDayIndex", selectedDayIndex);
                    request.setAttribute("selectedTime", selectedTime);
                    request.setAttribute("currencySymbol", "रू");

                    // If time is selected, prepare selected date
                    if (selectedTime != null) {
                        Calendar cal = Calendar.getInstance();
                        cal.add(Calendar.DAY_OF_MONTH, selectedDayIndex);
                        SimpleDateFormat dateFormat = new SimpleDateFormat("d-M-yyyy");
                        request.setAttribute("selectedDate", dateFormat.format(cal.getTime()));
                    }

                    request.getRequestDispatcher("/WEB-INF/view/Patient/appointment.jsp").forward(request, response);
                    return;
                } else {
                    System.err.println("AppointmentServlet: Doctor not found for ID: " + doctorId);
                    request.setAttribute("error", "Doctor not found");
                    response.sendRedirect(request.getContextPath() + "/doctors");
                    return;
                }
            } catch (Exception e) {
                System.err.println("AppointmentServlet: Error fetching doctor details: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "Error fetching doctor details: " + e.getMessage());
                response.sendRedirect(request.getContextPath() + "/doctors");
                return;
            }
        }
        
        // If we get here, no doctor ID was provided
        System.err.println("AppointmentServlet: No doctor ID provided");
        response.sendRedirect(request.getContextPath() + "/doctors");
    }

    private List<List<TimeSlot>> generateAvailableSlots(String doctorId) {
        List<List<TimeSlot>> weekSlots = new ArrayList<>();
        Calendar cal = Calendar.getInstance();
        
        // Get booked slots for this doctor
        List<Appointment> bookedAppointments = appointmentService.getAppointmentsByDoctorId(doctorId).getData();

        // Generate slots for next 7 days
        for (int day = 0; day < 7; day++) {
            List<TimeSlot> daySlots = new ArrayList<>();
            
            // Set time to 10:00 AM
            cal.set(Calendar.HOUR_OF_DAY, 10);
            cal.set(Calendar.MINUTE, 0);
            
            // Generate slots until 6:00 PM
            while (cal.get(Calendar.HOUR_OF_DAY) < 18) {
                TimeSlot slot = new TimeSlot();
                slot.setDayOfWeek(DAYS[cal.get(Calendar.DAY_OF_WEEK) - 1]);
                slot.setDate(cal.get(Calendar.DATE));
                
                SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");
                slot.setTime(timeFormat.format(cal.getTime()).toLowerCase());
                
                // Check if slot is already booked
                final Timestamp slotTime = new Timestamp(cal.getTimeInMillis());
                boolean isBooked = bookedAppointments.stream()
                    .anyMatch(apt -> apt.getAppointmentTime().equals(slotTime));
                
                if (!isBooked) {
                    daySlots.add(slot);
                }
                
                // Add 30 minutes for next slot
                cal.add(Calendar.MINUTE, 30);
            }
            
            weekSlots.add(daySlots);
            
            // Move to next day
            cal.add(Calendar.DAY_OF_MONTH, 1);
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
        }
        
        return weekSlots;
    }

    // Inner class to represent a time slot
    public static class TimeSlot {
        private String dayOfWeek;
        private int date;
        private String time;

        public String getDayOfWeek() { return dayOfWeek; }
        public void setDayOfWeek(String dayOfWeek) { this.dayOfWeek = dayOfWeek; }
        public int getDate() { return date; }
        public void setDate(int date) { this.date = date; }
        public String getTime() { return time; }
        public void setTime(String time) { this.time = time; }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is required");
            return;
        }

        switch (action) {
            case "create":
                createAppointment(request, response);
                break;
            case "update":
                updateAppointment(request, response);
                break;
            case "delete":
                deleteAppointment(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void createAppointment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Get patient from session
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            model.Patient patient = (model.Patient) session.getAttribute("user");
            if (patient == null) {
                System.err.println("Patient object is null in session");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
            
            System.out.println("Creating new appointment for patient ID: " + patient.getPatientId());
            
            Appointment appointment = new Appointment();
            appointment.setDoctorId(request.getParameter("doctorId"));
            appointment.setPatientId(patient.getPatientId().toString());
            appointment.setAppointmentTime(Timestamp.valueOf(request.getParameter("appointmentTime")));
            appointment.setStatus("PENDING");
            appointment.setReason(request.getParameter("reason"));
            appointment.setPayment(Float.parseFloat(request.getParameter("payment")));

            System.out.println("Appointment details: " + appointment.toString());

            StatusCode status = appointmentService.addAppointment(appointment);
            System.out.println("Appointment creation status: " + status);
            
            if (status == StatusCode.SUCCESS) {
                System.out.println("Appointment created successfully, redirecting to my-appointments");
                response.sendRedirect(request.getContextPath() + "/my-appointments?success=true");
            } else {
                System.out.println("Failed to create appointment: " + status);
                request.setAttribute("error", "Failed to create appointment: " + status);
                request.getRequestDispatcher("/WEB-INF/view/Patient/appointment.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.out.println("Error creating appointment: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error creating appointment: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/Patient/appointment.jsp").forward(request, response);
        }
    }

    private void updateAppointment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Clear any session messages
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("message");
            session.removeAttribute("messageType");
            session.removeAttribute("welcomeBack");  // Clear any welcome back message
        }
        
        try {
            String appointmentIdStr = request.getParameter("appointmentId");
            String status = request.getParameter("status");
            
            System.out.println("Updating appointment - ID: " + appointmentIdStr + ", Status: " + status);
            
            if (appointmentIdStr == null || appointmentIdStr.trim().isEmpty() || status == null || status.trim().isEmpty()) {
                System.out.println("Invalid parameters - appointmentId: " + appointmentIdStr + ", status: " + status);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid appointment ID or status\"}");
                return;
            }

            int appointmentId;
            try {
                appointmentId = Integer.parseInt(appointmentIdStr.trim());
                if (appointmentId <= 0) {
                    throw new NumberFormatException("ID must be positive");
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid appointment ID format: " + appointmentIdStr);
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid appointment ID format\"}");
                return;
            }

            boolean success = appointmentService.updateAppointmentStatus(appointmentId, status);
            
            if (success) {
                System.out.println("Successfully updated appointment " + appointmentId + " to status: " + status);
                response.getWriter().write("{\"success\": true, \"message\": \"Appointment updated successfully\"}");
            } else {
                System.out.println("Failed to update appointment " + appointmentId);
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to update appointment\"}");
            }
        } catch (Exception e) {
            System.err.println("Error updating appointment: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Server error: " + e.getMessage() + "\"}");
        }
    }

    private void deleteAppointment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            
            boolean success = appointmentService.deleteAppointment(appointmentId);
            
            if (success) {
                response.getWriter().write("{\"success\": true, \"message\": \"Appointment deleted successfully\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to delete appointment\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid appointment ID format\"}");
        } catch (Exception e) {
            System.err.println("Error deleting appointment: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Server error: " + e.getMessage() + "\"}");
        }
    }
} 