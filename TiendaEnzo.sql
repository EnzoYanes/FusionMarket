USE [master]
GO
/****** Object:  Database [TiendaEnzo]    Script Date: 31/7/2021 5:14:38 ******/
CREATE DATABASE [TiendaEnzo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TiendaEnzo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\TiendaEnzo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TiendaEnzo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\TiendaEnzo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [TiendaEnzo] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TiendaEnzo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TiendaEnzo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TiendaEnzo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TiendaEnzo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TiendaEnzo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TiendaEnzo] SET ARITHABORT OFF 
GO
ALTER DATABASE [TiendaEnzo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TiendaEnzo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TiendaEnzo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TiendaEnzo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TiendaEnzo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TiendaEnzo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TiendaEnzo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TiendaEnzo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TiendaEnzo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TiendaEnzo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TiendaEnzo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TiendaEnzo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TiendaEnzo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TiendaEnzo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TiendaEnzo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TiendaEnzo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TiendaEnzo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TiendaEnzo] SET RECOVERY FULL 
GO
ALTER DATABASE [TiendaEnzo] SET  MULTI_USER 
GO
ALTER DATABASE [TiendaEnzo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TiendaEnzo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TiendaEnzo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TiendaEnzo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TiendaEnzo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TiendaEnzo] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TiendaEnzo] SET QUERY_STORE = OFF
GO
USE [TiendaEnzo]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 31/7/2021 5:14:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderLines]    Script Date: 31/7/2021 5:14:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderLines](
	[OrderId] [int] NOT NULL,
	[ProductId] [smallint] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[Subtotal]  AS ([Quantity]*[UnitPrice]),
 CONSTRAINT [PK_OrderLine] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 31/7/2021 5:14:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BillingNumber] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UserId] [smallint] NOT NULL,
	[StatusId] [tinyint] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 31/7/2021 5:14:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[OrderStatusId] [tinyint] NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_OrderStatus] PRIMARY KEY CLUSTERED 
(
	[OrderStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 31/7/2021 5:14:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Description] [varchar](500) NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CategoryId] [smallint] NOT NULL,
	[StatusId] [tinyint] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductStatus]    Script Date: 31/7/2021 5:14:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductStatus](
	[ProductStatusId] [tinyint] NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ProductStatus] PRIMARY KEY CLUSTERED 
(
	[ProductStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 31/7/2021 5:14:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[DocumentNumber] [varchar](25) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[StatusId] [tinyint] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserStatus]    Script Date: 31/7/2021 5:14:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserStatus](
	[UserStatusId] [tinyint] NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_UserStatus] PRIMARY KEY CLUSTERED 
