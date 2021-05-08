/**
* The table designed for medicine project. 
* 
* @Auther: MTechProject Team
* @UpdateHistory: <Updater>-<date>-<Update Details>
* Dinu Thomas-02/05/2021-Added create scripts for the tables
* Dinu Thomas-03/05/2021-updated insert statements for doctor database
*
* TODO , pls insert the data according to the design and 
* add the change details as per the format<Updater>-<date>-<Update Details>
* pls use the same comment in the commit message
*/
use db1;
create database medicine;

use medicine;
set sql_safe_updates=0;
-- drop table Physician;
CREATE TABLE doctor (
  EmployeeID int PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Position TEXT NOT NULL,
  adhar_id INTEGER NOT NULL
); 
select * from doctor;

INSERT INTO doctor VALUES(18,'Sudhakar Reddy','Medical Officer',111111111);
INSERT INTO doctor VALUES(19,'Rajaram Mohan','Physician',111111112);
INSERT INTO doctor VALUES(23,'Sunny Kuttan','Pcychiatrist',111111113);
INSERT INTO doctor VALUES(27,'Annie Kurian','Pediatrician',111111114);
INSERT INTO doctor VALUES(28,'Mohan Kumar','Oncologist',111111115);
INSERT INTO doctor VALUES(33,'Mahendra Saraf','Gynacologist',111111116);
INSERT INTO doctor VALUES(35,'Arvind Sawakar','Cardiologist',111111117);
INSERT INTO doctor VALUES(38,'Suresh Kumar','Emergency',111111119);
INSERT INTO doctor VALUES(44,'Venugopal','Emergency',111111120);
select * from doctor;

CREATE TABLE Department (
  DepartmentID INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Head INTEGER,
  foreign key (Head) references doctor(EmployeeID)
);

INSERT INTO Department VALUES(1,'General Medicine',19);
INSERT INTO Department VALUES(2,'General Medicine',23);
INSERT INTO Department VALUES(3,'General Medicine',27);
INSERT INTO Department VALUES(4,'General Medicine',28);
INSERT INTO Department VALUES(5,'General Medicine',33);

select * from Department;


-- drop table Affiliated_With;
CREATE TABLE medical_departmets (
  doctorId INTEGER NOT NULL,
    foreign key (doctorId) REFERENCES doctor(EmployeeID),
  Department INTEGER NOT NULL,
    foreign key (Department) REFERENCES Department(DepartmentID),
  PrimaryDepartment BOOLEAN NOT NULL,
  PRIMARY KEY(doctorId, Department)
);
select * from  medical_departmets;
INSERT INTO medical_departmets VALUES(18,1,18);
INSERT INTO medical_departmets VALUES(19,2,19);
INSERT INTO medical_departmets VALUES(23,2,23);
INSERT INTO medical_departmets VALUES(27,2,27);

CREATE TABLE Patient (
  adhar_id INTEGER PRIMARY KEY NOT NULL,
  Name TEXT NOT NULL,
  Address TEXT NOT NULL,
  Phone TEXT NOT NULL,
  InsuranceID INTEGER NOT NULL,
  ConsultingDoctor INTEGER NOT NULL,
    foreign key (ConsultingDoctor) REFERENCES doctor(EmployeeID)
);
INSERT INTO patient VALUES(111111111,'ahgh','hjgh','jhg',12,18);
INSERT INTO patient VALUES(111111112,'ahgh','hjgh','jhg',12,19);
INSERT INTO patient VALUES(111111113,'ahgh','hjgh','jhg',12,23);
INSERT INTO patient VALUES(111111114,'ahgh','hjgh','jhg',12,27);
INSERT INTO patient VALUES(111111115,'ahgh','hjgh','jhg',12,28);

CREATE TABLE Appointment1 (
  AppointmentID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,
    foreign key (Patient) REFERENCES Patient(adhar_id),
  doctorId INTEGER NOT NULL,
    foreign key (doctorId) REFERENCES doctor(EmployeeID),
  Start DATETIME NOT NULL,
  End DATETIME NOT NULL
);
INSERT INTO Appointment1 VALUES(01,111111111,18,'2014-01-21 10:00','2014-01-28 11:00');
INSERT INTO Appointment1 VALUES(22,111111112,19,'2008-04-24 10:00','2008-04-24 11:00');
INSERT INTO Appointment1 VALUES(111,111111113,23,'2014-03-01 10:00','2014-03-09 11:00');
INSERT INTO Appointment1 VALUES(131,111111114,27,'2014-03-28 10:00','2014-03-31 11:00');
INSERT INTO Appointment1 VALUES(211,111111115,28,'2014-03-31 10:00','2014-04-10 11:00');

SELECT *, DATEDIFF (end, Start) AS DiffDays FROM ( SELECT Appointmentid, Patient AS PatientID,       
 Start, End,     
LAG( End,1,Null) OVER (PARTITION BY  Patient   ORDER BY Start, End) AS PreviousClaimEndDate     
 FROM Appointment1)lagselect;

select *  from Appointment1;

SELECT AppointmentID,Patient,doctorId,start,end FROM appointment1 ORDER BY start ASC;

SELECT AppointmentID, Patient AS PatientID,    
 start as ClaimStartDate, end as ClaimEndDate,
 LAG( End, 1, Null) OVER (PARTITION BY  Patient ORDER BY Start, End) AS PreviousClaimEndDate  FROM appointment1;
 
 SELECT *, DATEDIFF(PreviousClaimEndDate, Start) AS DiffDays FROM ( SELECT appointmentid, Patient AS PatientID,       
 Start, End,     
LAG( End, 1, Null) OVER (PARTITION BY  Patient   ORDER BY Start,End) AS PreviousClaimEndDate     
 FROM Appointment1)lagselect;

CREATE TABLE Medicine (
  MedCode INTEGER PRIMARY KEY NOT NULL,
  MedName TEXT NOT NULL,
  MedPrice INTEGER,
  MedBrand TEXT NOT NULL,
  MedGroup INTEGER, -- group id of similar medicines
  Description TEXT NOT NULL
);

CREATE TABLE prescription (
  doctorId INTEGER NOT NULL,
    foreign key (doctorId) REFERENCES doctor(EmployeeID),
  Patient INTEGER NOT NULL,
    foreign key (Patient) REFERENCES Patient(adhar_id),
  Medication INTEGER NOT NULL,
    foreign key (Medication) REFERENCES Medicine(MedCode),
  Date DATETIME NOT NULL,
  Appointment INTEGER,
    foreign key (Appointment) REFERENCES Appointment(AppointmentID),
  Dose TEXT NOT NULL,
  PRIMARY KEY(doctorId, Patient, Medication, Date)
);

/*
INSERT INTO doctor VALUES(1,'John Dorian','Staff Internist',111111111);


select * from Department;
INSERT INTO Department VALUES(1,'General Medicine',4);


INSERT INTO medical_departmets VALUES(1,1,1);


INSERT INTO Patient VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);


INSERT INTO Appointment VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');


INSERT INTO Medication VALUES(1,'Procrastin-X','X','N/A');

INSERT INTO prescription VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
*/
