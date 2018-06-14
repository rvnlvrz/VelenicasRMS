USE VelenicasRMS
GO

-- CATEGORICAL ITEM VIEW
CREATE OR ALTER VIEW ItemMenu AS
	SELECT Menus.ID as menuID, Menus.Name as menuCategory, MenuItems.ID AS itemID, 
		Products.ID AS productID, Products.Name as productName, Products.Price FROM MenuItems
		INNER JOIN Products ON Products.ID = MenuItems.ProductID
		INNER JOIN Menus ON MenuItems.MenuID = Menus.ID
GO

-- ORDERS VIEW
CREATE OR ALTER VIEW SpecificOrder AS
	SELECT Orders.ID, MenuItems.ID as MenuItemID, Products.Name, OrderItems.Price, OrderItems.Quantity FROM Orders
		INNER JOIN OrderItems ON OrderItems.OrderID = Orders.ID
		INNER JOIN MenuItems ON MenuItems.ID = OrderItems.MenuItemID
		INNER JOIN Products ON Products.ID = MenuItems.ProductID
GO

-- BEVERAGE LIST 
CREATE OR ALTER VIEW [dbo].[Beverage Products] AS
SELECT Products.ID, Products.[Name], Products.Price   
	FROM Products WHERE Products.ID IN (SELECT ProductID FROM Beverages)
GO

-- FOOD LIST
CREATE OR ALTER VIEW [dbo].[Food Products] AS
SELECT Products.ID, Products.[Name], Products.Price, Foods.PersonCount
  FROM Products 
  INNER JOIN Foods ON Foods.ProductID = Products.ID
  WHERE Products.ID IN (SELECT ProductID FROM Foods)
GO