USE VelenicasRMS
GO

SET NOCOUNT ON
GO

DECLARE @Date DATE = GETDATE(), @ID INT
EXEC [dbo].[usp_AddInitialInventory] N'Opening', @Date

----SELECT * FROM Menus
INSERT INTO Menus VALUES (N'Breakfast Plates','')
INSERT INTO Menus VALUES (N'Starters','')
INSERT INTO Menus VALUES (N'Best Sellers','')
INSERT INTO Menus VALUES (N'Pasta','')

INSERT INTO Menus VALUES (N'Daily Specials','')
INSERT INTO Menus VALUES (N'Other Choices','')
INSERT INTO Menus VALUES (N'Merienda Special','')
INSERT INTO Menus VALUES (N'By the Grill','')

INSERT INTO Menus VALUES (N'Drinks','')
INSERT INTO Menus VALUES (N'Seafood Lovers','')
INSERT INTO Menus VALUES (N'Desserts','')
INSERT INTO Menus VALUES (N'Extras','')
GO

-- Breakfast Plates
EXEC [dbo].[usp_AddFood] N'Tapa', 132, 5
EXEC [dbo].[usp_AddFood] N'Tocino', 94, 2
EXEC [dbo].[usp_AddFood] N'Traditional Imus Longganisa', 55, 1
EXEC [dbo].[usp_AddFood] N'Shanghai Rolls', 250, 6

-- Pasta
EXEC [dbo].[usp_AddFood] N'Chicken and Bacon Penne Pasta', 150, 2
EXEC [dbo].[usp_AddFood] N'Lasagna', 75, 1
EXEC [dbo].[usp_AddFood] N'Spaghetti', 90, 1

-- Merienda Special
EXEC [dbo].[usp_AddFood] N'Clubhouse with Chips on Top', 120, 2
EXEC [dbo].[usp_AddFood] N'Clubhouse Solo', 60, 1
EXEC [dbo].[usp_AddFood] N'Pancit Bihon Guisado', 175, 2
EXEC [dbo].[usp_AddFood] N'Pancit Sotanghon', 120, 2


-- Seafood Lovers
EXEC [dbo].[usp_AddFood] N'Fried Bangus Inasal', 75, 1
EXEC [dbo].[usp_AddFood] N'Boneless Daing na Bangus', 50, 1
--EXEC AddFood N'Camaron Rebusado', 75, 1

-- Starters
EXEC [dbo].[usp_AddFood] N'Ultimate Nachos', 190, 4
EXEC [dbo].[usp_AddFood] N'Buffalo Wings', 170, 2
EXEC [dbo].[usp_AddFood] N'Crunchy Tacos', 190, 4
EXEC [dbo].[usp_AddFood] N'Fench Fries', 50, 1
EXEC [dbo].[usp_AddFood] N'Mojos', 200, 4
EXEC [dbo].[usp_AddFood] N'Pork Shanghai Rolls', 250, 3

-- Daily Specials
EXEC [dbo].[usp_AddFood] N'Adobosilog', 50, 1
EXEC [dbo].[usp_AddFood] N'Hungarian Sausage', 90, 1
EXEC [dbo].[usp_AddFood] N'Beef Mechado', 270, 5
EXEC [dbo].[usp_AddFood] N'Lechon Kawali', 290, 5

-- By the grill
EXEC [dbo].[usp_AddFood] N'Baby Back Ribs', 170, 1
EXEC [dbo].[usp_AddFood] N'Pork BBQ', 100, 1
EXEC [dbo].[usp_AddFood] N'Grilled Liempo', 175, 1
EXEC [dbo].[usp_AddFood] N'Spicy Grilled Liempo', 125, 1
EXEC [dbo].[usp_AddFood] N'Pork BBQ Trio', 300, 3

-- Desserts
EXEC [dbo].[usp_AddFood] N'Choco Cherry Cream Cake', 250, 3
EXEC [dbo].[usp_AddFood] N'Blueberry Cheesecake', 300, 2
EXEC [dbo].[usp_AddFood] N'Sinful Chocolate Cake', 200, 2
EXEC [dbo].[usp_AddFood] N'Litlle Clan Choco Ice Cream', 170, 2
EXEC [dbo].[usp_AddFood] N'Brownie Ala Mode', 55, 1

-- Best Sellers
EXEC [dbo].[usp_AddFood] N'Domingo''s Beefsteak', 350, 4
EXEC [dbo].[usp_AddFood] N'Velenica''s Special Kare Kare', 400, 3
EXEC [dbo].[usp_AddFood] N'Emilio''s Fried Chicken', 250, 2
EXEC [dbo].[usp_AddFood] N'Crispy Pata', 200, 3
EXEC [dbo].[usp_AddFood] N'Sizzling Sisig', 150, 2

