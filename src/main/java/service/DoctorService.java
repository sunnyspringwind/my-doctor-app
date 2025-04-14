package service;

import dao.IDoctorDAO;
import model.Doctor;
import utils.StatusCode;
import org.mindrot.jbcrypt.BCrypt;

import java.util.List;
import java.util.UUID;

public class DoctorService {

    private final IDoctorDAO doctorDAO;

    public DoctorService(IDoctorDAO IdoctorDAO) {
        this.doctorDAO = IdoctorDAO;
    }

    // Register Doctor
    public StatusCode registerDoctor(Doctor doctor) {
        if (doctorDAO.getDoctorByEmail(doctor.getEmail()) != null) {
            return StatusCode.EMAIL_ALREADY_EXISTS;
        }

        // Hash the password before saving
        doctor.setPasswordHash(BCrypt.hashpw(doctor.getPasswordHash(), BCrypt.gensalt()));
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
    public boolean changeDoctorPassword(UUID doctorId, String oldPassword, String newPassword) {
        Doctor doctor = doctorDAO.getDoctorById(doctorId);
        if (doctor != null && BCrypt.checkpw(oldPassword, doctor.getPasswordHash())) {
            String newPasswordHash = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            return doctorDAO.updateDoctorPassword(doctorId, oldPassword, newPasswordHash);
        }
        return false;
    }

    // Get Doctor by ID
    public Doctor getDoctorById(UUID doctorId) {
        return doctorDAO.getDoctorById(doctorId);
    }

    // Get Doctor by Email
    public Doctor getDoctorByEmail(String email) {
        return doctorDAO.getDoctorByEmail(email);
    }

    // Get all Doctors
    public List<Doctor> getAllDoctors() {
        return doctorDAO.getAllDoctors();
    }

    // Get Doctors by Speciality
    public List<Doctor> getDoctorsBySpeciality(String speciality) {
        return doctorDAO.getDoctorsBySpeciality(speciality);
    }
}
