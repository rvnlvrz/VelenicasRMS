SET ANSI_NULLS ON
GO
USE VelenicasRMS;  
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Aristan Fradejas
-- Create date: May 23, 2018
-- Description:	Deleting an Item on both Product and Beverage tables
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].uspDeleteBeverage   
    @ID int
AS   
    SET NOCOUNT ON; 
	BEGIN
		DELETE FROM Products WHERE ID = @ID
	END
GO

-- =============================================
-- Author:		Aristan Fradejas
-- Create date: May 23, 2018
-- Description:	Inserting an Item on both Product and Beverage tables
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].uspInsertBeverage   
    @Name nvarchar(max),
	@Price nvarchar(max)
AS   
    SET NOCOUNT ON; 
	BEGIN
	
	DECLARE @ID INT

		INSERT INTO Products(Name, Price) VALUES (@Name, @Price);
		INSERT INTO Beverages(ProductID) VALUES (IDENT_CURRENT('Products'));	
	END
GO

CREATE OR ALTER PROCEDURE [dbo].uspUpdateBeverage                                                  
    @Name nvarchar(max),
	@Price nvarchar(max)
AS   
    SET NOCOUNT ON; 
	BEGIN
		UPDATE [dbo].[Products]
		SET [Name] = @Name, [Price] = @Price
	END
GO

-- =============================================
-- Author:		Tricia Ann Pelipas
-- Create date: May 26, 2018
-- Description:	C(R)UD Operations for Product and Food Tables
-- =============================================

---------- CREATE ----------
CREATE OR ALTER PROCEDURE [dbo].uspInsertFood 
	@name NVARCHAR(MAX), 
	@price DECIMAL(19,2),
	@personCount INT
AS
BEGIN
	INSERT INTO Products VALUES (@name, @price)
	INSERT INTO Foods VALUES (IDENT_CURRENT('Products'), @personCount)
END
GO

---------- UPDATE -----------
CREATE OR ALTER PROCEDURE [dbo].uspUpdateFood
	@name NVARCHAR(MAX), 
	@price DECIMAL(19,2), 
	@personCount INT,
	@ProductID INT
AS
BEGIN
	SET NOCOUNT ON;
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
CREATE OR ALTER PROCEDURE [dbo].uspDeleteFood
	@ProductID INT
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM Foods WHERE ProductID = @ProductID
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