-- Other Choices
EXEC [dbo].[usp_AddFood] N'Traditional Egg Drop Soup', 250, 2
EXEC [dbo].[usp_AddFood] N'Feisty Hungarian Sausage', 200, 2
EXEC [dbo].[usp_AddFood] N'Chopsuey', 100, 2
EXEC [dbo].[usp_AddFood] N'Pork Liempo Sinigang', 125, 2

-- Drinks
EXEC usp_AddBeverage N'Water', 25
EXEC usp_AddBeverage N'Iced Tea', 30
EXEC usp_AddBeverage N'Coke', 45
EXEC usp_AddBeverage N'Sprite', 40

-- Extras
EXEC [dbo].[usp_AddFood] N'Atsara', 20, 1
EXEC [dbo].[usp_AddFood] N'Egg', 10, 1
EXEC [dbo].[usp_AddFood] N'Toasted Bread', 15, 1
EXEC [dbo].[usp_AddFood] N'Bagoong', 5, 1
EXEC [dbo].[usp_AddFood] N'Plain Rice', 20, 1
EXEC [dbo].[usp_AddFood] N'Garlic Rice', 25, 1
EXEC [dbo].[usp_AddFood] N'Java Rice', 30, 1
GO

---- Breakfast Plates
--EXEC AddMenuItem 1, 1
--EXEC AddMenuItem 1, 2
--EXEC AddMenuItem 1, 4
--EXEC AddMenuItem 1, 5
--GO

---- Pasta
--EXEC AddMenuItem 4, 6
--EXEC AddMenuItem 4, 7
--EXEC AddMenuItem 4, 8
--GO

---- Merienda Special
--EXEC AddMenuItem 7, 9
--EXEC AddMenuItem 7, 10
--EXEC AddMenuItem 7, 11
--EXEC AddMenuItem 7, 12
--EXEC AddMenuItem 7, 13
--GO

---- Seafood Lovers
--EXEC AddMenuItem 10, 14
--EXEC AddMenuItem 10, 15
--GO

---- Starters
--EXEC AddMenuItem 2, 16
--EXEC AddMenuItem 2, 17
--EXEC AddMenuItem 2, 18
--EXEC AddMenuItem 2, 19
--EXEC AddMenuItem 2, 20
--EXEC AddMenuItem 2, 21
--GO

---- Daily Special
--EXEC AddMenuItem 5, 22
--EXEC AddMenuItem 5, 23
--EXEC AddMenuItem 5, 24
--EXEC AddMenuItem 5, 25
--GO

---- By the Grill
--EXEC AddMenuItem 8, 26
--EXEC AddMenuItem 8, 27
--EXEC AddMenuItem 8, 28
--EXEC AddMenuItem 8, 29
--EXEC AddMenuItem 8, 30
--GO

---- Desserts
--EXEC AddMenuItem 11, 31
--EXEC AddMenuItem 11, 32
--EXEC AddMenuItem 11, 33
--EXEC AddMenuItem 11, 34
--EXEC AddMenuItem 11, 35
--GO

---- Extras
--EXEC AddMenuItem 12, 36
--EXEC AddMenuItem 12, 36
--EXEC AddMenuItem 12, 36
--EXEC AddMenuItem 12, 36
--EXEC AddMenuItem 12, 40
--GO

---- Other Choices
--EXEC AddMenuItem 6 , 41
--EXEC AddMenuItem 6 , 42
--EXEC AddMenuItem 6 , 43
--EXEC AddMenuItem 6 , 44
--GO

---- Drinks
--EXEC AddMenuItem 9 , 45
--EXEC AddMenuItem 9 , 46
--EXEC AddMenuItem 9 , 47
--EXEC AddMenuItem 9 , 48
--GO

---- Extras
--EXEC AddMenuItem 12, 49
--EXEC AddMenuItem 12, 50
--EXEC AddMenuItem 12, 51
--EXEC AddMenuItem 12, 52
--EXEC AddMenuItem 12, 53
--EXEC AddMenuItem 12, 54
--EXEC AddMenuItem 12, 55
--GO

-- Add Inventory Records
DECLARE @Date DATE = GETDATE(), @ID INT
SET @ID = IDENT_CURRENT('inventory')
EXEC [dbo].[usp_AddInventory] N'Closing', @Date, @ID

SET @Date = DATEADD(DAY, 1, @Date)
SET @ID = IDENT_CURRENT('inventory')
EXEC [dbo].[usp_AddInventory] N'Opening', @Date, @ID
GO