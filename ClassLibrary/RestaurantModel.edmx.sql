
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 05/22/2018 16:24:28
-- Generated from EDMX file: C:\Users\Arvin\source\repos\VelenicasRMS\ClassLibrary\RestaurantModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [VelenicasRMS];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_FoodMenuItem]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MenuItems] DROP CONSTRAINT [FK_FoodMenuItem];
GO
IF OBJECT_ID(N'[dbo].[FK_MenuMenuItem]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MenuItems] DROP CONSTRAINT [FK_MenuMenuItem];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderOrderItem]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[OrderItemSet] DROP CONSTRAINT [FK_OrderOrderItem];
GO
IF OBJECT_ID(N'[dbo].[FK_OrderItemMenuItem]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[OrderItemSet] DROP CONSTRAINT [FK_OrderItemMenuItem];
GO
IF OBJECT_ID(N'[dbo].[FK_FoodProduct]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[FoodSet] DROP CONSTRAINT [FK_FoodProduct];
GO
IF OBJECT_ID(N'[dbo].[FK_BeverageProduct]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[BeverageSet] DROP CONSTRAINT [FK_BeverageProduct];
GO
IF OBJECT_ID(N'[dbo].[FK_InventoryProduct]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[InventorySet] DROP CONSTRAINT [FK_InventoryProduct];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Menus]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Menus];
GO
IF OBJECT_ID(N'[dbo].[Products]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Products];
GO
IF OBJECT_ID(N'[dbo].[MenuItems]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MenuItems];
GO
IF OBJECT_ID(N'[dbo].[OrderSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderSet];
GO
IF OBJECT_ID(N'[dbo].[OrderItemSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[OrderItemSet];
GO
IF OBJECT_ID(N'[dbo].[FoodSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[FoodSet];
GO
IF OBJECT_ID(N'[dbo].[BeverageSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[BeverageSet];
GO
IF OBJECT_ID(N'[dbo].[InventorySet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[InventorySet];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Menus'
CREATE TABLE [dbo].[Menus] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Description] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Products'
CREATE TABLE [dbo].[Products] (
    [ID] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'MenuItems'
CREATE TABLE [dbo].[MenuItems] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [ProductID] int  NOT NULL,
    [MenuID] int  NOT NULL
);
GO

-- Creating table 'Orders'
CREATE TABLE [dbo].[Orders] (
    [ID] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'OrderItems'
CREATE TABLE [dbo].[OrderItems] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [OrderID] int  NOT NULL,
    [MenuItemID] int  NOT NULL,
    [Quantity] int  NOT NULL
);
GO

-- Creating table 'Foods'
CREATE TABLE [dbo].[Foods] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [ProductID] int  NOT NULL,
    [PersonCount] int  NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Price] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Beverages'
CREATE TABLE [dbo].[Beverages] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [ProductID] int  NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Price] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Inventory'
CREATE TABLE [dbo].[Inventory] (
    [ProductID] int  NOT NULL,
    [Quantity] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ID] in table 'Menus'
ALTER TABLE [dbo].[Menus]
ADD CONSTRAINT [PK_Menus]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Products'
ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'MenuItems'
ALTER TABLE [dbo].[MenuItems]
ADD CONSTRAINT [PK_MenuItems]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'OrderItems'
ALTER TABLE [dbo].[OrderItems]
ADD CONSTRAINT [PK_OrderItems]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Foods'
ALTER TABLE [dbo].[Foods]
ADD CONSTRAINT [PK_Foods]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'Beverages'
ALTER TABLE [dbo].[Beverages]
ADD CONSTRAINT [PK_Beverages]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ProductID] in table 'Inventory'
ALTER TABLE [dbo].[Inventory]
ADD CONSTRAINT [PK_Inventory]
    PRIMARY KEY CLUSTERED ([ProductID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [ProductID] in table 'MenuItems'
ALTER TABLE [dbo].[MenuItems]
ADD CONSTRAINT [FK_FoodMenuItem]
    FOREIGN KEY ([ProductID])
    REFERENCES [dbo].[Products]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_FoodMenuItem'
CREATE INDEX [IX_FK_FoodMenuItem]
ON [dbo].[MenuItems]
    ([ProductID]);
GO

-- Creating foreign key on [MenuID] in table 'MenuItems'
ALTER TABLE [dbo].[MenuItems]
ADD CONSTRAINT [FK_MenuMenuItem]
    FOREIGN KEY ([MenuID])
    REFERENCES [dbo].[Menus]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_MenuMenuItem'
CREATE INDEX [IX_FK_MenuMenuItem]
ON [dbo].[MenuItems]
    ([MenuID]);
GO

-- Creating foreign key on [OrderID] in table 'OrderItems'
ALTER TABLE [dbo].[OrderItems]
ADD CONSTRAINT [FK_OrderOrderItem]
    FOREIGN KEY ([OrderID])
    REFERENCES [dbo].[Orders]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderOrderItem'
CREATE INDEX [IX_FK_OrderOrderItem]
ON [dbo].[OrderItems]
    ([OrderID]);
GO

-- Creating foreign key on [MenuItemID] in table 'OrderItems'
ALTER TABLE [dbo].[OrderItems]
ADD CONSTRAINT [FK_OrderItemMenuItem]
    FOREIGN KEY ([MenuItemID])
    REFERENCES [dbo].[MenuItems]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderItemMenuItem'
CREATE INDEX [IX_FK_OrderItemMenuItem]
ON [dbo].[OrderItems]
    ([MenuItemID]);
GO

-- Creating foreign key on [ProductID] in table 'Foods'
ALTER TABLE [dbo].[Foods]
ADD CONSTRAINT [FK_FoodProduct]
    FOREIGN KEY ([ProductID])
    REFERENCES [dbo].[Products]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_FoodProduct'
CREATE INDEX [IX_FK_FoodProduct]
ON [dbo].[Foods]
    ([ProductID]);
GO

-- Creating foreign key on [ProductID] in table 'Beverages'
ALTER TABLE [dbo].[Beverages]
ADD CONSTRAINT [FK_BeverageProduct]
    FOREIGN KEY ([ProductID])
    REFERENCES [dbo].[Products]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_BeverageProduct'
CREATE INDEX [IX_FK_BeverageProduct]
ON [dbo].[Beverages]
    ([ProductID]);
GO

-- Creating foreign key on [ProductID] in table 'Inventory'
ALTER TABLE [dbo].[Inventory]
ADD CONSTRAINT [FK_InventoryProduct]
    FOREIGN KEY ([ProductID])
    REFERENCES [dbo].[Products]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------