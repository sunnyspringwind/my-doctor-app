package service;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

/** EmailSender for email verification, password resets or email changes */
public class EmailSender {

    private static String username = "";
    private static String password = "";
    private static final Properties props = new Properties();

    // Static block to load configuration only once
    static {
        try (InputStream input = new FileInputStream("src/main/java/resources/config.properties")) {
            // Load the config file
            Properties config = new Properties();
            config.load(input);

            // Get credentials and server settings
            username = config.getProperty("email.username");
            password = config.getProperty("email.password");
            String host = config.getProperty("smtp.host");
            String port = config.getProperty("smtp.port");

            // Configure mail session properties
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
        return Session.getInstance(props,
                new javax.mail.Authenticator() {
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
            int code = new Random().nextInt(900000) + 100000; // Generate 6-digit random code

            Session session = getSession();
            System.out.println("Debug: Session Properties - " + session.getProperties());

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
            if (e.getCause() != null) {
                System.err.println("Caused by: " + e.getCause().getMessage());
            }
            throw new RuntimeException("Failed to send " + subject.toLowerCase() + " email.", e);
        }
    }

    public static void main(String[] args) throws IOException {
        EmailSender emailSender = new EmailSender();
        try {
            int code = emailSender.sendValidationEmail("immortalwizzard@gmail.com");
            System.out.println("Verification code: " + code);
        } catch (Exception e) {
            System.err.println("Failed to send email: " + e.getMessage());
        }
        System.out.println("Email sending process completed");
    }
}