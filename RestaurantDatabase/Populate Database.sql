USE VelenicasRMS
GO

--ALTER TABLE [dbo].[Inventory]
--ALTER COLUMN [Date] DATETIME
--GO

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
EXEC [dbo].[uspInsertInitialInventory] N'Opening', @Date

SET @Date = DATEADD(HOUR, 14, @Date)
SET @ID = IDENT_CURRENT('inventory')
EXEC [dbo].[uspInsertInventory] N'Closing', @Date, @ID

SET @Date = DATEADD(HOUR, 10, @Date)
SET @ID = IDENT_CURRENT('inventory')
EXEC [dbo].[uspInsertInventory] N'Opening', @Date, @ID
GO

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
SELECT * FROM MENUS
delete from Menus where ID < 13
-- Breakfast Plates
--EXEC AddFood N'Tapa', 132, 5
EXEC [dbo].[uspInsertFood] N'Tocino', 94, 2
EXEC [dbo].[uspInsertFood] N'Traditional Imus Longganisa', 55, 1
EXEC [dbo].[uspInsertFood] N'Shanghai Rolls', 250, 6

-- Pasta
EXEC [dbo].[uspInsertFood] N'Chicken and Bacon Penne Pasta', 150, 2
EXEC [dbo].[uspInsertFood] N'Lasagna', 75, 1
EXEC [dbo].[uspInsertFood] N'Spaghetti', 90, 1

-- Merienda Special
EXEC [dbo].[uspInsertFood] N'Clubhouse with Chips on Top', 120, 2
EXEC [dbo].[uspInsertFood] N'Clubhouse Solo', 60, 1
EXEC [dbo].[uspInsertFood] N'Pancit Bihon Guisado', 175, 2
EXEC [dbo].[uspInsertFood] N'Pancit Sotanghon', 120, 2
EXEC [dbo].[uspInsertFood] N'Pancit Canton', 75, 1

-- Seafood Lovers
EXEC [dbo].[uspInsertFood] N'Fried Bangus Inasal', 75, 1
EXEC [dbo].[uspInsertFood] N'Boneless Daing na Bangus', 50, 1
--EXEC AddFood N'Camaron Rebusado', 75, 1

-- Starters
EXEC [dbo].[uspInsertFood] N'Ultimate Nachos', 190, 4
EXEC [dbo].[uspInsertFood] N'Buffalo Wings', 170, 2
EXEC [dbo].[uspInsertFood] N'Crunchy Tacos', 190, 4
EXEC [dbo].[uspInsertFood] N'Fench Fries', 50, 1
EXEC [dbo].[uspInsertFood] N'Mojos', 200, 4
EXEC [dbo].[uspInsertFood] N'Pork Shanghai Rolls', 250, 3

-- Daily Specials
EXEC [dbo].[uspInsertFood] N'Adobosilog', 50, 1
EXEC [dbo].[uspInsertFood] N'Hungarian Sausage', 90, 1
EXEC [dbo].[uspInsertFood] N'Beef Mechado', 270, 5
EXEC [dbo].[uspInsertFood] N'Lechon Kawali', 290, 5

-- By the grill
EXEC [dbo].[uspInsertFood] N'Baby Back Ribs', 170, 1
EXEC [dbo].[uspInsertFood] N'Pork BBQ', 100, 1
EXEC [dbo].[uspInsertFood] N'Grilled Liempo', 175, 1
EXEC [dbo].[uspInsertFood] N'Spicy Grilled Liempo', 125, 1
EXEC [dbo].[uspInsertFood] N'Pork BBQ Trio', 300, 3

-- Desserts
EXEC [dbo].[uspInsertFood] N'Choco Cherry Cream Cake', 250, 3
EXEC [dbo].[uspInsertFood] N'Blueberry Cheesecake', 300, 2
EXEC [dbo].[uspInsertFood] N'Sinful Chocolate Cake', 200, 2
EXEC [dbo].[uspInsertFood] N'Litlle Clan Choco Ice Cream', 170, 2
EXEC [dbo].[uspInsertFood] N'Brownie Ala Mode', 55, 1

