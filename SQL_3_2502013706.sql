-- Assignment 3
-- 2502013706 - Shana Aurelia Novelyn Husni
USE OOVEO_Salon

-- No.1
SELECT MAX(Price) AS [Maximum Price], MIN(Price) AS [Minimum Price],
CAST(ROUND(AVG(Price),0) AS DECIMAL(18,2)) [Average Price]
	FROM MsTreatment

-- No.2
SELECT StaffPosition, LEFT(StaffGender, 1) AS [Gender],
CAST('Rp.' AS VARCHAR) + CAST(CAST(AVG(StaffSalary) AS DECIMAL(18,2)) AS VARCHAR) AS [Average Salary]
	FROM MsStaff
	GROUP BY StaffPosition, StaffGender

-- No.3
SELECT CONVERT(VARCHAR, TransactionDate, 107) as TransactionDate,
COUNT(TransactionId) AS [Total Transaction per Day]
	FROM HeaderSalonServices
	GROUP BY TransactionDate

-- No.4
SELECT UPPER(CustomerGender) AS [CustomerGender], COUNT(TransactionId) AS [Total Transaction]
	FROM HeaderSalonServices A
	JOIN MsCustomer B
		ON A.CustomerId = B.CustomerId
	GROUP BY CustomerGender

-- No.5 
SELECT B.TreatmentTypeName, COUNT(C.TransactionId) AS [Total Transaction]
	FROM MsTreatment A
	JOIN MsTreatmentType B
		ON A.TreatmentTypeId = B.TreatmentTypeId
	JOIN DetailSalonServices C
		ON A.TreatmentId = C.TreatmentId
	GROUP BY B.TreatmentTypeName
	ORDER BY [Total Transaction] desc

-- No. 6
SELECT CONVERT(VARCHAR, A.TransactionDate, 106) AS [Date],
CAST('Rp. 'AS VARCHAR) + CAST(SUM(Price)AS VARCHAR) AS [Revenue per Day]
	FROM HeaderSalonServices A
	JOIN DetailSalonServices B
		ON B.TransactionId = A.TransactionId
	JOIN MsTreatment C
		ON C.TreatmentId = B.TreatmentId
	GROUP BY A.TransactionDate
	HAVING SUM(Price) BETWEEN 1000000 AND 5000000

-- No.7
SELECT REPLACE(A.TreatmentTypeId, 'TT0','Treatment Type') AS [ID], A.TreatmentTypeName,
CAST(COUNT(B.TreatmentId)AS VARCHAR) + ' Treatment' AS [Total Treatment per Type]
	FROM MsTreatmentType A
	JOIN MsTreatment B
		ON A.TreatmentTypeId = B.TreatmentTypeId
	GROUP BY A.TreatmentTypeId, A.TreatmentTypeName
	HAVING COUNT(B.TreatmentId) > 5
	ORDER BY COUNT(B.TreatmentId) DESC

-- No.8
SELECT LEFT(A.StaffName, CHARINDEX(' ',A.StaffName) - 1) AS [StaffName],
B.TransactionId AS [TransactionID], COUNT(C.TreatmentId) AS [Total Treatment per Transaction]
	FROM MsStaff A
	JOIN HeaderSalonServices B
		ON B.StaffId = A.StaffId
	JOIN DetailSalonServices C
		ON C.TransactionId = B.TransactionId
	GROUP BY A.StaffName, B.TransactionId

-- No.9
SELECT A.TransactionDate, B.CustomerName, E.TreatmentName, E.Price
	FROM HeaderSalonServices A
	JOIN MsCustomer B
		ON B.CustomerId = A.CustomerId
	JOIN MsStaff C
		ON C.StaffId = A.StaffId
	JOIN DetailSalonServices D
		ON D.TransactionId = A.TransactionId
	JOIN MsTreatment E
		ON E.TreatmentId = D.TreatmentId
	WHERE DATENAME(weekday, TransactionDate) = 'Thursday' AND C.StaffName LIKE '%Ryan%'
	ORDER BY TransactionDate, B.CustomerName ASC

-- no.10
SELECT A.TransactionDate, B.CustomerName, SUM(D.Price) AS [Total Price]
	FROM HeaderSalonServices A
	JOIN MsCustomer B
		ON A.CustomerId = B.CustomerId
	JOIN DetailSalonServices C
		ON A.TransactionId = C.TransactionId
	JOIN MsTreatment D
		ON D.TreatmentId = C.TreatmentId
	WHERE DAY(A.TransactionDate) > 20
	GROUP BY A.TransactionDate, B.CustomerName
	ORDER BY TransactionDate