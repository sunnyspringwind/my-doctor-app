package utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.IOException;
import java.io.InputStream;
import java.security.SecureRandom;
import java.util.*;

public class EmailSender {

    private static String username = "";
    private static String password = "";
    private static final Properties props = new Properties();

    static {
        try (InputStream input = EmailSender.class.getClassLoader().getResourceAsStream("config.properties")) {
            Properties config = new Properties();
            config.load(input);

            username = config.getProperty("email.username");
            password = config.getProperty("email.password");
            String host = config.getProperty("smtp.host");
            String port = config.getProperty("smtp.port");

            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", port);

            System.out.println("SMTP Configuration: " + host + ":" + port);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static Session getSession() {
        return Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
    }

    public int passwordResetMail(String email) {
        return sendEmail(email, "Password Reset Request",
                "Dear User,\n\nWe have received a request to reset your password. "
                        + "Your verification code is: %d\n\nIf you did not request this, please ignore this email.\n\n"
                        + "Best regards,\nMyDoctorApp Team\n\n");
    }

    public int sendValidationEmail(String email) {
        return sendEmail(email, "Email Verification",
                "Dear User,\n\nThank you for registering at MyDoctorApp. "
                        + "Your email verification code is: %d\n\nPlease use this code to complete your email verification process.\n\n"
                        + "Best regards,\nMyDoctorApp Team\n\n");
    }

    private int sendEmail(String email, String subject, String bodyTemplate) {
        try {
            SecureRandom random = new SecureRandom();
            int code = 100000 + random.nextInt(900000); // Secure random 6-digit code

            Session session = getSession();
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject(subject);
            message.setText(String.format(bodyTemplate, code));

            Transport.send(message);
            System.out.println(subject + " email sent to " + email);

            return code;
        } catch (MessagingException e) {
            System.err.println("Email error: " + e.getMessage());
            return -1; // Return error code
        }
    }

    // Main method to test out the email functionality
//    public static void main(String[] args) {
//        EmailSender emailSender = new EmailSender();
//
//        // Test sending validation email
//        try {
//            String testEmail = "immortalwizzard@.com"; // Replace with a valid email address for testing
//            int code = emailSender.sendValidationEmail(testEmail);
//            System.out.println("Verification code sent: " + code);
//        } catch (Exception e) {
//            System.err.println("Failed to send validation email: " + e.getMessage());
//        }
//
//        // Test sending password reset email
//        try {
//            String testEmail = "immortalwizzard@.com"; // Replace with a valid email address for testing
//            int code = emailSender.passwordResetMail(testEmail);
//            System.out.println("Password reset code sent: " + code);
//        } catch (Exception e) {
//            System.err.println("Failed to send password reset email: " + e.getMessage());
//        }
//
//        System.out.println("Email sending process completed");
//    }

}
