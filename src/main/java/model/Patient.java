package model;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.Date;
import java.util.UUID;

public class Patient {
    private UUID patientId;
    private String name;
    private String email;
    private String passwordHash;
    private String phone;
    private String address;
    private String gender;
    private Date dateOfBirth;
    private boolean isActive;
    private Date registrationDate;
    private byte[] pfp;

    // Default constructor
    public Patient() {
    }

    // Parameterized constructor
    public Patient(UUID patientId, String name, String email, String passwordHash, String phone,
            String address, String gender, Date dateOfBirth, boolean isActive, Date registrationDate, byte[] pfp) {
        this.patientId = patientId;
        this.name = name;
        this.email = email;
        this.passwordHash = passwordHash;
        this.phone = phone;
        this.address = address;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.isActive = isActive;
        this.registrationDate = registrationDate;
        this.pfp = pfp;
    }

    public static Patient createFromRegistration(String name, String email, String plainPassword) {
        String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
        return new Patient(
                UUID.randomUUID(),
                name,
                email,
                hashedPassword,
                null, // phone
                null, // address
                null, // gender
                null, // dateOfBirth
                true, // isActive
                new Date(System.currentTimeMillis()), // registrationDate
                null // pfp
        );
    }

    public static Patient createFromDatabase(UUID patientId, String name, String email, String passwordHash,
            String phone, String address, String gender, Date dateOfBirth,
            boolean isActive, Date registrationDate, byte[] pfp) {
        return new Patient(patientId, name, email, passwordHash, phone, address, gender,
                dateOfBirth, isActive, registrationDate, pfp);
    }

    // Getters and Setters
    public UUID getPatientId() {
        return patientId;
    }

    public void setPatientId(UUID patientId) {
        this.patientId = patientId;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public byte[] getPfp() {
        return pfp;
    }

    public void setPfp(byte[] pfp) {
        this.pfp = pfp;
    }
}
