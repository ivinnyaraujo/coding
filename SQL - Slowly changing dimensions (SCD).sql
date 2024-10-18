//*
Slowly changing dimensions (SCD)
Slowly Changing Dimensions change over time, but at a slow pace and unpredictably. For example, a customer’s address in a retail business. When a customer moves, their address changes. If you overwrite the old address with the new one, you lose the history. But if you want to analyze historical sales data, you might need to know where the customer lived at the time of each sale. This is where SCDs come into play.

There are several types of slowly changing dimensions in a data warehouse, with type 1 and type 2 being the most frequently used.

Type 0 SCD: The dimension attributes never change.
Type 1 SCD: Overwrites existing data, doesn't keep history.
Type 2 SCD: Adds new records for changes, keeps full history for a given natural key.
Type 3 SCD: History is added as a new column.
Type 4 SCD: A new dimension is added.
Type 5 SCD: When certain attributes of a large dimension change over time, but using type 2 isn't feasible due to the dimension’s large size.
Type 6 SCD: Combination of type 2 and type 3.
In type 2 SCD, when a new version of the same element is brought to the data warehouse, the old version is considered expired and the new one becomes active.


The following example shows how to handle changes in a type 2 SCD for the Dim_Products table using T-SQL.

Source: https://learn.microsoft.com/en-us/training/modules/load-data-into-microsoft-fabric-data-warehouse/2-explore-data-load-strategies

*//

IF EXISTS (SELECT 1 FROM Dim_Products WHERE SourceKey = @ProductID AND IsActive = 'True')
BEGIN
    -- Existing product record
    UPDATE Dim_Products
    SET ValidTo = GETDATE(), IsActive = 'False'
    WHERE SourceKey = @ProductID AND IsActive = 'True';
END
ELSE
BEGIN
    -- New product record
    INSERT INTO Dim_Products (SourceKey, ProductName, StartDate, EndDate, IsActive)
    VALUES (@ProductID, @ProductName, GETDATE(), '9999-12-31', 'True');
END