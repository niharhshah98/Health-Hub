CREATE DATABASE PROJECT;
USE PROJECT;


CREATE TABLE Patient (
    PatientID INT PRIMARY KEY NOT NULL,
    PatientName VARCHAR(100),
    Gender VARCHAR(10) CHECK (Gender IN ('Male','Female','Other')),
    DateOfBirth DATE,
    ContactNumber VARCHAR(15),
    Email VARCHAR(100),
    StreetName VARCHAR(100),
    City VARCHAR(20),
    State VARCHAR(20),
    Zipcode VARCHAR(15)
);

CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY NOT NULL,
    InsuranceProvider VARCHAR(100),
    PlanName VARCHAR(100),
    ExpirationDate DATE,
    ContactNumber VARCHAR(15),
    PatientID INT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY NOT NULL,
    PatientID INT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE MedicationPrescribed (
    PrescriptionID INT,
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID),
    Medication VARCHAR(100),
    PRIMARY KEY (PrescriptionID, Medication)
);

CREATE TABLE Hospital (
    HospitalID INT PRIMARY KEY NOT NULL,
    HospitalName VARCHAR(100),
    StreetName VARCHAR(100),
    City VARCHAR(20),
    State VARCHAR(20),
    ZipCode VARCHAR(15),
    Phone VARCHAR(15),
    OperationHours VARCHAR(20) -- Format: HH:MM - HH:MM
);

CREATE TABLE Register (
    HospitalID INT,
    PatientID INT,
    FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    PRIMARY KEY (HospitalID, PatientID)
);

CREATE TABLE Physician (
    PhysicianID INT PRIMARY KEY NOT NULL,
    PhysicianName VARCHAR(100),
    ContactNumber VARCHAR(15),
    Email VARCHAR(100),
    StreetName VARCHAR(100),
    City VARCHAR(20),
    State VARCHAR(20),
    Zipcode VARCHAR(15),
    Specialization VARCHAR(100)
);

CREATE TABLE Practice (
    HospitalID INT,
    PhysicianID INT,
    FOREIGN KEY (HospitalID) REFERENCES Hospital(HospitalID),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID),
    PRIMARY KEY (HospitalID, PhysicianID)
);

CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY NOT NULL,
    PatientID INT,
    PhysicianID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    AppointmentStatus VARCHAR(50) CHECK (AppointmentStatus IN ('Scheduled','Confirmed','Cancelled','Completed','Rescheduled')),
    AppointmentType VARCHAR(50) CHECK (AppointmentType IN ('General Check-Up','Specialist Consultation','Follow-Up','Diagnostic Procedure','Vaccination')),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (PhysicianID) REFERENCES Physician(PhysicianID)
);

