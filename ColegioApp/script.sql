USE [master]
GO
/****** Object:  Database [ColegioDB]    Script Date: 11/20/2024 11:40:17 AM ******/
CREATE DATABASE [ColegioDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ColegioDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ColegioDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ColegioDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ColegioDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ColegioDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ColegioDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ColegioDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ColegioDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ColegioDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ColegioDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ColegioDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ColegioDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ColegioDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ColegioDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ColegioDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ColegioDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ColegioDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ColegioDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ColegioDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ColegioDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ColegioDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ColegioDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ColegioDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ColegioDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ColegioDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ColegioDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ColegioDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ColegioDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ColegioDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ColegioDB] SET  MULTI_USER 
GO
ALTER DATABASE [ColegioDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ColegioDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ColegioDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ColegioDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ColegioDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ColegioDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ColegioDB', N'ON'
GO
ALTER DATABASE [ColegioDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [ColegioDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ColegioDB]
GO
/****** Object:  Table [dbo].[Asignaturas]    Script Date: 11/20/2024 11:40:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asignaturas](
	[AsignaturaID] [int] IDENTITY(1,1) NOT NULL,
	[NombreAsignatura] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AsignaturaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Asistencias]    Script Date: 11/20/2024 11:40:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Asistencias](
	[AsistenciaID] [int] IDENTITY(1,1) NOT NULL,
	[EstudianteID] [int] NULL,
	[Fecha] [datetime] NOT NULL,
	[Presente] [bit] NOT NULL,
	[RecordID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AsistenciaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Calificaciones]    Script Date: 11/20/2024 11:40:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calificaciones](
	[CalificacionID] [int] IDENTITY(1,1) NOT NULL,
	[EstudianteID] [int] NULL,
	[CursoID] [int] NULL,
	[AsignaturaID] [int] NULL,
	[Nota] [int] NOT NULL,
	[Literal] [varchar](1) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CalificacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cursos]    Script Date: 11/20/2024 11:40:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cursos](
	[CursoID] [int] IDENTITY(1,1) NOT NULL,
	[NombreCurso] [varchar](100) NOT NULL,
	[Descripcion] [text] NULL,
	[ProfesorID] [int] NOT NULL,
	[NivelID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CursoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estudiantes]    Script Date: 11/20/2024 11:40:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estudiantes](
	[EstudianteID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Email] [varchar](100) NULL,
	[Sexo] [varchar](1) NOT NULL,
	[FechaNacimiento] [datetime] NOT NULL,
	[CursoID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EstudianteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Niveles]    Script Date: 11/20/2024 11:40:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Niveles](
	[NivelID] [int] IDENTITY(1,1) NOT NULL,
	[NombreNivel] [varchar](50) NOT NULL,
	[CoordinadorID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[NivelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecordAsistencias]    Script Date: 11/20/2024 11:40:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecordAsistencias](
	[RecordID] [int] IDENTITY(1,1) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[UsuarioRegistro] [int] NOT NULL,
	[CursoID] [int] NOT NULL,
 CONSTRAINT [PK_RecordAsistencias] PRIMARY KEY CLUSTERED 
(
	[RecordID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 11/20/2024 11:40:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 11/20/2024 11:40:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[UsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[PasswordHash] [varchar](255) NOT NULL,
	[RoleID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Asignaturas] ON 

INSERT [dbo].[Asignaturas] ([AsignaturaID], [NombreAsignatura]) VALUES (4, N'Ciencias naturales')
INSERT [dbo].[Asignaturas] ([AsignaturaID], [NombreAsignatura]) VALUES (3, N'Ciencias sociales')
INSERT [dbo].[Asignaturas] ([AsignaturaID], [NombreAsignatura]) VALUES (1, N'Lengua española')
INSERT [dbo].[Asignaturas] ([AsignaturaID], [NombreAsignatura]) VALUES (2, N'Matemáticas')
SET IDENTITY_INSERT [dbo].[Asignaturas] OFF
GO
SET IDENTITY_INSERT [dbo].[Asistencias] ON 

INSERT [dbo].[Asistencias] ([AsistenciaID], [EstudianteID], [Fecha], [Presente], [RecordID]) VALUES (2, 28, CAST(N'2024-11-19T20:16:57.163' AS DateTime), 1, 1)
INSERT [dbo].[Asistencias] ([AsistenciaID], [EstudianteID], [Fecha], [Presente], [RecordID]) VALUES (3, 29, CAST(N'2024-11-19T20:16:57.163' AS DateTime), 1, 1)
INSERT [dbo].[Asistencias] ([AsistenciaID], [EstudianteID], [Fecha], [Presente], [RecordID]) VALUES (4, 30, CAST(N'2024-11-19T20:16:57.163' AS DateTime), 1, 1)
INSERT [dbo].[Asistencias] ([AsistenciaID], [EstudianteID], [Fecha], [Presente], [RecordID]) VALUES (5, 31, CAST(N'2024-11-19T20:16:57.163' AS DateTime), 1, 1)
INSERT [dbo].[Asistencias] ([AsistenciaID], [EstudianteID], [Fecha], [Presente], [RecordID]) VALUES (6, 32, CAST(N'2024-11-19T20:16:57.163' AS DateTime), 0, 1)
INSERT [dbo].[Asistencias] ([AsistenciaID], [EstudianteID], [Fecha], [Presente], [RecordID]) VALUES (14, 28, CAST(N'2024-11-20T09:12:01.477' AS DateTime), 0, 3)
INSERT [dbo].[Asistencias] ([AsistenciaID], [EstudianteID], [Fecha], [Presente], [RecordID]) VALUES (15, 29, CAST(N'2024-11-20T09:12:01.477' AS DateTime), 0, 3)
INSERT [dbo].[Asistencias] ([AsistenciaID], [EstudianteID], [Fecha], [Presente], [RecordID]) VALUES (16, 30, CAST(N'2024-11-20T09:12:01.477' AS DateTime), 1, 3)
INSERT [dbo].[Asistencias] ([AsistenciaID], [EstudianteID], [Fecha], [Presente], [RecordID]) VALUES (17, 31, CAST(N'2024-11-20T09:12:01.477' AS DateTime), 1, 3)
INSERT [dbo].[Asistencias] ([AsistenciaID], [EstudianteID], [Fecha], [Presente], [RecordID]) VALUES (18, 32, CAST(N'2024-11-20T09:12:01.477' AS DateTime), 1, 3)
SET IDENTITY_INSERT [dbo].[Asistencias] OFF
GO
SET IDENTITY_INSERT [dbo].[Calificaciones] ON 

INSERT [dbo].[Calificaciones] ([CalificacionID], [EstudianteID], [CursoID], [AsignaturaID], [Nota], [Literal], [FechaRegistro]) VALUES (3, 28, 14, 1, 70, N'C', CAST(N'2024-11-20T02:51:40.383' AS DateTime))
INSERT [dbo].[Calificaciones] ([CalificacionID], [EstudianteID], [CursoID], [AsignaturaID], [Nota], [Literal], [FechaRegistro]) VALUES (4, 28, 14, 2, 70, N'C', CAST(N'2024-11-20T02:51:40.387' AS DateTime))
SET IDENTITY_INSERT [dbo].[Calificaciones] OFF
GO
SET IDENTITY_INSERT [dbo].[Cursos] ON 

INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (1, N'Pre-Kinder', N'Curso de introducción para niños pequeños', 4, 1)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (2, N'Kinder', N'Curso de preparación antes de la primaria', 5, 1)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (3, N'1er Grado', N'Primer curso de educación básica', 6, 2)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (4, N'2do Grado', N'Segundo curso de educación básica', 7, 2)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (5, N'3er Grado', N'Tercer curso de educación básica', 8, 2)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (6, N'4to Grado', N'Cuarto curso de educación básica', 9, 2)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (7, N'5to Grado', N'Quinto curso de educación básica', 10, 2)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (8, N'6to Grado', N'Sexto curso de educación básica', 11, 2)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (9, N'1ro de Secundaria', N'Primer curso de nivel medio', 12, 3)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (10, N'2do de Secundaria', N'Segundo curso de nivel medio', 13, 3)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (11, N'3ro de Secundaria', N'Tercer curso de nivel medio', 14, 3)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (12, N'4to de Secundaria', N'Cuarto curso de nivel medio', 15, 3)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (13, N'5to de Secundaria', N'Quinto curso de nivel medio', 16, 3)
INSERT [dbo].[Cursos] ([CursoID], [NombreCurso], [Descripcion], [ProfesorID], [NivelID]) VALUES (14, N'6to de Secundaria', N'Sexto curso de nivel medio', 17, 3)
SET IDENTITY_INSERT [dbo].[Cursos] OFF
GO
SET IDENTITY_INSERT [dbo].[Estudiantes] ON 

INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (2, N'Robert Cabrera', N'robert.cabrera@correo.com', N'M', CAST(N'2005-08-05T04:00:00.000' AS DateTime), 9)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (3, N'Felipe Miranda', N'felipe.miranda9@example.com', N'M', CAST(N'2011-06-03T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (4, N'Paula López', N'paula.lopez9@example.com', N'F', CAST(N'2011-09-14T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (5, N'Diego Rivera', N'diego.rivera9@example.com', N'M', CAST(N'2011-03-25T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (6, N'Mariana Pérez', N'mariana.perez9@example.com', N'F', CAST(N'2011-12-10T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (7, N'Ángel Gutiérrez', N'angel.gutierrez9@example.com', N'M', CAST(N'2011-08-29T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (8, N'Joaquín Morales', N'joaquin.morales10@example.com', N'M', CAST(N'2010-10-08T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (9, N'Alejandra Campos', N'alejandra.campos10@example.com', N'F', CAST(N'2010-04-13T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (10, N'Rodrigo Suárez', N'rodrigo.suarez10@example.com', N'M', CAST(N'2010-07-25T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (11, N'Natalia Duarte', N'natalia.duarte10@example.com', N'F', CAST(N'2010-09-19T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (12, N'Cristóbal Araya', N'cristobal.araya10@example.com', N'M', CAST(N'2010-12-03T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (13, N'Vicente Bravo', N'vicente.bravo11@example.com', N'M', CAST(N'2009-11-22T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (14, N'Valeria Rojas', N'valeria.rojas11@example.com', N'F', CAST(N'2009-05-18T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (15, N'Pedro Vega', N'pedro.vega11@example.com', N'M', CAST(N'2009-03-27T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (16, N'Claudia Palma', N'claudia.palma11@example.com', N'F', CAST(N'2009-08-08T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (17, N'Raúl Olivares', N'raul.olivares11@example.com', N'M', CAST(N'2009-01-29T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (18, N'Carlos Mendoza', N'carlos.mendoza12@example.com', N'M', CAST(N'2008-02-15T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (19, N'Andrea García', N'andrea.garcia12@example.com', N'F', CAST(N'2008-07-12T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (20, N'Luis Ortega', N'luis.ortega12@example.com', N'M', CAST(N'2008-04-25T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (21, N'Daniela Chávez', N'daniela.chavez12@example.com', N'F', CAST(N'2008-11-08T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (22, N'Pablo Contreras', N'pablo.contreras12@example.com', N'M', CAST(N'2008-09-01T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (23, N'Diego Núñez', N'diego.nunez13@example.com', N'M', CAST(N'2007-03-18T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (24, N'Camila Vásquez', N'camila.vasquez13@example.com', N'F', CAST(N'2007-10-05T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (25, N'Javier Herrera', N'javier.herrera13@example.com', N'M', CAST(N'2007-06-21T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (26, N'Laura Castillo', N'laura.castillo13@example.com', N'F', CAST(N'2007-09-14T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (27, N'Marcos López', N'marcos.lopez13@example.com', N'M', CAST(N'2007-12-03T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (28, N'Sebastián Paredes', N'sebastian.paredes14@example.com', N'M', CAST(N'2006-08-12T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (29, N'Sofía Martínez', N'sofia.martinez14@example.com', N'F', CAST(N'2006-05-19T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (30, N'Fernando Silva', N'fernando.silva14@example.com', N'M', CAST(N'2006-10-23T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (31, N'Luciana Díaz', N'luciana.diaz14@example.com', N'F', CAST(N'2006-03-15T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[Estudiantes] ([EstudianteID], [Nombre], [Email], [Sexo], [FechaNacimiento], [CursoID]) VALUES (32, N'Ignacio Rojas', N'ignacio.rojas14@example.com', N'M', CAST(N'2006-07-08T00:00:00.000' AS DateTime), 14)
SET IDENTITY_INSERT [dbo].[Estudiantes] OFF
GO
SET IDENTITY_INSERT [dbo].[Niveles] ON 

INSERT [dbo].[Niveles] ([NivelID], [NombreNivel], [CoordinadorID]) VALUES (1, N'Nivel Inicial', NULL)
INSERT [dbo].[Niveles] ([NivelID], [NombreNivel], [CoordinadorID]) VALUES (2, N'Nivel Básico', NULL)
INSERT [dbo].[Niveles] ([NivelID], [NombreNivel], [CoordinadorID]) VALUES (3, N'Nivel Medio', 1)
SET IDENTITY_INSERT [dbo].[Niveles] OFF
GO
SET IDENTITY_INSERT [dbo].[RecordAsistencias] ON 

INSERT [dbo].[RecordAsistencias] ([RecordID], [FechaRegistro], [UsuarioRegistro], [CursoID]) VALUES (1, CAST(N'2024-11-19T20:16:57.163' AS DateTime), 17, 14)
INSERT [dbo].[RecordAsistencias] ([RecordID], [FechaRegistro], [UsuarioRegistro], [CursoID]) VALUES (3, CAST(N'2024-11-20T09:12:01.477' AS DateTime), 17, 14)
SET IDENTITY_INSERT [dbo].[RecordAsistencias] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Coordinador')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (3, N'Director')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Profesor')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (1, N'Juan Pérez', N'juan.perez@correo.com', N'4RiziAKjmGfpBV3hmFllfOxVJ/+uIh3H3IuNRVPxvTs73GMe', 1)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (2, N'María López', N'maria.lopez@correo.com', N'4RiziAKjmGfpBV3hmFllfOxVJ/+uIh3H3IuNRVPxvTs73GMe', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (3, N'Carlos Rodríguez', N'carlos.rodriguez@correo.com', N'hashedpassword3', 3)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (4, N'Ana Martínez', N'ana.martinez@correo.com', N'hashedpassword4', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (5, N'Luis Gómez', N'luis.gomez@correo.com', N'hashedpassword5', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (6, N'Sofía Díaz', N'sofia.diaz@correo.com', N'hashedpassword6', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (7, N'Pedro Ruiz', N'pedro.ruiz@correo.com', N'hashedpassword7', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (8, N'Elena Torres', N'elena.torres@correo.com', N'4RiziAKjmGfpBV3hmFllfOxVJ/+uIh3H3IuNRVPxvTs73GMe', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (9, N'Ricardo Morales', N'ricardo.morales@correo.com', N'hashedpassword9', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (10, N'Laura Fernández', N'laura.fernandez@correo.com', N'hashedpassword10', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (11, N'Javier Castillo', N'javier.castillo@correo.com', N'hashedpassword11', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (12, N'Marta Sánchez', N'marta.sanchez@correo.com', N'hashedpassword12', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (13, N'Diego Herrera', N'diego.herrera@correo.com', N'hashedpassword13', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (14, N'Clara Jiménez', N'clara.jimenez@correo.com', N'hashedpassword14', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (15, N'Fernando Vargas', N'fernando.vargas@correo.com', N'hashedpassword15', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (16, N'Patricia Navarro', N'patricia.navarro@correo.com', N'hashedpassword16', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (17, N'Antonio Peña', N'antonio.pena@correo.com', N'4RiziAKjmGfpBV3hmFllfOxVJ/+uIh3H3IuNRVPxvTs73GMe', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (18, N'Gabriel Castillo', N'gabriel.castillo@correo.com', N'hashedpassword18', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (19, N'Isabel Ramos', N'isabel.ramos@correo.com', N'hashedpassword19', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (20, N'Samuel Ortiz', N'samuel.ortiz@correo.com', N'hashedpassword20', 2)
INSERT [dbo].[Usuarios] ([UsuarioID], [Nombre], [Email], [PasswordHash], [RoleID]) VALUES (21, N'Monica Flores', N'monica.flores@correo.com', N'hashedpassword21', 2)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Asignatu__101CCCC53D939423]    Script Date: 11/20/2024 11:40:18 AM ******/
ALTER TABLE [dbo].[Asignaturas] ADD UNIQUE NONCLUSTERED 
(
	[NombreAsignatura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Estudian__A9D10534D424B051]    Script Date: 11/20/2024 11:40:18 AM ******/
ALTER TABLE [dbo].[Estudiantes] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B6160EDA88492]    Script Date: 11/20/2024 11:40:18 AM ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__A9D1053439169C68]    Script Date: 11/20/2024 11:40:18 AM ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Asistencias]  WITH CHECK ADD FOREIGN KEY([EstudianteID])
REFERENCES [dbo].[Estudiantes] ([EstudianteID])
GO
ALTER TABLE [dbo].[Asistencias]  WITH CHECK ADD FOREIGN KEY([RecordID])
REFERENCES [dbo].[RecordAsistencias] ([RecordID])
GO
ALTER TABLE [dbo].[Calificaciones]  WITH CHECK ADD FOREIGN KEY([AsignaturaID])
REFERENCES [dbo].[Asignaturas] ([AsignaturaID])
GO
ALTER TABLE [dbo].[Calificaciones]  WITH CHECK ADD FOREIGN KEY([CursoID])
REFERENCES [dbo].[Cursos] ([CursoID])
GO
ALTER TABLE [dbo].[Calificaciones]  WITH CHECK ADD FOREIGN KEY([EstudianteID])
REFERENCES [dbo].[Estudiantes] ([EstudianteID])
GO
ALTER TABLE [dbo].[Cursos]  WITH CHECK ADD FOREIGN KEY([ProfesorID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Cursos]  WITH CHECK ADD FOREIGN KEY([NivelID])
REFERENCES [dbo].[Niveles] ([NivelID])
GO
ALTER TABLE [dbo].[Estudiantes]  WITH CHECK ADD FOREIGN KEY([CursoID])
REFERENCES [dbo].[Cursos] ([CursoID])
GO
ALTER TABLE [dbo].[Niveles]  WITH CHECK ADD FOREIGN KEY([CoordinadorID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[RecordAsistencias]  WITH CHECK ADD FOREIGN KEY([CursoID])
REFERENCES [dbo].[Cursos] ([CursoID])
GO
ALTER TABLE [dbo].[RecordAsistencias]  WITH CHECK ADD FOREIGN KEY([UsuarioRegistro])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
USE [master]
GO
ALTER DATABASE [ColegioDB] SET  READ_WRITE 
GO
