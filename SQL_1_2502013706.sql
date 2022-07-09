-- Assignment 1
-- 2502013706 - Shana Aurelia Novelyn Husni
USE salon

-- No. 1
CREATE TABLE MsCustomer(
	CustomerId CHAR(5) PRIMARY KEY NOT NULL,
	CustomerName VARCHAR(50),
	CustomerGender VARCHAR(10),
	CustomerPhone VARCHAR(13),
	CustomerAddress VARCHAR(100),
	
	CONSTRAINT validate_CID
		CHECK(CustomerId LIKE 'CU[0-9][0-9][0-9]'),
	CONSTRAINT validate_CGender
		CHECK(CustomerGender = 'Male' OR CustomerGender = 'Female')
)

CREATE TABLE MsStaff(
	StaffId CHAR(5) PRIMARY KEY NOT NULL,
	StaffName VARCHAR(50),
	StaffGender VARCHAR(10),
	StaffPhone VARCHAR(13),
	StaffAddress VARCHAR(100),
	StaffSalary NUMERIC(11,2),
	StaffPosition VARCHAR(20),

	CONSTRAINT validate_SID
		CHECK(StaffId LIKE 'SF[0-9][0-9][0-9]'),
	CONSTRAINT validate_SGender
		CHECK(StaffGender = 'Male' OR StaffGender = 'Female')
)

CREATE TABLE MsTreatmentType(
	TreatmentTypeId CHAR(5) PRIMARY KEY NOT NULL,
	TreatmentTypeName VARCHAR(50),

	CONSTRAINT validate_MTID
		CHECK(TreatmentTypeId LIKE 'TT[0-9][0-9][0-9]')
)

CREATE TABLE MsTreatment(
	TreatmentId CHAR(5) PRIMARY KEY NOT NULL,
	TreatmentTypeId CHAR(5) NOT NULL,
	TreatmentName VARCHAR(50),
	Price NUMERIC(11,2),

	CONSTRAINT validate_MTID
		CHECK(TreatmentId LIKE 'TM[0-9][0-9][0-9]'),
	CONSTRAINT validate_MTTMTID
		FOREIGN KEY(TreatmentTypeId) REFERENCES MsTreatmentType(TreatmentTypeId)
		ON UPDATE CASCADE
)

CREATE TABLE HeaderSalonServices(
	TransactionId CHAR(5) PRIMARY KEY NOT NULL,
	CustomerId CHAR(5) NOT NULL,
	StaffId CHAR(5) NOT NULL,
	TransactionDate DATE,
	PaymentType VARCHAR(20),

	CONSTRAINT validate_IDT
		CHECK(TransactionId LIKE 'TR[0-9][0-9][0-9]'),
	CONSTRAINT validate_MSCCID
		FOREIGN KEY(CustomerId) REFERENCES MsCustomer(CustomerId)
		ON UPDATE CASCADE,
	CONSTRAINT validate_MSSID
		FOREIGN KEY(StaffId) REFERENCES MsStaff(StaffId)
		ON UPDATE CASCADE
)

CREATE TABLE DetailSalonServices(
	TransactionId CHAR(5) NOT NULL,
	TreatmentId CHAR(5) NOT NULL,

	CONSTRAINT HSSTID
		FOREIGN KEY(TransactionId) REFERENCES HeaderSalonServices(TransactionId)
		ON UPDATE CASCADE,
	CONSTRAINT MSTDSS
		FOREIGN KEY(TreatmentId) REFERENCES MsTreatment(TreatmentId)
		ON UPDATE CASCADE,
	CONSTRAINT PKEY_DSS
		PRIMARY KEY(TransactionId, TreatmentId)
)

-- No. 2
DROP TABLE DetailSalonServices

-- No. 3
CREATE TABLE DetailSalonServices(
	TransactionId CHAR(5) NOT NULL,
	TreatmentId CHAR(5) NOT NULL,

	CONSTRAINT HSSDSS_TID
		FOREIGN KEY(TransactionId) REFERENCES HeaderSalonServices(TransactionId)
		ON UPDATE CASCADE,
	CONSTRAINT MSTDSS_TRID
		FOREIGN KEY(TreatmentId) REFERENCES MsTreatment(TreatmentId)
		ON UPDATE CASCADE
)
ALTER TABLE DetailSalonServices
	ADD CONSTRAINT PK_DSS_w
		PRIMARY KEY(TransactionId, TreatmentId)

-- No.4 
ALTER TABLE MsStaff WITH NOCHECK
	ADD CONSTRAINT validate_SName
		CHECK(LEN(StaffName) >= 5 AND LEN(StaffName) <= 20)

ALTER TABLE MsStaff
	DROP CONSTRAINT validate_SName

-- No. 5
ALTER TABLE MsCustomer
	ADD Description VARCHAR(100)

ALTER TABLE MsCustomer
	DROP COLUMN Description