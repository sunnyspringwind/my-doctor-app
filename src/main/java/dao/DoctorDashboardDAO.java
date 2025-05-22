package dao;

import model.DashboardStats;
import model.Booking;
import utils.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDashboardDAO {
    public DashboardStats getDoctorDashboardStats(String doctorId) throws SQLException {
        DashboardStats stats = new DashboardStats();

        try (Connection conn = DBUtil.getConnection()) {
            // Get total appointments count for this doctor
            String appointmentQuery = "SELECT COUNT(*) FROM Appointment WHERE doctorId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(appointmentQuery)) {
                stmt.setString(1, doctorId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    stats.setTotalAppointments(rs.getInt(1));
                }
            }

            // Get total patients count for this doctor
            String patientQuery = "SELECT COUNT(DISTINCT patientId) FROM Appointment WHERE doctorId = ?";
            try (PreparedStatement stmt = conn.prepareStatement(patientQuery)) {
                stmt.setString(1, doctorId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    stats.setTotalPatients(rs.getInt(1));
                }
            }

            // Get total earnings for this doctor from paid transactions
            String earningsQuery = "SELECT COALESCE(SUM(p.amount), 0) " +
                    "FROM Payment p " +
                    "JOIN Appointment a ON p.appointmentId = a.appointmentId " +
                    "WHERE a.doctorId = ? AND p.status = 'PAID'";
            try (PreparedStatement stmt = conn.prepareStatement(earningsQuery)) {
                stmt.setString(1, doctorId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    stats.setTotalEarnings(rs.getFloat(1));
                }
            }

            // Get latest bookings for this doctor with payment details
            String bookingQuery = "SELECT a.appointmentId, p.name as patient_name, p.pfp as patient_image, " +
                    "a.appointmentTime, a.status, pay.amount as payment_amount, pay.status as payment_status " +
                    "FROM appointment a " +
                    "JOIN patient p ON a.patientId = p.patientId " +
                    "LEFT JOIN payment pay ON a.appointmentId = pay.appointmentId " +
                    "WHERE a.doctorId = ? " +
                    "ORDER BY a.appointmentTime DESC LIMIT 10";

            List<Booking> latestBookings = new ArrayList<>();
            try (PreparedStatement stmt = conn.prepareStatement(bookingQuery)) {
                stmt.setString(1, doctorId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setId(rs.getInt("appointmentId"));
                    booking.setDoctorName(rs.getString("patient_name"));

                    // Handle the binary image data
                    byte[] imageBytes = rs.getBytes("patient_image");
                    if (imageBytes != null && imageBytes.length > 0) {
                        String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                        booking.setDoctorImage(base64Image);
                    }

                    booking.setDate(rs.getString("appointmentTime"));
                    booking.setStatus(rs.getString("status"));
                    booking.setPayment(rs.getFloat("payment_amount"));
                    latestBookings.add(booking);
                }
            }
            stats.setLatestBookings(latestBookings);
        }
        return stats;
    }
}