package model;

import java.sql.Blob;
import java.util.Date;
import java.util.UUID;

/**
 * Patient class that extends User with patient-specific attributes
 */
public class Patient extends User {
    // Patient-specific attribute
    private String bloodGroup;

    // Constructor with all fields including password
    public Patient(UUID id, String firstName, String lastName, String email,
                   String passwordHash, String address, String phone,
                   Blob pfp, String gender, Date dateOfBirth,
                   String bloodGroup) {
        super(id, firstName, lastName, email, passwordHash, address, phone, "PATIENT", pfp, gender, dateOfBirth);
        this.bloodGroup = bloodGroup;
    }

    // Constructor without password for view purposes
    public Patient(UUID id, String firstName, String lastName, String email,
                   String address, String phone, Blob pfp, String gender,
                   Date dateOfBirth, String bloodGroup) {
        super(id, firstName, lastName, email, address, phone, "PATIENT", pfp, gender, dateOfBirth);
        this.bloodGroup = bloodGroup;
    }

    // Getter and Setter for bloodGroup
    public String getBloodGroup() {
        return bloodGroup;
    }

    public void setBloodGroup(String bloodGroup) {
        this.bloodGroup = bloodGroup;
    }
}