CREATE TABLE BillingInformation (
    BillID INT PRIMARY KEY NOT NULL,
    BillDate DATE,
    TotalAmount DECIMAL(10, 2),
    InsurancePaid DECIMAL(10, 2),
    PatientAmount DECIMAL(10, 2),
    PaymentStatus VARCHAR(50) CHECK (PaymentStatus IN ('Pending','Paid','Partial','Overdue')),
    PaymentMethod VARCHAR(50) CHECK (PaymentMethod IN ('Cash','Credit Card','Debit Card','Bank Transfer','Check','Insurance')),
    AppointmentID INT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

INSERT INTO Patient (PatientID, PatientName, Gender, DateOfBirth, ContactNumber, Email, StreetName, City, State, Zipcode)
VALUES
(1, 'John Doe', 'Male', '1985-03-12', '123-456-7890', 'john@example.com', 'Main Street', 'Anytown', 'California', '12345'),
(2, 'Jane Smith', 'Female', '1978-08-25', '987-654-3210', 'jane@example.com', 'Elm Street', 'Smallville', 'New York', '54321'),
(3, 'Alice Johnson', 'Female', '1992-11-03', '555-555-5555', 'alice@example.com', 'Oak Avenue', 'Metropolis', 'Illinois', '67890'),
(4, 'Michael Brown', 'Male', '1970-06-17', '111-222-3333', 'michael@example.com', 'Pine Street', 'Bigcity', 'Texas', '98765'),
(5, 'Emily Davis', 'Female', '1988-12-30', '444-555-6666', 'emily@example.com', 'Cedar Lane', 'Springfield', 'Missouri', '45678'),
(6, 'David Wilson', 'Male', '1973-05-20', '777-888-9999', 'david@example.com', 'Birch Road', 'Sunnyvale', 'California', '23456'),
(7, 'Sarah Martinez', 'Female', '1980-02-15', '222-333-4444', 'sarah@example.com', 'Maple Street', 'Ocean City', 'Maryland', '34567'),
(8, 'Robert Taylor', 'Male', '1995-09-10', '666-777-8888', 'robert@example.com', 'Walnut Avenue', 'Riverside', 'California', '56789'),
(9, 'Laura Miller', 'Female', '1976-04-05', '333-444-5555', 'laura@example.com', 'Willow Lane', 'Phoenix', 'Arizona', '67890'),
(10, 'Christopher Lee', 'Male', '1950-01-20', '888-999-0000', 'chris@example.com', 'Oak Street', 'Boston', 'Massachusetts', '78901'),
(11, 'Jessica White', 'Female', '1958-07-18', '555-123-4567', 'jessica@example.com', 'Elm Avenue', 'Charleston', 'South Carolina', '89012'),
(12, 'Kevin Anderson', 'Male', '1961-10-22', '111-222-3333', 'kevin@example.com', 'Maple Lane', 'Albany', 'New York', '90123'),
(13, 'Amanda Harris', 'Female', '1948-03-08', '777-888-9999', 'amanda@example.com', 'Oak Street', 'Miami', 'Florida', '11223'),
(14, 'Daniel Clark', 'Male', '1957-11-28', '333-444-5555', 'daniel@example.com', 'Pine Avenue', 'Denver', 'Colorado', '33445'),
(15, 'Rachel Rodriguez', 'Female', '2021-06-14', '222-333-4444', 'rachel@example.com', 'Birch Street', 'Nashville', 'Tennessee', '55667'),
(16, 'Matthew Thomas', 'Male', '2022-09-03', '666-777-8888', 'matthew@example.com', 'Cedar Avenue', 'Austin', 'Texas', '77889'),
(17, 'Jennifer Garcia', 'Female', '2023-04-19', '888-999-0000', 'jennifer@example.com', 'Willow Street', 'Sacramento', 'California', '99001'),
(18, 'Justin Martinez', 'Male', '1971-12-07', '555-123-4567', 'justin@example.com', 'Maple Avenue', 'Charlotte', 'North Carolina', '11234'),
(19, 'Ashley Young', 'Female', '1986-08-09', '111-222-3333', 'ashley@example.com', 'Walnut Street', 'Seattle', 'Washington', '55678'),
(20, 'Megan Scott', 'Female', '1991-02-02', '333-444-5555', 'megan@example.com', 'Oak Lane', 'Portland', 'Oregon', '33445'),
(21, 'Alice Johnson', 'Female', '1982-06-25', '555-1234', 'alice.johnson@example.com', '123 Elm St', 'Springfield', 'Illinois', '62701'),
(22, 'Bob Smith', 'Male', '1964-11-15', '555-5678', 'bob.smith@example.com', '456 Maple Ave', 'Springfield', 'Illinois', '62702'),
(23, 'Carol White', 'Female', '1999-04-20', '555-8765', 'carol.white@example.com', '789 Oak Blvd', 'Springfield', 'Illinois', '62703'),
(24, 'David Brown', 'Male', '2010-09-10', '555-4321', 'david.brown@example.com', '101 Pine Ln', 'Springfield', 'Illinois', '62704'),
(25, 'Emma Davis', 'Female', '2017-02-05', '555-6789', 'emma.davis@example.com', '202 Cedar Dr', 'Springfield', 'Illinois', '62705'),
(26, 'Frank Miller', 'Male', '2023-07-30', '555-3456', 'frank.miller@example.com', '303 Birch Ct', 'Springfield', 'Illinois', '62706'),
(27, 'Grace Wilson', 'Female', '2022-12-12', '555-7890', 'grace.wilson@example.com', '404 Walnut St', 'Springfield', 'Illinois', '62707'),
(28, 'Henry Moore', 'Male', '2005-03-03', '555-1235', 'henry.moore@example.com', '505 Ash Rd', 'Springfield', 'Illinois', '62708'),
(29, 'Isla Taylor', 'Female', '2012-05-22', '555-5679', 'isla.taylor@example.com', '606 Cherry St', 'Springfield', 'Illinois', '62709'),
(30, 'Jack Anderson', 'Male', '2023-08-18', '555-8766', 'jack.anderson@example.com', '707 Poplar Ln', 'Springfield', 'Illinois', '62710');



INSERT INTO Insurance (InsuranceID, InsuranceProvider, PlanName, ExpirationDate, ContactNumber, PatientID)
VALUES
(1, 'ABC Insurance', 'Gold Plan', '2024-06-30', '800-123-4567', 1),
(2, 'XYZ Insurance', 'Silver Plan', '2024-07-15', '800-987-6543', 2),
(3, 'DEF Insurance', 'Bronze Plan', '2024-05-31', '800-555-5555', 3),
(4, 'GHI Insurance', 'Platinum Plan', '2024-08-20', '800-333-2222', 4),
(5, 'JKL Insurance', 'Basic Plan', '2024-09-10', '800-444-5555', 5),
(6, 'XYZ Insurance', 'Silver Plan', '2024-07-31', '800-666-7777', 6),
(7, 'ABC Insurance', 'Gold Plan', '2024-06-15', '800-777-8888', 7),
(8, 'STU Insurance', 'Bronze Plan', '2024-08-05', '800-888-9999', 8),
(9, 'VWX Insurance', 'Platinum Plan', '2024-07-20', '800-999-0000', 9),
(10, 'YZA Insurance', 'Gold Plan', '2024-05-25', '800-111-2222', 10),
(11, 'BCD Insurance', 'Silver Plan', '2024-09-30', '800-222-3333', 11),
(12, 'EFG Insurance', 'Bronze Plan', '2024-07-05', '800-333-4444', 12),
(13, 'HIJ Insurance', 'Platinum Plan', '2024-06-10', '800-444-5555', 13),
(14, 'ABC Insurance', 'Gold Plan', '2024-08-15', '800-555-6666', 14),
(15, 'NOP Insurance', 'Basic Plan', '2024-04-20', '800-666-7777', 15),
(16, 'ABC Insurance', 'Gold Plan', '2024-05-30', '800-123-4567', 17),
(17, 'XYZ Insurance', 'Silver Plan', '2024-06-15', '800-987-6543', 22),
(18, 'DEF Insurance', 'Bronze Plan', '2024-07-31', '800-555-5555', 30),
(19, 'GHI Insurance', 'Platinum Plan', '2024-08-20', '800-333-2222', 24),
(20, 'JKL Insurance', 'Basic Plan', '2024-10-10', '800-444-5555', 25);


INSERT INTO Prescription (PrescriptionID, PatientID, StartDate, EndDate)
VALUES
(1, 1, '2024-01-05', '2024-01-15'),
(2, 3, '2024-02-10', '2024-02-20'),
(3, 5, '2024-03-15', '2024-03-25'),
(4, 7, '2024-04-20', '2024-04-30'),
(5, 8, '2024-05-25', '2024-06-04'),
(6, 9, '2023-06-30', '2024-07-10'),
(7, 10, '2024-03-05', '2024-07-15'),
(8, 11, '2024-02-10', '2024-08-20'),
(9, 12, '2023-09-15', '2024-09-25'),
(10, 13, '2023-10-20', '2024-10-30'),
(11, 14, '2023-11-25', '2024-12-05'),
(12, 15, '2024-01-30', '2025-02-09'),
(13, 17, '2024-02-05', '2025-02-15'),
(14, 19, '2024-03-10', '2025-03-20'),
(15, 20, '2024-04-15', '2025-04-25');

INSERT INTO MedicationPrescribed (PrescriptionID, Medication)
VALUES
(1, 'Medicine A'),
(1, 'Medicine B'),
(1, 'Medicine J'),
(2, 'Medicine B'),
(3, 'Medicine C'),
(3, 'Medicine J'),
(4, 'Medicine D'),
(4, 'Medicine J'),
(4, 'Medicine H'),
(5, 'Medicine E'),
(6, 'Medicine F'),
(6, 'Medicine A'),
(6, 'Medicine B'),
(7, 'Medicine G'),
(7, 'Medicine A'),
(8, 'Medicine H'),
(9, 'Medicine I'),
(9, 'Medicine A'),
(10, 'Medicine J'),
(10, 'Medicine A'),
(10, 'Medicine H'),
(11, 'Medicine E'),
(11, 'Medicine F'),
(11, 'Medicine A'),
(12, 'Medicine B'),
(12, 'Medicine G'),
(13, 'Medicine A'),
(13, 'Medicine H'),
(14, 'Medicine I'),
(15, 'Medicine J');


INSERT INTO Hospital (HospitalID, HospitalName, StreetName, City, State, ZipCode, Phone, OperationHours)
VALUES
(1, 'City Hospital', '123 Main St', 'Anytown', 'AnyState', '12345', '555-123-4567', '08:00 - 17:00'),
(2, 'Community Medical Center', '456 Elm St', 'Another City', 'SomeState', '54321', '555-987-6543', '09:00 - 18:00'),
(3, 'Metro Hospital', '789 Oak St', 'Smalltown', 'DifferentState', '67890', '555-333-2222', '10:00 - 19:00'),
(4, 'General Hospital', '101 Pine St', 'Villageville', 'YetAnotherState', '13579', '555-444-5555', '08:30 - 17:30'),
(5, 'Unity Hospital', '202 Cedar St', 'Metro City', 'BigState', '24680', '555-666-7777', '07:00 - 16:00'),
(6, 'Community Health Center', '303 Maple St', 'Urbanville', 'GreatState', '97531', '555-888-9999', '09:30 - 18:30'),
(7, 'Regional Hospital', '404 Birch St', 'Suburbia', 'AwesomeState', '86420', '555-222-3333', '08:00 - 17:00'),
(8, 'County Medical Center', '505 Walnut St', 'Ruraltown', 'FantasticState', '35791', '555-444-3333', '08:30 - 17:30'),
(9, 'Village Health Clinic', '606 Sycamore St', 'Hamletville', 'SuperState', '19283', '555-666-5555', '09:00 - 18:00'),
(10, 'Town Medical Center', '707 Pineapple St', 'Citytown', 'WonderfulState', '80293', '555-888-7777', '08:00 - 17:00');

INSERT INTO Register (HospitalID, PatientID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(5,11),
(5,12),
(10,13),
(3,14),
(5,15),
(9,16),
(3,17),
(5,18),
(7,19),
(9,20),
(1,21),
(7,22),
(4,23),
(5,24),
(3,25),
(3,26),
(2,27),
(6,28),
(3,29),
(7,30);

INSERT INTO Physician (PhysicianID, PhysicianName, ContactNumber, Email, StreetName, City, State, Zipcode, Specialization)
VALUES
(1, 'Dr. Smith', '1234567890', 'drsmith@example.com', '123 Main St', 'Anytown', 'AnyState', '12345', 'General Practitioner'),
(2, 'Dr. Johnson', '9876543210', 'drjohnson@example.com', '456 Elm St', 'Another City', 'SomeState', '54321', 'Cardiologist'),
(3, 'Dr. Lee', '5554443333', 'drlee@example.com', '789 Oak St', 'Smalltown', 'DifferentState', '67890', 'Pediatrician'),
(4, 'Dr. Brown', '1112223333', 'drbrown@example.com', '101 Pine St', 'Villageville', 'YetAnotherState', '13579', 'Dermatologist'),
(5, 'Dr. Garcia', '9998887777', 'drgarcia@example.com', '202 Cedar St', 'Metro City', 'BigState', '24680', 'Orthopedic Surgeon'),
(6, 'Dr. White', '4445556666', 'drwhite@example.com', '303 Maple St', 'Urbanville', 'GreatState', '97531', 'Ophthalmologist'),
(7, 'Dr. Evans', '7776665555', 'drevans@example.com', '404 Birch St', 'Suburbia', 'AwesomeState', '86420', 'Neurologist'),
(8, 'Dr. Martinez', '2223334444', 'drmartinez@example.com', '505 Walnut St', 'Ruraltown', 'FantasticState', '35791', 'Psychiatrist'),
(9, 'Dr. Rodriguez', '8889990000', 'drrodriguez@example.com', '606 Sycamore St', 'Hamletville', 'SuperState', '19283', 'Endocrinologist'),
(10, 'Dr. Adams', '3332221111', 'dradams@example.com', '707 Pineapple St', 'Citytown', 'WonderfulState', '80293', 'Gastroenterologist'),
(11, 'Dr. John Doe', '555-1234', 'johndoe@example.com', '123 Elm St', 'Springfield', 'Illinois', '62701', 'General Practitioner'),
(12, 'Dr. Jane Smith', '555-5678', 'janesmith@example.com', '456 Maple Ave', 'Springfield', 'Illinois', '62702', 'Cardiologist'),
(13, 'Dr. Alice Johnson', '555-8765', 'alicejohnson@example.com', '789 Oak Blvd', 'Springfield', 'Illinois', '62703', 'Dermatologist'),
(14, 'Dr. Bob Brown', '555-4321', 'bobbrown@example.com', '101 Pine Ln', 'Springfield', 'Illinois', '62704', 'Neurologist'),
(15, 'Dr. Carol White', '555-6789', 'carolwhite@example.com', '202 Cedar Dr', 'Springfield', 'Illinois', '62705', 'Pediatrician');



INSERT INTO Practice (HospitalID, PhysicianID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(4, 11),
(4, 12),
(3, 13),
(5, 14),
(4, 15);




INSERT INTO Appointment (AppointmentID, PatientID, PhysicianID, AppointmentDate, AppointmentTime, AppointmentStatus, AppointmentType)
VALUES
(1, 1, 1, '2023-01-15', '09:00', 'Scheduled', 'General Check-Up'),
(2, 2, 2, '2024-03-10', '10:30', 'Confirmed', 'Specialist Consultation'),
(3, 3, 3, '2023-07-01', '11:15', 'Cancelled', 'Follow-Up'),
(4, 4, 4, '2022-12-05', '14:00', 'Completed', 'Diagnostic Procedure'),
(5, 5, 5, '2023-09-20', '08:45', 'Rescheduled', 'Vaccination'),
(6, 6, 6, '2024-06-10', '16:30', 'Scheduled', 'General Check-Up'),
(7, 7, 7, '2024-02-15', '13:30', 'Confirmed', 'Specialist Consultation'),
(8, 8, 8, '2025-05-01', '12:00', 'Cancelled', 'Follow-Up'),
(9, 9, 9, '2023-11-10', '10:45', 'Completed', 'Diagnostic Procedure'),
(10, 10, 10, '2024-08-25', '11:30', 'Rescheduled', 'Vaccination'),
(11, 25, 3, '2024-09-20', '11:00:00', 'Scheduled', 'General Check-Up'),
(12, 7, 1, '2023-12-15', '10:30:00', 'Confirmed', 'Specialist Consultation'),
(13, 15, 7, '2022-11-05', '09:15:00', 'Cancelled', 'Follow-Up'),
(14, 18, 11, '2025-02-21', '14:45:00', 'Completed', 'Diagnostic Procedure'),
(15, 27, 4, '2023-06-13', '13:00:00', 'Rescheduled', 'Vaccination'),
(16, 6, 9, '2023-01-10', '08:00:00', 'Scheduled', 'General Check-Up'),
(17, 19, 10, '2024-03-30', '12:30:00', 'Confirmed', 'Specialist Consultation'),
(18, 2, 10, '2024-04-25', '11:15:00', 'Cancelled', 'Follow-Up'),
(19, 11, 5, '2023-07-05', '16:00:00', 'Completed', 'Diagnostic Procedure'),
(20, 4, 12, '2023-09-14', '15:30:00', 'Rescheduled', 'Vaccination'),
(21, 21, 3, '2022-12-20', '10:00:00', 'Scheduled', 'General Check-Up'),
(22, 30, 7, '2024-01-09', '09:45:00', 'Confirmed', 'Specialist Consultation'),
(23, 5, 8, '2024-02-28', '13:45:00', 'Cancelled', 'Follow-Up'),
(24, 10, 1, '2025-06-15', '14:30:00', 'Completed', 'Diagnostic Procedure'),
(25, 9, 15, '2024-05-19', '08:30:00', 'Rescheduled', 'Vaccination'),
(26, 14, 6, '2023-03-30', '11:45:00', 'Scheduled', 'General Check-Up'),
(27, 28, 11, '2024-08-07', '15:00:00', 'Confirmed', 'Specialist Consultation'),
(28, 1, 4, '2025-05-22', '12:15:00', 'Cancelled', 'Follow-Up'),
(29, 3, 14, '2023-04-11', '14:15:00', 'Completed', 'Diagnostic Procedure'),
(30, 8, 10, '2022-11-25', '10:15:00', 'Rescheduled', 'Vaccination'),
(31, 12, 13, '2024-02-03', '09:00:00', 'Scheduled', 'General Check-Up'),
(32, 26, 5, '2023-10-08', '15:45:00', 'Confirmed', 'Specialist Consultation'),
(33, 10, 12, '2023-06-19', '13:00:00', 'Cancelled', 'Follow-Up'),
(34, 29, 9, '2025-07-04', '08:45:00', 'Completed', 'Diagnostic Procedure'),
(35, 16, 6, '2024-03-29', '14:30:00', 'Rescheduled', 'Vaccination'),
(36, 20, 3, '2023-12-12', '09:30:00', 'Scheduled', 'General Check-Up'),
(37, 24, 8, '2025-05-15', '16:15:00', 'Confirmed', 'Specialist Consultation'),
(38, 17, 7, '2024-04-14', '11:00:00', 'Cancelled', 'Follow-Up'),
(39, 13, 15, '2023-10-22', '08:30:00', 'Completed', 'Diagnostic Procedure'),
(40, 23, 11, '2022-12-03', '10:45:00', 'Rescheduled', 'Vaccination'),
(41, 29, 2, '2023-09-11', '13:15:00', 'Scheduled', 'General Check-Up'),
(42, 15, 9, '2025-04-07', '14:00:00', 'Confirmed', 'Specialist Consultation'),
(43, 7, 1, '2024-05-05', '11:30:00', 'Cancelled', 'Follow-Up'),
(44, 19, 12, '2024-02-20', '15:30:00', 'Completed', 'Diagnostic Procedure'),
(45, 4, 14, '2023-11-16', '09:15:00', 'Rescheduled', 'Vaccination'),
(46, 27, 6, '2023-07-27', '12:30:00', 'Scheduled', 'General Check-Up'),
(47, 22, 13, '2024-01-14', '14:15:00', 'Confirmed', 'Specialist Consultation'),
(48, 15, 1, '2025-06-01', '12:00', 'Cancelled', 'Follow-Up'),
(49, 2, 3, '2025-07-10', '10:45', 'Completed', 'Diagnostic Procedure'),
(50, 4, 5, '2025-08-25', '11:30', 'Rescheduled', 'Vaccination'),
(51, 19, 13, '2024-06-29', '15:30:00', 'Completed', 'Diagnostic Procedure'),
(52, 4, 11, '2024-06-17', '09:15:00', 'Rescheduled', 'Vaccination'),
(53, 27, 14, '2024-06-19', '12:30:00', 'Scheduled', 'General Check-Up'),
(54, 22, 7, '2024-06-18', '14:15:00', 'Confirmed', 'Specialist Consultation'),
(55, 15, 10, '2024-06-14', '12:00', 'Cancelled', 'Follow-Up');



INSERT INTO BillingInformation (BillID, BillDate, TotalAmount, InsurancePaid, PatientAmount, PaymentStatus, PaymentMethod, AppointmentID)
VALUES
(1, '2023-02-01', 150.00, 100.00, 50.00, 'Paid', 'Credit Card', 1),
(2, '2024-04-15', 200.00, 150.00, 50.00, 'Paid', 'Debit Card', 2),
(3, '2023-08-05', 75.00, 0.00, 75.00, 'Pending', 'Cash', 3),
(4, '2023-01-10', 500.00, 300.00, 200.00, 'Partial', 'Bank Transfer', 4),
(5, '2023-10-25', 100.00, 0.00, 100.00, 'Paid', 'Insurance', 5),
(6, '2024-07-20', 80.00, 0.00, 80.00, 'Paid', 'Credit Card', 6),
(7, '2024-03-25', 150.00, 100.00, 50.00, 'Paid', 'Debit Card', 7),
(8, '2025-06-10', 60.00, 60.00, 0.00, 'Paid', 'Cash', 8),
(9, '2024-01-05', 300.00, 200.00, 100.00, 'Partial', 'Bank Transfer', 9),
(10, '2024-09-30', 120.00, 0.00, 120.00, 'Paid', 'Insurance', 10),
(11, '2024-09-20',57,52,5,'Paid','Credit Card',11),
(12, '2023-12-15',227,43,184,'Pending','Bank Transfer',12),
(13, '2022-11-05',236,233,3,'Paid','Credit Card',13),
(14, '2025-02-21',237,80,157,'Pending','Bank Transfer',14),
(15, '2023-06-13',49,45,4,'Partial','Credit Card',15),
(16, '2023-01-10',157,61,96,'Overdue','Bank Transfer',16),
(17, '2024-03-18',195,9,186,'Paid','Debit Card',17),
(18, '2024-04-25',289,190,99,'Pending','Cash',18),
(19, '2023-07-05',175,142,33,'Paid','Credit Card',19),
(20, '2023-09-14',16,10,6,'Pending','Credit Card',20),
(21, '2022-12-20',37,33,4,'Paid','Bank Transfer',21),
(22, '2024-01-09',74,70,4,'Pending','Debit Card',22),
(23, '2024-02-28',138,99,39,'Paid','Credit Card',23),
(24, '2025-06-15',40,10,30,'Pending','Credit Card',24),
(25, '2024-05-19',62,20,42,'Paid','Bank Transfer',25),
(26, '2023-03-30',163,41,122,'Pending','Credit Card',26),
(27, '2024-08-07',86,12,74,'Paid','Bank Transfer',27),
(28, '2025-05-22',105,19,86,'Pending','Debit Card',28),
(29, '2023-04-11',77,52,25,'Paid','Credit Card',29),
(30, '2022-11-25',66,52,14,'Pending','Credit Card',30),
(31, '2024-02-03',76,67,9,'Paid','Bank Transfer',31),
(32, '2023-10-08',130,25,105,'Pending','Debit Card',32),
(33, '2023-06-19',221,199,22,'Partial','Cash',33),
(34, '2025-07-04',66,36,30,'Paid','Credit Card',34),
(35, '2024-03-29',129,58,71,'Pending','Credit Card',35),
(36, '2023-12-12',153,98,55,'Paid','Bank Transfer',36),
(37, '2025-05-15',172,111,61,'Pending','Debit Card',37),
(38, '2024-04-14',94,41,53,'Partial','Credit Card',38),
(39, '2023-10-22',242,129,113,'Paid','Credit Card',39),
(40, '2022-12-03',101,57,44,'Pending','Bank Transfer',40),
(41, '2023-09-11',288,23,265,'Paid','Credit Card',41),
(42, '2025-04-07',48,37,11,'Pending','Bank Transfer',42),
(43, '2024-05-05',75,40,35,'Paid','Debit Card',43),
(44, '2024-02-20',239,52,187,'Paid','Credit Card',44),
(45, '2023-11-16',255,223,32,'Pending','Credit Card',45),
(46, '2023-07-27',48,17,31,'Paid','Bank Transfer',46),
(47, '2024-01-14',41,35,6,'Paid','Debit Card',47),
(48, '2025-06-01',185,43,142,'Pending','Bank Transfer',48),
(49, '2025-07-10',217,205,12,'Paid','Credit Card',49),
(50, '2025-08-25',24,12,12,'Pending','Credit Card',50),
(51, '2024-06-29', 185,43,142,'Pending','Bank Transfer',51),
(52, '2024-06-17', 185,43,142,'Paid','Credit Card',52),
(53, '2024-06-19', 185,43,142,'Pending','Bank Transfer',53),
(54, '2024-06-18', 185,43,142,'Paid','Credit Card',54),
(55, '2024-06-14', 185,43,142,'Pending','Cash',55);




# Question 1: What is the number of visits at each hospital?
SELECT hosp.HospitalID, hosp.HospitalName, count(appo.AppointmentID) AS Number_Appointments
FROM Appointment AS appo  ,Practice AS prac, Hospital AS hosp
WHERE appo.PhysicianID = prac.PhysicianID
AND  prac.HospitalID = hosp.HospitalID
GROUP BY hosp.HospitalID, hosp.HospitalName;
 
/* Question 2: Which physicians have the highest patient appointments and what are their specializations? */
SELECT Physician.PhysicianID, Physician.PhysicianName, Physician.Specialization, COUNT(*) AS AppointmentCount
FROM Appointment
INNER JOIN Physician ON Appointment.PhysicianID = Physician.PhysicianID
GROUP BY Physician.PhysicianID
ORDER BY AppointmentCount DESC;

/* Question 3: Find the names of patients and their insurance providers where the insurance is about to expire within the next month */
SELECT P.PatientID, P.PatientName, I.InsuranceProvider
FROM Insurance I
INNER JOIN Patient P ON I.PatientID = P.PatientID
WHERE I.ExpirationDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 MONTH);
DROP VIEW PatientPaymentSummary;
/* Question 4: WHat is the average and total patient payment amount compared between insured and uninsured patients? */
CREATE VIEW PatientPaymentSummary AS
SELECT 
    'Insured' AS PatientType, 
    AVG(BI.PatientAmount) AS AvgPayment, 
    SUM(BI.PatientAmount) AS SumPayment
FROM BillingInformation BI
INNER JOIN Appointment A ON BI.AppointmentID = A.AppointmentID
INNER JOIN Insurance I ON A.PatientID = I.PatientID

UNION ALL

SELECT 
    'Uninsured' AS PatientType, 
    AVG(BI.PatientAmount) AS AvgPayment, 
    SUM(BI.PatientAmount) AS SumPayment
FROM BillingInformation BI
INNER JOIN Appointment A ON BI.AppointmentID = A.AppointmentID
LEFT JOIN Insurance I ON A.PatientID = I.PatientID
WHERE I.PatientID IS NULL;
SELECT * FROM PatientPaymentSummary;


# Question 5: What is the number of visits per age group? 
SELECT PatientAge.AgeGroup,count(appo.AppointmentID) AS Number_Appointments 
FROM 
	(SELECT PatientID,
		CASE 
		WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) <=1 THEN 'A.<1 yo'
		WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) <=4 THEN 'B.2-4 yo'
		WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) <=12 THEN 'C.5-12 yo'
		WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) <=19 THEN 'D.13-19 yo'
		WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) <=39 THEN 'E.20-39 yo'
		WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) <=59 THEN 'F.40-59 yo'
		WHEN TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) >=60 THEN 'G.60+ yo'
		ELSE '000'
		END AS AgeGroup
	FROM Patient 
	) AS PatientAge, Appointment AS appo 
