USE VelenicasRMS
GO

-- INVENTORY VIEW
CREATE OR ALTER VIEW [All Products] AS
SELECT Products.ID, Products.[Name], Products.Price,
	Inventory.Quantity, Foods.PersonCount
	FROM Products
	INNER JOIN Inventory ON Inventory.ProductID = Products.ID
	INNER JOIN Foods ON Foods.ProductID = Products.ID
GO

-- ORDERS VIEW (Order ID, item count, total)
CREATE OR ALTER VIEW [All Orders wit Products] AS
SELECT Products.ID, Products.[Name], (Products.Price * OrderItems.Quantity)  
	FROM Products INNER JOIN OrderItems ON OrderItems.OrderID = Orders.ID
GO

--SELECT Products.ID, Products.[Name], OrderItems.Quantity, OrderItems.OrderID
--	FROM OrderItems
--	INNER JOIN MenuItems ON OrderItems.MenuItemID = MenuItems.ID
--	INNER JOIN Products ON MenuItems.ProductID = Products.ID

-- ORDERS VIEW
SELECT Products.ID, Products.Name, Products.Price, OrderItems.Quantity, 
	(OrderItems.Quantity * Products.Price) AS itemPrice FROM Products
	INNER JOIN MenuItems ON MenuItems.ProductID = Products.ID
	INNER JOIN OrderItems ON OrderItems.OrderID = MenuItems.ID
	INNER JOIN Orders ON OrderItems.OrderID = Orders.ID

-- BEVERAGE LIST 
SELECT Products.ID, Products.[Name], Products.Price   
	FROM Products WHERE Products.ID IN (SELECT ProductID FROM Beverages)

-- FOOD LIST
SELECT Products.ID, Products.[Name], Products.Price 
	FROM Products WHERE Products.ID IN (SELECT ProductID FROM Foods)