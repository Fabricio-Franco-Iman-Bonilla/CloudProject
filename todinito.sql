
/****** Object:  User [usuarioAguilu]    Script Date: 16/06/2025 0:17:19 ******/
CREATE USER [usuarioAguilu] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[administrador]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[administrador](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[usuarioId] [int] NULL,
	[credencial] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auxiliarAlmacen]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auxiliarAlmacen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[usuarioId] [int] NULL,
	[credencial] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categorias]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categorias](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detallePedido]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detallePedido](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[pedidoId] [int] NULL,
	[cantidad] [int] NULL,
	[precioUnitario] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inventario]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inventario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[cantidadMinima] [int] NULL,
	[cantidadMaxima] [int] NULL,
	[fechaIngreso] [datetime] NULL,
	[capacidad] [int] NULL,
	[estado] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jefeAlmacen]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jefeAlmacen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[usuarioId] [int] NULL,
	[credencial] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[kardex]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kardex](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[fechaMovimiento] [datetime] NULL,
	[tipoMovId] [int] NULL,
	[inventarioId] [int] NULL,
	[productoId] [int] NULL,
	[jefeAlmacenId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pedido]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pedido](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NULL,
	[estado] [nvarchar](50) NULL,
	[proveedorId] [int] NULL,
	[productoId] [int] NULL,
	[adminId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[persona]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[persona](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[dni] [nvarchar](8) NULL,
	[fechaNacimiento] [datetime] NULL,
	[telefono] [nvarchar](9) NULL,
	[direccion] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productos]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[precioCosto] [decimal](10, 2) NULL,
	[precioVenta] [decimal](10, 2) NULL,
	[descripcion] [nvarchar](255) NULL,
	[fechaCreacion] [datetime] NULL,
	[cantidad] [int] NULL,
	[categoriaId] [int] NULL,
	[proveedorId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[proveedores]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[proveedores](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](100) NULL,
	[telefono] [nvarchar](20) NULL,
	[email] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[registroPago]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[registroPago](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[detalle] [nvarchar](255) NULL,
	[estado] [nvarchar](50) NULL,
	[tipoPagoId] [int] NULL,
	[adminId] [int] NULL,
	[pedidoId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipoMovimiento]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipoMovimiento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipoPago]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipoPago](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[tipo] [nvarchar](50) NULL,
	[descripcion] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 16/06/2025 0:17:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[contraseña] [nvarchar](255) NULL,
	[rolId] [int] NULL,
	[personaId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[administrador] ON 

INSERT [dbo].[administrador] ([Id], [usuarioId], [credencial]) VALUES (1, 3, N'001')
INSERT [dbo].[administrador] ([Id], [usuarioId], [credencial]) VALUES (2, 14, N'003')
SET IDENTITY_INSERT [dbo].[administrador] OFF
GO
SET IDENTITY_INSERT [dbo].[auxiliarAlmacen] ON 

INSERT [dbo].[auxiliarAlmacen] ([Id], [usuarioId], [credencial]) VALUES (1, 4, N'001')
INSERT [dbo].[auxiliarAlmacen] ([Id], [usuarioId], [credencial]) VALUES (2, 6, N'002')
SET IDENTITY_INSERT [dbo].[auxiliarAlmacen] OFF
GO
SET IDENTITY_INSERT [dbo].[categorias] ON 

INSERT [dbo].[categorias] ([Id], [nombre]) VALUES (1, N'peluche')
INSERT [dbo].[categorias] ([Id], [nombre]) VALUES (2, N'calentador')
INSERT [dbo].[categorias] ([Id], [nombre]) VALUES (3, N'manta')
SET IDENTITY_INSERT [dbo].[categorias] OFF
GO
SET IDENTITY_INSERT [dbo].[inventario] ON 

INSERT [dbo].[inventario] ([Id], [cantidadMinima], [cantidadMaxima], [fechaIngreso], [capacidad], [estado]) VALUES (1, 10, 25000, CAST(N'2022-01-01T00:00:00.000' AS DateTime), 1000, N'pendiente')
SET IDENTITY_INSERT [dbo].[inventario] OFF
GO
SET IDENTITY_INSERT [dbo].[jefeAlmacen] ON 

INSERT [dbo].[jefeAlmacen] ([Id], [usuarioId], [credencial]) VALUES (1, 2, N'001')
SET IDENTITY_INSERT [dbo].[jefeAlmacen] OFF
GO
SET IDENTITY_INSERT [dbo].[pedido] ON 

INSERT [dbo].[pedido] ([Id], [fecha], [estado], [proveedorId], [productoId], [adminId]) VALUES (1, CAST(N'2025-04-17T23:47:00.000' AS DateTime), N'Pendiente', 1, 1, 1)
INSERT [dbo].[pedido] ([Id], [fecha], [estado], [proveedorId], [productoId], [adminId]) VALUES (3, CAST(N'2025-01-01T02:12:00.000' AS DateTime), N'Enviado', 1, 1, 1)
INSERT [dbo].[pedido] ([Id], [fecha], [estado], [proveedorId], [productoId], [adminId]) VALUES (4, CAST(N'2025-05-26T01:11:00.000' AS DateTime), N'Pendiente', 1, 1, 1)
INSERT [dbo].[pedido] ([Id], [fecha], [estado], [proveedorId], [productoId], [adminId]) VALUES (5, CAST(N'2025-02-02T18:11:00.000' AS DateTime), N'Aprobado', 2, 3, 1)
INSERT [dbo].[pedido] ([Id], [fecha], [estado], [proveedorId], [productoId], [adminId]) VALUES (6, CAST(N'2025-04-09T19:20:00.000' AS DateTime), N'Pendiente', 2, 2, 1)
SET IDENTITY_INSERT [dbo].[pedido] OFF
GO
SET IDENTITY_INSERT [dbo].[persona] ON 

INSERT [dbo].[persona] ([Id], [nombre], [dni], [fechaNacimiento], [telefono], [direccion]) VALUES (1, N'jean piere', N'78945612', CAST(N'1999-01-22T12:44:00.000' AS DateTime), N'964587159', N'av. milagros 2251')
INSERT [dbo].[persona] ([Id], [nombre], [dni], [fechaNacimiento], [telefono], [direccion]) VALUES (2, N'jose', N'12634567', CAST(N'1998-03-02T12:00:00.000' AS DateTime), N'941456878', N'jiron de la union 1221')
INSERT [dbo].[persona] ([Id], [nombre], [dni], [fechaNacimiento], [telefono], [direccion]) VALUES (3, N'daniel', N'76147428', CAST(N'1995-09-01T04:20:00.000' AS DateTime), N'955477144', N'jr. mermeladaconfresa')
INSERT [dbo].[persona] ([Id], [nombre], [dni], [fechaNacimiento], [telefono], [direccion]) VALUES (4, N'Ronny', N'76448514', CAST(N'2005-07-28T23:44:00.000' AS DateTime), N'948155111', N'casablanca av grande')
INSERT [dbo].[persona] ([Id], [nombre], [dni], [fechaNacimiento], [telefono], [direccion]) VALUES (6, N'mathias', N'14714714', CAST(N'1995-01-01T01:25:00.000' AS DateTime), N'159478825', N'casadelprado 255')
INSERT [dbo].[persona] ([Id], [nombre], [dni], [fechaNacimiento], [telefono], [direccion]) VALUES (7, N'geraldin', N'15484848', CAST(N'1995-01-01T09:01:00.000' AS DateTime), N'123456787', N'casadelcampo 255')
INSERT [dbo].[persona] ([Id], [nombre], [dni], [fechaNacimiento], [telefono], [direccion]) VALUES (12, N'maria', N'21212121', CAST(N'1999-05-12T16:19:00.000' AS DateTime), N'987456321', N'casa del campo')
INSERT [dbo].[persona] ([Id], [nombre], [dni], [fechaNacimiento], [telefono], [direccion]) VALUES (13, N'tatiana', N'99999999', CAST(N'2001-05-16T20:43:00.000' AS DateTime), N'999999999', N'software  jiron')
SET IDENTITY_INSERT [dbo].[persona] OFF
GO
SET IDENTITY_INSERT [dbo].[productos] ON 

INSERT [dbo].[productos] ([Id], [nombre], [precioCosto], [precioVenta], [descripcion], [fechaCreacion], [cantidad], [categoriaId], [proveedorId]) VALUES (1, N'Stitch', CAST(10.00 AS Decimal(10, 2)), CAST(25.00 AS Decimal(10, 2)), N'color azul, felpa ,16x4', CAST(N'2025-04-28T22:43:00.000' AS DateTime), 200, 1, 1)
INSERT [dbo].[productos] ([Id], [nombre], [precioCosto], [precioVenta], [descripcion], [fechaCreacion], [cantidad], [categoriaId], [proveedorId]) VALUES (2, N'teddy', CAST(10.00 AS Decimal(10, 2)), CAST(25.00 AS Decimal(10, 2)), N'color marron, felpa ,16x4', CAST(N'2025-04-17T21:45:00.000' AS DateTime), 150, 1, 2)
INSERT [dbo].[productos] ([Id], [nombre], [precioCosto], [precioVenta], [descripcion], [fechaCreacion], [cantidad], [categoriaId], [proveedorId]) VALUES (3, N'Tomas', CAST(5.00 AS Decimal(10, 2)), CAST(10.00 AS Decimal(10, 2)), N'coloramarillo felpa ,20x10', CAST(N'2025-04-07T23:46:00.000' AS DateTime), 50, 1, 2)
INSERT [dbo].[productos] ([Id], [nombre], [precioCosto], [precioVenta], [descripcion], [fechaCreacion], [cantidad], [categoriaId], [proveedorId]) VALUES (4, N'Angel', CAST(10.00 AS Decimal(10, 2)), CAST(25.00 AS Decimal(10, 2)), N'color rosa felpa ,16x4', CAST(N'2025-03-31T00:48:00.000' AS DateTime), 200, 2, 1)
SET IDENTITY_INSERT [dbo].[productos] OFF
GO
SET IDENTITY_INSERT [dbo].[proveedores] ON 

INSERT [dbo].[proveedores] ([Id], [nombre], [telefono], [email]) VALUES (1, N'aliet', N'948155154', N'aliet@gmail.com')
INSERT [dbo].[proveedores] ([Id], [nombre], [telefono], [email]) VALUES (2, N'provedoresccaros', N'948155156', N'provedoresccaros@gmail.com')
SET IDENTITY_INSERT [dbo].[proveedores] OFF
GO
SET IDENTITY_INSERT [dbo].[registroPago] ON 

INSERT [dbo].[registroPago] ([Id], [detalle], [estado], [tipoPagoId], [adminId], [pedidoId]) VALUES (1, N'cliente abc', N'pagado', 2, 1, 1)
SET IDENTITY_INSERT [dbo].[registroPago] OFF
GO
SET IDENTITY_INSERT [dbo].[rol] ON 

INSERT [dbo].[rol] ([Id], [nombre], [descripcion]) VALUES (1, N'AuxiliarAlmacen', N'organiza en el almacen')
INSERT [dbo].[rol] ([Id], [nombre], [descripcion]) VALUES (2, N'JefeAlmacen', N'dirige el almacen')
INSERT [dbo].[rol] ([Id], [nombre], [descripcion]) VALUES (3, N'Administrador', N'administra la empresa.')
SET IDENTITY_INSERT [dbo].[rol] OFF
GO
SET IDENTITY_INSERT [dbo].[tipoPago] ON 

INSERT [dbo].[tipoPago] ([Id], [tipo], [descripcion]) VALUES (1, N'Tarjeta', N'Paga con tarjeta ,Visa ,Mastercar, Oh , Banco falabella, Dinner')
INSERT [dbo].[tipoPago] ([Id], [tipo], [descripcion]) VALUES (2, N'Virtual', N'Yape')
SET IDENTITY_INSERT [dbo].[tipoPago] OFF
GO
SET IDENTITY_INSERT [dbo].[usuario] ON 

INSERT [dbo].[usuario] ([Id], [nombre], [contraseña], [rolId], [personaId]) VALUES (2, N'polo', N'$2a$10$uN6aH0.cur5AFtkoipC7Le/TRO43a4tm6Y.w3ajlfNJ4HXrM1UbkK', 1, 1)
INSERT [dbo].[usuario] ([Id], [nombre], [contraseña], [rolId], [personaId]) VALUES (3, N'daniel', N'$2a$10$amAV5sG/JzO0mgYJpgkLf.NBaxruIcafc7MxVkjK4sMlnNcxnRjbG', 3, 3)
INSERT [dbo].[usuario] ([Id], [nombre], [contraseña], [rolId], [personaId]) VALUES (4, N'jose', N'$2a$11$kmfhgnpOddSjZ22DGGATaOSfIodZfsWC/tpKTbDTf8QRYWz0RgIxO', 1, 2)
INSERT [dbo].[usuario] ([Id], [nombre], [contraseña], [rolId], [personaId]) VALUES (6, N'ronny', N'$2a$11$8/DgXw3lPkQHjdhxZeBwu.Z/tjOaKEu0M7gqAbhf0utKmshrQeURO', 1, 4)
INSERT [dbo].[usuario] ([Id], [nombre], [contraseña], [rolId], [personaId]) VALUES (7, N'josias', N'$2a$11$gjAP7XqfR/zv0NDzWcm6w.RH1cxGOxjEYIIjYaSUwn8pZHvW.rduW', 2, 2)
INSERT [dbo].[usuario] ([Id], [nombre], [contraseña], [rolId], [personaId]) VALUES (8, N'da', N'$2a$11$iyGjTifevX/FTWT/xg0MEuqjJ3RuWJ.QkODLwMTpnns8UpDIt7WEC', 1, 1)
INSERT [dbo].[usuario] ([Id], [nombre], [contraseña], [rolId], [personaId]) VALUES (10, N'test', N'$2a$11$vMYmaAPnmLwXVMuE4fB2.uEuLhCr6IRRAMGz.q0fX8afvEr3/0pnO', 3, 1)
INSERT [dbo].[usuario] ([Id], [nombre], [contraseña], [rolId], [personaId]) VALUES (12, N'jefealmacen', N'$2a$11$IGDpEQbNxS5AVw/Yw7IBmeaC5nbEQuKI084RDMKS6nK2X.CdpRC2e', 2, 1)
INSERT [dbo].[usuario] ([Id], [nombre], [contraseña], [rolId], [personaId]) VALUES (13, N'auxiliar', N'$2a$11$1QBJht/nbvCYl25nx1NjTOabfNi9Nv0gurbftwLI0N9x3cE2.AAKS', 1, 6)
INSERT [dbo].[usuario] ([Id], [nombre], [contraseña], [rolId], [personaId]) VALUES (14, N'admi', N'$2a$11$ovNWNxTbNt1VHO1s.rmepuaLcn6yEeDJYoc8Ybx3XpphL77c.F8lS', 3, 7)
INSERT [dbo].[usuario] ([Id], [nombre], [contraseña], [rolId], [personaId]) VALUES (16, N'hola', N'$2a$11$jcG60CF9W6HKEZiKZibwA.5mNh5Hmg2WPRecCPPOSBIceVuhVb61O', 2, 4)
SET IDENTITY_INSERT [dbo].[usuario] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__persona__2A16D9454FA23B1E]    Script Date: 16/06/2025 0:17:20 ******/
ALTER TABLE [dbo].[persona] ADD UNIQUE NONCLUSTERED 
(
	[telefono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__persona__D87608A7DF57BE6D]    Script Date: 16/06/2025 0:17:20 ******/
ALTER TABLE [dbo].[persona] ADD UNIQUE NONCLUSTERED 
(
	[dni] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__proveedo__2A16D945467ED49F]    Script Date: 16/06/2025 0:17:20 ******/
ALTER TABLE [dbo].[proveedores] ADD UNIQUE NONCLUSTERED 
(
	[telefono] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__proveedo__AB6E616489D35FAC]    Script Date: 16/06/2025 0:17:20 ******/
ALTER TABLE [dbo].[proveedores] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[administrador]  WITH CHECK ADD FOREIGN KEY([usuarioId])
REFERENCES [dbo].[usuario] ([Id])
GO
ALTER TABLE [dbo].[auxiliarAlmacen]  WITH CHECK ADD FOREIGN KEY([usuarioId])
REFERENCES [dbo].[usuario] ([Id])
GO
ALTER TABLE [dbo].[detallePedido]  WITH CHECK ADD FOREIGN KEY([pedidoId])
REFERENCES [dbo].[pedido] ([Id])
GO
ALTER TABLE [dbo].[jefeAlmacen]  WITH CHECK ADD FOREIGN KEY([usuarioId])
REFERENCES [dbo].[usuario] ([Id])
GO
ALTER TABLE [dbo].[kardex]  WITH CHECK ADD FOREIGN KEY([inventarioId])
REFERENCES [dbo].[inventario] ([Id])
GO
ALTER TABLE [dbo].[kardex]  WITH CHECK ADD FOREIGN KEY([jefeAlmacenId])
REFERENCES [dbo].[jefeAlmacen] ([Id])
GO
ALTER TABLE [dbo].[kardex]  WITH CHECK ADD FOREIGN KEY([productoId])
REFERENCES [dbo].[productos] ([Id])
GO
ALTER TABLE [dbo].[kardex]  WITH CHECK ADD FOREIGN KEY([tipoMovId])
REFERENCES [dbo].[tipoMovimiento] ([Id])
GO
ALTER TABLE [dbo].[pedido]  WITH CHECK ADD FOREIGN KEY([adminId])
REFERENCES [dbo].[administrador] ([Id])
GO
ALTER TABLE [dbo].[pedido]  WITH CHECK ADD FOREIGN KEY([productoId])
REFERENCES [dbo].[productos] ([Id])
GO
ALTER TABLE [dbo].[pedido]  WITH CHECK ADD FOREIGN KEY([proveedorId])
REFERENCES [dbo].[proveedores] ([Id])
GO
ALTER TABLE [dbo].[productos]  WITH CHECK ADD FOREIGN KEY([categoriaId])
REFERENCES [dbo].[categorias] ([Id])
GO
ALTER TABLE [dbo].[productos]  WITH CHECK ADD FOREIGN KEY([proveedorId])
REFERENCES [dbo].[proveedores] ([Id])
GO
ALTER TABLE [dbo].[registroPago]  WITH CHECK ADD FOREIGN KEY([adminId])
REFERENCES [dbo].[administrador] ([Id])
GO
ALTER TABLE [dbo].[registroPago]  WITH CHECK ADD FOREIGN KEY([pedidoId])
REFERENCES [dbo].[pedido] ([Id])
GO
ALTER TABLE [dbo].[registroPago]  WITH CHECK ADD FOREIGN KEY([tipoPagoId])
REFERENCES [dbo].[tipoPago] ([Id])
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD FOREIGN KEY([personaId])
REFERENCES [dbo].[persona] ([Id])
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD FOREIGN KEY([rolId])
REFERENCES [dbo].[rol] ([Id])
GO
USE [master]
GO
ALTER DATABASE [usuarioAguilu] SET  READ_WRITE 
GO
