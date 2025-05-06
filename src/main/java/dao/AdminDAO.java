package dao;

import model.Admin;
import utils.DBUtil;
import utils.StatusCode;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class AdminDAO implements IAdminDAO {

    public AdminDAO() {
        createDefaultAdmin();
    }

    private void createDefaultAdmin() {
        String checkSql = "SELECT COUNT(*) as count FROM Admin WHERE email = 'admin@mydoctorapp.com'";
        try (Connection conn = DBUtil.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(checkSql)) {

            if (rs.next() && rs.getInt("count") == 0) {
                // Default admin doesn't exist, create it
                String insertSql = "INSERT INTO Admin (adminId, email, password, role, isActive) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                    pstmt.setString(1, UUID.randomUUID().toString());
                    pstmt.setString(2, "admin@mydoctorapp.com");
                    pstmt.setString(3, BCrypt.hashpw("12345678", BCrypt.gensalt()));
                    pstmt.setString(4, "ADMIN");
                    pstmt.setBoolean(5, true);
                    pstmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public StatusCode addAdmin(Admin admin) {
        String checkExistingSql = "SELECT COUNT(*) as count FROM Admin WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement checkStmt = conn.prepareStatement(checkExistingSql)) {
            checkStmt.setString(1, admin.getEmail());
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt("count") > 0) {
                return StatusCode.EMAIL_ALREADY_EXISTS;
            }
        } catch (SQLException err) {
            err.printStackTrace();
            return StatusCode.INTERNAL_SERVER_ERROR;
        }

        String sql = "INSERT INTO Admin (adminId, email, password, role, isActive, lastLogin, pfp) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, admin.getAdminId().toString());
            stmt.setString(2, admin.getEmail());
            stmt.setString(3, admin.getPasswordHash());
            stmt.setString(4, admin.getRole());
            stmt.setBoolean(5, admin.isActive());
            stmt.setDate(6, admin.getLastLogin());
            stmt.setBlob(7, admin.getPfp());

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
    public Admin getAdminById(UUID adminId) {
        String sql = "SELECT * FROM Admin WHERE adminId = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, adminId.toString());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return createAdminFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Admin getAdminByEmail(String email) {
        String sql = "SELECT * FROM Admin WHERE email = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return createAdminFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Admin> getAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        String sql = "SELECT * FROM Admin";
        try (Connection conn = DBUtil.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                admins.add(createAdminFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admins;
    }

    @Override
    public boolean updateAdmin(Admin admin) {
        String sql = "UPDATE Admin SET email = ?, role = ?, isActive = ?, lastLogin = ?, pfp = ? WHERE adminId = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, admin.getEmail());
            stmt.setString(2, admin.getRole());
            stmt.setBoolean(3, admin.isActive());
            stmt.setDate(4, admin.getLastLogin());
            stmt.setBlob(5, admin.getPfp());
            stmt.setString(6, admin.getAdminId().toString());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateAdminPassword(UUID adminId, String oldPassword, String newPassword) {
        String sql = "UPDATE Admin SET password = ? WHERE adminId = ? AND password = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, BCrypt.hashpw(newPassword, BCrypt.gensalt()));
            stmt.setString(2, adminId.toString());
            stmt.setString(3, oldPassword);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteAdmin(UUID adminId) {
        String sql = "DELETE FROM Admin WHERE adminId = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, adminId.toString());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Admin createAdminFromResultSet(ResultSet rs) throws SQLException {
        Admin admin = new Admin();
        admin.setAdminId(UUID.fromString(rs.getString("adminId")));
        admin.setEmail(rs.getString("email"));
        admin.setPasswordHash(rs.getString("password"));
        admin.setRole(rs.getString("role"));
        admin.setActive(rs.getBoolean("isActive"));
        admin.setLastLogin(rs.getDate("lastLogin"));
        admin.setPfp(rs.getBlob("pfp"));
        return admin;
    }
}