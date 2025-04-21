package dao;

import model.Doctor;
import utils.StatusCode;

import java.util.List;
import java.util.UUID;

public interface IDoctorDAO {

    StatusCode addDoctor(Doctor doctor);

    Doctor getDoctorById(UUID doctorId);

    Doctor getDoctorByEmail(String email);

    List<Doctor> getAllDoctors();

    List<Doctor> getDoctorsBySpeciality(String speciality);

    boolean updateDoctor(Doctor doctor);

    boolean updateDoctorPassword(UUID doctorId, String oldPassword, String newPassword);

    boolean deleteDoctor(UUID doctorId);

}
