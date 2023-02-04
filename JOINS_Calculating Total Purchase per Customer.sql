--- Author: Ivinny Araujo
--- Context: There are two tables: 1) contains the value of purchase per customer; 2) contains all the customers
--- Script Goal: a) Find the total spent by each customer; b) Add FirstName and LastName attributes in a single attribute; 
---				 c) Round Total_Purchase values with 2 decimal places

SELECT 
	TP.CustomerId,
	(C.FirstName + ' ' +C.LastName) AS CustomerFullName,
	C.Country,
	ROUND(TP.Total_Purchase,2) AS Total_Purchase
FROM [Training_dbo].[dbo].[Customer] C
JOIN (
		SELECT SUM(TotalAmount) AS Total_Purchase,
		CustomerId
		FROM [Training_dbo].[dbo].[Order] 
		GROUP BY CustomerId
		) TP
ON C.Id = TP.CustomerId
ORDER BY Total_Purchase DESC