package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import model.Patient;
import utils.DBUtil;
import org.mindrot.jbcrypt.BCrypt;
import utils.StatusCode;

public class PatientDAO implements IPatientDAO {

    @Override
    public StatusCode addPatient(Patient patient) {
        // Check if patient with same email or phone already exists
        String checkExistingSql = "SELECT COUNT(*) as count, email, phone FROM patient WHERE email = ? OR phone = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkExistingSql)) {
            checkStmt.setString(1, patient.getEmail());
            checkStmt.setString(2, patient.getPhone());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt("count") > 0) {
                if (patient.getEmail().equals(rs.getString("email"))) {
                    return StatusCode.EMAIL_ALREADY_EXISTS;
                }
                if (patient.getPhone().equals(rs.getString("phone"))) {
                    return StatusCode.PHONE_ALREADY_EXISTS;
                }
            }
        } catch (SQLException err) {
            err.printStackTrace();
            return StatusCode.INTERNAL_SERVER_ERROR;
        }

        String sql = "INSERT INTO patient (patientId, name, email, password, phone, address, gender, dateOfBirth) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, String.valueOf(patient.getPatientId()));  // Use UUID as string
            stmt.setString(2, patient.getName());
            stmt.setString(3, patient.getEmail());
            stmt.setString(4, patient.getPasswordHash());
            stmt.setString(5, patient.getPhone());
            stmt.setString(6, patient.getAddress());
            stmt.setString(7, patient.getGender());
            stmt.setDate(8, patient.getDateOfBirth());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return StatusCode.SUCCESS;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return StatusCode.INTERNAL_SERVER_ERROR;
    }

    @Override
    public Patient getPatientById(String userId) {
        String sql = "SELECT * FROM Patient WHERE patientId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return createPatientFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Patient getPatientByEmail(String email) {
        String sql = "SELECT * FROM Patient WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return createPatientFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Patient getPatientByPhone(String phone) {
        String sql = "SELECT * FROM Patient WHERE phone = ?";
        try(Connection conn = DBUtil.getConnection();
        PreparedStatement ps = conn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return createPatientFromResultSet(rs);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM Patient";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                patients.add(createPatientFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patients;
    }

    @Override
    public boolean updatePatient(Patient patient) {
        String sql = "UPDATE Patient SET name=?, email=?, phone=?, address=?, gender=?, dateOfBirth=?, isActive=?, registrationDate=?, pfp=? " +
                "WHERE patientId=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, patient.getName());
            stmt.setString(2, patient.getEmail());
            stmt.setString(3, patient.getPhone());
            stmt.setString(4, patient.getAddress());
            stmt.setString(5, patient.getGender());
            stmt.setDate(6, patient.getDateOfBirth());
            stmt.setBoolean(7, patient.isActive());
            stmt.setDate(8, patient.getRegistrationDate());
            stmt.setBytes(9, patient.getPfp());
            stmt.setString(10, patient.getPatientId().toString());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updatePatientPassword(String patientId, String oldPassword, String newPassword) {
        // First verify the old password
        Patient patient = getPatientById(patientId);
        if (patient == null) {
            return false;
        }

        if (!BCrypt.checkpw(oldPassword, patient.getPasswordHash())) {
            return false; // Old password doesn't match
        }

        // Hash the new password
        String newPasswordHash = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        // Update the password in the database
        String sql = "UPDATE Patient SET password = ? WHERE patientId = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newPasswordHash);
            stmt.setString(2, patientId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deletePatient(String patientId) {
        String sql = "DELETE FROM Patient WHERE patientId=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, patientId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Patient loginPatient(String email, String password) {
        String sql = "SELECT * FROM patient WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password");
                if (BCrypt.checkpw(password, hashedPassword)) {
                    return createPatientFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Patient createPatientFromResultSet(ResultSet rs) throws SQLException {
        Patient patient = new Patient();
        patient.setPatientId(UUID.fromString(rs.getString("patientId")));
        patient.setName(rs.getString("name"));
        patient.setEmail(rs.getString("email"));
        patient.setPasswordHash(rs.getString("password"));
        patient.setPhone(rs.getString("phone"));
        patient.setAddress(rs.getString("address"));
        patient.setGender(rs.getString("gender"));
        patient.setDateOfBirth(rs.getDate("dateOfBirth"));
        patient.setActive(rs.getBoolean("isActive"));
        patient.setRegistrationDate(rs.getDate("registrationDate"));
        return patient;
    }
}