(
	[UserStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([Id], [Description]) VALUES (1, N'Comida')
INSERT [dbo].[Categories] ([Id], [Description]) VALUES (2, N'Bebida')
INSERT [dbo].[Categories] ([Id], [Description]) VALUES (3, N'Limpieza')
INSERT [dbo].[Categories] ([Id], [Description]) VALUES (4, N'Papelería')
INSERT [dbo].[Categories] ([Id], [Description]) VALUES (5, N'Mascotas')
INSERT [dbo].[Categories] ([Id], [Description]) VALUES (6, N'Vestimenta')
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (1, 3, 4, CAST(92.70 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (1, 9, 4, CAST(54.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (1, 10, 1, CAST(104.40 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (1, 12, 4, CAST(145.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (1, 20, 4, CAST(749.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (1, 21, 4, CAST(95.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (2, 9, 2, CAST(54.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (2, 12, 2, CAST(145.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (3, 1, 2, CAST(111.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (3, 4, 3, CAST(55.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (3, 16, 1, CAST(390.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (3, 17, 1, CAST(490.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (4, 7, 1, CAST(49.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (4, 9, 1, CAST(54.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderLines] ([OrderId], [ProductId], [Quantity], [UnitPrice]) VALUES (4, 20, 1, CAST(749.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [BillingNumber], [CreatedDate], [UserId], [StatusId]) VALUES (1, N'1-81', CAST(N'2021-07-31T05:05:47.083' AS DateTime), 1, 1)
INSERT [dbo].[Orders] ([Id], [BillingNumber], [CreatedDate], [UserId], [StatusId]) VALUES (2, N'3-877', CAST(N'2021-07-31T05:06:19.877' AS DateTime), 3, 1)
INSERT [dbo].[Orders] ([Id], [BillingNumber], [CreatedDate], [UserId], [StatusId]) VALUES (3, N'1-571', CAST(N'2021-07-31T05:06:47.570' AS DateTime), 1, 1)
INSERT [dbo].[Orders] ([Id], [BillingNumber], [CreatedDate], [UserId], [StatusId]) VALUES (4, N'1-30', CAST(N'2021-07-31T05:10:02.030' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
INSERT [dbo].[OrderStatus] ([OrderStatusId], [Description]) VALUES (1, N'Issued')
INSERT [dbo].[OrderStatus] ([OrderStatusId], [Description]) VALUES (2, N'Paid')
INSERT [dbo].[OrderStatus] ([OrderStatusId], [Description]) VALUES (3, N'Cancelled')
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (1, N'Ciff Detergente 750 Ml', N'Limón Bio Active', CAST(111.00 AS Decimal(18, 2)), CAST(N'2021-04-04T00:00:00.000' AS DateTime), 3, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (2, N'Hipoclorito 1L', N'Solución Cristal', CAST(45.00 AS Decimal(18, 2)), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 3, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (3, N'Agua Lavandina 2L', N'Sello rojo', CAST(92.70 AS Decimal(18, 2)), CAST(N'2021-04-04T00:00:00.000' AS DateTime), 3, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (4, N'Pilpa de tomate 1020Gr', N'Tamizada', CAST(55.00 AS Decimal(18, 2)), CAST(N'2021-07-07T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (5, N'Fideos Muñas 500Gr', N'Naturales Las Acasias', CAST(51.00 AS Decimal(18, 2)), CAST(N'2021-05-05T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (7, N'Tomate Perita 400Gr', N'Río de la plata', CAST(49.00 AS Decimal(18, 2)), CAST(N'2021-07-07T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (8, N'Fideos Tallarin 500Gr', N'Al Huevo Cololó', CAST(65.00 AS Decimal(18, 2)), CAST(N'2021-03-03T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (9, N'Arroz 1Kg', N'Blue Patna', CAST(54.00 AS Decimal(18, 2)), CAST(N'2021-02-15T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (10, N'Coca Cola 1.5L', N'Light', CAST(104.40 AS Decimal(18, 2)), CAST(N'2021-01-07T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (11, N'Sprite 2.25L', N'Zero', CAST(111.60 AS Decimal(18, 2)), CAST(N'2021-01-14T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (12, N'Cerveza Ipa 500Ml', N'Cabesas Bier', CAST(145.00 AS Decimal(18, 2)), CAST(N'2021-03-15T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (13, N'Cuadernola 96 hojas', N'Tapa dura', CAST(39.00 AS Decimal(18, 2)), CAST(N'2021-04-12T00:00:00.000' AS DateTime), 4, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (14, N'Cinta Adhesiva', N'Con Soporte Playschool', CAST(49.00 AS Decimal(18, 2)), CAST(N'2021-02-14T00:00:00.000' AS DateTime), 4, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (15, N'Bolígrafo Bic', N'Cristal x4', CAST(99.00 AS Decimal(18, 2)), CAST(N'2021-02-20T00:00:00.000' AS DateTime), 4, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (16, N'Pantalon M', N'Polar Azul para Hombre', CAST(390.00 AS Decimal(18, 2)), CAST(N'2021-01-01T00:00:00.000' AS DateTime), 6, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (17, N'Chaleco L', N'Polar para Hombre', CAST(490.00 AS Decimal(18, 2)), CAST(N'2021-01-01T00:00:00.000' AS DateTime), 6, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (18, N'Remera L', N'Manga larga para Hombre', CAST(390.00 AS Decimal(18, 2)), CAST(N'2021-04-04T00:00:00.000' AS DateTime), 6, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (19, N'Musculosa L', N'Microfibra para Dama', CAST(179.00 AS Decimal(18, 2)), CAST(N'2021-06-05T00:00:00.000' AS DateTime), 6, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (20, N'Alimento para Perro 7Kg', N'Primocao Original', CAST(749.00 AS Decimal(18, 2)), CAST(N'2021-02-23T00:00:00.000' AS DateTime), 5, 1)
INSERT [dbo].[Products] ([Id], [Name], [Description], [Price], [CreatedDate], [CategoryId], [StatusId]) VALUES (21, N'Alimento para Perros 1Kg', N'Kun carne', CAST(95.00 AS Decimal(18, 2)), CAST(N'2020-10-04T00:00:00.000' AS DateTime), 5, 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
INSERT [dbo].[ProductStatus] ([ProductStatusId], [Description]) VALUES (1, N'Active')
INSERT [dbo].[ProductStatus] ([ProductStatusId], [Description]) VALUES (2, N'Inactive')
INSERT [dbo].[ProductStatus] ([ProductStatusId], [Description]) VALUES (3, N'OutOfStock')
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Name], [Surname], [DocumentNumber], [CreatedDate], [Username], [Password], [StatusId]) VALUES (1, N'Andres', N'Martinez', N'41458965', CAST(N'2020-12-12T00:00:00.000' AS DateTime), N'andresmartinez@gmail.com', N'123456', 1)
INSERT [dbo].[Users] ([Id], [Name], [Surname], [DocumentNumber], [CreatedDate], [Username], [Password], [StatusId]) VALUES (2, N'Lidia', N'Dávila', N'51548796', CAST(N'2021-01-31T00:00:00.000' AS DateTime), N'lidiadavila@gmail.com', N'456321', 1)
INSERT [dbo].[Users] ([Id], [Name], [Surname], [DocumentNumber], [CreatedDate], [Username], [Password], [StatusId]) VALUES (3, N'Diego', N'Garcia', N'31238597', CAST(N'2021-03-05T00:00:00.000' AS DateTime), N'diegogarcia@hotmail.com', N'748596', 1)
INSERT [dbo].[Users] ([Id], [Name], [Surname], [DocumentNumber], [CreatedDate], [Username], [Password], [StatusId]) VALUES (4, N'Enzo', N'Yanes', N'48523692', CAST(N'2021-07-31T05:08:38.627' AS DateTime), N'enzoyanes@gmail.com', N'999999', 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
INSERT [dbo].[UserStatus] ([UserStatusId], [Description]) VALUES (1, N'Active')
INSERT [dbo].[UserStatus] ([UserStatusId], [Description]) VALUES (2, N'Inactive')
INSERT [dbo].[UserStatus] ([UserStatusId], [Description]) VALUES (3, N'Blocked')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_Users]    Script Date: 31/7/2021 5:14:39 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UK_Users] UNIQUE NONCLUSTERED 
(
	[Id] ASC,
	[Username] ASC,
	[DocumentNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderLines] ADD  CONSTRAINT [DF_OrderLines_UnitPrice]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_StatusId]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_StatusId]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_StatusId]  DEFAULT ((1)) FOR [StatusId]
GO
ALTER TABLE [dbo].[OrderLines]  WITH CHECK ADD  CONSTRAINT [FK_OrderLine_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderLines] CHECK CONSTRAINT [FK_OrderLine_Orders]
GO
ALTER TABLE [dbo].[OrderLines]  WITH CHECK ADD  CONSTRAINT [FK_OrderLine_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[OrderLines] CHECK CONSTRAINT [FK_OrderLine_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_OrderStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[OrderStatus] ([OrderStatusId])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_OrderStatus]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Categories] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_ProductStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[ProductStatus] ([ProductStatusId])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_ProductStatus]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_UserStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[UserStatus] ([UserStatusId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_UserStatus]
GO
/****** Object:  StoredProcedure [dbo].[Products_GetProductsPaginated]    Script Date: 31/7/2021 5:14:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pablo García
-- Create date: 13-05-2021
-- Description:	Retorna un paginado de productos
-- =============================================
CREATE PROCEDURE [dbo].[Products_GetProductsPaginated]
	-- Add the parameters for the stored procedure here
	@PageIndex INT,
	@PageSize INT,
	@Name VARCHAR(20) NULL,
	@CategoryId INT,
	@OrderByNameOrPrice VARCHAR(10),
	@ASCorDESC VARCHAR(5)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TotalRows INT

	IF(@PageIndex < 1)
	BEGIN
		SET @PageIndex = 1
	END
	SET @OrderByNameOrPrice = LOWER(@OrderByNameOrPrice);
	SET @ASCorDESC = LOWER(@ASCorDESC)
	IF(@OrderByNameOrPrice NOT IN ('name','price') OR @OrderByNameOrPrice IS NULL)
	BEGIN
		SET @OrderByNameOrPrice = 'name'
	END
	IF(@ASCorDESC NOT IN ('asc','desc') OR @ASCorDESC IS NULL)
	BEGIN
		SET @ASCorDESC = 'asc'
	END

	SELECT *
	FROM dbo.Products
	WHERE (@Name IS NULL OR [Name] like '%'+@Name+'%') 
		AND (@CategoryId = 0 OR CategoryId = @CategoryId)
	ORDER BY 
		CASE WHEN @OrderByNameOrPrice='name' AND @ASCorDESC='asc' THEN [Name] END ASC,
		CASE WHEN @OrderByNameOrPrice='name' AND @ASCorDESC='desc' THEN [Name] END DESC,
		CASE WHEN @OrderByNameOrPrice='price' AND @ASCorDESC='asc' THEN [Price] END ASC,
		CASE WHEN @OrderByNameOrPrice='price' AND @ASCorDESC='desc' THEN [Price] END DESC
	OFFSET (@PageSize * (@PageIndex -1)) ROWS
	FETCH NEXT @PageSize ROWS ONLY
	
	SELECT COUNT(*) AS TotalItems
	FROM dbo.Products
	WHERE (@Name IS NULL OR [Name] like '%'+@Name+'%') 
		AND (@CategoryId = 0 OR CategoryId = @CategoryId)

END
GO
USE [master]
GO
ALTER DATABASE [TiendaEnzo] SET  READ_WRITE 
GO
