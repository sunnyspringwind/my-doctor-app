package service;

import dao.IAppointmentDAO;
import model.Appointment;
import utils.ServiceResponse;
import utils.StatusCode;

import java.util.List;

/** takes methods from dao,utils and combines them to create proper service */
public class AppointmentService {

    private final IAppointmentDAO appointmentDao;

    public AppointmentService(IAppointmentDAO IappointmentDAO) {
        this.appointmentDao = IappointmentDAO;
    }

    public StatusCode addAppointment(Appointment appointment) {
        if (appointmentDao.doesAppointmentExist(appointment.getDoctorId(), appointment.getAppointmentTime()) == StatusCode.APPOINTMENT_ALREADY_EXISTS)
        {
             return StatusCode.APPOINTMENT_ALREADY_EXISTS;
        }
        return appointmentDao.insertAppointment(appointment);
    }
    public ServiceResponse<List<Appointment>> getAllAppointments() {
        try {
            List<Appointment> appointments = appointmentDao.getAllAppointments();
            return new ServiceResponse<>(StatusCode.SUCCESS, appointments);
        } catch (Exception e) {
            e.printStackTrace();
            return new ServiceResponse<>(StatusCode.INTERNAL_SERVER_ERROR);
        }
    }

    public ServiceResponse<Appointment> getAppointmentById(int id) {
        try {
            Appointment appointment = appointmentDao.getAppointmentById(id);
            if (appointment != null) {
                return new ServiceResponse<>(StatusCode.SUCCESS, appointment);
            } else {
                return new ServiceResponse<>(StatusCode.NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new ServiceResponse<>(StatusCode.INTERNAL_SERVER_ERROR);
        }
    }

    public ServiceResponse<List<Appointment>> getAppointmentsByDoctorId(String doctorId) {
        try {
            List<Appointment> list = appointmentDao.getAppointmentByDoctorId(doctorId);
            return new ServiceResponse<>(StatusCode.SUCCESS, list);
        } catch (Exception e) {
            e.printStackTrace();
            return new ServiceResponse<>(StatusCode.INTERNAL_SERVER_ERROR);
        }
    }

    public ServiceResponse<List<Appointment>> getAppointmentsByPatientId(String patientId) {
        try {
            List<Appointment> list = appointmentDao.getAppointmentsByPatientId(patientId);
            return new ServiceResponse<>(StatusCode.SUCCESS, list);
        } catch (Exception e) {
            e.printStackTrace();
            return new ServiceResponse<>(StatusCode.INTERNAL_SERVER_ERROR);
        }
    }
    public boolean updateAppointmentStatus(int appointmentId, String status) {
        if (appointmentDao.getAppointmentById(appointmentId) == null)
            return false;
        return  appointmentDao.updateAppointmentStatus(appointmentId, status) == StatusCode.SUCCESS;
    }
    public boolean deleteAppointment(int appointmentId) {
        return appointmentDao.deleteAppointment(appointmentId) == StatusCode.SUCCESS;
    }
}
