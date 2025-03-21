CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Specialization VARCHAR(100),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    Availability ENUM('Available', 'On Leave') DEFAULT 'Available'
);

CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Age INT,
    Gender ENUM('Male', 'Female', 'Other'),
    PhoneNumber VARCHAR(15),
    Address TEXT
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Billing (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Amount DECIMAL(10,2),
    PaymentStatus ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

CREATE TABLE Medicines (
    MedicineID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    ExpiryDate DATE,
    Stock INT DEFAULT 0,
    Price DECIMAL(10,2)
);

INSERT INTO Doctors (Name, Specialization, PhoneNumber, Email, Availability) 
VALUES ('Dr. Smith', 'Cardiologist', '9876543210', 'smith@example.com', 'Available'),
       ('Dr. John', 'Orthopedic', '9123456789', 'john@example.com', 'On Leave');

INSERT INTO Patients (Name, Age, Gender, PhoneNumber, Address) 
VALUES ('Alice Johnson', 30, 'Female', '9898989898', 'New York'),
       ('Bob Smith', 45, 'Male', '9123456789', 'California');

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status) 
VALUES (1, 1, '2025-03-25', 'Scheduled'),
       (2, 2, '2025-03-26', 'Cancelled');

INSERT INTO Billing (PatientID, Amount, PaymentStatus) 
VALUES (1, 500.00, 'Paid'),
       (2, 1000.00, 'Unpaid');

INSERT INTO Medicines (Name, ExpiryDate, Stock, Price) 
VALUES ('Paracetamol', '2026-12-31', 100, 5.00),
       ('Ibuprofen', '2027-06-30', 50, 8.00);



INSERT INTO Doctors (Name, Specialization, PhoneNumber, Email, Availability) VALUES
('Dr. Smith', 'Cardiologist', '9876543210', 'smith@example.com', 'Available'),
('Dr. John', 'Orthopedic', '9123456789', 'john@example.com', 'On Leave');

INSERT INTO Patients (Name, Age, Gender, PhoneNumber, Address) VALUES
('Alice Johnson', 30, 'Female', '9898989898', 'New York'),
('Bob Smith', 45, 'Male', '9123456789', 'California');

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status) VALUES
(1, 1, '2025-03-25', 'Scheduled'),
(2, 2, '2025-03-26', 'Cancelled');

INSERT INTO Billing (PatientID, Amount, PaymentStatus) VALUES
(1, 500.00, 'Paid'),
(2, 1000.00, 'Unpaid');

INSERT INTO Medicines (Name, ExpiryDate, Stock, Price) VALUES
('Paracetamol', '2026-12-31', 100, 5.00),
('Ibuprofen', '2027-06-30', 50, 8.00);

SELECT Patients.Name, Doctors.Name AS Doctor, Appointments.AppointmentDate, Appointments.Status
FROM Appointments
JOIN Patients ON Appointments.PatientID = Patients.PatientID
JOIN Doctors ON Appointments.DoctorID = Doctors.DoctorID;

SELECT SUM(Amount) AS Total_Revenue FROM Billing WHERE PaymentStatus = 'Paid';

SELECT Name, Stock, Price FROM Medicines ORDER BY ExpiryDate ASC;

SELECT Name, Specialization, Availability FROM Doctors WHERE Availability = 'Available';
