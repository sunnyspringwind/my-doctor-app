package model;
import java.util.Date;
import java.util.UUID;

@SuppressWarnings("unused")
public class User {
    private UUID id;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String passwordHash;
    private String address;
    private String phone;
    private String role;
    private byte[] pfp;
    private String gender;
    private Date dateOfBirth;

    //additional attribute for doctor user
    private String degree;
    private String specialization;
    private Float fee;
    private Boolean isAvailable;


    //Constructor
    public User(UUID id, String firstName, String lastName, String email, String passwordHash, String address, String phone, String role, byte[] pfp, String gender, Date dateOfBirth, String degree, String specialization, Float fee, Boolean isAvailable) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.passwordHash = passwordHash;
        this.address = address;
        this.phone = phone;
        this.role = role;
        this.pfp = pfp;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.degree = degree;
        this.specialization = specialization;
        this.fee = fee;
        this.isAvailable = isAvailable;
    }

    //Constructor for user view without password
    public User(UUID id, String firstName, String lastName, String email, String address, String phone, String role, byte[] pfp, String gender, Date dateOfBirth, String degree, String specialization, Float fee, Boolean isAvailable) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.address = address;
        this.phone = phone;
        this.role = role;
        this.pfp = pfp;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.degree = degree;
        this.specialization = specialization;
        this.fee = fee;
        this.isAvailable = isAvailable;
    }

    // Getters Setters

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public byte[] getPfp() {
        return pfp;
    }

    public void setPfp(byte[] pfp) {
        this.pfp = pfp;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
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

    public void setPassword(String password) {
        this.password = password;
    }

    public java.sql.Date getDateOfBirth() {
        return (java.sql.Date) dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public Boolean getAvailable() {
        return isAvailable;
    }

    public void setAvailable(Boolean available) {
        isAvailable = available;
    }
}
