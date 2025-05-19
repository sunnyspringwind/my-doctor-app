package model;

import java.util.List;

public class DashboardStats {
    private int totalDoctors;
    private int totalAppointments;
    private int totalPatients;
    private List<Booking> latestBookings;

    // Getters and Setters
    public int getTotalDoctors() {
        return totalDoctors;
    }

    public void setTotalDoctors(int totalDoctors) {
        this.totalDoctors = totalDoctors;
    }

    public int getTotalAppointments() {
        return totalAppointments;
    }

    public void setTotalAppointments(int totalAppointments) {
        this.totalAppointments = totalAppointments;
    }

    public int getTotalPatients() {
        return totalPatients;
    }

    public void setTotalPatients(int totalPatients) {
        this.totalPatients = totalPatients;
    }

    public List<Booking> getLatestBookings() {
        return latestBookings;
    }

    public void setLatestBookings(List<Booking> latestBookings) {
        this.latestBookings = latestBookings;
    }
} 