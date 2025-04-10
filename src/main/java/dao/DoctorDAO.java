//package dao;
//
//import model.Doctor;
//import utils.DBConnectionUtil;
//
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.UUID;
//
//public class DoctorDAO {
//
//    /**
//     * Add a doctor to the `doctors` table.
//     */
//    public boolean addDoctor(Doctor doctor) {
//        String query = "INSERT INTO doctors (user_id, degree, specialization, fee, is_available) "
//                     + "VALUES (?, ?, ?, ?, ?)";
//        try (Connection conn = DBConnectionUtil.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(query)) {
//
//            stmt.setString(1, doctor.getId().toString());
//            stmt.setString(2, doctor.getDegree());
//            stmt.setString(3, doctor.getSpecialization());
//            stmt.setBigDecimal(4, doctor.getFee());
//            stmt.setBoolean(5, doctor.isAvailable());
//            return stmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
//
//    /**
//     * Get a doctor by their user ID.
//     */
//    public Doctor getDoctorById(UUID id) {
//        String query = "SELECT * FROM doctors d JOIN users u ON d.user_id = u.id WHERE d.user_id = ?";
//        try (Connection conn = DBConnectionUtil.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(query)) {
//
//            stmt.setString(1, id.toString());
//            ResultSet rs = stmt.executeQuery();
//
//            if (rs.next()) {
//                return createDoctorFromResultSet(rs);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    /**
//     * Get all doctors.
//     */
//    public List<Doctor> getAllDoctors() {
//        List<Doctor> doctors = new ArrayList<>();
//        String query = "SELECT * FROM doctors d JOIN users u ON d.user_id = u.id";
//        try (Connection conn = DBConnectionUtil.getConnection();
//             PreparedStatement stmt = conn.prepareStatement(query)) {
//
//            ResultSet rs = stmt.executeQuery();
//            while (rs.next()) {
//                doctors.add(createDoctorFromResultSet(rs));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return doctors;
//    }
//
//    /**
//     * Helper method to create a Doctor object from a ResultSet.
//     */
//    private Doctor createDoctorFromResultSet(ResultSet rs) throws SQLException {
//        Doctor doctor = new Doctor();
//        doctor.setId(UUID.fromString(rs.getString("user_id")));
//        doctor.setFirstName(rs.getString("first_name"));
//        doctor.setLastName(rs.getString("last_name"));
//        doctor.setEmail(rs.getString("email"));
//        doctor.setPhone(rs.getString("phone"));
//        doctor.setDegree(rs.getString("degree"));
//        doctor.setSpecialization(rs.getString("specialization"));
//        doctor.setFee(rs.getBigDecimal("fee"));
//        doctor.setAvailable(rs.getBoolean("is_available"));
//        return doctor;
//    }
//
//    // Add update and delete methods for doctors
//}