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
	@Price nvarchar(max),
	@Quantity nvarchar(max)
AS   
    SET NOCOUNT ON; 
	BEGIN
	
	DECLARE @ID INT

		INSERT INTO Products(Name, Price) VALUES (@Name, @Price);
		INSERT INTO Beverages(ProductID) VALUES (IDENT_CURRENT('Products'));	
	END
GO

-- =============================================
-- Author:		Tricia Ann Pelipas
-- Create date: May 26, 2018
-- Description:	C(R)UD Operations for Product and Food Tables
-- =============================================

---------- CREATE ----------
CREATE OR ALTER PROCEDURE [dbo].AddFood 
	@name NVARCHAR(MAX), 
	@price NVARCHAR(MAX),
	@personCount INT
AS
BEGIN
	INSERT INTO Products VALUES (@name, @price)
	INSERT INTO Foods VALUES (IDENT_CURRENT('Products'), @personCount)
END
GO

---------- UPDATE -----------
CREATE OR ALTER PROCEDURE [dbo].updateFood
	@name NVARCHAR(MAX), 
	@price NVARCHAR(MAX), 
	@ProductID INT
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE Products
	SET Name = @name,
		Price = @price
	WHERE EXISTS (Select @ProductID from Foods where @ProductID = Products.ID)
		 
END
GO

---------- DELETE ----------
CREATE OR ALTER PROCEDURE [dbo].deleteFood
	@ProductID INT
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM Foods WHERE ProductID = @ProductID
	DELETE FROM Products WHERE @ProductID = Products.ID
 
END
GO