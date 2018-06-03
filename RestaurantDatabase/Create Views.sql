USE VelenicasRMS
GO

-- INVENTORY VIEW
--CREATE OR ALTER VIEW [All Products] AS
SELECT [Products].[ID], [Name], [Date] FROM [dbo].[Products]
	INNER JOIN (SELECT [Date], [ProductID] FROM [dbo].[Inventory], [dbo].[InventoryItems]) s ON [Products].[ID] = s.[ProductID]
	GROUP BY [Products].[ID], [Name], [Date]
GO

-- PIVOT
SELECT i.[ProductID], p.[Name], i.[Quantity], [Date] FROM [dbo].[Inventory]
	INNER JOIN [dbo].[InventoryItems] i ON [Inventory].[ID] = i.[InventoryID]
	INNER JOIN [dbo].[Products] p ON i.[ProductID] = p.[ID]
GO

-- STUFF
DECLARE @DynamicPivotQuery AS NVARCHAR(MAX)
DECLARE @ColumnName AS NVARCHAR(MAX)
 
--Get distinct values of the PIVOT Column 
SELECT @ColumnName= ISNULL(@ColumnName + ',','') 
       + QUOTENAME(Course)
FROM (SELECT DISTINCT Course FROM #CourseSales) AS Courses
 
--Prepare the PIVOT query using the dynamic 
SET @DynamicPivotQuery = 
  N'SELECT Year, ' + @ColumnName + '
    FROM #CourseSales
    PIVOT(SUM(Earning) 
          FOR Course IN (' + @ColumnName + ')) AS PVTTable'
--Execute the Dynamic Pivot Query
EXEC sp_executesql @DynamicPivotQuery
GO

-- CATEGORICAL ITEM VIEW
CREATE OR ALTER VIEW ItemMenu AS
	SELECT Menus.ID as menuID, Menus.Name as menuCategory, MenuItems.ID AS itemID, 
		Products.ID AS productID, Products.Name as productName, Products.Price FROM MenuItems
		INNER JOIN Products ON Products.ID = MenuItems.ProductID
		INNER JOIN Menus ON MenuItems.MenuID = Menus.ID
GO

-- ORDERS VIEW
--SELECT Products.ID, Products.Name, Products.Price, OrderItems.Quantity, 
--	(OrderItems.Quantity * Products.Price) AS itemPrice FROM Products
--	INNER JOIN MenuItems ON MenuItems.ProductID = Products.ID
--	INNER JOIN OrderItems ON OrderItems.OrderID = MenuItems.ID
--	INNER JOIN Orders ON OrderItems.OrderID = Orders.ID
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