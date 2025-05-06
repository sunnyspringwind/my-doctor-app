package model;

import org.mindrot.jbcrypt.BCrypt;

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
    private byte[] pfp;
    private String address;
    private String about;

    // Default constructor
    public Doctor() {
    }

    // Parameterized constructor
    public Doctor(UUID doctorId, String name, String email, String passwordHash, String speciality,
            int experience, float fees, String degree, boolean isAvailable, byte[] pfp,
            String address, String about) {
        this.doctorId = doctorId;
        this.name = name;
        this.email = email;
        this.passwordHash = passwordHash;
        this.speciality = speciality;
        this.experience = experience;
        this.fees = fees;
        this.degree = degree;
        this.isAvailable = isAvailable;
        this.pfp = pfp;
        this.address = address;
        this.about = about;
    }

    // 🔐 1. Factory method for registration (add UUID, hashes the plain password)
    public static Doctor createFromRegistration(String name, String email, String plainPassword, String speciality,
            int experience, float fees, String degree, boolean isAvailable, byte[] pfp,
            String address, String about) {
        String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
        return new Doctor(UUID.randomUUID(), name, email, hashedPassword, speciality,
                experience, fees, degree, isAvailable, pfp, address, about);
    }

    public static Doctor createFromRegistration(String name, String email, String plainPassword) {
        return createFromRegistration(name, email, plainPassword, null, 0, 0, null, true, null, null, null);
    }

    // 🗂️ 2. Factory method for loading from the database (uses pre-hashed
    // password)
    public static Doctor createFromDatabase(UUID doctorId, String name, String email, String passwordHash,
            String speciality, int experience, float fees, String degree,
            boolean isAvailable, byte[] pfp, String address, String about) {
        return new Doctor(doctorId, name, email, passwordHash, speciality,
                experience, fees, degree, isAvailable, pfp, address, about);
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

    public byte[] getPfp() {
        return pfp;
    }

    public void setPfp(byte[] pfp) {
        this.pfp = pfp;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAbout() {
        return about;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    @Override
    public String toString() {
        return "Doctor{" +
                "doctorId=" + doctorId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", speciality='" + speciality + '\'' +
                ", experience=" + experience +
                ", available=" + isAvailable +
                ", fees=" + fees +
                ", degree='" + degree + '\'' +
                ", pfp=" + (pfp != null ? "present" : "null") +
                ", address='" + address + '\'' +
                ", about='" + about + '\'' +
                '}';
    }

}
