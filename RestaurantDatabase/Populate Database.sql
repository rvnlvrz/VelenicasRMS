USE VelenicasRMS
GO

--ALTER TABLE [dbo].[Inventory]
--ALTER COLUMN [Date] DATETIME
--GO

DECLARE @Date DATETIME = GETDATE(), @ID INT
EXEC [dbo].[uspInsertInitialInventory] N'Initial Tally', @Date
GO

-- Insert Food Products
EXEC [dbo].[uspInsertFood] N'Spring Rolls', 100, 1
EXEC [dbo].[uspInsertFood] N'Pork Sinigang', 275, 3
EXEC [dbo].[uspInsertFood] N'Salmon with Mango Salsa', 175, 1
EXEC [dbo].[uspInsertFood] N'Domingo''s Beefsteak', 145, 1
EXEC [dbo].[uspInsertFood] N'Breakfast Bangus', 100, 1
GO

-- Insert Beverage Products
EXEC [dbo].[uspInsertBeverage] N'Strawberry Milkshake', 85
EXEC [dbo].[uspInsertBeverage] N'Hazelnut Coffee', 60
EXEC [dbo].[uspInsertBeverage] N'Brewed Iced Tea', 45
EXEC [dbo].[uspInsertBeverage] N'Four Seasons', 50
GO

-- Insert Inventory Records
DECLARE @Date DATETIME = GETDATE(), @ID INT
SET @Date = DATEADD(HOUR, 14, @Date)
SET @ID = IDENT_CURRENT('inventory')
EXEC [dbo].[uspInsertInventory] N'Closing', @Date, @ID

SET @Date = DATEADD(HOUR, 10, @Date)
SET @ID = IDENT_CURRENT('inventory')
EXEC [dbo].[uspInsertInventory] N'Opening', @Date, @ID
GO