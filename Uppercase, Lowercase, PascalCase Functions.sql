--- Author: Ivinny Araujo
--- Summary: Case conversion functions in SQL Server (Uppercase, Lowercase, PascalCase)

  SELECT LOWER ([CompanyName]) AS CompanyName_lowercase
        ,UPPER ([CompanyName]) AS CompanyName_UPPERCASE
	,UPPER(SUBSTRING([CompanyName], 1, 1)) + LOWER(SUBSTRING([CompanyName], 2, LEN([CompanyName]))) AS CompanyName_PascalCase
  FROM [Training_dbo].[dbo].[Supplier]
