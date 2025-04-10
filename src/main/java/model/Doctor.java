package model;
import java.sql.Blob;
import java.util.Date;
import java.util.UUID;

/**
 * Doctor class that extends User with doctor-specific attributes
 */
public class Doctor extends User {
    private String degree;
    private String specialization;
    private Float fee;
    private Boolean isAvailable;

    // Constructor with all fields including password
    public Doctor(UUID id, String firstName, String lastName, String email,
                  String passwordHash, String address, String phone,
                  Blob pfp, String gender, Date dateOfBirth,
                  String degree, String specialization, Float fee, Boolean isAvailable) {
        super(id, firstName, lastName, email, passwordHash, address, phone, "DOCTOR", pfp, gender, dateOfBirth);
        this.degree = degree;
        this.specialization = specialization;
        this.fee = fee;
        this.isAvailable = isAvailable;
    }

    // Constructor without password for view purposes
    public Doctor(UUID id, String firstName, String lastName, String email,
                  String address, String phone, Blob pfp, String gender,
                  Date dateOfBirth, String degree, String specialization, Float fee, Boolean isAvailable) {
        super(id, firstName, lastName, email, address, phone, "DOCTOR", pfp, gender, dateOfBirth);
        this.degree = degree;
        this.specialization = specialization;
        this.fee = fee;
        this.isAvailable = isAvailable;
    }

    // Getters and Setters for Doctor-specific fields
    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public Float getFee() {
        return fee;
    }

    public void setFee(Float fee) {
        this.fee = fee;
    }

    public Boolean getAvailable() {
        return isAvailable;
    }

    public void setAvailable(Boolean available) {
        this.isAvailable = available;
    }
}