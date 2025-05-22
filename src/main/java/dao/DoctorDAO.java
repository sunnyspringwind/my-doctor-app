package dao;

import model.Doctor;
import utils.DBUtil;
import org.mindrot.jbcrypt.BCrypt;
import utils.StatusCode;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class DoctorDAO implements IDoctorDAO {

    @Override
    public StatusCode addDoctor(Doctor doctor) {
        String checkExistingSql = "SELECT COUNT(*) as count FROM Doctor WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement checkStmt = conn.prepareStatement(checkExistingSql)) {
            checkStmt.setString(1, doctor.getEmail());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt("count") > 0) {
                return StatusCode.EMAIL_ALREADY_EXISTS;
            }
        } catch (SQLException err) {
            err.printStackTrace();
            return StatusCode.INTERNAL_SERVER_ERROR;
        }

        String sql = "INSERT INTO Doctor (doctorId, name, email, password, speciality, experience, fees, degree, " +
                "isAvailable, pfp, address, about) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Make sure doctorId is already set (done in factory )
            stmt.setString(1, doctor.getDoctorId().toString());
            stmt.setString(2, doctor.getName());
            stmt.setString(3, doctor.getEmail());
            stmt.setString(4, doctor.getPasswordHash()); // Already hashed
            stmt.setString(5, doctor.getSpeciality());
            stmt.setInt(6, doctor.getExperience());
            stmt.setFloat(7, doctor.getFees());
            stmt.setString(8, doctor.getDegree());
            stmt.setBoolean(9, doctor.isAvailable());
            stmt.setBytes(10, doctor.getPfp());
            stmt.setString(11, doctor.getAddress());
            stmt.setString(12, doctor.getAbout());

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
    public Doctor getDoctorById(UUID doctorId) {
        System.out.println("DoctorDAO: Getting doctor by ID: " + doctorId);
        String sql = "SELECT * FROM Doctor WHERE doctorId = ?";
        try (Connection conn = DBUtil.getConnection()) {
            System.out.println("DoctorDAO: Database connection established");
            
            if (conn == null) {
                System.err.println("DoctorDAO: Database connection is null");
                return null;
            }

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, doctorId.toString());
                System.out.println("DoctorDAO: Executing query with ID: " + doctorId);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        Doctor doctor = createDoctorFromResultSet(rs);
                        System.out.println("DoctorDAO: Found doctor: " + doctor.toString());
                        return doctor;
                    } else {
                        System.err.println("DoctorDAO: No doctor found for ID: " + doctorId);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("DoctorDAO: SQL error getting doctor: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("DoctorDAO: Error getting doctor: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Doctor getDoctorByEmail(String email) {
        String sql = "SELECT * FROM Doctor WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return createDoctorFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Doctor> getAllDoctors() {
        System.out.println("DoctorDAO: Starting getAllDoctors method");
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT * FROM Doctor";

        try (Connection conn = DBUtil.getConnection()) {
            System.out.println("DoctorDAO: Database connection established");

            try (Statement stmt = conn.createStatement()) {
                System.out.println("DoctorDAO: Executing query: " + sql);

                try (ResultSet rs = stmt.executeQuery(sql)) {
                    while (rs.next()) {
                        Doctor doctor = createDoctorFromResultSet(rs);
                        doctors.add(doctor);
                        System.out.println("DoctorDAO: Added doctor: " + doctor.toString());
                    }
                }
            }

            System.out.println("DoctorDAO: Retrieved " + doctors.size() + " doctors");
            return doctors;

        } catch (SQLException e) {
            System.err.println("DoctorDAO: Error in getAllDoctors: " + e.getMessage());
            e.printStackTrace();
        }
        return doctors;
    }

    @Override
    public List<Doctor> getDoctorsBySpeciality(String speciality) {
        System.out.println("DoctorDAO: Starting getDoctorsBySpeciality method for speciality: " + speciality);
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT * FROM Doctor WHERE speciality = ?";

        try (Connection conn = DBUtil.getConnection()) {
            System.out.println("DoctorDAO: Database connection established");

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, speciality);
                System.out.println("DoctorDAO: Executing query with speciality: " + speciality);

                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Doctor doctor = createDoctorFromResultSet(rs);
                        doctors.add(doctor);
                        System.out.println("DoctorDAO: Added doctor: " + doctor.toString());
                    }
                }
            }

            System.out.println("DoctorDAO: Retrieved " + doctors.size() + " doctors for speciality: " + speciality);
            return doctors;

        } catch (SQLException e) {
            System.err.println("DoctorDAO: Error in getDoctorsBySpeciality: " + e.getMessage());
            e.printStackTrace();
        }
        return doctors;
    }

    @Override
    public boolean updateDoctor(Doctor doctor) {
        String sql = "UPDATE Doctor SET name=?, email=?, speciality=?, experience=?, " +
                "fees=?, degree=?, isAvailable=?, pfp=?, address=?, about=? WHERE doctorId=?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, doctor.getName());
            stmt.setString(2, doctor.getEmail());
            stmt.setString(3, doctor.getSpeciality());
            stmt.setInt(4, doctor.getExperience());
            stmt.setFloat(5, doctor.getFees());
            stmt.setString(6, doctor.getDegree());
            stmt.setBoolean(7, doctor.isAvailable());
            stmt.setBytes(8, doctor.getPfp());
            stmt.setString(9, doctor.getAddress());
            stmt.setString(10, doctor.getAbout());
            stmt.setString(11, doctor.getDoctorId().toString());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateDoctorPassword(UUID doctorId, String oldPassword, String newPassword) {
        Doctor doctor = getDoctorById(doctorId);
        if (doctor == null) {
            return false;
        }

        if (!BCrypt.checkpw(oldPassword, doctor.getPasswordHash())) {
            return false;
        }

        String newPasswordHash = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        String sql = "UPDATE Doctor SET password = ? WHERE doctorId = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newPasswordHash);
            stmt.setString(2, doctorId.toString());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteDoctor(UUID doctorId) {
        String sql = "DELETE FROM Doctor WHERE doctorId=?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, doctorId.toString());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Doctor createDoctorFromResultSet(ResultSet rs) throws SQLException {
        System.out.println("DoctorDAO: Creating Doctor object from ResultSet");
        Doctor doctor = new Doctor();
        doctor.setDoctorId(UUID.fromString(rs.getString("doctorId")));
        doctor.setName(rs.getString("name"));
        doctor.setEmail(rs.getString("email"));
        doctor.setPasswordHash(rs.getString("password"));
        doctor.setSpeciality(rs.getString("speciality"));
        doctor.setExperience(rs.getInt("experience"));
        doctor.setFees(rs.getFloat("fees"));
        doctor.setDegree(rs.getString("degree"));
        doctor.setAvailable(rs.getBoolean("isAvailable"));
        byte[] pfpBytes = rs.getBytes("pfp"); // Retrieve bytes
        doctor.setPfp(pfpBytes); // Set bytes on the Doctor object

        // Add printout here to check if pfpBytes is populated
        if (pfpBytes != null && pfpBytes.length > 0) {
            System.out.println("DoctorDAO: PFP byte array length in createDoctorFromResultSet: " + pfpBytes.length);
        } else {
            System.out.println("DoctorDAO: PFP byte array is NULL or EMPTY in createDoctorFromResultSet.");
        }

        doctor.setAddress(rs.getString("address"));
        doctor.setAbout(rs.getString("about"));
        System.out.println("DoctorDAO: Created Doctor object: " + doctor.toString());
        return doctor;
    }
}
