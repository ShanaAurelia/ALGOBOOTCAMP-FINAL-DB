-- Assignment 2
-- 2502013706 - Shana Aurelia Novelyn Husni
USE OOVEO_Salon

-- No.1
SELECT * FROM MsStaff
	WHERE StaffGender = 'Female'

-- No.2
SELECT StaffName, CAST('Rp. 'AS VARCHAR) + CAST(StaffSalary AS VARCHAR) 
AS StaffSalary
	FROM MsStaff
	WHERE StaffName LIKE '%M%' AND StaffSalary >= 10000000

-- No.3
SELECT TreatmentName, Price
	FROM MsTreatment
	WHERE TreatmentTypeId IN ('TT002', 'TT003')

-- No.4
SELECT StaffName, StaffPosition, CONVERT(VARCHAR, TransactionDate, 107) 
AS TransactionDate
	FROM HeaderSalonServices A
	JOIN MsStaff B
		ON A.StaffId = B.StaffId
		WHERE StaffSalary BETWEEN 700000 AND 10000000

-- No.5
SELECT SUBSTRING(CustomerName, 1, CHARINDEX(' ',CustomerName))
AS Name, LEFT(CustomerGender, 1) AS Gender, PaymentType AS 'Payment Type'
	FROM HeaderSalonServices A
	JOIN MsCustomer B
		ON A.CustomerId = B.CustomerId
		WHERE PaymentType = 'Debit'

-- No.6
SELECT LEFT(CustomerName, 1) + SUBSTRING(CustomerName, CHARINDEX(' ',CustomerName)+1, 1)
AS Initial, DATENAME(WEEKDAY, TransactionDate) AS DAY
	FROM HeaderSalonServices A
	JOIN MsCustomer B
		ON A.CustomerId = B.CustomerId
		Where DATEDIFF(DAY, '2012/12/24', TransactionDate) BETWEEN -2 AND 2

-- No.7
SELECT TransactionDate, REVERSE(SUBSTRING(REVERSE(CustomerName),1,CHARINDEX(' ',ReVERSE(CustomerName))-1))
AS CustomerName
	FROM HeaderSalonServices A
	JOIN MsCustomer B
		ON A.CustomerId = B.CustomerId
		WHERE CustomerName LIKE '% %' AND DATENAME(WEEKDAY, TransactionDate) = 'Saturday'

-- No.8
SELECT StaffName, CustomerName, REPLACE(CustomerPhone, '0', '+62')
AS CustomerPhone, CustomerAddress
	FROM HeaderSalonServices A
	JOIN MsCustomer B
		ON A.CustomerId = B.CustomerId
	JOIN MsStaff C
		ON A.StaffId = C.StaffId
		WHERE StaffName LIKE '% % %' AND CustomerName LIKE '[aiueo]%'

-- No.9
SELECT StaffName, TreatmentName, DATEDIFF(DAY, TransactionDate, '2021/12/24')
AS 'Term of Transaction'
	FROM DetailSalonServices A
	JOIN HeaderSalonServices B
		ON A.TransactionId = B.TransactionId
	JOIN MsStaff C
		ON B.StaffId = C.StaffId
	JOIN MsTreatment D
		ON A.TreatmentId = D.TreatmentId
	WHERE LEN(TreatmentName) > 20 OR TreatmentName LIKE '% %'

-- No.10
SELECT TransactionDate, CustomerName, TreatmentName, CAST(PRICE AS INT)*20/100 AS Discount,
PaymentType AS 'Payment Type'
	FROM DetailSalonServices A
	JOIN HeaderSalonServices B
		ON A.TransactionId = B.TransactionId
	JOIN MsStaff C
		ON B.StaffId = C.StaffId
	JOIN MsTreatment D
		ON A.TreatmentId = D.TreatmentId
	JOIN MsCustomer E
		ON B.CustomerId = E.CustomerId
	WHERE TransactionDate = '2012/12/22'