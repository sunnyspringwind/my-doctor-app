package model;

import utils.PaymentMode;
import utils.PaymentStatus;

public class Payment {
    private int paymentId;
    private int appointmentId;
    private float amount;
    private PaymentMode paymentMode;
    private PaymentStatus status;
    private String transactionId;
    private java.sql.Date date;

    // Constructors
    public Payment() {}

    public Payment(int paymentId, int appointmentId, float amount, PaymentMode paymentMode, PaymentStatus status, String transactionId, java.sql.Date date) {
        this.paymentId = paymentId;
        this.appointmentId = appointmentId;
        this.amount = amount;
        this.paymentMode = paymentMode;
        this.status = status;
        this.transactionId = transactionId;
        this.date = date;
    }

    public Payment(int appointmentId, float amount, PaymentMode paymentMode, PaymentStatus status, String transactionId, java.sql.Date date) {
        this.appointmentId = appointmentId;
        this.amount = amount;
        this.paymentMode = paymentMode;
        this.status = status;
        this.transactionId = transactionId;
        this.date = date;
    }

    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }
    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }
    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public PaymentMode getPaymentMode() {
        return paymentMode;
    }

    public void setStatus(PaymentStatus status) {
        this.status = status;
    }

    public void setPaymentMode(PaymentMode paymentMode) {
        this.paymentMode = paymentMode;
    }

    public PaymentStatus getStatus() {
        return status;
    }


    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public java.sql.Date getDate() {
        return date;
    }

    public void setDate(java.sql.Date date) {
        this.date = date;
    }
}

