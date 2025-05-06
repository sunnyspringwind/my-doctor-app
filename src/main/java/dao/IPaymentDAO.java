package dao;

import model.Payment;
import utils.StatusCode;


public interface IPaymentDAO {
    public StatusCode createPayment(Payment payment);
    public boolean makePayment(Payment payment);
    public boolean deletePayment(int paymentId);
    public Payment getPaymentByAppointmentId(int appointmentId);
}
