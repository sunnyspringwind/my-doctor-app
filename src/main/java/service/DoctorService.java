package service;

import dao.IDoctorDAO;
import model.Doctor;
import utils.StatusCode;
import org.mindrot.jbcrypt.BCrypt;

import java.util.List;
import java.util.UUID;

public class DoctorService implements IDoctorService {

    private final IDoctorDAO doctorDAO;

    public DoctorService(IDoctorDAO IdoctorDAO) {
        this.doctorDAO = IdoctorDAO;
    }

    // Register Doctor
    public StatusCode registerDoctor(Doctor doctor) {
        // Check if the email already exists
        if (doctorDAO.getDoctorByEmail(doctor.getEmail()) != null) {
            return StatusCode.EMAIL_ALREADY_EXISTS;
        }
        // Add doctor to the database
        return doctorDAO.addDoctor(doctor);
    }

    // Doctor Login
    public Doctor loginDoctor(String email, String password) {
        Doctor doctor = doctorDAO.getDoctorByEmail(email);
        if (doctor != null && BCrypt.checkpw(password, doctor.getPasswordHash())) {
            return doctor;  // Login successful
        }
        return null;  // Invalid credentials
    }

    // Update Doctor Profile
    public boolean updateDoctorProfile(Doctor updatedDoctor) {
        return doctorDAO.updateDoctor(updatedDoctor);
    }

    // Change Password
//    public boolean changeDoctorPassword(UUID doctorId, String oldPassword, String newPassword) {
//        Doctor doctor = doctorDAO.getDoctorById(doctorId);
//        if (doctor != null && BCrypt.checkpw(oldPassword, doctor.getPasswordHash())) {
//            String newPasswordHash = BCrypt.hashpw(newPassword, BCrypt.gensalt());
//            return doctorDAO.updateDoctorPassword(doctorId, oldPassword, newPasswordHash);
//        }
//        return false;
//    }

    // Get Doctor by ID
    public Doctor getDoctorById(String doctorId) {
        System.out.println("DoctorService: Getting doctor by ID: " + doctorId);
        try {
            UUID uuid = UUID.fromString(doctorId);
            System.out.println("DoctorService: Converted ID to UUID: " + uuid);
            Doctor doctor = doctorDAO.getDoctorById(uuid);
            if (doctor != null) {
                System.out.println("DoctorService: Found doctor: " + doctor.toString());
            } else {
                System.err.println("DoctorService: No doctor found for ID: " + doctorId);
            }
            return doctor;
        } catch (IllegalArgumentException e) {
            System.err.println("DoctorService: Invalid UUID format: " + doctorId);
            e.printStackTrace();
            return null;
        } catch (Exception e) {
            System.err.println("DoctorService: Error getting doctor: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Get Doctor by Email
//    public Doctor getDoctorByEmail(String email) {
//        return doctorDAO.getDoctorByEmail(email);
//    }

    // Get all Doctors
    public List<Doctor> getAllDoctors() {
        return doctorDAO.getAllDoctors();
    }

    // Get Doctors by Speciality
    public List<Doctor> getDoctorsBySpeciality(String speciality) {
        return doctorDAO.getDoctorsBySpeciality(speciality);
    }
}
