--- Author: Ivinny Araujo
--- Summary: Join Type Statements

--- Context: In a relational database, data professionals may often want to retrieve data from multiple related tables.
---			 Depending on the relationship we want, we can use different join type statements. The most common statements are:
---			a) INNER JOIN/JOIN, LEFT JOIN, RIGH JOIN, FULL JOIN, CROSS JOIN

--========================================================================================================================================================================================
---- Code briefing:		See below the example for each join type.
--================================================================================================
-- JOIN TYPES STATEMENTS
--================================================================================================

--- JOIN or INNER JOIN: are functionally equivalent. Retrieve data that intersects both tables.
--- Total rows retrieved: 830
SELECT C.[Id]
    ,C.[FirstName]
    ,C.[LastName]
    ,C.[City]
    ,C.[Country]
    ,C.[Phone]
	,O.[OrderDate]
    ,O.[OrderNumber]
    ,O.[TotalAmount]
FROM [Training_dbo].[dbo].[Customer] C
INNER JOIN [Training_dbo].[dbo].[Order] O ON C.[Id] = O.[CustomerId]

--- LEFT OUTER JOIN: Retrieve all data for [Customer] table and all data that intersects both tables. 
--- Total rows retrieved: 832 (in this query we have 2 customers that have no purchase order registered).
SELECT C.[Id]
    ,C.[FirstName]
    ,C.[LastName]
    ,C.[City]
    ,C.[Country]
    ,C.[Phone]
	,O.[OrderDate]
    ,O.[OrderNumber]
    ,O.[TotalAmount]
FROM [Training_dbo].[dbo].[Customer] C
LEFT OUTER JOIN [Training_dbo].[dbo].[Order] O ON C.[Id] = O.[CustomerId]

--- ANTI LEFT OUTER JOIN: Retrieve all data for [Customer] table that is not intersecting with [Order] table.
--- Total rows retrieved: 2 (it means 2 customers have not done any purchases yet).
SELECT C.[Id]
    ,C.[FirstName]
    ,C.[LastName]
    ,C.[City]
    ,C.[Country]
	,C.[Phone]
	,O.[OrderDate]
	,O.[OrderNumber]
	,O.[TotalAmount]
FROM [Training_dbo].[dbo].[Customer] C
LEFT OUTER JOIN [Training_dbo].[dbo].[Order] O ON C.[Id] = O.[CustomerId]
WHERE O.[CustomerId] IS NULL

--- RIGHT OUTER JOIN: Retrieve all data for [Order] table and all data that intersects both tables. 
--- Total rows retrieved: 830 (same result as INNER JOIN, because C.[Id] is the Primary Key at Customer table).
SELECT C.[Id]
    ,C.[FirstName]
    ,C.[LastName]
    ,C.[City]
    ,C.[Country]
    ,C.[Phone]
	,O.[OrderDate]
    ,O.[OrderNumber]
    ,O.[TotalAmount]
FROM [Training_dbo].[dbo].[Customer] C
RIGHT OUTER JOIN [Training_dbo].[dbo].[Order] O ON C.[Id] = O.[CustomerId]

--- ANTI RIGHT OUTER JOIN: retrieve all data for [Order] table that is not intersecting with [Customer] table. 
--- Total rows retrieved: 0 (zero results because each order must have a customer).
SELECT C.[Id]
    ,C.[FirstName]
    ,C.[LastName]
    ,C.[City]
    ,C.[Country]
    ,C.[Phone]
	,O.[OrderDate]
    ,O.[OrderNumber]
    ,O.[TotalAmount]
FROM [Training_dbo].[dbo].[Customer] C
RIGHT OUTER JOIN [Training_dbo].[dbo].[Order] O ON C.[Id] = O.[CustomerId]
WHERE C.[Id] IS NULL
 
--- ANTI OUTER JOIN: returns any unique values for each table (excludes all data intersected).
--- Total rows retrieved: 2 (from [Customer] table)
SELECT C.[Id]
    ,C.[FirstName]
    ,C.[LastName]
    ,C.[City]
    ,C.[Country]
    ,C.[Phone]
	,O.[OrderDate]
    ,O.[OrderNumber]
    ,O.[TotalAmount]
FROM [Training_dbo].[dbo].[Customer] C
FULL OUTER JOIN [Training_dbo].[dbo].[Order] O ON C.[Id] = O.[CustomerId]
WHERE C.[Id] IS NULL OR O.[CustomerId] IS NULL

--- FULL JOIN: returns any unique values for each table + intersected data.
--- Total rows retrieved: 832
SELECT C.[Id]
    ,C.[FirstName]
    ,C.[LastName]
    ,C.[City]
    ,C.[Country]
    ,C.[Phone]
	,O.[OrderDate]
    ,O.[OrderNumber]
    ,O.[TotalAmount]
FROM [Training_dbo].[dbo].[Customer] C
FULL JOIN [Training_dbo].[dbo].[Order] O ON C.[Id] = O.[CustomerId]

--- CROSS JOIN: get all possible combinations between 2 tables. It generates a paired combination of each row
---				from table A with table B. When using this statement, we should consider the number of rows 
---				that with be combined, because Cross Join can consume high resources and cause performance issues
---				in the database.
---				The example below cross join each customer with each product available.
--- Total rows retrieved: 7,098  (91 customers X 78 product types)
SELECT C.[Id]
    ,C.[FirstName]
    ,C.[LastName]
	,P.[ProductName]
FROM [Training_dbo].[dbo].[Customer] C
CROSS JOIN [Training_dbo].[dbo].[Product] P
