USE [master]
GO
/****** Object:  Database [MarmitonVanced]    Script Date: 09/07/2025 10:02:27 ******/
CREATE DATABASE [MarmitonVanced]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MarmitonVanced', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MarmitonVanced.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MarmitonVanced_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MarmitonVanced_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MarmitonVanced] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MarmitonVanced].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MarmitonVanced] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MarmitonVanced] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MarmitonVanced] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MarmitonVanced] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MarmitonVanced] SET ARITHABORT OFF 
GO
ALTER DATABASE [MarmitonVanced] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MarmitonVanced] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MarmitonVanced] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MarmitonVanced] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MarmitonVanced] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MarmitonVanced] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MarmitonVanced] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MarmitonVanced] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MarmitonVanced] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MarmitonVanced] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MarmitonVanced] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MarmitonVanced] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MarmitonVanced] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MarmitonVanced] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MarmitonVanced] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MarmitonVanced] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MarmitonVanced] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MarmitonVanced] SET RECOVERY FULL 
GO
ALTER DATABASE [MarmitonVanced] SET  MULTI_USER 
GO
ALTER DATABASE [MarmitonVanced] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MarmitonVanced] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MarmitonVanced] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MarmitonVanced] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MarmitonVanced] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MarmitonVanced] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MarmitonVanced', N'ON'
GO
ALTER DATABASE [MarmitonVanced] SET QUERY_STORE = ON
GO
ALTER DATABASE [MarmitonVanced] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MarmitonVanced]
GO
/****** Object:  Table [dbo].[Article]    Script Date: 09/07/2025 10:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NOT NULL,
	[idIngredient] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredient]    Script Date: 09/07/2025 10:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredient](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[typeQte] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Ingredient] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IngredientUsed]    Script Date: 09/07/2025 10:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngredientUsed](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idRecipe] [int] NOT NULL,
	[idIngredient] [int] NOT NULL,
	[qte] [int] NOT NULL,
 CONSTRAINT [PK__Ingredie__3213E83F599FD8B1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prompt]    Script Date: 09/07/2025 10:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prompt](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[request] [text] NOT NULL,
	[response] [varchar](500) NOT NULL,
	[userId] [int] NOT NULL,
 CONSTRAINT [PK_Prompt] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recipe]    Script Date: 09/07/2025 10:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipe](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[time] [time](7) NOT NULL,
	[image] [varchar](150) NOT NULL,
	[idUser] [int] NOT NULL,
	[type] [varchar](50) NOT NULL,
	[count] [int] NOT NULL,
 CONSTRAINT [PK_Recipe] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 09/07/2025 10:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idRecipe] [int] NOT NULL,
	[idUser] [int] NOT NULL,
	[date] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Step]    Script Date: 09/07/2025 10:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Step](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idRecipe] [int] NOT NULL,
	[desc] [text] NOT NULL,
	[pos] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stock]    Script Date: 09/07/2025 10:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stock](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NOT NULL,
	[idIngredient] [int] NOT NULL,
	[qte] [int] NOT NULL,
 CONSTRAINT [PK_Stock] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Token]    Script Date: 09/07/2025 10:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Token](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUser] [int] NOT NULL,
	[token] [varchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 09/07/2025 10:02:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](150) NOT NULL,
	[surname] [varchar](150) NOT NULL,
	[mail] [varchar](500) NOT NULL,
	[password] [varchar](500) NOT NULL,
	[state] [varchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Article] ON 

INSERT [dbo].[Article] ([id], [idUser], [idIngredient], [quantity], [price]) VALUES (3, 9, 1, 100, 2.1000)
INSERT [dbo].[Article] ([id], [idUser], [idIngredient], [quantity], [price]) VALUES (4, 9, 2, 1000, 0.9500)
INSERT [dbo].[Article] ([id], [idUser], [idIngredient], [quantity], [price]) VALUES (5, 9, 3, 1000, 0.9700)
INSERT [dbo].[Article] ([id], [idUser], [idIngredient], [quantity], [price]) VALUES (6, 9, 4, 500, 3.2100)
INSERT [dbo].[Article] ([id], [idUser], [idIngredient], [quantity], [price]) VALUES (7, 9, 5, 300, 4.0000)
INSERT [dbo].[Article] ([id], [idUser], [idIngredient], [quantity], [price]) VALUES (8, 9, 6, 300, 4.0000)
INSERT [dbo].[Article] ([id], [idUser], [idIngredient], [quantity], [price]) VALUES (9, 9, 8, 5000, 3.0000)
INSERT [dbo].[Article] ([id], [idUser], [idIngredient], [quantity], [price]) VALUES (10, 9, 9, 1, 1.0000)
INSERT [dbo].[Article] ([id], [idUser], [idIngredient], [quantity], [price]) VALUES (11, 9, 10, 40, 2.3000)
SET IDENTITY_INSERT [dbo].[Article] OFF
GO
SET IDENTITY_INSERT [dbo].[Ingredient] ON 

INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (1, N'Tomate', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (2, N'Farine', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (3, N'Sucre', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (4, N'Beurre', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (5, N'Sel', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (6, N'Poivre', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (8, N'Pomme de terre', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (9, N'Oignon', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (10, N'Ail', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (11, N'Carotte', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (12, N'Courgette', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (13, N'Poivron rouge', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (14, N'Poivron vert', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (15, N'Concombre', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (16, N'Aubergine', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (17, N'Champignon de Paris', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (18, N'Laitue', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (19, N'Épinard', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (20, N'Brocoli', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (21, N'Chou-fleur', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (22, N'Haricot vert', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (23, N'Petit pois', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (24, N'Maïs', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (25, N'Avocat', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (26, N'Citron', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (27, N'Orange', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (28, N'Banane', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (29, N'Pomme', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (30, N'Poire', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (31, N'Fraise', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (32, N'Framboise', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (33, N'Myrtille', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (34, N'Cerise', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (35, N'Ananas', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (36, N'Mangue', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (37, N'Kiwi', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (38, N'Melon', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (39, N'Pastèque', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (40, N'Raisin', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (41, N'Abricot', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (42, N'Figue', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (43, N'Lentilles', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (44, N'Pois chiches', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (45, N'Riz', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (46, N'Pâtes', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (51, N'Cannelle', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (52, N'Cumin', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (53, N'Curry', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (54, N'Paprika', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (55, N'Moutarde', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (56, N'Ketchup', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (57, N'Mayonnaise', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (58, N'Huile d''olive', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (59, N'Huile de tournesol', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (60, N'Vinaigre balsamique', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (62, N'Crème fraîche', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (63, N'Lait', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (64, N'Fromage râpé', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (65, N'Mozzarella', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (66, N'Parmesan', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (67, N'Jambon', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (68, N'Lardons', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (69, N'Saucisse', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (70, N'Poulet', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (71, N'Bœuf', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (72, N'Porc', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (73, N'Poisson blanc', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (74, N'Saumon', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (75, N'Thon', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (76, N'Crevettes', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (77, N'Calamar', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (78, N'Oeufs', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (79, N'Pain', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (80, N'Chocolat', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (81, N'Vanille', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (82, N'Levure chimique', N'Sachet')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (83, N'Bicarbonate', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (84, N'Yaourt', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (85, N'Noix', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (86, N'Amande', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (87, N'Noisette', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (88, N'Pistache', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (89, N'Miel', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (90, N'Sirop d''érable', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (91, N'Eau', N'L')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (92, N'Bouillon de légumes', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (93, N'Bouillon de volaille', N'L')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (94, N'Vin blanc', N'L')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (95, N'Vin rouge', N'L')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (96, N'Basilic', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (97, N'Persil', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (98, N'Thym', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (99, N'Romarin', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (100, N'Laurier', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (101, N'Menthe', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (102, N'Gingembre', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (103, N'Curcuma', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (104, N'Piment', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (105, N'Sésame', N'G')
GO
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (106, N'Tofu', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (107, N'Tempeh', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (108, N'Seitan', N'G')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (109, N'test', N'Sachet')
INSERT [dbo].[Ingredient] ([id], [name], [typeQte]) VALUES (110, N'test2', N'L')
SET IDENTITY_INSERT [dbo].[Ingredient] OFF
GO
SET IDENTITY_INSERT [dbo].[IngredientUsed] ON 

INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2, 1, 2, 200)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (3, 1, 3, 100)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (4, 1, 4, 50)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (5, 2, 6, 5)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (6, 2, 5, 5)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1605, 1, 38, 479)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1606, 1, 105, 112)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1607, 1, 79, 250)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1608, 2, 41, 162)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1609, 2, 85, 175)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1610, 2, 36, 106)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1611, 5, 95, 421)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1612, 5, 59, 447)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1613, 5, 10, 453)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1614, 6, 80, 80)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1615, 6, 39, 410)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1616, 6, 54, 36)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1617, 7, 66, 243)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1618, 7, 60, 317)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1619, 7, 27, 264)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1620, 8, 94, 326)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1621, 8, 64, 300)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1622, 8, 77, 334)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1623, 9, 55, 497)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1624, 9, 101, 177)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1625, 9, 17, 49)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1626, 10, 76, 5)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1627, 10, 26, 464)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1628, 10, 96, 433)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1629, 11, 107, 475)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1630, 11, 13, 179)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1631, 11, 37, 29)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1632, 12, 95, 350)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1633, 12, 29, 293)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1634, 12, 86, 313)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1635, 13, 26, 137)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1636, 13, 59, 314)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1637, 13, 51, 97)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1638, 14, 46, 240)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1639, 14, 35, 6)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1640, 14, 19, 207)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1641, 15, 95, 355)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1642, 15, 76, 162)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1643, 15, 99, 55)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1644, 16, 83, 261)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1645, 16, 26, 237)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1646, 16, 44, 378)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1647, 17, 39, 477)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1648, 17, 99, 247)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1649, 17, 54, 85)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1650, 18, 43, 412)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1651, 18, 69, 311)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1652, 18, 73, 223)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1653, 19, 95, 196)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1654, 19, 55, 7)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1655, 19, 4, 412)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1656, 20, 11, 418)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1657, 20, 104, 23)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1658, 20, 95, 389)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1659, 21, 11, 34)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1660, 21, 97, 359)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1661, 21, 104, 292)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1662, 22, 51, 130)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1663, 22, 1, 408)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1664, 22, 41, 58)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1665, 23, 34, 243)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1666, 23, 44, 339)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1667, 23, 57, 70)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1668, 24, 82, 372)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1669, 24, 91, 440)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1670, 24, 95, 68)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1671, 26, 69, 63)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1672, 26, 13, 361)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1673, 26, 39, 270)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1674, 27, 84, 62)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1675, 27, 87, 321)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1676, 27, 43, 474)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1677, 28, 96, 151)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1678, 28, 32, 462)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1679, 28, 83, 35)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1680, 29, 36, 74)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1681, 29, 1, 63)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1682, 29, 14, 207)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1683, 30, 77, 351)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1684, 30, 38, 452)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1685, 30, 9, 5)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1687, 31, 107, 75)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1688, 31, 63, 415)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1689, 32, 46, 242)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1690, 32, 88, 190)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1691, 32, 39, 406)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1694, 33, 104, 342)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1695, 35, 43, 67)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1696, 35, 103, 458)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1697, 35, 77, 329)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1698, 36, 64, 88)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1699, 36, 5, 19)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1701, 37, 11, 168)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1702, 37, 94, 459)
GO
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1703, 37, 81, 225)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1704, 38, 95, 154)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1705, 38, 25, 172)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1707, 39, 33, 77)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1708, 39, 74, 298)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1709, 39, 45, 32)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1710, 40, 55, 486)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1711, 40, 46, 279)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1712, 40, 78, 308)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1713, 41, 103, 279)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1714, 41, 43, 242)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1715, 41, 33, 18)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1716, 42, 103, 307)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1717, 42, 22, 129)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1719, 43, 13, 258)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1720, 43, 31, 185)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1721, 43, 36, 201)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1722, 44, 12, 105)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1723, 44, 87, 129)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1724, 44, 1, 32)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1725, 45, 57, 357)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1726, 45, 103, 256)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1727, 45, 30, 112)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1728, 46, 28, 229)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1729, 46, 40, 173)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1730, 46, 92, 55)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1731, 47, 87, 400)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1732, 47, 4, 344)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1733, 47, 11, 259)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1734, 48, 81, 74)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1735, 48, 66, 120)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1736, 48, 92, 23)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1737, 49, 83, 11)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1738, 49, 10, 103)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1740, 50, 6, 266)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1741, 50, 98, 207)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1742, 50, 45, 423)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1743, 51, 13, 447)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1744, 51, 42, 336)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1745, 51, 85, 490)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1746, 52, 38, 431)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1747, 52, 89, 309)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1748, 52, 87, 202)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1749, 53, 100, 206)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1750, 53, 107, 11)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1751, 53, 22, 1)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1752, 54, 54, 276)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1753, 54, 72, 268)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1754, 54, 1, 62)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1755, 55, 11, 35)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1756, 55, 59, 175)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1757, 55, 35, 419)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1758, 56, 32, 423)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1759, 56, 95, 428)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1760, 56, 6, 461)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1761, 57, 62, 172)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1763, 57, 74, 51)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1764, 58, 56, 281)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1765, 58, 11, 175)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1766, 58, 21, 182)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1767, 59, 10, 344)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1768, 59, 4, 387)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1769, 59, 18, 435)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1770, 60, 90, 421)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1771, 60, 26, 148)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1772, 60, 78, 100)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1773, 61, 73, 226)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1774, 61, 74, 204)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1775, 61, 23, 478)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1776, 62, 70, 35)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1777, 62, 54, 218)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1778, 62, 34, 235)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1779, 63, 14, 439)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1780, 63, 71, 216)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1781, 63, 36, 397)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1782, 64, 65, 93)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1785, 65, 63, 338)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1786, 65, 86, 51)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1787, 65, 11, 92)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1788, 66, 32, 178)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1789, 66, 92, 474)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1790, 66, 93, 65)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1791, 67, 39, 447)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1792, 67, 18, 494)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1793, 67, 72, 264)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1794, 68, 55, 347)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1795, 68, 90, 98)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1796, 68, 35, 465)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1797, 69, 45, 432)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1799, 69, 35, 426)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1800, 70, 87, 64)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1801, 70, 30, 184)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1802, 70, 105, 277)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1804, 71, 107, 70)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1805, 71, 12, 309)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1806, 72, 90, 313)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1807, 72, 17, 286)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1808, 72, 30, 70)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1809, 73, 79, 310)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1810, 73, 38, 329)
GO
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1812, 74, 24, 463)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1813, 74, 38, 194)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1814, 74, 17, 34)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1815, 75, 56, 482)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1816, 75, 65, 13)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1817, 75, 41, 283)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1818, 76, 51, 251)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1819, 76, 75, 249)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1820, 76, 15, 477)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1821, 77, 83, 481)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1822, 77, 94, 361)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1823, 77, 76, 136)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1824, 78, 28, 394)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1825, 78, 2, 3)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1827, 79, 75, 160)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1828, 79, 107, 354)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1829, 79, 30, 190)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1830, 80, 23, 471)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1831, 80, 18, 367)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1832, 80, 72, 399)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1833, 81, 79, 397)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1834, 81, 13, 488)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1835, 81, 97, 299)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1836, 82, 23, 379)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1837, 82, 58, 382)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1838, 82, 52, 381)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1839, 83, 10, 227)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1840, 83, 23, 168)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1841, 83, 57, 131)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1842, 84, 26, 347)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1843, 84, 76, 318)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1844, 84, 104, 400)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1845, 85, 1, 145)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1846, 85, 72, 208)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1847, 85, 12, 356)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1848, 86, 73, 79)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1849, 86, 72, 325)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1850, 86, 102, 405)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1851, 87, 55, 159)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1852, 87, 87, 123)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1854, 88, 104, 231)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1855, 88, 19, 189)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1856, 88, 44, 497)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1857, 89, 106, 224)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1858, 89, 83, 61)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1859, 89, 33, 482)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1860, 90, 67, 83)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1861, 90, 60, 496)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1862, 90, 30, 156)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1863, 91, 82, 462)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1864, 91, 19, 328)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1865, 91, 57, 2)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1866, 92, 62, 2)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1867, 92, 12, 268)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1868, 92, 91, 222)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1869, 93, 58, 169)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1870, 93, 27, 76)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1871, 93, 75, 134)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1872, 94, 1, 360)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1873, 94, 14, 112)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1874, 94, 27, 383)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1875, 95, 62, 143)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1876, 95, 82, 3)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1877, 95, 20, 209)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1878, 96, 23, 125)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1879, 96, 78, 424)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1880, 96, 36, 287)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1881, 97, 45, 276)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1882, 97, 27, 181)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1883, 97, 68, 17)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1884, 98, 5, 163)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1885, 98, 55, 12)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1886, 98, 1, 271)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1887, 99, 62, 79)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1888, 99, 97, 141)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1889, 99, 13, 29)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1890, 100, 66, 14)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1891, 100, 12, 4)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1892, 100, 71, 264)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1893, 101, 101, 286)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1894, 101, 83, 498)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1895, 101, 92, 299)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1896, 102, 16, 103)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1897, 102, 76, 131)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1898, 102, 102, 248)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1899, 103, 77, 266)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1900, 103, 13, 329)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1901, 103, 21, 395)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1902, 104, 2, 89)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1903, 104, 32, 60)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1906, 105, 36, 252)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1907, 105, 83, 347)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1908, 106, 99, 346)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1909, 106, 97, 81)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1910, 106, 26, 115)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1911, 107, 100, 315)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1912, 107, 46, 332)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1913, 107, 10, 124)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1914, 108, 96, 415)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1915, 108, 9, 400)
GO
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1916, 108, 38, 175)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1917, 109, 18, 24)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1918, 109, 42, 439)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1919, 109, 57, 440)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1920, 110, 60, 167)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1922, 110, 56, 60)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1923, 111, 51, 175)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1924, 111, 42, 197)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1925, 111, 43, 440)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1926, 112, 92, 82)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1927, 112, 74, 424)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1928, 112, 14, 306)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1929, 113, 68, 455)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1930, 113, 5, 69)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1931, 113, 11, 38)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1932, 114, 18, 238)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1933, 114, 42, 135)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1934, 114, 75, 265)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1935, 115, 57, 381)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1936, 115, 31, 293)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1937, 115, 41, 172)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1938, 116, 74, 288)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1939, 116, 82, 266)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1940, 116, 93, 43)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1941, 117, 18, 4)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1942, 117, 69, 232)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1943, 117, 16, 178)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1944, 118, 51, 206)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1945, 118, 8, 266)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1946, 118, 79, 487)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1947, 119, 43, 124)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1948, 119, 83, 335)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1949, 119, 71, 206)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1950, 121, 33, 118)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1951, 121, 14, 360)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1952, 121, 20, 140)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1953, 122, 30, 236)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1954, 122, 25, 168)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1955, 122, 46, 38)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1956, 123, 38, 386)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1957, 123, 83, 193)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1958, 123, 96, 474)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1959, 124, 72, 452)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1960, 124, 76, 384)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1962, 125, 84, 478)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1963, 125, 9, 270)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1964, 125, 92, 390)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1965, 126, 42, 65)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1966, 126, 105, 315)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1967, 126, 41, 376)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1968, 127, 79, 444)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1969, 127, 42, 376)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1970, 127, 10, 483)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1971, 128, 6, 298)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1972, 128, 86, 20)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1973, 128, 72, 365)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1974, 129, 35, 58)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1976, 129, 66, 418)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1977, 130, 72, 16)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1978, 130, 79, 476)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1979, 130, 34, 463)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1980, 131, 83, 298)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1981, 131, 13, 375)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1982, 131, 75, 61)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1983, 132, 3, 240)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1984, 132, 52, 329)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1985, 132, 88, 164)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1986, 133, 35, 426)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1987, 133, 16, 280)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1988, 133, 56, 213)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1989, 134, 28, 345)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1990, 134, 29, 500)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1991, 134, 60, 353)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1992, 135, 82, 111)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1993, 135, 38, 461)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1995, 136, 90, 217)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1996, 136, 73, 282)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1997, 136, 59, 443)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (1998, 137, 51, 1)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2000, 137, 84, 179)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2001, 138, 23, 425)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2002, 138, 11, 181)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2003, 138, 12, 455)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2004, 139, 103, 247)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2005, 139, 18, 9)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2006, 139, 33, 446)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2007, 140, 37, 222)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2008, 140, 27, 351)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2009, 140, 71, 392)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2010, 141, 58, 435)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2011, 141, 13, 69)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2013, 142, 51, 66)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2014, 142, 97, 409)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2015, 142, 82, 268)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2016, 143, 6, 210)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2018, 143, 73, 386)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2019, 144, 51, 345)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2020, 144, 63, 399)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2021, 144, 27, 52)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2022, 146, 82, 218)
GO
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2023, 146, 51, 416)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2024, 146, 64, 445)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2025, 147, 4, 237)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2026, 147, 10, 495)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2027, 147, 78, 464)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2028, 148, 95, 457)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2029, 148, 23, 103)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2030, 148, 3, 428)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2031, 149, 67, 254)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2032, 149, 55, 98)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2033, 149, 8, 91)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2035, 150, 86, 474)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2036, 150, 100, 435)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2037, 151, 103, 116)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2038, 151, 58, 495)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2039, 151, 33, 356)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2040, 152, 67, 246)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2041, 152, 42, 73)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2042, 152, 46, 15)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2043, 153, 34, 196)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2044, 153, 72, 418)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2045, 153, 44, 454)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2046, 154, 82, 24)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2047, 154, 84, 111)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2048, 154, 22, 240)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2049, 156, 39, 367)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2050, 156, 16, 236)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2051, 156, 84, 242)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2052, 158, 51, 240)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2053, 158, 29, 183)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2054, 158, 18, 208)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2055, 159, 56, 438)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2056, 159, 9, 272)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2057, 159, 81, 320)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2058, 160, 23, 130)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2059, 160, 73, 281)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2060, 160, 53, 474)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2061, 161, 82, 274)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2062, 161, 96, 71)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2064, 162, 107, 488)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2065, 162, 3, 453)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2066, 162, 29, 313)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2067, 163, 29, 227)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2068, 163, 9, 267)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2069, 163, 45, 58)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2070, 169, 103, 149)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2071, 169, 79, 368)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2072, 169, 107, 490)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2073, 170, 34, 75)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2074, 170, 44, 214)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2075, 170, 107, 52)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2076, 172, 65, 467)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2077, 172, 68, 333)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2078, 172, 98, 375)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2079, 173, 31, 107)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2080, 173, 67, 369)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2081, 173, 75, 459)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2083, 174, 98, 440)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2084, 174, 1, 20)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2085, 175, 28, 189)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2086, 175, 94, 92)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2087, 175, 92, 174)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2088, 177, 77, 351)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2089, 177, 5, 170)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2090, 177, 63, 308)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2091, 178, 31, 477)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2092, 178, 14, 330)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2093, 178, 83, 128)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2094, 179, 13, 380)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2095, 179, 12, 59)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2097, 180, 53, 259)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2099, 180, 3, 168)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2100, 182, 56, 282)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2101, 182, 104, 253)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2102, 182, 85, 126)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2103, 183, 19, 280)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2104, 183, 104, 457)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2105, 183, 32, 362)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2106, 184, 104, 241)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2107, 184, 59, 4)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2108, 184, 46, 319)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2109, 186, 94, 54)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2110, 186, 21, 458)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2111, 186, 30, 94)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2113, 187, 98, 350)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2114, 187, 53, 32)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2115, 189, 75, 302)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2116, 189, 37, 246)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2117, 189, 42, 480)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2118, 190, 108, 322)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2120, 190, 81, 333)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2121, 192, 5, 344)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2122, 192, 56, 117)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2123, 192, 60, 10)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2124, 194, 98, 30)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2125, 194, 74, 114)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2127, 195, 30, 285)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2128, 195, 99, 485)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2129, 195, 5, 284)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2130, 196, 3, 172)
GO
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2131, 196, 17, 23)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2132, 196, 8, 321)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2133, 197, 34, 186)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2134, 197, 54, 344)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2135, 197, 39, 69)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2136, 199, 51, 98)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2137, 199, 57, 133)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2138, 199, 89, 337)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2139, 200, 103, 154)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2140, 200, 56, 167)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2141, 200, 88, 383)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2142, 201, 91, 338)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2143, 201, 106, 182)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2144, 201, 20, 89)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2145, 202, 100, 441)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2146, 202, 79, 185)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2147, 202, 108, 39)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2149, 203, 19, 495)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2150, 203, 100, 425)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2151, 204, 33, 202)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2152, 204, 9, 454)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2153, 204, 44, 190)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2154, 206, 70, 320)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2155, 206, 103, 358)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2156, 206, 22, 112)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2157, 209, 37, 269)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2158, 209, 34, 101)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2159, 209, 99, 12)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2160, 210, 102, 395)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2161, 210, 24, 96)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2162, 210, 100, 317)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2163, 211, 25, 382)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2164, 211, 85, 99)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2165, 211, 104, 488)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2166, 212, 78, 60)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2167, 212, 81, 276)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2168, 212, 100, 133)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2169, 213, 46, 398)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2170, 213, 107, 199)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2171, 213, 76, 184)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2172, 214, 89, 374)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2173, 214, 29, 384)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2174, 214, 52, 194)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2176, 215, 77, 418)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2177, 215, 65, 289)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2178, 216, 23, 466)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2179, 216, 24, 471)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2180, 216, 59, 1)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2181, 217, 8, 248)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2182, 217, 81, 478)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2184, 218, 56, 26)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2185, 218, 24, 359)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2186, 218, 85, 374)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2187, 219, 68, 246)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2188, 219, 97, 80)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2189, 219, 70, 32)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2190, 220, 105, 164)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2191, 220, 84, 203)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2192, 220, 107, 145)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2234, 221, 31, 500)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2235, 221, 2, 250)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2236, 221, 4, 125)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2237, 221, 5, 250)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2238, 221, 3, 10)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2239, 221, 41, 110)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2240, 221, 78, 2)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2241, 221, 91, 0)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2242, 221, 63, 250)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2243, 221, 81, 10)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2244, 225, 2, 250)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2245, 225, 78, 2)
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIngredient], [qte]) VALUES (2246, 225, 82, 1)
SET IDENTITY_INSERT [dbo].[IngredientUsed] OFF
GO
SET IDENTITY_INSERT [dbo].[Prompt] ON 

INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1, N'Entré froide rapide', N'7,19,50,40,65,149,210,183,162', 8)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (2, N'PLat principale avec du poisson', N'19,58,62,84,90,95,104,110,119,174,201,217', 8)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (3, N'recette facile', N'1,2', 8)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (4, N'recette facile 2', N'1,2', 8)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1002, N'recette facile', N'1,2', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1003, N'je cherche une recette rapide avec du chocolat', N'7,19,55,62,65,115,162,180,184,186,200,204,210,225', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1004, N'je cherche une recette rapide avec du chocolat', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1005, N'je cherche une recette rapide avec du saumon', N'19,62,204', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1006, N'je cherche une recette rapide avec du chocolat', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1007, N'je cherche une recette rapide avec du chocolat', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1008, N'je cherche une recette rapide avec du chocolat', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1009, N'je cherche une recette rapide avec du chocolat', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1010, N'je cherche une recette rapide avec du chocolat', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1011, N'test', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1012, N'test', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1013, N'test', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1014, N'test', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1015, N'test', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1016, N'test', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1017, N'test', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1018, N'je recherche un gateau', N'', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1019, N'je recherche un Gâteau ', N'61', 9)
INSERT [dbo].[Prompt] ([id], [request], [response], [userId]) VALUES (1020, N'je recherche un Gâteau', N'46,61,79,93,107,114,126,141,169,219', 9)
SET IDENTITY_INSERT [dbo].[Prompt] OFF
GO
SET IDENTITY_INSERT [dbo].[Recipe] ON 

INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (1, N'Tarte aux pommes', CAST(N'01:30:00' AS Time), N'', 1, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (2, N'Pâtes Carbonara', CAST(N'00:30:00' AS Time), N'', 2, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (5, N'Gratin dauphinois', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (6, N'Tarte au citron', CAST(N'00:45:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (7, N'Salade niçoise', CAST(N'00:20:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (8, N'Bœuf bourguignon', CAST(N'02:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (9, N'Crème brûlée', CAST(N'01:10:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (10, N'Soupe à l’oignon', CAST(N'00:50:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (11, N'Poulet basquaise', CAST(N'01:15:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (12, N'Mousse au chocolat', CAST(N'00:30:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (13, N'Quiche lorraine', CAST(N'00:40:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (14, N'Lasagnes à la bolognaise', CAST(N'01:20:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (15, N'Tarte tatin', CAST(N'01:15:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (16, N'Velouté de potiron', CAST(N'00:50:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (17, N'Cassoulet', CAST(N'02:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (18, N'Île flottante', CAST(N'00:45:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (19, N'Carpaccio de saumon', CAST(N'00:15:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (20, N'Ratatouille', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (21, N'Clafoutis aux cerises', CAST(N'00:40:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (22, N'Caviar d’aubergine', CAST(N'00:25:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (23, N'Blanquette de veau', CAST(N'01:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (24, N'Fondant au chocolat', CAST(N'00:40:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (26, N'Pizza Margherita', CAST(N'00:35:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (27, N'Chocolat liégeois', CAST(N'00:40:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (28, N'Soupe de légumes', CAST(N'00:50:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (29, N'Chili con carne', CAST(N'01:10:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (30, N'Tarte au chocolat', CAST(N'01:05:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (31, N'Gratin de courgettes', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (32, N'Madeleines', CAST(N'00:30:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (33, N'Oeufs cocotte', CAST(N'00:25:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (35, N'Tiramisu', CAST(N'01:10:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (36, N'Frittata', CAST(N'00:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (37, N'Crêpes Suzette', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (38, N'Baba au rhum', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (39, N'Couscous', CAST(N'02:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (40, N'Salade de chèvre chaud', CAST(N'00:35:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (41, N'Poêlée de légumes', CAST(N'00:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (42, N'Panna cotta', CAST(N'00:50:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (43, N'Raviolis maison', CAST(N'01:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (44, N'Crêpes salées', CAST(N'00:40:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (45, N'Pâtisserie orientale', CAST(N'01:20:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (46, N'Gâteau au yaourt', CAST(N'00:45:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (47, N'Ragoût de légumes', CAST(N'01:10:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (48, N'Croissants', CAST(N'02:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (49, N'Aubergines farcies', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (50, N'Salade César', CAST(N'00:25:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (51, N'Crêpes bretonnes', CAST(N'00:35:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (52, N'Bouillabaisse', CAST(N'02:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (53, N'Pâté en croûte', CAST(N'01:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (54, N'Tarte aux fraises', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (55, N'Pap', CAST(N'00:15:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (56, N'Boeuf à la mode', CAST(N'02:10:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (57, N'Sablés de Noël', CAST(N'00:45:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (58, N'Maki au saumon', CAST(N'00:25:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (59, N'Côtelettes d’agneau', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (60, N'Crêpes de sarrasin', CAST(N'00:35:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (61, N'Gâteau de semoule', CAST(N'00:40:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (62, N'Gravlax de saumon', CAST(N'00:20:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (63, N'Poulet rôti', CAST(N'01:40:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (64, N'Chouquettes', CAST(N'00:30:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (65, N'Salade de fruits', CAST(N'00:15:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (66, N'Pain de viande', CAST(N'01:20:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (67, N'Bouchées à la reine', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (68, N'Mousse de framboises', CAST(N'00:30:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (69, N'Pâtisserie tunisienne', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (70, N'Bœuf au curry', CAST(N'01:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (71, N'Minestrone', CAST(N'01:10:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (72, N'Pouding au chocolat', CAST(N'00:40:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (73, N'Brioche', CAST(N'02:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (74, N'Moules marinières', CAST(N'00:40:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (75, N'Tarte au fromage', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (76, N'Tarte aux pêches', CAST(N'01:05:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (77, N'Gratin de chou-fleur', CAST(N'01:10:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (78, N'Tarte rustique', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (79, N'Gâteau au chocolat', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (80, N'Gambas à l’ail', CAST(N'00:40:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (81, N'Crêpes à la confiture', CAST(N'00:30:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (82, N'Tarte au fromage blanc', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (83, N'Pâté de campagne', CAST(N'01:30:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (84, N'Loup en croûte de sel', CAST(N'01:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (85, N'Tarte au sucre', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (86, N'Ragoût de mouton', CAST(N'02:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (87, N'Tarte à la rhubarbe', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (88, N'Bavarois à la fraise', CAST(N'01:10:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (89, N'Chocolat chaud maison', CAST(N'00:25:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (90, N'Moules au curry', CAST(N'00:45:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (91, N'Couscous végétarien', CAST(N'02:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (92, N'Tarte à la crème de marrons', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (93, N'Gâteau aux noix', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (94, N'Brochettes de poulet', CAST(N'00:45:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (95, N'Marmite de poisson', CAST(N'01:20:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (96, N'Tarte au chocolat et noisettes', CAST(N'01:10:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (97, N'Canelés', CAST(N'00:55:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (98, N'Quiche aux épinards', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (99, N'Poulet au paprika', CAST(N'01:15:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (100, N'Flan pâtissier', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (101, N'Pâtes aux champignons', CAST(N'00:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (102, N'Tarte au fromage de chèvre', CAST(N'01:10:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (103, N'Riz au lait', CAST(N'00:40:00' AS Time), N'', 8, N'Dessert', 4)
GO
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (104, N'Saumon en papillote', CAST(N'00:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (105, N'Pâté de foie gras', CAST(N'01:20:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (106, N'Panna cotta à la vanille', CAST(N'00:40:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (107, N'Gâteau au fromage blanc', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (108, N'Tarte à la poire', CAST(N'01:10:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (109, N'Pâtes à la puttanesca', CAST(N'00:40:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (110, N'Soupe de poisson', CAST(N'01:30:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (111, N'Chocolat mousseux', CAST(N'00:40:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (112, N'Boeuf aux légumes', CAST(N'01:20:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (113, N'Riz basmati au curry', CAST(N'00:40:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (114, N'Gâteau aux pommes', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (115, N'Tartare de bœuf', CAST(N'00:15:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (116, N'Poule au pot', CAST(N'02:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (117, N'Chou à la crème', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (118, N'Croissants au beurre', CAST(N'02:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (119, N'Sardines grillées', CAST(N'00:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (121, N'Quiche à la tomate', CAST(N'01:10:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (122, N'Mousse au citron', CAST(N'00:40:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (123, N'Gnocchis maison', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (124, N'Cake aux carottes', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (125, N'Escargots de Bourgogne', CAST(N'00:40:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (126, N'Gâteau au citron', CAST(N'00:55:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (127, N'Tarte à la tomate', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (128, N'Pâté en croûte de veau', CAST(N'01:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (129, N'Bœuf sauté aux légumes', CAST(N'00:40:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (130, N'Tiramisu aux fruits rouges', CAST(N'01:10:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (131, N'Tartelette aux fruits', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (132, N'Pizza quatre fromages', CAST(N'00:45:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (133, N'Crêpes au Nutella', CAST(N'00:30:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (134, N'Tarte à la banane', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (135, N'Poulet aux herbes', CAST(N'01:10:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (136, N'Riz au lait à la vanille', CAST(N'00:50:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (137, N'Pâtisserie marocaine', CAST(N'01:20:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (138, N'Salade de quinoa', CAST(N'00:30:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (139, N'Risotto aux champignons', CAST(N'01:10:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (140, N'Côte de bœuf grillée', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (141, N'Gâteau moelleux à la banane', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (142, N'Pain d’épices', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (143, N'Salade de légumes grillés', CAST(N'00:35:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (144, N'Gratin de pommes de terre', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (146, N'Clafoutis aux abricots', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (147, N'Boeuf stroganoff', CAST(N'01:20:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (148, N'Riz pilaf', CAST(N'00:40:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (149, N'Poire belle Hélène', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (150, N'Tarte au fromage blanc et fruits', CAST(N'01:10:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (151, N'Velouté de courgettes', CAST(N'00:45:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (152, N'Tagliatelles au saumon', CAST(N'00:50:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (153, N'Cake marbré', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (154, N'Tarte fine aux pommes', CAST(N'00:55:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (156, N'Terrine de légumes', CAST(N'01:30:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (158, N'Crumble aux pommes', CAST(N'00:50:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (159, N'Tarte aux myrtilles', CAST(N'01:15:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (160, N'Soufflé au fromage', CAST(N'00:50:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (161, N'Poulet tikka masala', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (162, N'Salade grecque', CAST(N'00:20:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (163, N'Muffins au chocolat', CAST(N'00:45:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (169, N'Gâteau marbré chocolat-vanille', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (170, N'Pizza maison', CAST(N'01:10:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (172, N'Tarte aux abricots', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (173, N'Lasagnes aux légumes', CAST(N'01:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (174, N'Blinis au saumon', CAST(N'00:35:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (175, N'Madeleines au miel', CAST(N'00:50:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (177, N'Soupe de courge', CAST(N'00:45:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (178, N'Poulet au citron', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (179, N'Crumble poire-chocolat', CAST(N'00:55:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (180, N'Soupe froide de concombre', CAST(N'00:20:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (182, N'Cheesecake au citron', CAST(N'01:20:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (183, N'Mini quiches', CAST(N'00:45:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (184, N'Omelette aux fines herbes', CAST(N'00:15:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (186, N'Croque-monsieur', CAST(N'00:20:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (187, N'Gaspacho andalou', CAST(N'00:25:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (189, N'Spaghetti bolognaise', CAST(N'00:45:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (190, N'Tarte aux noix', CAST(N'01:20:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (192, N'Tian de légumes', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (194, N'Salade de lentilles', CAST(N'00:35:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (195, N'Pâtes aux épinards', CAST(N'00:40:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (196, N'Moelleux au citron', CAST(N'00:55:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (197, N'Velouté de champignons', CAST(N'00:45:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (199, N'Moelleux au chocolat', CAST(N'00:45:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (200, N'Carpaccio de tomates', CAST(N'00:15:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (201, N'Tagine de légumes', CAST(N'01:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (202, N'Riz au coco', CAST(N'00:35:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (203, N'Muffins aux myrtilles', CAST(N'00:40:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (204, N'Tartare de saumon', CAST(N'00:20:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (206, N'Brownie aux noix', CAST(N'00:50:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (209, N'Brioche maison', CAST(N'02:30:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (210, N'Salade de melon et jambon cru', CAST(N'00:15:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (211, N'Paëlla', CAST(N'01:30:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (212, N'Millefeuille', CAST(N'01:20:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (213, N'Soupe de tomates', CAST(N'00:40:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (214, N'Tarte aux figues', CAST(N'01:15:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (215, N'Chili sin carne', CAST(N'01:00:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (216, N'Flan au caramel', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (217, N'Terrine de poisson', CAST(N'01:10:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (218, N'Tartiflette', CAST(N'01:15:00' AS Time), N'', 8, N'Plat', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (219, N'Gâteau roulé à la confiture', CAST(N'01:00:00' AS Time), N'', 8, N'Dessert', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (220, N'Soupe thaï au lait de coco', CAST(N'00:50:00' AS Time), N'', 8, N'Entrée', 4)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (221, N'Tarte a la fraise', CAST(N'00:35:00' AS Time), N'be3f95c2-a5b7-47bf-b52b-fda858b62fe7.png', 9, N'Dessert', 6)
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [count]) VALUES (225, N'pancake', CAST(N'00:20:00' AS Time), N'411dbd08-166c-4b2e-aa11-a2a33fbe3e95.png', 9, N'Dessert', 10)
SET IDENTITY_INSERT [dbo].[Recipe] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([id], [idRecipe], [idUser], [date]) VALUES (294, 7, 9, CAST(N'2025-06-14T12:00:00.000' AS DateTime))
INSERT [dbo].[Schedule] ([id], [idRecipe], [idUser], [date]) VALUES (295, 43, 9, CAST(N'2025-06-14T12:00:00.000' AS DateTime))
INSERT [dbo].[Schedule] ([id], [idRecipe], [idUser], [date]) VALUES (296, 54, 9, CAST(N'2025-06-14T12:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Schedule] OFF
GO
SET IDENTITY_INSERT [dbo].[Step] ON 

INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (2, 1, N'Préchauffer le four à 180 degrés.', 1)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (3, 1, N'Préparer la pâte avec la farine, le sucre et le beurre.', 2)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (4, 1, N'Étaler la pâte et ajouter les pommes.', 3)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (5, 1, N'Cuire pendant 45 minutes.', 4)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (6, 5, N'Faire bouillir les pâtes.', 1)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (7, 5, N'Préparer la sauce carbonara.', 2)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (8, 2, N'Mélanger les pâtes avec la sauce.', 3)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (9, 221, N'PÂTE: Blanchir les jaunes et le sucre au fouet et détendre le mélange avec un peu d''eau.

', 1)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (12, 221, N'Mélanger au doigt la farine et le beurre coupé en petites parcelles pour obtenir une consistance sableuse et que tout le beurre soit absorbé (!!! Il faut faire vite pour que le mélange ne ramollisse pas trop!).', 2)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (15, 225, N'etape1', 1)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (16, 225, N'etape2', 2)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (17, 225, N'etape3', 3)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (18, 225, N'etape4', 4)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (19, 221, N'Verser au milieu de ce "sable" le mélange liquide. Incorporer au couteau les éléments rapidement sans leur donner de corps.

', 3)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (20, 221, N'Former une boule avec les paumes et fraiser 1 ou 2 fois pour rendre la boule + homogène.

', 4)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (21, 221, N'Foncer un moule de 25 cm de diamètre avec la pâte, garnissez la de papier sulfurisé et de haricots secs. Faire cuire à blanc 20 à 25 min, à 180°C (thermostat 6).

', 5)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (22, 221, N'CRÈME PÂTISSIÈRE : Mettre le lait à bouillir avec le parfum choisi (vanille ou autre).

', 6)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (23, 221, N'Travailler l''oeuf avec le sucre jusqu''à ce que la pâte fasse le ruban, ajouter la farine.

', 7)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (24, 221, N'Verser le lait bouillant sur le mélange en tournant bien.

', 8)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (25, 221, N'Remettre dans la casserole sur le feu. Faire cuire en tournant très soigneusement. Retirer après ébullition.

', 9)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (26, 221, N'Verser la crème sur le fond de tarte et disposer joliment les fraises coupées en 2.

', 10)
SET IDENTITY_INSERT [dbo].[Step] OFF
GO
SET IDENTITY_INSERT [dbo].[Stock] ON 

INSERT [dbo].[Stock] ([id], [idUser], [idIngredient], [qte]) VALUES (20, 8, 1, 100)
INSERT [dbo].[Stock] ([id], [idUser], [idIngredient], [qte]) VALUES (21, 8, 93, 50)
INSERT [dbo].[Stock] ([id], [idUser], [idIngredient], [qte]) VALUES (22, 8, 110, 2)
INSERT [dbo].[Stock] ([id], [idUser], [idIngredient], [qte]) VALUES (26, 9, 1, 100)
INSERT [dbo].[Stock] ([id], [idUser], [idIngredient], [qte]) VALUES (27, 9, 93, 50)
INSERT [dbo].[Stock] ([id], [idUser], [idIngredient], [qte]) VALUES (28, 9, 10, 10)
INSERT [dbo].[Stock] ([id], [idUser], [idIngredient], [qte]) VALUES (29, 9, 94, 459)
INSERT [dbo].[Stock] ([id], [idUser], [idIngredient], [qte]) VALUES (30, 9, 96, 433)
SET IDENTITY_INSERT [dbo].[Stock] OFF
GO
SET IDENTITY_INSERT [dbo].[Token] ON 

INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (29, 9, N'RkAW4VYQ5kijdz0EWJX2Qg==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (30, 9, N'z2gxcWZeGUWkclAHIQzojg==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (34, 8, N'awo0PoDgtkyFmsUuS2/gDQ==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (35, 8, N'Hqi7QzHLBU6eb7sASQTAdQ==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (36, 8, N'zHR9gapb70OpsUAUrH6CcA==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (37, 8, N'hWNnkOIICU2prDgEsa3M0w==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (38, 8, N'hbSGqMY4PkuIbyMrcbVPpg==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (39, 8, N'ywTQxXtmLE2KTLciE7W6wg==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (40, 8, N'BeRvlsCl5kGllauPOd94Nw==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (41, 8, N'noVkzKzxPUiTvBcJEkD4xQ==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (42, 8, N'FLc4gQf+20mAe633jALPpg==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (43, 8, N'1RNcQHLXJUu9e2RDFBroqw==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (44, 8, N'NvSF3eblqUWd0LDAtsmMzA==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (45, 8, N'ONlIkpoB1EmqgRQ1P4Vu2Q==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (46, 8, N'LeV5vm3XdEqpwwnHF5Bykw==')
INSERT [dbo].[Token] ([id], [idUser], [token]) VALUES (51, 8, N'bjLrNCklcEqIpFsHrfTWtA==')
SET IDENTITY_INSERT [dbo].[Token] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([id], [name], [surname], [mail], [password], [state]) VALUES (1, N'Jean', N'Dupont', N'jean.dupont@email.com', N'password123', N'Active')
INSERT [dbo].[User] ([id], [name], [surname], [mail], [password], [state]) VALUES (2, N'Marie', N'Curie', N'marie.curie@email.com', N'password456', N'Active')
INSERT [dbo].[User] ([id], [name], [surname], [mail], [password], [state]) VALUES (3, N'Albert', N'Einstein', N'albert.einstein@email.com', N'password789', N'Inactive')
INSERT [dbo].[User] ([id], [name], [surname], [mail], [password], [state]) VALUES (8, N'boulay', N'Clément', N'boulayclement2003@gmail.com', N'9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', N'wait')
INSERT [dbo].[User] ([id], [name], [surname], [mail], [password], [state]) VALUES (9, N'nom1', N'prénom1', N'mail@gmail.com', N'03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', N'wait')
INSERT [dbo].[User] ([id], [name], [surname], [mail], [password], [state]) VALUES (14, N'Elsa', N'Server', N'serverelsab@gmail.com', N'7v1WrjRFO0e/m4LXKiMVVg==', N'wait')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [fk_idIngredient_article] FOREIGN KEY([idIngredient])
REFERENCES [dbo].[Ingredient] ([id])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [fk_idIngredient_article]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [fk_userid_article] FOREIGN KEY([idUser])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [fk_userid_article]
GO
ALTER TABLE [dbo].[IngredientUsed]  WITH CHECK ADD  CONSTRAINT [FK_IngredientUsed_Ingredient] FOREIGN KEY([idIngredient])
REFERENCES [dbo].[Ingredient] ([id])
GO
ALTER TABLE [dbo].[IngredientUsed] CHECK CONSTRAINT [FK_IngredientUsed_Ingredient]
GO
ALTER TABLE [dbo].[IngredientUsed]  WITH CHECK ADD  CONSTRAINT [FK_IngredientUsed_Recipe] FOREIGN KEY([idRecipe])
REFERENCES [dbo].[Recipe] ([id])
GO
ALTER TABLE [dbo].[IngredientUsed] CHECK CONSTRAINT [FK_IngredientUsed_Recipe]
GO
ALTER TABLE [dbo].[Prompt]  WITH CHECK ADD  CONSTRAINT [fk_userid] FOREIGN KEY([userId])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Prompt] CHECK CONSTRAINT [fk_userid]
GO
ALTER TABLE [dbo].[Recipe]  WITH CHECK ADD  CONSTRAINT [FK__Recipe__idUser__4AB81AF0] FOREIGN KEY([idUser])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Recipe] CHECK CONSTRAINT [FK__Recipe__idUser__4AB81AF0]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_Recipe] FOREIGN KEY([idRecipe])
REFERENCES [dbo].[Recipe] ([id])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_Recipe]
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD  CONSTRAINT [FK_Schedule_User] FOREIGN KEY([idUser])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Schedule] CHECK CONSTRAINT [FK_Schedule_User]
GO
ALTER TABLE [dbo].[Step]  WITH CHECK ADD  CONSTRAINT [FK_Step_Recipe] FOREIGN KEY([idRecipe])
REFERENCES [dbo].[Recipe] ([id])
GO
ALTER TABLE [dbo].[Step] CHECK CONSTRAINT [FK_Step_Recipe]
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD  CONSTRAINT [fk_ingredient_idIngredient] FOREIGN KEY([idIngredient])
REFERENCES [dbo].[Ingredient] ([id])
GO
ALTER TABLE [dbo].[Stock] CHECK CONSTRAINT [fk_ingredient_idIngredient]
GO
ALTER TABLE [dbo].[Stock]  WITH CHECK ADD  CONSTRAINT [fk_user_iduser] FOREIGN KEY([idUser])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Stock] CHECK CONSTRAINT [fk_user_iduser]
GO
USE [master]
GO
ALTER DATABASE [MarmitonVanced] SET  READ_WRITE 
GO
