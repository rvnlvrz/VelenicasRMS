DROP PROCEDURE [dbo].deleteBeverage 
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Aristan Fradejas
-- Create date: May 23, 2018
-- Description:	Deleting an Item on both Product and Beverage tables
-- =============================================
USE VelenicasRMS;  
GO
CREATE PROCEDURE [dbo].deleteBeverage   
    @ID int
AS   
    SET NOCOUNT ON; 
	BEGIN
		DELETE FROM Products WHERE ID = @ID
	END
	
-- EXECUTE dbo.deleteBeverage @ID = 2
	
	