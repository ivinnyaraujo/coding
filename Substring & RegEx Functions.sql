--- Author: Ivinny Araujo
--- Summary: This file contains a summary of some Substring and RegEx Functions in SQL Server
---			 It aims to support SQL users to smartly retrieve data to support data professionals.

--- Context: Databases have the data stored in an organized manner. However, we may come across situations where we need to retrieve 
---          the data but we don’t have a specific filter to achieve this. For such cases, Substring and RegEx (Regular Expressions) functions can help us to retrieve the 
---          data we need. Subtring Functions returns a portion of a character string, while RegEx are generalized expressions used to match patterns with various sequences of characters.
---			 See a few examples below.

--- Attention!! 
--- You must have some idea of the form of the data before you specify a substring function.
--- Check if the database collation is case-insensitive.

---		Exemples:

---     Returns the first letter of a person Lastname in a CONCAT function that merges the Customer FirstName and the 1st letter of the LastName (start at initial position 1 and extracts 1 character)
		SELECT CONCAT (FirstName, ' ', SUBSTRING(LastName,1,1)) AS CustomerShortName
		FROM [Training_dbo].[dbo].[Customer]

---     Returns all Customers in which LastName starts with letter 'A'
		SELECT * FROM [Training_dbo].[dbo].[Customer]
		WHERE SUBSTRING (LastName,1,1) = 'A'

---     Returns all Customers in which Country starts with letter 'B' OR 'C'
		SELECT * FROM [Training_dbo].[dbo].[Customer]
		WHERE [Country] LIKE '[BC]%'

---     Returns all Customers in which Country starts with letter 'B' and the 2nd letter is 'R'
		SELECT * FROM [Training_dbo].[dbo].[Customer]
		WHERE [Country] LIKE '[B][R]%'

---     Returns all Customers in which Country starts with characters ranging from 'A' to 'G'
		SELECT * FROM [Training_dbo].[dbo].[Customer]
		WHERE [Country] LIKE '[A-G]%'
		ORDER BY Country

---     Returns all Customers in which Country ends with 'E'
		SELECT * FROM [Training_dbo].[dbo].[Customer]
		WHERE [Country] LIKE '%[E]%'
		ORDER BY Country

---     Returns all Customers in which Country starts ranging from 'A' to 'M' and ends with 'E'
		SELECT * FROM [Training_dbo].[dbo].[Customer]
		WHERE [Country] LIKE '[A-M]%[E]'
		ORDER BY Country

---     Returns all Customers in which Country do not start ranging from 'A' to 'M'
		SELECT * FROM [Training_dbo].[dbo].[Customer]
		WHERE [Country] LIKE '[^A-M]%'
		ORDER BY Country