WHERE appo.PatientID = PatientAge.PatientID
GROUP BY AgeGroup
ORDER BY 1;

# Question 6: What is the most common medication prescribed for patients over 65 years old? 
SELECT mp.Medication,COUNT(mp.Medication) AS MedicationCount
FROM Patient pat ,Prescription pr ,MedicationPrescribed mp
WHERE pat.PatientID = pr.PatientID
AND pr.PrescriptionID = mp.PrescriptionID
AND TIMESTAMPDIFF(YEAR, pat.DateOfBirth, CURDATE())  > 65  
GROUP BY mp.Medication
ORDER BY MedicationCount DESC
LIMIT 1;


# Question 7: What is the average age of patients for each type of insurance plan?
SELECT i.PlanName AS InsurancePlan, ROUND(AVG(TIMESTAMPDIFF(YEAR, p.DateOfBirth, CURDATE())),0) AS AveragAge
FROM Patient p
JOIN Insurance i ON p.PatientID = i.PatientID
GROUP BY i.PlanName;

# Question 8: Which days are the busiest accross all the hospitals? 
SELECT HospitalID,HospitalName,DayOfWeek,NumberAppointments
FROM
	(
	SELECT HospitalID,HospitalName,NumberAppointments,DayOfWeek,
	ROW_NUMBER() OVER (PARTITION BY HospitalID ORDER BY NumberAppointments DESC) AS Ranking
	FROM
			(
			SELECT hosp.HospitalID,hosp.HospitalName,
			DAYNAME(AppointmentDate) AS DayOfWeek, COUNT(AppointmentID) NumberAppointments
			FROM Appointment AS appo  ,Practice AS prac, Hospital AS hosp
			WHERE appo.PhysicianID = prac.PhysicianID
			AND  prac.HospitalID = hosp.HospitalID
			GROUP BY  hosp.HospitalID,hosp.HospitalName,DAYNAME(AppointmentDate)
			) AS HospApp
	) AS RankingTab 
WHERE ranking = 1
ORDER BY  NumberAppointments DESC;


