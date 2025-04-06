package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.UUID;

import model.User;
import org.mindrot.jbcrypt.BCrypt;
import utils.UserStatus;
import utils.UserAuthentication;

public class UserDAO {
    //database credentials
    private static final String url = "jdbc:mysql://localhost:8080/users";
    private static final String username = "root";
    private static final String password = "";

    /*create jdbc connection */
    static Connection getConnection() {
        try{Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, username, password);
        }catch (ClassNotFoundException | SQLException err){
            System.out.println(err.getMessage());
        }
        return null;
    }

    /*add user*/
    public UserStatus addUser(User user) {
        //convert plaintext password to hashPassword
        String plaintextPassword = user.getPassword();  // The user's plaintext password
        String passwordHash = BCrypt.hashpw(plaintextPassword, BCrypt.gensalt());
        user.setPasswordHash(passwordHash);

        String checkExisingSql = "SELECT COUNT(*) FROM users WHERE email = ? OR phone = ?";
        String sql = "INSERT INTO users (firstName, lastName, email, passwordHash, address, phone, role, pfp, gender, dateOfBirth, degree, specialization, fee, isAvailable) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            // Check if user with same email or phone already exists
            try (Connection conn = getConnection();
                    PreparedStatement checkStmt = conn.prepareStatement(checkExisingSql)) {
                checkStmt.setString(1, user.getEmail());
                checkStmt.setString(2, user.getPhone());
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    if (rs.getString("email") == user.getEmail()) {
                        return  UserStatus.EMAIL_ALREADY_EXISTS;
                    }
                    if (rs.getString("phone") == user.getPhone()) {
                        return  UserStatus.PHONE_ALREADY_EXISTS;
                    }
                }
            }catch (SQLException err){
                err.printStackTrace();
            }

            try (Connection conn = getConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, user.getFirstName());
            stmt.setString(2, user.getLastName());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPasswordHash());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getPhone());
            stmt.setString(7, user.getRole());
            stmt.setBytes(8, user.getPfp());
            stmt.setString(9, user.getGender());
            stmt.setDate(10, new java.sql.Date(user.getDateOfBirth().getTime()));

            // Conditionals for doctor user type
            if (user.getDegree() != null) {
                stmt.setString(11, user.getDegree());
            }else {
                stmt.setNull(11, Types.VARCHAR);
            }
            if (user.getSpecialization() != null) {
                stmt.setString(12, user.getSpecialization());
            } else {
                stmt.setNull(12, Types.VARCHAR);
            }
            if (user.getFee() != null) {
                stmt.setFloat(13, user.getFee());
            } else {
                stmt.setNull(13, Types.FLOAT);
            }
            if (user.getAvailable() != null) {
                    stmt.setBoolean(14, user.getAvailable());
            } else {
                stmt.setNull(14, Types.BOOLEAN);
            }

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                return UserStatus.SUCCESS;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            }
            return UserStatus.INTERNAL_SERVER_ERROR;
    }
    
/* get user by id*/
public User getUserById(UUID id) {
    String sql = "SELECT * FROM users WHERE id = ?";
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, id.toString());
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            return new User(
                    UUID.fromString(rs.getString("id")),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("passwordHash"),
                    rs.getString("address"),
                    rs.getString("phone"),
                    rs.getString("role"),
                    rs.getBytes("pfp"),
                    rs.getString("gender"),
                    rs.getDate("dateOfBirth"),
                    rs.getString("degree"),
                    rs.getString("specialization"),
                    rs.getObject("fee", Float.class), //Wrapper class handling for possible null value
                    rs.getBoolean("isAvailable")
            );
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

/*get all users without their password*/
public ArrayList<User> getAllUsers() {
    ArrayList<User> users = new ArrayList<>();
    String sql = "SELECT * FROM users";
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)){

        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            users.add(new User(
                    UUID.fromString(rs.getString("id")),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("address"),
                    rs.getString("phone"),
                    rs.getString("role"),
                    rs.getBytes("pfp"),
                    rs.getString("gender"),
                    rs.getDate("dateOfBirth"),
                    rs.getString("degree"),
                    rs.getString("specialization"),
                    rs.getObject("fee", Float.class),
                    rs.getBoolean("isAvailable")
            ));
        }
    }
    catch (SQLException e){
        e.printStackTrace();
    }
    return users;
}

/*update user*/
public boolean updateUser(User user) {
    String sql = "UPDATE users SET firstName=?, lastName=?, email=?, address=?, phone=?, role=?, pfp=?, gender=?, dateOfBirth=?, degree=?, specialization=?, fee=?, isAvailable=? WHERE id=?";
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, user.getFirstName());
        stmt.setString(2, user.getLastName());
        stmt.setString(3, user.getEmail());
        stmt.setString(4, user.getAddress());
        stmt.setString(5, user.getPhone());
        stmt.setString(6, user.getRole());
        stmt.setBytes(7, user.getPfp());
        stmt.setString(8, user.getGender());
        stmt.setDate(9, user.getDateOfBirth());
        stmt.setString(10, user.getDegree());
        stmt.setString(11, user.getSpecialization());
        stmt.setObject(12, user.getFee());
        stmt.setBoolean(13, user.getAvailable());
        stmt.setString(14, user.getId().toString());

        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected > 0) {
            return true;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

/* delete user*/
public boolean deleteUser(UUID id) {
    String sql = "DELETE FROM users WHERE id=?";
    try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, id.toString());

        int rowsAffected = stmt.executeUpdate();
        if (rowsAffected > 0) {
            return true;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}

/**login method using email and password returns null if invalid*/
public User loginUser(String email, String password) {
    
    boolean isAuthenticated = UserAuthentication.authenticateUser(email, password); // check auth
    
    //if user is authenticated try loggin in 
    if (isAuthenticated) {
    String sql = "SELECT * FROM users WHERE email = ?";
    
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, email);
     
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return new User(
                    UUID.fromString(rs.getString("id")),
                    rs.getString("firstName"),
                    rs.getString("lastName"),
                    rs.getString("email"),
                    rs.getString("passwordHash"),
                    rs.getString("address"),
                    rs.getString("phone"),
                    rs.getString("role"),
                    rs.getBytes("pfp"),
                    rs.getString("gender"),
                    rs.getDate("dateOfBirth"),
                    rs.getString("degree"),
                    rs.getString("specialization"),
                    rs.getObject("fee", Float.class),
                    rs.getBoolean("isAvailable")
            );
        }
    
    } catch (SQLException e) {
        e.printStackTrace();
    }}
    return null;
}

public void changePassword(String oldPassword, String newPassword) {
    //todo
}
}



