

USE myDoctorDb;
-- Patient Table
CREATE TABLE Patient (
                         patientId CHAR(36) PRIMARY KEY,
                         name VARCHAR(100),
                         email VARCHAR(100) UNIQUE NOT NULL,
                         password VARCHAR(100) NOT NULL,
                         phone VARCHAR(15),
                         address VARCHAR(255),
                         gender VARCHAR(10),
                         dateOfBirth DATE,
                         isActive BOOLEAN DEFAULT TRUE,
                         registrationDate DATE DEFAULT CURRENT_DATE,
                         pfp LONGBLOB  -- Profile Picture stored as a Blob (binary large object)
);

-- Admin Table
CREATE TABLE Admin (
                         adminId CHAR(36) PRIMARY KEY,
                         email VARCHAR(100) UNIQUE NOT NULL,
                       password VARCHAR(100) NOT NULL,
                       role VARCHAR(50),
                       isActive BOOLEAN DEFAULT TRUE,
                       lastLogin DATE,
                       pfp LONGBLOB  -- Profile Picture stored as a Blob (binary large object)
);

-- Doctor Table
CREATE TABLE Doctor (
                         doctorId CHAR(36) PRIMARY KEY,
                         name VARCHAR(100),
                        email VARCHAR(100) UNIQUE NOT NULL,
                        password VARCHAR(100) NOT NULL,
                        speciality VARCHAR(100),
                        experience INT,
                        fees FLOAT,
                        degree VARCHAR(100),
                        isAvailable BOOLEAN DEFAULT TRUE,
                        pfp LONGBLOB  -- Profile Picture stored as a Blob (binary large object)
);

-- Appointment Table
CREATE TABLE Appointment (
                             appointmentId INT AUTO_INCREMENT PRIMARY KEY,
                             doctorId CHAR(36),
                             patientId CHAR(36),
                             appointmentTime TIMESTAMP,  -- Use TIMESTAMP for both date and time
                             status VARCHAR(50),
                             payment float,
                             reason TEXT,
                             FOREIGN KEY (doctorId) REFERENCES Doctor(doctorId) ON DELETE CASCADE,
                             FOREIGN KEY (patientId) REFERENCES Patient(patientId) ON DELETE CASCADE
);


-- Payment Table
CREATE TABLE Payment (
                         paymentId INT AUTO_INCREMENT PRIMARY KEY,
                         appointmentId INT NOT NULL UNIQUE,
                         amount FLOAT,
                         paymentMode VARCHAR(50),
                         status VARCHAR(50),
                         transactionId VARCHAR(100),
                         date DATE,
                         FOREIGN KEY (appointmentId) REFERENCES Appointment(appointmentId) ON DELETE CASCADE
);
