SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
