package model;

import java.sql.Timestamp;

public class Appointment {
    private String id;
    private DoctorData docData;
    private String slotDate;
    private boolean cancelled;
    private int appointmentId;
    private String doctorId;
    private String patientId;
    private String patientName;
    private int patientAge;
    private float fees;
    private Timestamp appointmentTime;
    private String status;
    private String reason;
    private float payment;

    // Default constructor and custom ones
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

    public Appointment(String doctorId, String patientId, Timestamp appointmentTime, String status, String reason, float payment) {
        this.doctorId = doctorId;
        this.patientId = patientId;
        this.appointmentTime = appointmentTime;
        this.status = status;
        this.reason = reason;
        this.payment = payment;
    }

    // Getters and setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public DoctorData getDocData() {
        return docData;
    }

    public void setDocData(DoctorData docData) {
        this.docData = docData;
    }

    public String getSlotDate() {
        return slotDate;
    }

    public void setSlotDate(String slotDate) {
        this.slotDate = slotDate;
    }

    public boolean isCancelled() {
        return cancelled;
    }

    public void setCancelled(boolean cancelled) {
        this.cancelled = cancelled;
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

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public int getPatientAge() {
        return patientAge;
    }

    public void setPatientAge(int patientAge) {
        this.patientAge = patientAge;
    }

    public float getFees() {
        return fees;
    }

    public void setFees(float fees) {
        this.fees = fees;
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
