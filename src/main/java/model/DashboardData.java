package model;

import java.util.List;

public class DashboardData {
    private int doctors;
    private int appointments;
    private int patients;
    private List<Appointment> latestAppointments;

    // Getters and Setters
    public int getDoctors() {
        return doctors;
    }

    public void setDoctors(int doctors) {
        this.doctors = doctors;
    }

    public int getAppointments() {
        return appointments;
    }

    public void setAppointments(int appointments) {
        this.appointments = appointments;
    }

    public int getPatients() {
        return patients;
    }

    public void setPatients(int patients) {
        this.patients = patients;
    }

    public List<Appointment> getLatestAppointments() {
        return latestAppointments;
    }

    public void setLatestAppointments(List<Appointment> latestAppointments) {
        this.latestAppointments = latestAppointments;
    }
} 