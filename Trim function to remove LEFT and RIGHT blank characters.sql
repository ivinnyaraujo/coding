--- Author: Ivinny Araujo
--- Summary: This query helps in the data cleaning process by trimming blank characters that may be present in the beginning and end of values

DECLARE @DeclaredVariable AS VARCHAR(100) --- declaring a sample value
SET @DeclaredVariable = '           Sample Value                    ' --- value contain blank characters in the right and left side of the value 'Sample Value'
SELECT @DeclaredVariable AS DeclaredVariable, RTRIM(LTRIM(@DeclaredVariable)) AS DeclaredVariable_Trimmed --- Trim right and left blank spaces



