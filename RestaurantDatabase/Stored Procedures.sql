USE VelenicasRMS;  
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Aristan Fradejas
-- Create date: May 23, 2018
-- Description:	Deleting an Item on both Product and Beverage tables
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].usp_DeleteBeverage   
    @ID int
AS   
	BEGIN
		DELETE FROM Products WHERE ID = @ID
	END
GO

-- =============================================
-- Author:		Aristan Fradejas
-- Create date: May 23, 2018
-- Description:	Inserting an Item on both Product and Beverage tables
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].usp_AddBeverage   
    @Name nvarchar(max),
	@Price nvarchar(max)
AS   
	BEGIN
	
	DECLARE @ID INT
		INSERT INTO Products(Name, Price) VALUES (@Name, @Price);
		INSERT INTO Beverages(ProductID) VALUES (IDENT_CURRENT('Products'));	

		INSERT INTO [dbo].[InventoryItems]([ProductID], [InventoryID], [Quantity]) 
			VALUES(IDENT_CURRENT('Products'), IDENT_CURRENT('inventory'), 1)

		INSERT INTO [dbo].[MenuItems]([MenuID], [ProductID])
			VALUES(NULL, IDENT_CURRENT('Products'))
	END
GO

CREATE OR ALTER PROCEDURE [dbo].usp_UpdateBeverage   
	@ID INT,
    @Name nvarchar(max),
	@Price nvarchar(max)
AS   
	BEGIN
		UPDATE [dbo].[Products]
		SET [Name] = @Name, [Price] = @Price
		WHERE [ID] = @ID
	END
GO

-- =============================================
-- Author:		Tricia Ann Pelipas
-- Create date: May 26, 2018
-- Description:	C(R)UD Operations for Product and Food Tables
-- =============================================

---------- CREATE ----------
CREATE OR ALTER PROCEDURE [dbo].usp_AddFood 
	@name NVARCHAR(MAX), 
	@price DECIMAL(19,2),
	@personCount INT
AS
BEGIN
	INSERT INTO Products VALUES (@name, @price)
	INSERT INTO Foods VALUES (IDENT_CURRENT('Products'), @personCount)

	INSERT INTO [dbo].[InventoryItems]([ProductID], [InventoryID], [Quantity]) 
		VALUES(IDENT_CURRENT('Products'), IDENT_CURRENT('inventory'), 1)

	INSERT INTO [dbo].[MenuItems]([MenuID], [ProductID])
		VALUES(NULL, IDENT_CURRENT('Products'))
END
GO

---------- UPDATE -----------
CREATE OR ALTER PROCEDURE [dbo].usp_UpdateFood
	@name NVARCHAR(MAX), 
	@price DECIMAL(19,2), 
	@personCount INT,
	@ProductID INT
AS
BEGIN
	UPDATE Products
	SET Name = @name,
		Price = @price
	WHERE ID = @ProductID

	UPDATE Foods
	SET	PersonCount = @personCount
	WHERE [ProductID] = @ProductID
		 
END
GO

---------- DELETE ----------
CREATE OR ALTER PROCEDURE [dbo].usp_DeleteFood
	@ProductID INT
AS
BEGIN
	DELETE FROM Products WHERE @ProductID = Products.ID 
END
GO

-- MENU PROCEDURES
CREATE OR ALTER PROCEDURE AddMenuItem(@menuID INT, @productID INT) AS
	INSERT INTO MenuItems VALUES (@menuID, @productID)
GO

-- POS PROCEDURES
CREATE OR ALTER PROCEDURE AddNewTransaction AS
	INSERT INTO Orders VALUES(0,0,GETDATE())
GO

CREATE OR ALTER PROCEDURE AddToTransaction (@MenuItemID INT, @quant INT) AS
	DECLARE @totalPrice DECIMAL
	DECLARE @totalCount INT
	DECLARE @prodPrice DECIMAL
	SELECT @prodPrice = Price FROM Products WHERE ID IN (SELECT productID FROM MenuItems WHERE ID = @MenuItemID)
	INSERT INTO OrderItems VALUES (IDENT_CURRENT('Orders'), @MenuItemID, @quant, @prodPrice)
	SELECT @totalPrice = SUM(Price) FROM OrderItems WHERE OrderID = IDENT_CURRENT('orders')
	SELECT @totalCount = SUM(Quantity) FROM OrderItems WHERE OrderID = IDENT_CURRENT('orders')
	UPDATE Orders SET Total = @totalPrice, ItemCount = @totalCount WHERE ID = IDENT_CURRENT('orders')
