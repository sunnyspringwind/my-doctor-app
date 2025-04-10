package model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Appointment {
    //Attributes: appointmentId(PK), doctorId(FK to Doctor), userId(FK to User), appointmentTime, appointmentTime, status, payment, reason
    private int appointmentId;
    private String doctorId;
    private String patientId;
    private Timestamp appointmentTime;
    private String status;
    private String reason;
    private float payment;

    //default constructor and custom ones
    public Appointment() {}

    public Appointment(int appointmentId, String doctorId, String patientId, Timestamp appointmentTime, String status, String reason, float payment) {
        this.appointmentId = appointmentId;
        this.doctorId = doctorId;
        this.patientId = patientId;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.reason = reason;
        this.payment = payment;
    }

    public Appointment( String doctorId, String patientId, Timestamp appointmentTime, String status, String reason, float payment) {
        this.doctorId = doctorId;
        this.patientId = patientId;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.reason = reason;
        this.payment = payment;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public String getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(String doctorId) {
        this.doctorId = doctorId;
    }

    public String getPatientId() {
        return patientId;
    }

    public void setPatientId(String patientId) {
        this.patientId = patientId;
    }

    public Timestamp getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(Timestamp appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public float getPayment() {
        return payment;
    }

    public void setPayment(float payment) {
        this.payment = payment;
    }
}
