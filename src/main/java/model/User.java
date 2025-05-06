package model;

import java.sql.Blob;

public class User {
    private String email;
    private String hashedPassword;  // Store only the hashed password
    private boolean isActive;
    private Blob pfp;

    // Default constructor
    public User() {}

    // Parameterized constructor
    public User(String email, String passwordHash, boolean isActive, Blob pfp) {
        this.email = email;
        this.hashedPassword = passwordHash;  // Hash password before saving
        this.isActive = isActive;
        this.pfp = pfp;
    }

    // Getters and Setters
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHashedPassword() {
        return hashedPassword;
    }

    public void setHashedPassword(String hashedPassword) {
        this.hashedPassword = hashedPassword;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Blob getPfp() {
        return pfp;
    }

    public void setPfp(Blob pfp) {
        this.pfp = pfp;
    }
}
