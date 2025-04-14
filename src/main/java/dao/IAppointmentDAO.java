package dao;

import model.Appointment;
import utils.StatusCode;

import java.sql.Timestamp;
import java.util.List;

public interface IAppointmentDAO {

    StatusCode insertAppointment(Appointment appointment);

    List<Appointment> getAllAppointments();

    Appointment getAppointmentById(int id);

    List<Appointment> getAppointmentByDoctorId(String doctorId);

    List<Appointment> getAppointmentsByPatientId(String patientId);

    StatusCode updateAppointmentStatus(int appointmentId, String status);

    StatusCode deleteAppointment(int appointmentId);

    StatusCode doesAppointmentExist(String doctorId, Timestamp appointmentTime);
}
