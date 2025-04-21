package service;

import model.Doctor;
import utils.StatusCode;

import java.util.List;

public interface IDoctorService {
    StatusCode registerDoctor(String name,String email,String password);
    Doctor loginDoctor(String email, String password);
    boolean updateDoctorProfile(Doctor doctor);
//    void setAvailability(String doctorId, boolean isAvailable);
//    Doctor getDoctorById(String doctorId);
//    List<Doctor> getDoctorsBySpeciality(String speciality);
    List<Doctor> getAllDoctors();
}

