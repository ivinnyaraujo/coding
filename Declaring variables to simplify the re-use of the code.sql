--- Author: Ivinny Araujo
--- Summary: Declaring local variables in SQL queries to automate the re-use of your code

--- Context: By hardcoding our code, we make its maintenance timing consuming and complex. It will not only take more time to re-use, but it also increases the risk of
---          missing some variables in future use. If we declare key local variables in our code, it will help us to automate and re-use it and make the team more confident
---			 when sharing the code with stakeholders. See example below on how we can declare local variables.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----		The code below retrieves data from 3 different tables. The goal is to retrieve the product name purchased for all order numbers registered in a desired period of time,
----		as well as the name of the custumer for each OrderId. The key local variables declared are @start date and @stop date.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- Declare your local variables
DECLARE @start date
DECLARE @stop date

--- Set values for each local variable.
SET @start = '2013-01-01 00:00:00.000' --- Format: YYYY-MM-DD hh:mm:ss[.nnn]
SET @stop = '2013-06-30 00:00:00.000'  --- Format: YYYY-MM-DD hh:mm:ss[.nnn]

--- Run select statement
SELECT O.[OrderDate]
      ,O.[OrderNumber]
	  ,C.[FirstName]
	  ,C.[LastName]
	  ,P.[ProductName]
FROM [Training_dbo].[dbo].[Order] O
INNER JOIN [Training_dbo].[dbo].[Customer] C ON O.[CustomerId] = C.[Id]
INNER JOIN [Training_dbo].[dbo].[OrderItem] OI ON O.[Id] = OI.[OrderId]
INNER JOIN [Training_dbo].[dbo].[Product] P ON OI.[ProductId] = P.[Id]
WHERE O.[OrderDate] BETWEEN @start AND @stop
ORDER BY O.[OrderDate] ASC





