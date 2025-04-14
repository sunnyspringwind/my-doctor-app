package model;

import java.sql.Blob;
import java.util.UUID;

public class Doctor {
    private UUID doctorId;
    private String name;
    private String email;
    private String passwordHash;
    private String speciality;
    private int experience;
    private float fees;
    private String degree;
    private boolean isAvailable;
    private String imageUrl;
    private Blob pfp;  // Profile picture (binary large object)

    // Default constructor
    public Doctor() {}

    // Parameterized constructor
    public Doctor(UUID doctorId, String name, String email, String passwordHash, String speciality,
                  int experience, float fees, String degree, boolean isAvailable, String imageUrl, Blob pfp) {
        this.doctorId = doctorId;
        this.name = name;
        this.email = email;
        this.passwordHash = passwordHash;
        this.speciality = speciality;
        this.experience = experience;
        this.fees = fees;
        this.degree = degree;
        this.isAvailable = isAvailable;
        this.imageUrl = imageUrl;
        this.pfp = pfp;
    }

    // Getters and Setters
    public UUID getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(UUID doctorId) {
        this.doctorId = doctorId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getSpeciality() {
        return speciality;
    }

    public void setSpeciality(String speciality) {
        this.speciality = speciality;
    }

    public int getExperience() {
        return experience;
    }

    public void setExperience(int experience) {
        this.experience = experience;
    }

    public float getFees() {
        return fees;
    }

    public void setFees(float fees) {
        this.fees = fees;
    }

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Blob getPfp() {
        return pfp;
    }

    public void setPfp(Blob pfp) {
        this.pfp = pfp;
    }
}
