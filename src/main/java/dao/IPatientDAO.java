package dao;

import model.Patient;
import utils.StatusCode;

import java.util.List;

public interface IPatientDAO {
    StatusCode addPatient(Patient patient);
    Patient getPatientById(String userId);
    Patient getPatientByEmail(String email);
    List<Patient> getAllPatients();
    boolean updatePatient(Patient patient);
    boolean updatePatientPassword(String patientId, String oldPassword, String newPassword);
    boolean deletePatient(String patientId);
    Patient loginPatient(String email, String password);
}
