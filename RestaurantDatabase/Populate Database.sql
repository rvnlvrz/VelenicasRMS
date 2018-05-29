USE VelenicasRMS
GO

---- Insert beverages using SP
--EXEC uspInsertBeverage N'Strawberry Milkshake', 85
--EXEC uspInsertBeverage N'Hazelnut Coffee', 60
--EXEC uspInsertBeverage N'Brewed Iced Tea', 45
--EXEC uspInsertBeverage N'Four Seasons', 50
--GO

-- Insert Food Products
declare @ProductID int
insert into Products(Name, Price)
values (N'Spring Rolls', 100)
set @ProductID = SCOPE_IDENTITY()
insert into Foods(ProductID, PersonCount)
values (@ProductID, 1)

insert into Products(Name, Price)
values (N'Pork Sinigang', 275)
set @ProductID = SCOPE_IDENTITY()
insert into Foods(ProductID, PersonCount)
values (@ProductID, 3)

insert into Products(Name, Price)
values (N'Salmon with Mango Salsa', 175)
set @ProductID = SCOPE_IDENTITY()
insert into Foods(ProductID, PersonCount)
values (@ProductID, 1)

insert into Products(Name, Price)
values (N'Domingo''s Beefsteak', 145)
set @ProductID = SCOPE_IDENTITY()
insert into Foods(ProductID, PersonCount)
values (@ProductID, 1)
GO

-- Insert Beverage Products
declare @ProductID int
insert into Products(Name, Price)
values (N'Strawberry Milkshake', 85)
set @ProductID = SCOPE_IDENTITY()
insert into Beverages(ProductID)
values (@ProductID)

insert into Products(Name, Price)
values (N'Hazelnut Coffee', 60)
set @ProductID = SCOPE_IDENTITY()
insert into Beverages(ProductID)
values (@ProductID)

insert into Products(Name, Price)
values (N'Brewed Iced Tea', 45)
set @ProductID = SCOPE_IDENTITY()
insert into Beverages(ProductID)
values (@ProductID)

insert into Products(Name, Price)
values (N'Four Seasons', 50)
set @ProductID = SCOPE_IDENTITY()
insert into Beverages(ProductID)
values (@ProductID)
GO

-- Insert inventory Records
