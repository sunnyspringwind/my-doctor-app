package dao;

import model.Booking;
import model.DashboardStats;
import utils.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO {
    public DashboardStats getDashboardStats() throws SQLException {
        DashboardStats stats = new DashboardStats();
        
        try (Connection conn = DBUtil.getConnection()) {
            // Get total doctors count
            String doctorQuery = "SELECT COUNT(*) FROM Doctor";
            try (PreparedStatement stmt = conn.prepareStatement(doctorQuery)) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    stats.setTotalDoctors(rs.getInt(1));
                }
            }

            // Get total appointments count
            String appointmentQuery = "SELECT COUNT(*) FROM Appointment";
            try (PreparedStatement stmt = conn.prepareStatement(appointmentQuery)) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    stats.setTotalAppointments(rs.getInt(1));
                }
            }

            // Get total patients count
            String patientQuery = "SELECT COUNT(*) FROM Patient";
            try (PreparedStatement stmt = conn.prepareStatement(patientQuery)) {
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    stats.setTotalPatients(rs.getInt(1));
                }
            }

            // Get latest bookings
            System.out.println("DashboardDAO: Retrieving latest bookings");
            String bookingQuery = "SELECT a.appointmentId, d.name as doctor_name, d.pfp as doctor_image, d.speciality as doctor_speciality, d.address as doctor_address, " +
                                "a.appointmentTime, a.status " +
                                "FROM appointment a " +
                                "JOIN doctor d ON a.doctorId = d.doctorId " +
                                "ORDER BY a.appointmentTime DESC LIMIT 10;";
            
            System.out.println("DashboardDAO: Executing query: " + bookingQuery);
            List<Booking> latestBookings = new ArrayList<>();
            try (PreparedStatement stmt = conn.prepareStatement(bookingQuery)) {
                ResultSet rs = stmt.executeQuery();
                System.out.println("DashboardDAO: Query executed successfully");
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setId(rs.getInt("appointmentId"));
                    booking.setDoctorName(rs.getString("doctor_name"));
                    
                    // Handle the binary image data
                    byte[] imageBytes = rs.getBytes("doctor_image");
                    if (imageBytes != null && imageBytes.length > 0) {
                        String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                        booking.setDoctorImage(base64Image);
                    } else {
                        // Set a default image if no image is available
                        booking.setDoctorImage("");
                    }
                    
                    booking.setDate(rs.getString("appointmentTime"));
                    String status = rs.getString("status");
                    booking.setStatus(status);
                    booking.setCancelled(status.equalsIgnoreCase("CANCELLED"));
                    System.out.println("Booking: id=" + booking.getId() + ", status=" + status + ", cancelled=" + booking.isCancelled());
                    latestBookings.add(booking);
                    System.out.println("DashboardDAO: Added booking - ID: " + booking.getId() + ", Doctor: " + booking.getDoctorName() + ", Status: " + status);
                }
                System.out.println("DashboardDAO: Retrieved " + latestBookings.size() + " latest bookings");
            }
            stats.setLatestBookings(latestBookings);
        }
        return stats;
    }
} 