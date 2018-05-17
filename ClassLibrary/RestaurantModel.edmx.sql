
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 05/17/2018 15:09:31
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
IF OBJECT_ID(N'[dbo].[FK_IngredientFood]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[IngredientSet] DROP CONSTRAINT [FK_IngredientFood];
GO
IF OBJECT_ID(N'[dbo].[FK_IngredientRawMaterial]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[IngredientSet] DROP CONSTRAINT [FK_IngredientRawMaterial];
GO
IF OBJECT_ID(N'[dbo].[FK_InventoryRawMaterial]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[InventorySet] DROP CONSTRAINT [FK_InventoryRawMaterial];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Menus]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Menus];
GO
IF OBJECT_ID(N'[dbo].[Foods]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Foods];
GO
IF OBJECT_ID(N'[dbo].[MenuItems]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MenuItems];
GO
IF OBJECT_ID(N'[dbo].[IngredientSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[IngredientSet];
GO
IF OBJECT_ID(N'[dbo].[RawMaterialSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RawMaterialSet];
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
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Foods'
CREATE TABLE [dbo].[Foods] (
    [ID] int IDENTITY(1,1) NOT NULL
);
GO

-- Creating table 'MenuItems'
CREATE TABLE [dbo].[MenuItems] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [FoodID] int  NOT NULL,
    [MenuID] int  NOT NULL,
    [ItemName] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'IngredientSet'
CREATE TABLE [dbo].[IngredientSet] (
    [FoodID] int  NOT NULL,
    [RawMaterialID] int  NOT NULL,
    [Quantity] int  NOT NULL
);
GO

-- Creating table 'RawMaterialSet'
CREATE TABLE [dbo].[RawMaterialSet] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'InventorySet'
CREATE TABLE [dbo].[InventorySet] (
    [RawMaterialID] int  NOT NULL,
    [Quantity] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'OrderSet'
CREATE TABLE [dbo].[OrderSet] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [Quantity] int  NOT NULL,
    [MenuItemID] int  NOT NULL
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

-- Creating primary key on [ID] in table 'Foods'
ALTER TABLE [dbo].[Foods]
ADD CONSTRAINT [PK_Foods]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [ID] in table 'MenuItems'
ALTER TABLE [dbo].[MenuItems]
ADD CONSTRAINT [PK_MenuItems]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [FoodID], [RawMaterialID] in table 'IngredientSet'
ALTER TABLE [dbo].[IngredientSet]
ADD CONSTRAINT [PK_IngredientSet]
    PRIMARY KEY CLUSTERED ([FoodID], [RawMaterialID] ASC);
GO

-- Creating primary key on [ID] in table 'RawMaterialSet'
ALTER TABLE [dbo].[RawMaterialSet]
ADD CONSTRAINT [PK_RawMaterialSet]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- Creating primary key on [RawMaterialID] in table 'InventorySet'
ALTER TABLE [dbo].[InventorySet]
ADD CONSTRAINT [PK_InventorySet]
    PRIMARY KEY CLUSTERED ([RawMaterialID] ASC);
GO

-- Creating primary key on [ID] in table 'OrderSet'
ALTER TABLE [dbo].[OrderSet]
ADD CONSTRAINT [PK_OrderSet]
    PRIMARY KEY CLUSTERED ([ID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [FoodID] in table 'MenuItems'
ALTER TABLE [dbo].[MenuItems]
ADD CONSTRAINT [FK_FoodMenuItem]
    FOREIGN KEY ([FoodID])
    REFERENCES [dbo].[Foods]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_FoodMenuItem'
CREATE INDEX [IX_FK_FoodMenuItem]
ON [dbo].[MenuItems]
    ([FoodID]);
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

-- Creating foreign key on [FoodID] in table 'IngredientSet'
ALTER TABLE [dbo].[IngredientSet]
ADD CONSTRAINT [FK_IngredientFood]
    FOREIGN KEY ([FoodID])
    REFERENCES [dbo].[Foods]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [RawMaterialID] in table 'IngredientSet'
ALTER TABLE [dbo].[IngredientSet]
ADD CONSTRAINT [FK_IngredientRawMaterial]
    FOREIGN KEY ([RawMaterialID])
    REFERENCES [dbo].[RawMaterialSet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_IngredientRawMaterial'
CREATE INDEX [IX_FK_IngredientRawMaterial]
ON [dbo].[IngredientSet]
    ([RawMaterialID]);
GO

-- Creating foreign key on [RawMaterialID] in table 'InventorySet'
ALTER TABLE [dbo].[InventorySet]
ADD CONSTRAINT [FK_InventoryRawMaterial]
    FOREIGN KEY ([RawMaterialID])
    REFERENCES [dbo].[RawMaterialSet]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [MenuItemID] in table 'OrderSet'
ALTER TABLE [dbo].[OrderSet]
ADD CONSTRAINT [FK_OrderMenuItem]
    FOREIGN KEY ([MenuItemID])
    REFERENCES [dbo].[MenuItems]
        ([ID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_OrderMenuItem'
CREATE INDEX [IX_FK_OrderMenuItem]
ON [dbo].[OrderSet]
    ([MenuItemID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------