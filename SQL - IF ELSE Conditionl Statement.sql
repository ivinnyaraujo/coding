--- Author: Ivinny Araujo
--- Summary: IF ELSE Conditional Statement

--- Context: From time to time we need to add logic to our data to incorporate conditions based decisions in a programming logic format. SQL IF ELSE statement is one of the 
--- 		 conditional statements that allow us to achieve this.
---			 A) "IF" should return a Boolean value to evaluate. If TRUE, execute conditional statement. IF FALSE, execute else conditional statement.
---			 B) "ELSE" is optional to use. ELSE is used when we want to setup a value if the condition is FALSE. Otherwise, no values will be returned.
---			
--================================================================================================
-- See SQL IF Else statements examples
--================================================================================================

--A) IF statements with a numeric value in a Boolean expression

	IF ((5*564) > (76*9)) -- If the condition is TRUE then execute the following statement
		PRINT 'A > B' 	-- If the condition is False then execute the following statement
		ELSE
		PRINT 'A < B'

--B) IF statements with a variable in a Boolean expression

	DECLARE @ProductWeight DECIMAL= 25 -- Declare your local variables and data types
	IF @ProductWeight >= 67.90
		PRINT 'Light Item'
		ELSE
		PRINT 'Heavy Item. Delivery should be requested'

--C) Multiple IF ELSE statements: this example uses the Body Mass Index (BMI) Scale.

	DECLARE @BMI DECIMAL(5,2) = 25.7 -- Declare your local variables and data types
	IF (@BMI BETWEEN 18.5 AND 24.9)
		PRINT 'Person is normal'
	ELSE IF (@BMI BETWEEN 25 AND 29.9)
		PRINT 'Person is overweight. Visit a doctor'
	ELSE IF (@BMI BETWEEN 30 AND 34.9)
		PRINT 'Person is obese. Visit a doctor'
	ELSE IF (@BMI > 35)
		PRINT 'Person is extremely obese. Visit a doctor'
	ELSE
		PRINT 'Person is underweight. Visit a doctor'

--- OR

	DECLARE @FirstName NVARCHAR(50) = 'Ivinny' -- Declare your local variables and data types
	DECLARE @LastName NVARCHAR(50) = 'Santos' -- Declare your local variables and data types
	IF (@FirstName = 'Ivinny' AND @LastName = 'Araujo')
	PRINT 'It is me'
	ELSE
		PRINT 'Not me. Verify identity'

--D) Multiple IF statements without Else statement (if the expression is NOT True, it does not return any output)

	DECLARE @BMI DECIMAL(5,2) = 18 -- Declare your local variables and data types
	IF (@BMI < 18.5)
		PRINT 'Person is underweight'
	ELSE IF (@BMI BETWEEN 18.5 AND 24.9)
		PRINT 'Person is normal'
	ELSE IF (@BMI BETWEEN 25 AND 29.9)
		PRINT 'Person is overweight. Visit a doctor'
	ELSE IF (@BMI BETWEEN 30 AND 34.9)
		PRINT 'Person is obese. Visit a doctor'
	ELSE IF (@BMI > 35)
		PRINT 'Person is extremely obese. Visit a doctor'

--E) Conditional script execution: in the example below, if customer name is equal to Maria or Paula, it will select records for all customers with 1st name equals to Maria or Paula.
--								   Otherwise, it will display a message 'No purchase filter for this customer is available'.

	DECLARE @customer NVARCHAR(50) = 'Maria' -- Declare your local variables and data types
	IF @customer IN ('Maria', 'Paula')
		SELECT O.[OrderDate]
		  ,O.[OrderNumber]
		  ,C.[FirstName]
		  ,C.[LastName]
		  ,P.[ProductName]
		  ,P.[UnitPrice]
		FROM [Training_dbo].[dbo].[Order] O
		INNER JOIN [Training_dbo].[dbo].[Customer] C ON O.[CustomerId] = C.[Id]
		INNER JOIN [Training_dbo].[dbo].[OrderItem] OI ON O.[Id] = OI.[OrderId]
		INNER JOIN [Training_dbo].[dbo].[Product] P ON OI.[ProductId] = P.[Id]
		WHERE C.[FirstName] = @customer
		ORDER BY O.[OrderDate] ASC
	ELSE
		PRINT 'No purchase filter for this customer is available'
