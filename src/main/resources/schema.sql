CREATE DATABASE myDoctorAppDb;

USE myDoctorAppDb;

CREATE TABLE users (
                       id CHAR(36) NOT NULL PRIMARY KEY,
                       firstName VARCHAR(50) NOT NULL,
                       lastName VARCHAR(50) NOT NULL,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       passwordHash VARCHAR(255),
                       address VARCHAR(255),
                       phone VARCHAR(15) NOT NULL UNIQUE,
                       role ENUM('PATIENT', 'DOCTOR') NOT NULL,
                       pfp MEDIUMBLOB,
                       gender ENUM('MALE', 'FEMALE', 'OTHER'),
                       dateOfBirth DATE NOT NULL,
    -- Doctor specific fields
                       degree VARCHAR(50),
                       specialization VARCHAR(100),
                       fee DECIMAL(10, 2),
                       isAvailable BOOLEAN DEFAULT FALSE,
    -- Patient specific fields
                       bloodGroup VARCHAR(3)

);

CREATE TABLE appointments (
                              appointment_id INT AUTO_INCREMENT PRIMARY KEY,
                              doctor_id VARCHAR(50),
                              patient_id VARCHAR(50),
                              appointment_time TIMESTAMP,
                              status VARCHAR(50),
                              reason VARCHAR(50),
                              payment VARCHAR(50),
                              FOREIGN KEY (doctor_id) REFERENCES users(id),
                              FOREIGN KEY (patient_id) REFERENCES users(id)
);
