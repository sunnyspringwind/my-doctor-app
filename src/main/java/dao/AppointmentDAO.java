package dao;

import model.Appointment;
import model.DoctorData;
import utils.DBUtil;
import utils.StatusCode;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Base64;
import java.time.format.DateTimeFormatter;

public class AppointmentDAO implements IAppointmentDAO {

    @Override
    public StatusCode insertAppointment(Appointment appointment) {
        String sql = "INSERT INTO appointment (doctorId, patientId, appointmentTime, status, reason, payment) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, appointment.getDoctorId());
            ps.setString(2, appointment.getPatientId());
            ps.setTimestamp(3, appointment.getAppointmentTime());
            ps.setString(4, appointment.getStatus());
            ps.setString(5, appointment.getReason());
            ps.setFloat(6, appointment.getPayment());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return StatusCode.SUCCESS;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return StatusCode.APPOINTMENT_CREATION_FAILED;
    }

    @Override
    public List<Appointment> getAllAppointments() {
        String sql = "SELECT a.*, d.name as doctor_name, d.pfp as doctor_image, d.speciality as doctor_speciality, d.address as doctor_address, "
                +
                "p.name as patient_name " +
                "FROM appointment a " +
                "JOIN doctor d ON a.doctorId = d.doctorId " +
                "JOIN patient p ON a.patientId = p.patientId " +
                "ORDER BY a.appointmentTime DESC";

        List<Appointment> appointments = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            System.out.println("Executing getAllAppointments query");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment appointment = mapResultSetToAppointment(rs);
                appointment.setPatientName(rs.getString("patient_name"));
                appointments.add(appointment);
                System.out.println("Found appointment: ID=" + appointment.getAppointmentId() +
                        ", Doctor=" + appointment.getDocData().getName() +
                        ", Patient=" + appointment.getPatientName() +
                        ", Time=" + appointment.getAppointmentTime());
            }

            System.out.println("Total appointments found: " + appointments.size());

        } catch (SQLException e) {
            System.err.println("Error in getAllAppointments: " + e.getMessage());
            e.printStackTrace();
        }
        return appointments;
    }

    @Override
    public Appointment getAppointmentById(int id) {
        String sql = "SELECT a.*, " +
                "d.name as doctor_name, d.pfp as doctor_image, d.speciality as doctor_speciality, d.address as doctor_address "
                +
                "FROM appointment a " +
                "JOIN doctor d ON a.doctorId = CAST(d.doctorId as VARCHAR(255)) " +
                "WHERE a.appointmentId = ?";
        Appointment appointment = null;
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                appointment = mapResultSetToAppointment(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointment;
    }

    @Override
    public List<Appointment> getAppointmentByDoctorId(String doctorId) {
        String sql = "SELECT a.*, d.name as doctor_name, d.pfp as doctor_image, d.speciality as doctor_speciality, d.address as doctor_address FROM appointment a "
                +
                "JOIN doctor d ON a.doctorId = CAST(d.doctorId as VARCHAR) " +
                "WHERE a.doctorId = ? ORDER BY a.appointmentTime";
        List<Appointment> appointmentList = new ArrayList<>();
        return getAppointments(doctorId, appointmentList, sql);
    }

    @Override
    public List<Appointment> getAppointmentsByPatientId(String patientId) {
        String sql = "SELECT a.*, " +
                "d.name as doctor_name, d.pfp as doctor_image, d.speciality as doctor_speciality, d.address as doctor_address "
                +
                "FROM appointment a " +
                "JOIN doctor d ON a.doctorId = CAST(d.doctorId as VARCHAR(255)) " +
                "WHERE a.patientId = ? ORDER BY a.appointmentTime";
        List<Appointment> appointmentList = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            System.out.println("Executing query for patient ID: " + patientId);
            ps.setString(1, patientId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                System.out.println("Found appointment with ID: " + rs.getInt("appointmentId"));
                appointmentList.add(mapResultSetToAppointment(rs));
            }
            System.out.println("Total appointments found: " + appointmentList.size());
        } catch (SQLException e) {
            System.out.println("Error executing query: " + e.getMessage());
            e.printStackTrace();
        }
        return appointmentList;
    }

    @Override
    public StatusCode updateAppointmentStatus(int appointmentId, String status) {
        String sql = "UPDATE appointment SET status = ? WHERE appointmentId = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, appointmentId);
            int rows = stmt.executeUpdate();
            return rows > 0 ? StatusCode.SUCCESS : StatusCode.APPOINTMENT_UPDATE_FAILED;
        } catch (SQLException e) {
            e.printStackTrace();
            return StatusCode.INTERNAL_SERVER_ERROR;
        }
    }

    @Override
    public StatusCode deleteAppointment(int appointmentId) {
        String sql = "DELETE FROM appointment WHERE appointmentId = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, appointmentId);
            int rows = stmt.executeUpdate();
            return rows > 0 ? StatusCode.SUCCESS : StatusCode.APPOINTMENT_DELETION_FAILED;
        } catch (SQLException e) {
            e.printStackTrace();
            return StatusCode.INTERNAL_SERVER_ERROR;
        }
    }

    @Override
    public StatusCode doesAppointmentExist(String doctorId, Timestamp appointmentTime) {
        String sql = "SELECT 1 FROM appointment WHERE appointmentTime = ? AND doctorId = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, appointmentTime);
            ps.setString(2, doctorId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return StatusCode.APPOINTMENT_ALREADY_EXISTS;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return StatusCode.INTERNAL_SERVER_ERROR;
        }
        return StatusCode.NOT_FOUND;
    }

    private static List<Appointment> getAppointments(String userId, List<Appointment> appointmentList, String sql) {
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                appointmentList.add(mapResultSetToAppointment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointmentList;
    }

    private static Appointment mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(rs.getInt("appointmentId"));
        appointment.setDoctorId(rs.getString("doctorId"));
        appointment.setPatientId(rs.getString("patientId"));
        appointment.setAppointmentTime(rs.getTimestamp("appointmentTime"));
        appointment.setStatus(rs.getString("status"));
        appointment.setReason(rs.getString("reason"));
        appointment.setPayment(rs.getFloat("payment"));
        appointment.setSlotDate(rs.getTimestamp("appointmentTime").toLocalDateTime()
                .format(DateTimeFormatter.ofPattern("MMM dd, yyyy hh:mm a")));
        appointment.setCancelled(rs.getString("status").equalsIgnoreCase("CANCELLED"));

        // Set doctor data
        DoctorData docData = new DoctorData();
        docData.setName(rs.getString("doctor_name"));
        byte[] imageBytes = rs.getBytes("doctor_image");
        docData.setImage(imageBytes != null ? Base64.getEncoder().encodeToString(imageBytes) : null);
        docData.setSpeciality(rs.getString("doctor_speciality"));
        docData.setAddress(rs.getString("doctor_address"));
        appointment.setDocData(docData);

        return appointment;
    }
}
