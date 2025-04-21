package service;

import dao.IPatientDAO;
import dao.PatientDAO;
import model.Doctor;
import model.Patient;
import org.mindrot.jbcrypt.BCrypt;
import utils.StatusCode;

import java.util.List;

public class PatientService implements IPatientService {
    private final IPatientDAO patientDAO;

    public  PatientService(IPatientDAO patientDAO) {
        this.patientDAO = patientDAO;
    }

    public StatusCode registerPatient(String name, String email, String password) {
        //check for existing patient email or phone
        if (patientDAO.getPatientByEmail(email) != null ) {
            return StatusCode.EMAIL_ALREADY_EXISTS;        }
        //create patient from registration data
        Patient patient = Patient.createFromRegistration(name, email, password);
        //add to db
        return patientDAO.addPatient(patient);

    }

    // Doctor Login
    public Patient loginPatient(String email, String password) {
        //get patient using email
        Patient patient = patientDAO.getPatientByEmail(email);
        //hash and compare password
        if (patient != null && BCrypt.checkpw(password, patient.getPasswordHash())) {
            return patient;  // Login successful
        }
        return null;  // Invalid credentials
    }
    public boolean updatePatientProfile(Patient patient) {
        return patientDAO.updatePatient(patient);
    }

    @Override
    public List<Patient> getAllPatients() {
        // Business logic or filtering could be added here later
        return patientDAO.getAllPatients();
    }
}
