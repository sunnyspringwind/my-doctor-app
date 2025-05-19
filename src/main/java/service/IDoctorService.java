package service;

import model.Doctor;
import utils.StatusCode;

import java.util.List;

public interface IDoctorService {
    StatusCode registerDoctor(Doctor doctor);
    Doctor loginDoctor(String email, String password);
    boolean updateDoctorProfile(Doctor doctor);
    Doctor getDoctorById(String doctorId);
//    void setAvailability(String doctorId, boolean isAvailable);
//    List<Doctor> getDoctorsBySpeciality(String speciality);
    List<Doctor> getAllDoctors();
}

