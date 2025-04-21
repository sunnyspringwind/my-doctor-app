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
    public StatusCode registerDoctor(String name, String email, String password) {
        // Check if the email already exists
        if (doctorDAO.getDoctorByEmail(email) != null) {
            return StatusCode.EMAIL_ALREADY_EXISTS;
        }
        // Create Doctor object
        Doctor doctor = Doctor.createFromRegistration(name,email,password);
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
//    public Doctor getDoctorById(UUID doctorId) {
//        return doctorDAO.getDoctorById(doctorId);
//    }

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
