package model;
import java.sql.Blob;
import java.util.Date;
import java.util.UUID;

/**
 * Base User class containing common attributes and behaviors
 */
public abstract class User {
    private UUID id;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String passwordHash;
    private String address;
    private String phone;
    private String role;
    private Blob pfp;  // Changed to java.sql.Blob for database compatibility
    private String gender;
    private Date dateOfBirth;

    // Constructor with all common fields
    public User(UUID id, String firstName, String lastName, String email,
                String passwordHash, String address, String phone, String role,
                Blob pfp, String gender, Date dateOfBirth) {
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
    }

    // Constructor without password for view purposes
    public User(UUID id, String firstName, String lastName, String email,
                String address, String phone, String role, Blob pfp,
                String gender, Date dateOfBirth) {
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
    }

    // Getters and Setters for common fields
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

    public void setPassword(String password) {
        this.password = password;
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

    public Blob getPfp() {
        return pfp;
    }

    public void setPfp(Blob pfp) {
        this.pfp = pfp;
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

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", email='" + email + '\'' +
                ", passwordHash='" + passwordHash + '\'' +
                ", address='" + address + '\'' +
                ", phone='" + phone + '\'' +
                ", role='" + role + '\'' +
                ", pfp=" + pfp +
                ", gender='" + gender + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                '}';
    }

}