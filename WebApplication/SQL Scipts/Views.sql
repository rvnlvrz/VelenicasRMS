-- INVENTORY VIEW
SELECT Products.ID, Products.[Name], Products.[Type], Products.Price,
	Inventory.Quantity, Inventory.Unit, Foods.PersonCount
	FROM Products
	INNER JOIN Inventory ON Inventory.ProductID = Products.ID
	INNER JOIN Foods ON Foods.ProductID = Products.ID

-- ORDERS VIEW (Order ID, item count, total)
SELECT Products.ID, Products.[Name], (Products.Price * OrderItems.Quantity)  
	FROM Products INNER JOIN OrderItems ON OrderItems.OrderID = Orders.ID

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