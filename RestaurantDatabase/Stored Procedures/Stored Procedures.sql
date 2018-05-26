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

		INSERT INTO Products(Name, Price) VALUES (@Name, @Price, @Quantity);
		INSERT INTO Beverages(ProductID) VALUES (IDENT_CURRENT('Products'));	
	END
GO