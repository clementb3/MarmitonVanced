USE [master]
GO
/****** Object:  Database [MarmitonVanced]    Script Date: 09/05/2025 14:41:25 ******/
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
/****** Object:  Table [dbo].[Ingredient]    Script Date: 09/05/2025 14:41:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredient](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[image] [nchar](150) NOT NULL,
 CONSTRAINT [PK_Ingredient] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IngredientUsed]    Script Date: 09/05/2025 14:41:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngredientUsed](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idRecipe] [int] NOT NULL,
	[idIgredient] [int] NOT NULL,
	[qte] [varchar](50) NOT NULL,
 CONSTRAINT [PK__Ingredie__3213E83F599FD8B1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recipe]    Script Date: 09/05/2025 14:41:25 ******/
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
	[description] [text] NOT NULL,
 CONSTRAINT [PK_Recipe] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 09/05/2025 14:41:25 ******/
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
/****** Object:  Table [dbo].[Step]    Script Date: 09/05/2025 14:41:25 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 09/05/2025 14:41:25 ******/
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
SET IDENTITY_INSERT [dbo].[Ingredient] ON 

INSERT [dbo].[Ingredient] ([id], [name], [image]) VALUES (1, N'Tomate', N'Tomate.jpg                                                                                                                                            ')
INSERT [dbo].[Ingredient] ([id], [name], [image]) VALUES (2, N'Farine', N'Farine.jpg                                                                                                                                            ')
INSERT [dbo].[Ingredient] ([id], [name], [image]) VALUES (3, N'Sucre', N'Sucre.jpg                                                                                                                                             ')
INSERT [dbo].[Ingredient] ([id], [name], [image]) VALUES (4, N'Beurre', N'Beurre.jpg                                                                                                                                            ')
INSERT [dbo].[Ingredient] ([id], [name], [image]) VALUES (5, N'Sel', N'Sel.jpg                                                                                                                                               ')
INSERT [dbo].[Ingredient] ([id], [name], [image]) VALUES (6, N'Poivre', N'Poivre.jpg                                                                                                                                            ')
SET IDENTITY_INSERT [dbo].[Ingredient] OFF
GO
SET IDENTITY_INSERT [dbo].[IngredientUsed] ON 

INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIgredient], [qte]) VALUES (2, 1, 2, N'200')
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIgredient], [qte]) VALUES (3, 1, 3, N'100')
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIgredient], [qte]) VALUES (4, 1, 4, N'50')
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIgredient], [qte]) VALUES (5, 2, 6, N'5')
INSERT [dbo].[IngredientUsed] ([id], [idRecipe], [idIgredient], [qte]) VALUES (6, 2, 5, N'5')
SET IDENTITY_INSERT [dbo].[IngredientUsed] OFF
GO
SET IDENTITY_INSERT [dbo].[Recipe] ON 

INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [description]) VALUES (1, N'Tarte aux pommes', CAST(N'01:30:00' AS Time), N'tarte_pommes.jpg', 1, N'Dessert', N'Une délicieuse tarte traditionnelle aux pommes.')
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [description]) VALUES (2, N'Pâtes Carbonara', CAST(N'00:30:00' AS Time), N'carbonara.jpg', 2, N'Plat', N'Un grand classique italien avec des œufs et du lard.')
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [description]) VALUES (3, N'Tarte aux pommes', CAST(N'01:30:00' AS Time), N'tarte_pommes.jpg', 1, N'Dessert', N'Une délicieuse tarte traditionnelle aux pommes.')
INSERT [dbo].[Recipe] ([id], [name], [time], [image], [idUser], [type], [description]) VALUES (4, N'Pâtes Carbonara', CAST(N'00:30:00' AS Time), N'carbonara.jpg', 2, N'Entrée', N'Un grand classique italien avec des œufs et du lard.')
SET IDENTITY_INSERT [dbo].[Recipe] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([id], [idRecipe], [idUser], [date]) VALUES (2, 1, 1, CAST(N'2025-04-27T16:11:56.630' AS DateTime))
INSERT [dbo].[Schedule] ([id], [idRecipe], [idUser], [date]) VALUES (3, 2, 2, CAST(N'2025-04-28T16:11:56.630' AS DateTime))
SET IDENTITY_INSERT [dbo].[Schedule] OFF
GO
SET IDENTITY_INSERT [dbo].[Step] ON 

INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (2, 1, N'Préchauffer le four à 180 degrés.', 1)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (3, 1, N'Préparer la pâte avec la farine, le sucre et le beurre.', 2)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (4, 1, N'Étaler la pâte et ajouter les pommes.', 3)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (5, 1, N'Cuire pendant 45 minutes.', 4)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (6, 2, N'Faire bouillir les pâtes.', 1)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (7, 2, N'Préparer la sauce carbonara.', 2)
INSERT [dbo].[Step] ([id], [idRecipe], [desc], [pos]) VALUES (8, 2, N'Mélanger les pâtes avec la sauce.', 3)
SET IDENTITY_INSERT [dbo].[Step] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([id], [name], [surname], [mail], [password], [state]) VALUES (1, N'Jean', N'Dupont', N'jean.dupont@email.com', N'password123', N'Active')
INSERT [dbo].[User] ([id], [name], [surname], [mail], [password], [state]) VALUES (2, N'Marie', N'Curie', N'marie.curie@email.com', N'password456', N'Active')
INSERT [dbo].[User] ([id], [name], [surname], [mail], [password], [state]) VALUES (3, N'Albert', N'Einstein', N'albert.einstein@email.com', N'password789', N'Inactive')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[IngredientUsed]  WITH CHECK ADD  CONSTRAINT [FK_IngredientUsed_Ingredient] FOREIGN KEY([idIgredient])
REFERENCES [dbo].[Ingredient] ([id])
GO
ALTER TABLE [dbo].[IngredientUsed] CHECK CONSTRAINT [FK_IngredientUsed_Ingredient]
GO
ALTER TABLE [dbo].[IngredientUsed]  WITH CHECK ADD  CONSTRAINT [FK_IngredientUsed_Recipe] FOREIGN KEY([idRecipe])
REFERENCES [dbo].[Recipe] ([id])
GO
ALTER TABLE [dbo].[IngredientUsed] CHECK CONSTRAINT [FK_IngredientUsed_Recipe]
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
USE [master]
GO
ALTER DATABASE [MarmitonVanced] SET  READ_WRITE 
GO