-- Best Sellers
EXEC [dbo].[uspInsertFood] N'Domingo''s Beefsteak', 350, 4
EXEC [dbo].[uspInsertFood] N'Velenica''s Special Kare Kare', 400, 3
EXEC [dbo].[uspInsertFood] N'Emilio''s Fried Chicken', 250, 2
EXEC [dbo].[uspInsertFood] N'Crispy Pata', 200, 3
EXEC [dbo].[uspInsertFood] N'Sizzling Sisig', 150, 2

-- Other Choices
EXEC [dbo].[uspInsertFood] N'Traditional Egg Drop Soup', 250, 2
EXEC [dbo].[uspInsertFood] N'Feisty Hungarian Sausage', 200, 2
EXEC [dbo].[uspInsertFood] N'Chopsuey', 100, 2
EXEC [dbo].[uspInsertFood] N'Pork Liempo Sinigang', 125, 2

-- Drinks
EXEC uspInsertBeverage N'Water', 25
EXEC uspInsertBeverage N'Iced Tea', 30
EXEC uspInsertBeverage N'Coke', 45
EXEC uspInsertBeverage N'Sprite', 40

-- Extras
EXEC [dbo].[uspInsertFood] N'Atsara', 20, 1
EXEC [dbo].[uspInsertFood] N'Egg', 10, 1
EXEC [dbo].[uspInsertFood] N'Toasted Bread', 15, 1
EXEC [dbo].[uspInsertFood] N'Bagoong', 5, 1
EXEC [dbo].[uspInsertFood] N'Plain Rice', 20, 1
EXEC [dbo].[uspInsertFood] N'Garlic Rice', 25, 1
EXEC [dbo].[uspInsertFood] N'Java Rice', 30, 1

-- Breakfast Plates
EXEC AddMenuItem 13, 1
EXEC AddMenuItem 13, 3
EXEC AddMenuItem 13, 4
EXEC AddMenuItem 13, 5
-- Pasta
EXEC AddMenuItem 16, 6
EXEC AddMenuItem 16, 7
EXEC AddMenuItem 16, 8
-- Merienda Special
EXEC AddMenuItem 19, 9
EXEC AddMenuItem 19, 10
EXEC AddMenuItem 19, 11
EXEC AddMenuItem 19, 12
EXEC AddMenuItem 19, 13
-- Seafood Lovers
EXEC AddMenuItem 23, 14
EXEC AddMenuItem 23, 15
-- Starters
EXEC AddMenuItem 14, 16
EXEC AddMenuItem 14, 17
EXEC AddMenuItem 14, 18
EXEC AddMenuItem 14, 19
EXEC AddMenuItem 14, 20
EXEC AddMenuItem 14, 21
-- Daily Special
EXEC AddMenuItem 17, 22
EXEC AddMenuItem 17, 23
EXEC AddMenuItem 17, 24
EXEC AddMenuItem 17, 25
-- By the Grill
EXEC AddMenuItem 20, 26
EXEC AddMenuItem 20, 27
EXEC AddMenuItem 20, 28
EXEC AddMenuItem 20, 29
EXEC AddMenuItem 20, 30
-- Desserts
EXEC AddMenuItem 23, 31
EXEC AddMenuItem 23, 32
EXEC AddMenuItem 23, 33
EXEC AddMenuItem 23, 34
EXEC AddMenuItem 23, 35
-- Extras
EXEC AddMenuItem 24, 36
EXEC AddMenuItem 24, 36
EXEC AddMenuItem 24, 36
EXEC AddMenuItem 24, 36
EXEC AddMenuItem 24, 40
-- Other Choices
EXEC AddMenuItem 18, 41
EXEC AddMenuItem 18, 42
EXEC AddMenuItem 18, 43
EXEC AddMenuItem 18, 44
-- Drinks
EXEC AddMenuItem 21, 45
EXEC AddMenuItem 21, 46
EXEC AddMenuItem 21, 47
EXEC AddMenuItem 21, 48
-- Extras
EXEC AddMenuItem 24, 49
EXEC AddMenuItem 24, 50
EXEC AddMenuItem 24, 51
EXEC AddMenuItem 24, 52
EXEC AddMenuItem 24, 53
EXEC AddMenuItem 24, 54
EXEC AddMenuItem 24, 55
GO