GO

CREATE OR ALTER PROCEDURE UpdateTransaction (@tranID INT, @itemID INT, @itemQuant INT, @itemPrice DECIMAL) AS
	DECLARE @total DECIMAL
	DECLARE @count INT
	UPDATE OrderItems SET Quantity = @itemQuant, Price = @itemPrice 
	WHERE OrderID = @tranID AND MenuItemID = @itemID
	SELECT @total = SUM(Price) FROM OrderItems WHERE OrderID = @tranID
	SELECT @count = SUM(Quantity) FROM OrderItems WHERE OrderID = @tranID
	UPDATE Orders SET Total = @total, ItemCount = @count WHERE ID = @tranID
GO

CREATE OR ALTER PROCEDURE DeleteFromTransaction (@tranID INT, @itemID INT) AS
	DECLARE @totalPrice DECIMAL
	DECLARE @totalCount INT
	DELETE FROM OrderItems WHERE OrderID = @tranID AND MenuItemID = @itemID
	IF (SELECT SUM(Price) FROM OrderItems WHERE OrderID = IDENT_CURRENT('orders')) IS NOT NULL
		BEGIN
			SELECT @totalPrice = SUM(Price) FROM OrderItems WHERE OrderID = IDENT_CURRENT('orders');
			SELECT @totalCount = SUM(Quantity) FROM OrderItems WHERE OrderID = IDENT_CURRENT('orders');
		END
	ELSE
		BEGIN
			SET @totalCount = 0
			SET @totalPrice = 0
		END

	UPDATE Orders SET Total = @totalPrice, ItemCount = @totalCount WHERE ID = IDENT_CURRENT('orders')
GO

CREATE OR ALTER PROCEDURE DeleteTransaction (@tranID INT) AS
	DELETE FROM OrderItems WHERE OrderID = @tranID
	DELETE FROM Orders WHERE ID = @tranID
GO

-- --------------------------------------------------
-- Inventory Stored Procedures
-- --------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].usp_AddInventory 
	@Type NVARCHAR(MAX),
	@Date DATE,
	@SourceRecord INT
AS
	INSERT INTO [dbo].[Inventory]
	VALUES (@Date, @Type)

	DECLARE @Cursor CURSOR, @Current INT, @Quantity INT
	DECLARE @ID INT, @Name NVARCHAR(MAX)
		
	BEGIN
		SET @Cursor = CURSOR FOR SELECT [ID], [Name] FROM [dbo].[Products]

		OPEN @Cursor
		FETCH NEXT FROM @Cursor
		INTO @ID, @Name

		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT @SourceRecord
			PRINT @ID
			PRINT @Name
			SET @Current = IDENT_CURRENT('inventory')
			SET @Quantity = ISNULL((SELECT [Quantity] FROM [dbo].[InventoryItems] 
			WHERE [InventoryID] = @SourceRecord AND [ProductID] = @ID), 1)
			EXEC [dbo].[usp_AddInventoryItem] @ID, @Current, @Quantity

			FETCH NEXT FROM @Cursor
			INTO @ID, @Name
		END

		CLOSE @Cursor
		DEALLOCATE @Cursor
	END
GO

CREATE OR ALTER PROCEDURE [dbo].usp_AddInitialInventory 
	@Type NVARCHAR(MAX),
	@Date DATETIME
AS
	INSERT INTO [dbo].[Inventory]
	VALUES (@Date, @Type)

	DECLARE @Cursor CURSOR, @Current INT, @Quantity INT
	DECLARE @ID INT, @Name NVARCHAR(MAX)
	
	BEGIN
		SET @Cursor = CURSOR FOR SELECT [ID], [Name] FROM [dbo].[Products]

		OPEN @Cursor
		FETCH NEXT FROM @Cursor
		INTO @ID, @Name

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @Current = IDENT_CURRENT('inventory')
			EXEC [dbo].[usp_AddInventoryItem] @ID, @Current, 1

			FETCH NEXT FROM @Cursor
			INTO @ID, @Name
		END

		CLOSE @Cursor
		DEALLOCATE @Cursor
	END
