package model;

import java.sql.Date;
import java.sql.Blob;
import java.util.UUID;

public class Admin {
    private UUID adminId;
    private String email;
    private String passwordHash;
    private String role;
    private boolean isActive;
    private Date lastLogin;
    private Blob pfp;  // Profile picture (binary large object)

    // Default constructor
    public Admin() {}

    // Parameterized constructor
    public Admin(UUID adminId, String email, String passwordHash, String role, boolean isActive, Date lastLogin, Blob pfp) {
        this.adminId = adminId;
        this.email = email;
        this.passwordHash = passwordHash;
        this.role = role;
        this.isActive = isActive;
        this.lastLogin = lastLogin;
        this.pfp = pfp;
    }

    // Getters and Setters
    public UUID getAdminId() {
        return adminId;
    }

    public void setAdminId(UUID adminId) {
        this.adminId = adminId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }
    public Date getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }

    public Blob getPfp() {
        return pfp;
    }

    public void setPfp(Blob pfp) {
        this.pfp = pfp;
    }
}
