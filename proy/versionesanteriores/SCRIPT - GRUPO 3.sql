USE [master]
GO
/****** Object:  Database [TRANSPORTE]    Script Date: 7/11/2024 12:00:46 ******/
CREATE DATABASE [TRANSPORTE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TRANSPORTE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TRANSPORTE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TRANSPORTE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\TRANSPORTE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TRANSPORTE] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TRANSPORTE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TRANSPORTE] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TRANSPORTE] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TRANSPORTE] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TRANSPORTE] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TRANSPORTE] SET ARITHABORT OFF 
GO
ALTER DATABASE [TRANSPORTE] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TRANSPORTE] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TRANSPORTE] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TRANSPORTE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TRANSPORTE] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TRANSPORTE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TRANSPORTE] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TRANSPORTE] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TRANSPORTE] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TRANSPORTE] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TRANSPORTE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TRANSPORTE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TRANSPORTE] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TRANSPORTE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TRANSPORTE] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TRANSPORTE] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TRANSPORTE] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TRANSPORTE] SET RECOVERY FULL 
GO
ALTER DATABASE [TRANSPORTE] SET  MULTI_USER 
GO
ALTER DATABASE [TRANSPORTE] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TRANSPORTE] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TRANSPORTE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TRANSPORTE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TRANSPORTE] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TRANSPORTE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'TRANSPORTE', N'ON'
GO
ALTER DATABASE [TRANSPORTE] SET QUERY_STORE = ON
GO
ALTER DATABASE [TRANSPORTE] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TRANSPORTE]
GO
/****** Object:  Table [dbo].[CARRO]    Script Date: 7/11/2024 12:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARRO](
	[id_carro] [int] IDENTITY(1,1) NOT NULL,
	[placa] [varchar](10) NOT NULL,
	[id_estado] [int] NOT NULL,
 CONSTRAINT [PK__CARRO__D3C318A13CB82453] PRIMARY KEY CLUSTERED 
(
	[id_carro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CONDUCTORES]    Script Date: 7/11/2024 12:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONDUCTORES](
	[id_cond] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[apellido] [varchar](100) NOT NULL,
	[telefono] [varchar](20) NULL,
	[correo] [varchar](100) NULL,
	[dni] [varchar](20) NOT NULL,
 CONSTRAINT [PK__CONDUCTO__6D69F2D7E39A3BF6] PRIMARY KEY CLUSTERED 
(
	[id_cond] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ESTADO_CARRO]    Script Date: 7/11/2024 12:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESTADO_CARRO](
	[id_estado] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_estado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[INCIDENTE]    Script Date: 7/11/2024 12:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INCIDENTE](
	[id_incidente] [int] IDENTITY(1,1) NOT NULL,
	[id_prog] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[id_tipo] [int] NOT NULL,
 CONSTRAINT [PK__INCIDENT__7DD868DCDBBD5F66] PRIMARY KEY CLUSTERED 
(
	[id_incidente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MANTENIMIENTO]    Script Date: 7/11/2024 12:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MANTENIMIENTO](
	[id_mant] [int] IDENTITY(1,1) NOT NULL,
	[id_carro] [int] NOT NULL,
	[fecha_entrada] [date] NOT NULL,
	[fecha_salida] [date] NOT NULL,
	[id_taller] [int] NOT NULL,
 CONSTRAINT [PK__MANTENIM__707E5D1686F608C4] PRIMARY KEY CLUSTERED 
(
	[id_mant] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROGRAMACION]    Script Date: 7/11/2024 12:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROGRAMACION](
	[id_prog] [int] IDENTITY(1,1) NOT NULL,
	[id_carro] [int] NOT NULL,
	[fecha_partida] [date] NOT NULL,
	[fecha_llegada] [date] NOT NULL,
	[id_ruta] [int] NOT NULL,
	[id_cond] [int] NOT NULL,
 CONSTRAINT [PK_PROGRAMACION] PRIMARY KEY CLUSTERED 
(
	[id_prog] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REPARACIONES]    Script Date: 7/11/2024 12:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REPARACIONES](
	[id_rep] [int] IDENTITY(1,1) NOT NULL,
	[id_incidente] [int] NOT NULL,
	[calificacion] [decimal](3, 2) NULL,
	[fecha_entrada] [date] NOT NULL,
	[fecha_salida] [date] NOT NULL,
	[id_taller] [int] NOT NULL,
 CONSTRAINT [PK__REPARACI__6ABE6F076B672061] PRIMARY KEY CLUSTERED 
(
	[id_rep] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RUTA]    Script Date: 7/11/2024 12:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RUTA](
	[id_ruta] [int] IDENTITY(1,1) NOT NULL,
	[origen] [varchar](100) NOT NULL,
	[destino] [varchar](100) NOT NULL,
	[distancia] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK__RUTA__33C9344F9BB39AC8] PRIMARY KEY CLUSTERED 
(
	[id_ruta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TALLER]    Script Date: 7/11/2024 12:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TALLER](
	[id_taller] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[direccion] [varchar](255) NOT NULL,
	[telefono] [varchar](20) NULL,
 CONSTRAINT [PK__TALLER__D52A94EFFDBA4476] PRIMARY KEY CLUSTERED 
(
	[id_taller] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPO_INCIDENTE]    Script Date: 7/11/2024 12:00:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_INCIDENTE](
	[id_tipo] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CARRO]  WITH CHECK ADD  CONSTRAINT [FK__CARRO__id_estado__4316F928] FOREIGN KEY([id_estado])
REFERENCES [dbo].[ESTADO_CARRO] ([id_estado])
GO
ALTER TABLE [dbo].[CARRO] CHECK CONSTRAINT [FK__CARRO__id_estado__4316F928]
GO
ALTER TABLE [dbo].[INCIDENTE]  WITH CHECK ADD  CONSTRAINT [FK__INCIDENTE__id_ti__4AB81AF0] FOREIGN KEY([id_tipo])
REFERENCES [dbo].[TIPO_INCIDENTE] ([id_tipo])
GO
ALTER TABLE [dbo].[INCIDENTE] CHECK CONSTRAINT [FK__INCIDENTE__id_ti__4AB81AF0]
GO
ALTER TABLE [dbo].[INCIDENTE]  WITH CHECK ADD  CONSTRAINT [FK_INCIDENTE_PROGRAMACION] FOREIGN KEY([id_prog])
REFERENCES [dbo].[PROGRAMACION] ([id_prog])
GO
ALTER TABLE [dbo].[INCIDENTE] CHECK CONSTRAINT [FK_INCIDENTE_PROGRAMACION]
GO
ALTER TABLE [dbo].[MANTENIMIENTO]  WITH CHECK ADD  CONSTRAINT [FK_MANTENIMIENTO_CARRO] FOREIGN KEY([id_carro])
REFERENCES [dbo].[CARRO] ([id_carro])
GO
ALTER TABLE [dbo].[MANTENIMIENTO] CHECK CONSTRAINT [FK_MANTENIMIENTO_CARRO]
GO
ALTER TABLE [dbo].[MANTENIMIENTO]  WITH CHECK ADD  CONSTRAINT [FK_MANTENIMIENTO_TALLER] FOREIGN KEY([id_taller])
REFERENCES [dbo].[TALLER] ([id_taller])
GO
ALTER TABLE [dbo].[MANTENIMIENTO] CHECK CONSTRAINT [FK_MANTENIMIENTO_TALLER]
GO
ALTER TABLE [dbo].[PROGRAMACION]  WITH CHECK ADD  CONSTRAINT [FK_PROGRAMACION_CARRO] FOREIGN KEY([id_carro])
REFERENCES [dbo].[CARRO] ([id_carro])
GO
ALTER TABLE [dbo].[PROGRAMACION] CHECK CONSTRAINT [FK_PROGRAMACION_CARRO]
GO
ALTER TABLE [dbo].[PROGRAMACION]  WITH CHECK ADD  CONSTRAINT [FK_PROGRAMACION_CONDUCTORES] FOREIGN KEY([id_cond])
REFERENCES [dbo].[CONDUCTORES] ([id_cond])
GO
ALTER TABLE [dbo].[PROGRAMACION] CHECK CONSTRAINT [FK_PROGRAMACION_CONDUCTORES]
GO
ALTER TABLE [dbo].[PROGRAMACION]  WITH CHECK ADD  CONSTRAINT [FK_PROGRAMACION_RUTA] FOREIGN KEY([id_ruta])
REFERENCES [dbo].[RUTA] ([id_ruta])
GO
ALTER TABLE [dbo].[PROGRAMACION] CHECK CONSTRAINT [FK_PROGRAMACION_RUTA]
GO
ALTER TABLE [dbo].[REPARACIONES]  WITH CHECK ADD  CONSTRAINT [FK__REPARACIO__id_em__534D60F1] FOREIGN KEY([id_taller])
REFERENCES [dbo].[TALLER] ([id_taller])
GO
ALTER TABLE [dbo].[REPARACIONES] CHECK CONSTRAINT [FK__REPARACIO__id_em__534D60F1]
GO
ALTER TABLE [dbo].[REPARACIONES]  WITH CHECK ADD  CONSTRAINT [FK__REPARACIO__id_in__5070F446] FOREIGN KEY([id_incidente])
REFERENCES [dbo].[INCIDENTE] ([id_incidente])
GO
ALTER TABLE [dbo].[REPARACIONES] CHECK CONSTRAINT [FK__REPARACIO__id_in__5070F446]
GO
USE [master]
GO
ALTER DATABASE [TRANSPORTE] SET  READ_WRITE 
GO
