package dao;

import model.Payment;
import utils.DBUtil;
import utils.PaymentMode;
import utils.PaymentStatus;
import utils.StatusCode;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PaymentDAO implements IPaymentDAO {

    public StatusCode createPayment(Payment payment) {
        String sql = "INSERT INTO payment (appointmentId, amount, status) VALUES (?,?,?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);){
            ps.setInt(1, payment.getAppointmentId());
            ps.setFloat(2, payment.getAmount());
            String status = payment.getStatus() != null ? payment.getStatus().name() : null;
            ps.setString(3, status);

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return StatusCode.SUCCESS;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return StatusCode.INTERNAL_SERVER_ERROR;
    }

    public boolean makePayment(Payment payment) {
        String sql = "INSERT INTO Payment (appointmentId, amount, paymentMode, status, transactionId, date) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, payment.getAppointmentId());
            ps.setFloat(2, payment.getAmount());
            ps.setString(3, payment.getPaymentMode() != null ? payment.getPaymentMode().name() : null);
            ps.setString(4, String.valueOf(payment.getStatus())); // or .name() if enum
            ps.setString(5, payment.getTransactionId());
            ps.setDate(6, payment.getDate());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deletePayment(int paymentId) {
        String sql = "DELETE FROM Payment WHERE paymentId = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, paymentId);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Payment getPaymentByAppointmentId(int appointmentId) {
        String sql = "SELECT * FROM Payment WHERE appointmentId = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, appointmentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(rs.getInt("paymentId"));
                    payment.setAppointmentId(rs.getInt("appointmentId"));
                    payment.setAmount(rs.getFloat("amount"));
                    payment.setPaymentMode(PaymentMode.valueOf(rs.getString("paymentMode")));
                    payment.setStatus(PaymentStatus.valueOf(rs.getString("status"))); // if using enum
                    payment.setTransactionId(rs.getString("transactionId"));
                    payment.setDate(rs.getDate("date"));

                    return payment;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean updatePayment(Payment payment) {
        String sql = "UPDATE Payment SET status = ?, transactionId = ? WHERE appointmentId = ?";
        
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, payment.getStatus().name());
            ps.setString(2, payment.getTransactionId());
            ps.setInt(3, payment.getAppointmentId());
            
            int rows = ps.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }






}
