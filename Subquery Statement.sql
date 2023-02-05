--- Author: Ivinny Araujo
--- Summary: Subquery Statement

--- Context: A Subquery is a query within another SQL query and embedded within the WHERE clause. It is used to return data that will be used in
---			 the main query as a condition to restrict the data to be retrieved.

--========================================================================================================================================================================================
---- Code briefing:		There are two tables: 1) contains the value of purchase per customer; 2) contains all the customers. We want to:
---							a) Find the total spent per each customer; 
---							b) Add FirstName and LastName attributes in a single attribute; 
---							c) Round Total_Purchase values with 2 decimal places
--================================================================================================

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