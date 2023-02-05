--- Author: Ivinny Araujo
--- Summary: Create Stored Procedures with Local Variables

--- Context: Stored Procedures (SP) allow us to easily re-use a code. It can be handy for queries we need to run frequently. Instead of running a big query, 
--- 		 SP allow us to retrieve the data with a few lines using the EXC function. Within a SP, we can declare values to allow multiple users to input
---			 the desired parameters to filter the data.
---			 SP are also a strategy to enhance db security, by restricting users from direct access to tables.
---			 SP also passes only the procedure name instead of the whole query, reducing network traffic.
---			 We may ask "why not creating a view instead?". A view is used when a select statement is needed (what could also be applicable for the example below).
---			 A SP is able to hold more complex logics, such as INSERT, DELETE and UPDATE statements to automate large SQL workflows.

--========================================================================================================================================================================================
---- Code briefing:		This stored procedure retrieves data from 3 different tables. The goal is to retrieve the product name purchased for all order numbers 
----					registered during a period of time, as well as the name of the custumer for each OrderId.
----					The key local variables declared are @start date and @stop date.

--================================================================================================
-- CREATE PROCEDURE
--================================================================================================
CREATE PROCEDURE dbo.spProductName_perOrdemId
	--- Declare your local variables and data types
	@start date,
	@stop date
AS

BEGIN
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
END

--================================================================================================
-- EXECUTE PROCEDURE SPECIFYING VARIABLE VALUES
--================================================================================================

EXEC dbo.spProductName_perOrdemId '@start','@stop'

EXEC dbo.spProductName_perOrdemId '2013-01-01 00:00:00.000','2013-06-30 00:00:00.000'