GO

CREATE OR ALTER PROCEDURE [dbo].usp_UpdateInventory 
	@ID INT,
	@Type NVARCHAR(MAX),
	@Date DATE
AS
	UPDATE [dbo].[Inventory]
	SET [Date] = @Date, [Type] = @Type
	WHERE [ID] = @ID
GO

CREATE OR ALTER PROCEDURE [dbo].usp_DeleteInventory 
	@ID INT
AS
	DELETE [dbo].[Inventory]
	WHERE [ID] = @ID
GO

CREATE OR ALTER PROCEDURE [dbo].usp_AddInventoryItem 
	@ProductID INT,
	@InventoryID INT,
	@Quantity INT
AS
	INSERT INTO [dbo].[InventoryItems]
	VALUES (@ProductID, @InventoryID, @Quantity)
GO

CREATE OR ALTER PROCEDURE [dbo].usp_UpdateInventoryItem 
	@ID INT,
	@Quantity INT
AS
	UPDATE [dbo].[InventoryItems]
	SET [Quantity] = @Quantity
	WHERE [ID] = @ID
GO

CREATE OR ALTER PROCEDURE [dbo].usp_DeleteInventoryItem 
	@ID INT
AS
	DELETE [dbo].[InventoryItems]
	WHERE [ID] = @ID
GO

-- --------------------------------------------------
-- Product Menu Stored Procedures
-- --------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[usp_AddMenu]
	@Name NVARCHAR(MAX),
	@Description NVARCHAR(MAX)
AS
	INSERT INTO [dbo].[Menus]
	VALUES (@Name, @Description)
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_UpdateMenu]
	@ID INT,
	@Name NVARCHAR(MAX),
	@Description NVARCHAR(MAX)
AS
	UPDATE [dbo].[Menus]
	SET [Name] = @Name, [Description] = @Description
	WHERE [ID] = @ID
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_DeleteMenu]
	@ID INT
AS
	DELETE [dbo].[Menus]
	WHERE [ID] = @ID
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_GetProductsByMenuID]
	@MenuID INT
AS
IF (@MenuID IS NULL)
	BEGIN
		SELECT m.MenuID, p.ID, p.Name
		FROM [dbo].[MenuItems] m
		LEFT JOIN [dbo].[Products] p ON m.ProductID = p.ID
		WHERE m.MenuID IS NULL
	END
ELSE
	BEGIN
		SELECT m.MenuID, p.ID, p.Name
		FROM [dbo].[MenuItems] m
		LEFT JOIN [dbo].[Products] p ON m.ProductID = p.ID
		WHERE m.MenuID = @MenuID
	END
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_UpdateMenuID]
	@MenuID INT,
	@ProductID INT
AS
	UPDATE [dbo].[MenuItems]
	SET MenuID = @MenuID
	WHERE ProductID = @ProductID
GO

-- --------------------------------------------------
-- Reporting Stored Procedures
-- --------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[usp_FoodInvReport]
	@Date DATE
AS
	-- work week is set from tuesdays(start) to sundays(+5)
	DECLARE @today DATE, @tue DATE, @wed DATE, @thu DATE, @fri DATE, @sat DATE, @sun DATE
	
	IF (DATEPART(DW, @today) = 1)	-- checks if today is sunday, and changes date to saturday
		SET @Date = DATEADD(day, -1, @Date)

	DECLARE @start DATE
	SET @start = DATEADD(WEEK, DATEDIFF(WEEK, '19050103', @Date), '19050103')
	SET @tue = @start
	SET @wed = DATEADD(DAY, 1, @start)
	SET @thu = DATEADD(DAY, 2, @start)
	SET @fri = DATEADD(DAY, 3, @start)
	SET @sat = DATEADD(DAY, 4, @start)
	SET @sun = DATEADD(DAY, 5, @start)

	SELECT 
		p.Name, 
		t.Quantity,
		i.Date,
		i.Type
	FROM 
		Inventory AS i LEFT OUTER JOIN
		InventoryItems AS t ON i.ID = t.InventoryID LEFT OUTER JOIN
		Products AS p ON p.ID = t.ProductID
	WHERE
		CAST(i.Date AS date) IN (@tue, @wed, @thu, @fri, @sat, @sun) AND
		(p.ID IN(SELECT ProductID FROM Foods))	
GO
