package dao;

import model.Appointment;
import utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    public boolean createAppointment(Appointment appointment) {
        String sql = "INSERT INTO appointments (doctor_id, patient_id, appointment_time, status, reason, payment) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, appointment.getDoctorId());
                stmt.setString(2, appointment.getPatientId());
                stmt.setTimestamp(3, appointment.getAppointmentTime());
                stmt.setString(4, appointment.getStatus());
                stmt.setString(5, appointment.getReason());
                stmt.setFloat(6, appointment.getPayment());

                int rows = stmt.executeUpdate();
                return rows > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Appointment getAppointmentById(int appointmentId) {
        String sql = "SELECT * FROM appointments WHERE appointment_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setInt(1, appointmentId);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        return mapResultSetToAppointment(rs);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Appointment> getAllAppointments() {
        List<Appointment> appointmentList = new ArrayList<>();
        String sql = "SELECT * FROM appointments ORDER BY appointment_time";

        try (Connection conn = DBConnectionUtil.getConnection()) {
            assert conn != null;
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {

                while (rs.next()) {
                    appointmentList.add(mapResultSetToAppointment(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentList;
    }

    public List<Appointment> getAppointmentsByDoctorId(String doctorId) {
        List<Appointment> appointmentList = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE doctor_id = ? ORDER BY appointment_time";

        try (Connection conn = DBConnectionUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, doctorId);

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        appointmentList.add(mapResultSetToAppointment(rs));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentList;
    }

    public List<Appointment> getAppointmentsByPatientId(String patientId) {
        List<Appointment> appointmentList = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE patient_id = ? ORDER BY appointment_time";

        try (Connection conn = DBConnectionUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, patientId);

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        appointmentList.add(mapResultSetToAppointment(rs));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentList;
    }

    public List<Appointment> getAppointmentsByDateRange(Timestamp startDate, Timestamp endDate) {
        List<Appointment> appointmentList = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE appointment_time BETWEEN ? AND ? ORDER BY appointment_time";

        try (Connection conn = DBConnectionUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setTimestamp(1, startDate);
                stmt.setTimestamp(2, endDate);

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        appointmentList.add(mapResultSetToAppointment(rs));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentList;
    }

    public List<Appointment> getAppointmentsByStatus(String status) {
        List<Appointment> appointmentList = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE status = ? ORDER BY appointment_time";

        try (Connection conn = DBConnectionUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, status);

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        appointmentList.add(mapResultSetToAppointment(rs));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentList;
    }

    public boolean updateAppointment(Appointment appointment) {
        String sql = "UPDATE appointments SET doctor_id = ?, patient_id = ?, appointment_time = ?, " +
                "status = ?, reason = ?, payment = ? WHERE appointment_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, appointment.getDoctorId());
                stmt.setString(2, appointment.getPatientId());
                stmt.setTimestamp(3, appointment.getAppointmentTime());
                stmt.setString(4, appointment.getStatus());
                stmt.setString(5, appointment.getReason());
                stmt.setFloat(6, appointment.getPayment());
                stmt.setInt(7, appointment.getAppointmentId());

                int rows = stmt.executeUpdate();
                return rows > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateAppointmentStatus(int appointmentId, String status) {
        String sql = "UPDATE appointments SET status = ? WHERE appointment_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, status);
                stmt.setInt(2, appointmentId);

                int rows = stmt.executeUpdate();
                return rows > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteAppointment(int appointmentId) {
        String sql = "DELETE FROM appointments WHERE appointment_id = ?";

        try (Connection conn = DBConnectionUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setInt(1, appointmentId);

                int rows = stmt.executeUpdate();
                return rows > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Utility method to map ResultSet to Appointment object
    private Appointment mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(rs.getInt("appointment_Id"));
        appointment.setDoctorId(rs.getString("doctor_id"));
        appointment.setPatientId(rs.getString("patient_id"));
        appointment.setAppointmentTime(rs.getTimestamp("appointment_time"));
        appointment.setStatus(rs.getString("status"));
        appointment.setReason(rs.getString("reason"));
        appointment.setPayment(rs.getFloat("payment"));
        return appointment;
    }
}