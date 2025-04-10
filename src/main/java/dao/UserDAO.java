package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import model.Doctor;
import model.Patient;
import model.User;
import utils.DBConnectionUtil;
import org.mindrot.jbcrypt.BCrypt;
import utils.UserStatus;
import utils.UserAuthentication;

public class UserDAO {

//    public static void main(String[] args) {
//        // Create a mock Doctor object
//        Doctor mockDoctor = new Doctor(
//                UUID.randomUUID(),
//                "John",
//                "Doe",
//                "john.doe@example.com",
//                BCrypt.hashpw("password123", BCrypt.gensalt()),
//                "1234 Elm Street",
//                "1234567890",
//                null, // Assuming profile picture is null for this test
//                "Male",
//                java.sql.Date.valueOf("1980-01-01"),
//                "MBBS",
//                "Cardiology",
//                500.0f,
//                true
//        );
//
//        // Instantiate UserDAO and test adding the Doctor
//        UserDAO userDAO = new UserDAO();
//        UserStatus status = userDAO.addUser(mockDoctor);
//
//        // Output the result
//        System.out.println("Doctor addition status: " + status);
//    }

    /* Add user - handles both Doctor and Patient types */
    public UserStatus addUser(User user) {

        // Check if user with same email or phone already exists
        String checkExisingSql = "SELECT COUNT(*) as count, email, phone FROM users WHERE email = ? OR phone = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkExisingSql)) {
            checkStmt.setString(1, user.getEmail());
            checkStmt.setString(2, user.getPhone());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt("count") > 0) {
                if (user.getEmail().equals(rs.getString("email"))) {
                    return UserStatus.EMAIL_ALREADY_EXISTS;
                }
                if (user.getPhone().equals(rs.getString("phone"))) {
                    return UserStatus.PHONE_ALREADY_EXISTS;
                }
            }
        } catch (SQLException err) {
            err.printStackTrace();
            return UserStatus.INTERNAL_SERVER_ERROR;
        }

        // Insert user based on their role
        if (user instanceof Doctor) {
            return addDoctorUser((Doctor) user);
        } else if (user instanceof Patient) {
            return addPatientUser((Patient) user);
        } else {
            return UserStatus.INTERNAL_SERVER_ERROR;
        }
    }

    /* Helper method to add a doctor */
    private UserStatus addDoctorUser(Doctor doctor) {
        String sql = "INSERT INTO users (id, firstName, lastName, email, passwordHash, address, phone, role, pfp, " +
                "gender, dateOfBirth, degree, specialization, fee, isAvailable) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            UUID userId = doctor.getId() != null ? doctor.getId() : UUID.randomUUID();
            stmt.setString(1, userId.toString());
            stmt.setString(2, doctor.getFirstName());
            stmt.setString(3, doctor.getLastName());
            stmt.setString(4, doctor.getEmail());
            stmt.setString(5, doctor.getPasswordHash());
            stmt.setString(6, doctor.getAddress());
            stmt.setString(7, doctor.getPhone());
            stmt.setString(8, doctor.getRole());
            stmt.setBlob(9, doctor.getPfp());
            stmt.setString(10, doctor.getGender());
            stmt.setDate(11, new java.sql.Date(doctor.getDateOfBirth().getTime()));
            stmt.setString(12, doctor.getDegree());
            stmt.setString(13, doctor.getSpecialization());
            stmt.setFloat(14, doctor.getFee());
            stmt.setBoolean(15, doctor.getAvailable());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return UserStatus.SUCCESS;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return UserStatus.INTERNAL_SERVER_ERROR;
    }

    /* Helper method to add a patient */
    private UserStatus addPatientUser(Patient patient) {
        String sql = "INSERT INTO users (id, firstName, lastName, email, passwordHash, address, phone, role, pfp, " +
                "gender, dateOfBirth, bloodGroup ) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            UUID userId = patient.getId() != null ? patient.getId() : UUID.randomUUID();
            stmt.setString(1, userId.toString());
            stmt.setString(2, patient.getFirstName());
            stmt.setString(3, patient.getLastName());
            stmt.setString(4, patient.getEmail());
            stmt.setString(5, patient.getPasswordHash());
            stmt.setString(6, patient.getAddress());
            stmt.setString(7, patient.getPhone());
            stmt.setString(8, patient.getRole());
            stmt.setBlob(9, patient.getPfp());
            stmt.setString(10, patient.getGender());
            stmt.setDate(11, new java.sql.Date(patient.getDateOfBirth().getTime()));
            stmt.setString(12, patient.getBloodGroup());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return UserStatus.SUCCESS;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return UserStatus.INTERNAL_SERVER_ERROR;
    }

    /* Get user by id - returns either Doctor or Patient based on role */
    public User getUserById(UUID id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id.toString());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                if ("DOCTOR".equals(role)) {
                    return createDoctorFromResultSet(rs);
                } else if ("PATIENT".equals(role)) {
                    return createPatientFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Get user by email - returns either Doctor or Patient based on role
     *
     * @param email the email of the user to retrieve
     * @return User object if found, else null
     */
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            System.out.println(email);

            if (rs.next()) {
                String role = rs.getString("role");
                if ("DOCTOR".equals(role)) {
                    System.out.println(rs.getString("email"));
                    return createDoctorFromResultSet(rs);
                } else if ("PATIENT".equals(role)) {
                    return createPatientFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    /* Get all users without their password */
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String role = rs.getString("role");
                if ("DOCTOR".equals(role)) {
                    users.add(createDoctorFromResultSet(rs));
                } else if ("PATIENT".equals(role)) {
                    users.add(createPatientFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    /* Get all doctors */
    public List<Doctor> getAllDoctors() {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'DOCTOR'";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                doctors.add(createDoctorFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return doctors;
    }

    /* Get all patients */
    public List<Patient> getAllPatients() {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role = 'PATIENT'";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                patients.add(createPatientFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patients;
    }

    /* Update user - handles both Doctor and Patient types */
    public boolean updateUser(User user) {
        if (user instanceof Doctor) {
            return updateDoctor((Doctor) user);
        } else if (user instanceof Patient) {
            return updatePatient((Patient) user);
        }
        return false;
    }

    /* Helper method to update a doctor */
    private boolean updateDoctor(Doctor doctor) {
        String sql = "UPDATE users SET firstName=?, lastName=?, email=?, address=?, phone=?, pfp=?, " +
                "gender=?, dateOfBirth=?, degree=?, specialization=?, fee=?, isAvailable=? WHERE id=?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, doctor.getFirstName());
            stmt.setString(2, doctor.getLastName());
            stmt.setString(3, doctor.getEmail());
            stmt.setString(4, doctor.getAddress());
            stmt.setString(5, doctor.getPhone());
            stmt.setBlob(6, doctor.getPfp());
            stmt.setString(7, doctor.getGender());
            stmt.setDate(8, new java.sql.Date(doctor.getDateOfBirth().getTime()));
            stmt.setString(9, doctor.getDegree());
            stmt.setString(10, doctor.getSpecialization());
            stmt.setFloat(11, doctor.getFee());
            stmt.setBoolean(12, doctor.getAvailable());
            stmt.setString(13, doctor.getId().toString());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /* Helper method to update a patient */
    private boolean updatePatient(Patient patient) {
        String sql = "UPDATE users SET firstName=?, lastName=?, email=?, address=?, phone=?, pfp=?, " +
                "gender=?, dateOfBirth=?, bloodGroup=? WHERE id=?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, patient.getFirstName());
            stmt.setString(2, patient.getLastName());
            stmt.setString(3, patient.getEmail());
            stmt.setString(4, patient.getAddress());
            stmt.setString(5, patient.getPhone());
            stmt.setBlob(6, patient.getPfp());
            stmt.setString(7, patient.getGender());
            stmt.setDate(8, new java.sql.Date(patient.getDateOfBirth().getTime()));
            stmt.setString(9, patient.getBloodGroup());
            stmt.setString(10, patient.getId().toString());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /* Delete user */
    public boolean deleteUser(UUID id) {
        String sql = "DELETE FROM users WHERE id=?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id.toString());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /* Login method using email and password */
    public User loginUser(String email, String password) {
        User user = getUserByEmail(email);

        String hashedPassword = user.getPasswordHash();
        boolean isAuthenticated = UserAuthentication.authenticateUser(password, hashedPassword);

        if (isAuthenticated) {
            String sql = "SELECT * FROM users WHERE email = ?";

            try (Connection conn = DBConnectionUtil.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, email);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    String role = rs.getString("role");
                    if ("DOCTOR".equals(role)) {
                        return createDoctorFromResultSet(rs);
                    } else if ("PATIENT".equals(role)) {
                        return createPatientFromResultSet(rs);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    /* Update password */
    public boolean changePassword(UUID userId, String oldPassword, String newPassword) {
        // First verify the old password
        User user = getUserById(userId);
        if (user == null) {
            return false;
        }

        if (!BCrypt.checkpw(oldPassword, user.getPasswordHash())) {
            return false; // Old password doesn't match
        }

        // Hash the new password
        String newPasswordHash = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        // Update the password in the database
        String sql = "UPDATE users SET passwordHash = ? WHERE id = ?";
        try (Connection conn = DBConnectionUtil.getConnection()) {
            assert conn != null;
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setString(1, newPasswordHash);
                stmt.setString(2, userId.toString());

                int rowsAffected = stmt.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /* Helper method to create a Doctor from a ResultSet */
    private Doctor createDoctorFromResultSet(ResultSet rs) throws SQLException {
        return new Doctor(
                UUID.fromString(rs.getString("id")),
                rs.getString("firstName"),
                rs.getString("lastName"),
                rs.getString("email"),
                rs.getString("passwordHash"),
                rs.getString("address"),
                rs.getString("phone"),
                rs.getBlob("pfp"),
                rs.getString("gender"),
                rs.getDate("dateOfBirth"),
                rs.getString("degree"),
                rs.getString("specialization"),
                rs.getFloat("fee"),
                rs.getBoolean("isAvailable")
        );
    }

    /* Helper method to create a Patient from a ResultSet */
    private Patient createPatientFromResultSet(ResultSet rs) throws SQLException {
        return new Patient(
                UUID.fromString(rs.getString("id")),
                rs.getString("firstName"),
                rs.getString("lastName"),
                rs.getString("email"),
                rs.getString("passwordHash"),
                rs.getString("address"),
                rs.getString("phone"),
                rs.getBlob("pfp"),
                rs.getString("gender"),
                rs.getDate("dateOfBirth"),
                rs.getString("bloodGroup")
        );
    }


}