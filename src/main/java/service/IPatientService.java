package service;

import model.Patient;
import utils.StatusCode;

import java.util.List;

public interface IPatientService {
    StatusCode registerPatient(String name, String email, String password );
    Patient loginPatient(String email, String password);
    boolean updatePatientProfile(Patient patient);
//    void deactivatePatient(String patientId);
//    Patient getPatientById(String patientId);
    List<Patient> getAllPatients();
}
