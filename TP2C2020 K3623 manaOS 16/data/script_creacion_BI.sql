--Creacion de esquema--------------------------------------------------------------------------------

USE GD2C2020
GO

CREATE SCHEMA [manaOS_BI]
GO

--Creacion de tablas---------------------------------------------------------------------------------

BEGIN TRANSACTION transaccion_creacion_tablas

CREATE TABLE GD2C2020.manaOS_BI.Tiempo (
	TIEMPO_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	MES_NRO decimal (18,0) NOT NULL,
	ANIO_NRO decimal (18,0) NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.Cliente (
	CLIENTE_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CLIENTE_APELLIDO nvarchar (255) NOT NULL,
	CLIENTE_NOMBRE nvarchar (255) NOT NULL,
	CLIENTE_DIRECCION nvarchar (255),
	CLIENTE_DNI decimal (18,0),
	CLIENTE_MAIL NVARCHAR (255),
	CLIENTE_EDAD NVARCHAR(15),
	CLIENTE_SEXO NVARCHAR(15)
);

-----------------------------------------------------------------------------------------------------


CREATE TABLE GD2C2020.manaOS_BI.Sucursal(
	SUCURSAL_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	SUCURSAL_DIRECCION nvarchar(255),
	SUCURSAL_MAIL nvarchar (255),
	SUCURSAL_TELEFONO decimal (18,0),
	CIUDAD_NOMBRE nvarchar(255)
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.Modelo (
	MODELO_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	MODELO_NOMBRE NVARCHAR(255),
	MODELO_POTENCIA DECIMAL(18,0),
	TRANSMISION_CODIGO DECIMAL(18,0) NOT NULL,
	MOTOR_CODIGO DECIMAL(18,0) NOT NULL,
	CAJA_CODIGO DECIMAL(18,0) NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.Fabricante (
	FABRICANTE_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FABRICANTE_NOMBRE VARCHAR(50)
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.TipoAuto (
	TIPO_AUTO_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TIPO_AUTO_DESC NVARCHAR(255),
);


-----------------------------------------------------------------------------------------------------


CREATE TABLE GD2C2020.manaOS_BI.Caja(
	CAJA_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CAJA_DESC NVARCHAR(255),
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.Motor (
	MOTOR_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.Transmision (
	TRANSMISION_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TRANSMISION_DESC NVARCHAR(255),
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.Potencia (
	POTENCIA_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	POTENCIA_DESC NVARCHAR(25),
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.AutoParte(
	AUTOPARTE_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	AUTO_PARTE_CODIGO decimal(18,0),
	AUTO_PARTE_DESCRIPCION nvarchar (255),
	FABRICANTE_ID int NOT NULL,
	MODELO_CODIGO decimal(18,0) NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.CompraDeAutoParte(
	COMPRA_AUTOPARTE_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COMPRA_AUTOPARTE_PRECIO float,
	COMPRA_NRO decimal (18,0) NOT NULL,
	AUTOPARTE_ID int NOT NULL
);

-----------------------------------------------------------------------------------------------------


CREATE TABLE GD2C2020.manaOS_BI.FacturacionDeAutoParte(
	FACTURACION_AUTOPARTE_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	PRECIO_AUTOPARTE_FACTURADO float,
	FACTURA_NRO decimal (18,0) NOT NULL,
	AUTOPARTE_ID int NOT NULL
);


-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.FacturacionDeAuto(
	FACTURACION_AUTO_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	PRECIO_AUTO_FACTURADO float,
	FACTURA_NRO decimal (18,0) NOT NULL,
	AUTO_ID int NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.CompraDeAuto(
	COMPRA_AUTO_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COMPRA_AUTO_PRECIO float,
	COMPRA_NRO decimal (18,0) NOT NULL,
	AUTO_ID int NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.Factura(
	FACTURA_NRO decimal (18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FACTURA_FECHA datetime2 (3),
	CANT_FACTURADA decimal (18,0),
	PRECIO_FACTURADO decimal (18,0),
	CLIENTE_ID DECIMAL(18,0) NOT NULL,
	SUCURSAL_ID int NOT NULL,
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.Compra(
	COMPRA_NRO decimal (18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COMPRA_FECHA datetime2 (3),
	COMPRA_PRECIO decimal (18,0),
	COMPRA_CANT decimal (18,0),
	FACTURA_NRO decimal (18,0)
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE GD2C2020.manaOS_BI.Auto (
	AUTO_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	AUTO_CANT_KMS DECIMAL(18,0),
	AUTO_FECHA_ALTA DATETIME2(3),
	AUTO_NRO_CHASIS NVARCHAR(255),
	AUTO_NRO_MOTOR nvarchar (255),
	AUTO_PATENTE nvarchar (255),
	MODELO_CODIGO decimal(18,0) NOT NULL,
	FABRICANTE_ID int NOT NULL,
	TIPO_AUTO_CODIGO decimal(18,0) NOT NULL,
);


--Agregamos las FK-----------------------------------------------------------------------------------

ALTER TABLE GD2C2020.manaOS_BI.Modelo
   ADD CONSTRAINT FK_Modelo_Transmision FOREIGN KEY (TRANSMISION_CODIGO)
      REFERENCES GD2C2020.manaOS_BI.Transmision (TRANSMISION_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS_BI.Modelo
   ADD CONSTRAINT FK_Modelo_Motor FOREIGN KEY (MOTOR_CODIGO)
      REFERENCES GD2C2020.manaOS_BI.Motor (MOTOR_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS_BI.Modelo
   ADD CONSTRAINT FK_Modelo_Caja FOREIGN KEY (CAJA_CODIGO)
      REFERENCES GD2C2020.manaOS_BI.Caja (CAJA_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE GD2C2020.manaOS_BI.AutoParte
   ADD CONSTRAINT FK_AutoParte_Fabricante FOREIGN KEY (FABRICANTE_ID)
      REFERENCES GD2C2020.manaOS_BI.Fabricante(FABRICANTE_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS_BI.AutoParte
   ADD CONSTRAINT FK_AutoParte_Modelo FOREIGN KEY (MODELO_CODIGO)
      REFERENCES GD2C2020.manaOS_BI.Modelo(MODELO_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE GD2C2020.manaOS_BI.CompraDeAutoParte
   ADD CONSTRAINT FK_CompraDeAutoParte_Compra FOREIGN KEY (COMPRA_NRO)
      REFERENCES GD2C2020.manaOS_BI.Compra(COMPRA_NRO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS_BI.CompraDeAutoParte
   ADD CONSTRAINT FK_CompraDeAutoParte_AutoParte FOREIGN KEY (AUTOPARTE_ID)
      REFERENCES GD2C2020.manaOS_BI.AutoParte(AUTOPARTE_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE GD2C2020.manaOS_BI.FacturacionDeAuto
   ADD CONSTRAINT FK_FacturacionDeAuto_Factura FOREIGN KEY (FACTURA_NRO)
      REFERENCES GD2C2020.manaOS_BI.Factura(FACTURA_NRO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS_BI.FacturacionDeAuto
   ADD CONSTRAINT FK_FacturacionDeAuto_Auto FOREIGN KEY (AUTO_ID)
      REFERENCES GD2C2020.manaOS_BI.Auto(AUTO_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE GD2C2020.manaOS_BI.CompraDeAuto
   ADD CONSTRAINT FK_CompraDeAuto_Compra FOREIGN KEY (COMPRA_NRO)
      REFERENCES GD2C2020.manaOS_BI.Compra(COMPRA_NRO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS_BI.CompraDeAuto
   ADD CONSTRAINT FK_CompraDeAuto_Auto FOREIGN KEY (AUTO_ID)
      REFERENCES GD2C2020.manaOS_BI.Auto(AUTO_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE GD2C2020.manaOS_BI.Factura
   ADD CONSTRAINT FK_Factura_Cliente FOREIGN KEY (CLIENTE_ID)
      REFERENCES GD2C2020.manaOS_BI.Cliente(CLIENTE_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS_BI.Factura
   ADD CONSTRAINT FK_Factura_Sucursal FOREIGN KEY (SUCURSAL_ID)
      REFERENCES GD2C2020.manaOS_BI.Sucursal(SUCURSAL_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE GD2C2020.manaOS_BI.Compra
   ADD CONSTRAINT FK_Compra_Factura FOREIGN KEY (FACTURA_NRO)
      REFERENCES GD2C2020.manaOS_BI.Factura(FACTURA_NRO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE GD2C2020.manaOS_BI.Auto
   ADD CONSTRAINT FK_Auto_Modelo FOREIGN KEY (MODELO_CODIGO)
      REFERENCES GD2C2020.manaOS_BI.Modelo(MODELO_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS_BI.Auto
   ADD CONSTRAINT FK_Auto_Fabricante FOREIGN KEY (FABRICANTE_ID)
      REFERENCES GD2C2020.manaOS_BI.Fabricante(FABRICANTE_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS_BI.Auto
   ADD CONSTRAINT FK_Auto_Tipo FOREIGN KEY (TIPO_AUTO_CODIGO)
      REFERENCES GD2C2020.manaOS_BI.TipoAuto(TIPO_AUTO_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

COMMIT TRANSACTION transaccion_creacion_tablas

--Inserts--------------------------------------------------------------------------------------------

USE GD2C2020
GO

BEGIN TRANSACTION transaccion_migracion_datos

--Tiempo

INSERT INTO GD2C2020.manaOS_BI.[Tiempo] (ANIO_NRO,MES_NRO)
SELECT year([COMPRA_FECHA]) as anio, MONTH([COMPRA_FECHA]) as mes
FROM [GD2C2020].[manaOS].[Compra]
WHERE [COMPRA_FECHA] IS NOT NULL
GROUP BY year([COMPRA_FECHA]), MONTH([COMPRA_FECHA])
UNION
SELECT year([CLIENTE_FECHA]) as anio, MONTH([CLIENTE_FECHA]) as mes
FROM [GD2C2020].[manaOS].[Cliente]
WHERE [CLIENTE_FECHA] IS NOT NULL
GROUP BY year([CLIENTE_FECHA]), MONTH([CLIENTE_FECHA])
UNION
SELECT year([AUTO_FECHA_ALTA]) as anio, MONTH([AUTO_FECHA_ALTA]) as mes
FROM [GD2C2020].[manaOS].[Auto]
WHERE [AUTO_FECHA_ALTA] IS NOT NULL
GROUP BY year([AUTO_FECHA_ALTA]), MONTH([AUTO_FECHA_ALTA])
UNION
SELECT year([FACTURA_FECHA]) as anio, MONTH([FACTURA_FECHA]) as mes
FROM [GD2C2020].[manaOS].[Factura]
WHERE [FACTURA_FECHA] IS NOT NULL
GROUP BY year([FACTURA_FECHA]), MONTH([FACTURA_FECHA])
ORDER BY anio, mes

GO

--Cliente
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Cliente] ON
GO

INSERT INTO [GD2C2020].[manaOS_BI].[Cliente] (CLIENTE_CODIGO,CLIENTE_APELLIDO,CLIENTE_NOMBRE,CLIENTE_DIRECCION,CLIENTE_DNI,CLIENTE_MAIL,CLIENTE_EDAD)
SELECT [CLIENTE_ID]
      ,[CLIENTE_APELLIDO]
      ,[CLIENTE_NOMBRE]
      ,[CLIENTE_DIRECCION]
      ,[CLIENTE_DNI]
      ,[CLIENTE_MAIL]
      ,CASE WHEN (YEAR(GETDATE()) - YEAR([CLIENTE_FECHA])) BETWEEN 18 AND 30 THEN '18-30 a�os'
			WHEN (YEAR(GETDATE()) - YEAR([CLIENTE_FECHA])) BETWEEN 31 AND 50 THEN '31-50 a�os'
			WHEN (YEAR(GETDATE()) - YEAR([CLIENTE_FECHA])) >51 THEN '>50 a�os'
			END AS Edad
  FROM [GD2C2020].[manaOS].[Cliente]

SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Cliente] OFF
GO

-- Sucursal

INSERT INTO [GD2C2020].[manaOS_BI].[Sucursal] ([SUCURSAL_DIRECCION],[SUCURSAL_MAIL], [SUCURSAL_TELEFONO], [CIUDAD_NOMBRE])
SELECT s.[SUCURSAL_DIRECCION],s.[SUCURSAL_MAIL], s.[SUCURSAL_TELEFONO], c.[CIUDAD_NOMBRE]
	FROM [GD2C2020].[manaOS].[Sucursal] s
	INNER JOIN [GD2C2020].[manaOS].[Ciudad] c ON s.[CIUDAD_ID] = c.[CIUDAD_ID]
GO

-- Transmicion

SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Transmision] ON
GO

INSERT INTO [GD2C2020].[manaOS_BI].[Transmision] ([TRANSMISION_CODIGO], [TRANSMISION_DESC])
SELECT t.[TRANSMISION_CODIGO], t.[TRANSMISION_DESC]
	FROM [GD2C2020].[manaOS].[Transmision] t

SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Transmision] OFF
GO

-- Caja

SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Caja] ON
GO

INSERT INTO [GD2C2020].[manaOS_BI].[Caja] ([CAJA_CODIGO], [CAJA_DESC])
SELECT c.[CAJA_CODIGO], c.[CAJA_DESC]
	FROM [GD2C2020].[manaOS].[Caja] c

SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Caja] OFF
GO

--TipoMotor
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Motor] ON
GO

INSERT INTO [GD2C2020].[manaOS_BI].[Motor](MOTOR_CODIGO)
SELECT m.MOTOR_CODIGO
	FROM [GD2C2020].[manaOS].[Motor] m
	
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Motor] OFF
GO

-- Modelo

SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Modelo] ON
GO

INSERT INTO [GD2C2020].[manaOS_BI].[Modelo] ([MODELO_CODIGO], [MODELO_NOMBRE], [MODELO_POTENCIA], [MOTOR_CODIGO], [TRANSMISION_CODIGO], [CAJA_CODIGO])
SELECT m.[MODELO_CODIGO], m.[MODELO_NOMBRE], m.[MODELO_POTENCIA], m.[MOTOR_CODIGO], m.[TRANSMISION_CODIGO], m.[CAJA_CODIGO]
	FROM [GD2C2020].[manaOS].[Modelo] m

SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Modelo] OFF
GO

-- Fabricante

INSERT INTO [GD2C2020].[manaOS_BI].[Fabricante] ([FABRICANTE_NOMBRE])
SELECT f.FABRICANTE_NOMBRE
	FROM [GD2C2020].[manaOS].[Fabricante] f

-- TipoDeAuto

SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[TipoAuto] ON
GO

INSERT INTO [GD2C2020].[manaOS_BI].[TipoAuto] ([TIPO_AUTO_CODIGO], [TIPO_AUTO_DESC])
SELECT ta.[TIPO_AUTO_CODIGO], ta.[TIPO_AUTO_DESC]
	FROM [GD2C2020].[manaOS].[TipoAuto] ta
	
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[TipoAuto] OFF
GO

--Potencia

SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Potencia] ON
GO

INSERT INTO GD2C2020.manaOS_BI.Potencia (POTENCIA_CODIGO, POTENCIA_DESC)
VALUES (1, '50-150cv')

INSERT INTO GD2C2020.manaOS_BI.Potencia (POTENCIA_CODIGO, POTENCIA_DESC)
VALUES (2, '151-300cv')

INSERT INTO GD2C2020.manaOS_BI.Potencia (POTENCIA_CODIGO, POTENCIA_DESC)
VALUES (3, '>300cv')

SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Potencia] OFF
GO

-- AutoParte

INSERT INTO [GD2C2020].[manaOS_BI].[AutoParte] ([AUTO_PARTE_CODIGO],[AUTO_PARTE_DESCRIPCION],[FABRICANTE_ID],[MODELO_CODIGO])
SELECT a.[AUTO_PARTE_CODIGO], a.[AUTO_PARTE_DESCRIPCION], f_bi.[FABRICANTE_ID], a.[MODELO_CODIGO]
	FROM [GD2C2020].[manaOS].[AutoParte] a
	INNER JOIN [GD2C2020].[manaOS].[Fabricante] f ON f.FABRICANTE_ID = a.FABRICANTE_ID
	INNER JOIN [GD2C2020].[manaOS_BI].[Fabricante] f_bi ON f_bi.FABRICANTE_NOMBRE =f.FABRICANTE_NOMBRE

-- Auto

INSERT INTO [GD2C2020].[manaOS_BI].[Auto] ([AUTO_CANT_KMS],[AUTO_FECHA_ALTA],[AUTO_NRO_CHASIS],[AUTO_NRO_MOTOR],[AUTO_PATENTE],[FABRICANTE_ID],[MODELO_CODIGO],[TIPO_AUTO_CODIGO])
	SELECT [AUTO_CANT_KMS],[AUTO_FECHA_ALTA],[AUTO_NRO_CHASIS],[AUTO_NRO_MOTOR],[AUTO_PATENTE],[FABRICANTE_ID],[MODELO_CODIGO],[TIPO_AUTO_CODIGO]
	FROM [GD2C2020].[manaOS].[Auto]

-- Factura
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Factura] ON
GO
INSERT INTO [GD2C2020].[manaOS_BI].[Factura] ([FACTURA_NRO],[CANT_FACTURADA],[CLIENTE_ID],[FACTURA_FECHA],[PRECIO_FACTURADO],[SUCURSAL_ID])
	SELECT [FACTURA_NRO],[CANT_FACTURADA],[CLIENTE_ID],[FACTURA_FECHA],[PRECIO_FACTURADO],[SUCURSAL_ID] 
	FROM [manaOS].[Factura]
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Factura] OFF
GO
-- FacturacionDeAuto
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[FacturacionDeAuto] ON
GO
INSERT INTO [GD2C2020].[manaOS_BI].[FacturacionDeAuto] ([FACTURACION_AUTO_ID],[PRECIO_AUTO_FACTURADO],[FACTURA_NRO],[AUTO_ID])
	SELECT [FACTURACION_AUTO_ID],[PRECIO_AUTO_FACTURADO],[FACTURA_NRO],[AUTO_ID]
	FROM [manaOS].[FacturacionDeAuto]
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[FacturacionDeAuto] OFF
GO
-- FacturacionDeAutoParte
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[FacturacionDeAutoParte] ON
GO
INSERT INTO [GD2C2020].[manaOS_BI].[FacturacionDeAutoParte] ([AUTOPARTE_ID],[FACTURA_NRO],[FACTURACION_AUTOPARTE_ID],[PRECIO_AUTOPARTE_FACTURADO])
	SELECT [AUTOPARTE_ID],[FACTURA_NRO],[FACTURACION_AUTOPARTE_ID],[PRECIO_AUTOPARTE_FACTURADO]
	FROM [manaOS].[FacturacionDeAutoParte]
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[FacturacionDeAutoParte] OFF
GO
-- Compra
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Compra] ON
GO
INSERT INTO [GD2C2020].[manaOS_BI].[Compra] ([COMPRA_CANT],[COMPRA_FECHA],[COMPRA_NRO],[COMPRA_PRECIO],[FACTURA_NRO])
	SELECT [COMPRA_CANT],[COMPRA_FECHA],[COMPRA_NRO],[COMPRA_PRECIO],[FACTURA_NRO]
	FROM  [GD2C2020].[manaOS].[Compra]
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Compra] OFF
GO
-- CompraDeAuto
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[CompraDeAuto] ON
GO
INSERT INTO [GD2C2020].[manaOS_BI].[CompraDeAuto] ([AUTO_ID],[COMPRA_AUTO_ID],[COMPRA_AUTO_PRECIO],[COMPRA_NRO])
	SELECT [AUTO_ID],[COMPRA_AUTO_ID],[COMPRA_AUTO_PRECIO],[COMPRA_NRO]
	FROM [GD2C2020].[manaOS].[CompraDeAuto]
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[CompraDeAuto] OFF
GO
-- CompraDeAutoParte
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[CompraDeAutoParte] ON
GO
INSERT INTO [GD2C2020].[manaOS_BI].[CompraDeAutoParte] ([AUTOPARTE_ID],[COMPRA_AUTOPARTE_ID],[COMPRA_AUTOPARTE_PRECIO],[COMPRA_NRO])
	SELECT [AUTOPARTE_ID],[COMPRA_AUTOPARTE_ID],[COMPRA_AUTOPARTE_PRECIO],[COMPRA_NRO]
	FROM [GD2C2020].[manaOS].[CompraDeAutoParte]
SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[CompraDeAutoParte] OFF
GO

COMMIT TRANSACTION transaccion_migracion_datos

--Vistas---------------------------------------------------------------------------------------------

USE GD2C2020
GO

BEGIN TRANSACTION transaccion_creacion_vistas
GO
-- Cantidad de autom�viles, vendidos y comprados x sucursal y mes

CREATE VIEW [manaOS_BI].vista_automoviles_vendido_x_sucursal_y_mes AS 
	SELECT CONCAT( s.[SUCURSAL_DIRECCION], ', ', s.[CIUDAD_NOMBRE]) as Sucursal,
	COUNT(a.[AUTO_ID]) AS CANTIDAD_DE_AUTOMOVILES, MONTH(F.[FACTURA_FECHA]) AS MES
	FROM [GD2C2020].[manaOS_BI].[Sucursal] s
	INNER JOIN [GD2C2020].[manaOS_BI].[Factura] f ON f.[SUCURSAL_ID] = S.[SUCURSAL_ID]
	INNER JOIN [GD2C2020].[manaOS_BI].[FacturacionDeAuto] fa ON fa.[FACTURA_NRO] = f.[FACTURA_NRO]
	INNER JOIN [GD2C2020].[manaOS_BI].[Auto] a ON a.[AUTO_ID] = fa.[AUTO_ID]
	GROUP BY s.[SUCURSAL_DIRECCION],s.[CIUDAD_NOMBRE], MONTH(F.[FACTURA_FECHA])
GO

-- Precio promedio de autom�viles, vendidos y comprados.

CREATE VIEW [manaOS_BI].vista_precio_promedio_autos_vendidos_y_comprados AS 
	SELECT CASE WHEN (AVG((f.[PRECIO_FACTURADO] + c.[COMPRA_PRECIO])/2)) IS NULL THEN 0
				WHEN (AVG((f.[PRECIO_FACTURADO] + c.[COMPRA_PRECIO])/2)) IS NOT NULL THEN AVG((f.[PRECIO_FACTURADO] + c.[COMPRA_PRECIO])/2)
				END as PrecioPromedio, 
				a.[AUTO_PATENTE]
	FROM [GD2C2020].[manaOS_BI].[Factura] f 
	INNER JOIN [GD2C2020].[manaOS_BI].[FacturacionDeAuto] fa ON fa.[FACTURA_NRO] = f.[FACTURA_NRO]
	RIGHT OUTER JOIN [GD2C2020].[manaOS_BI].[Auto] a ON a.[AUTO_ID] = fa.[AUTO_ID]
	LEFT OUTER JOIN [GD2C2020].[manaOS_BI].[CompraDeAuto] ca ON ca.[AUTO_ID] = a.[AUTO_ID]
	INNER JOIN [GD2C2020].[manaOS_BI].[Compra] c ON c.[COMPRA_NRO] = ca.[COMPRA_NRO]
	GROUP BY A.[AUTO_PATENTE]
GO 

-- Ganancias (precio de venta � precio de compra) x Sucursal x mes
CREATE VIEW [manaOS_BI].vista_ganancias_xSucursal_xMes_AUTO AS 
	SELECT SUM(fa.PRECIO_AUTO_FACTURADO - ca.COMPRA_AUTO_PRECIO) as Ganancia, s.SUCURSAL_ID, t.MES_NRO
	FROM [manaOS_BI].Compra c
	INNER JOIN [manaOS_BI].[Factura] f ON c.FACTURA_NRO = f.FACTURA_NRO
	INNER JOIN [manaOS_BI].[Sucursal] s ON f.SUCURSAL_ID = s.SUCURSAL_ID
	INNER JOIN [manaOS_BI].[Tiempo] t ON t.MES_NRO = MONTH(f.FACTURA_FECHA) AND t.ANIO_NRO = YEAR(f.FACTURA_FECHA)
	INNER JOIN [manaOS_BI].[FacturacionDeAuto] fa ON fa.FACTURA_NRO = f.FACTURA_NRO
	INNER JOIN [manaOS_BI].[CompraDeAuto] ca ON ca.COMPRA_NRO = c.COMPRA_NRO
	GROUP BY s.SUCURSAL_ID, t.MES_NRO, t.ANIO_NRO
GO

-- Promedio de tiempo en stock de cada modelo de autom�vil.
CREATE VIEW [manaOS_BI].PromedioTiempoStockCadaModeloAutoXDIA AS 
SELECT [MODELO_CODIGO], AVG(DATEDIFF(DAY,[AUTO_FECHA_ALTA],SYSDATETIME())) as PromedioTiempoEnStockEnDias
FROM [manaOS_BI].[Auto]
WHERE [AUTO_ID] NOT IN (select [AUTO_ID] from [manaOS_BI].[FacturacionDeAuto])
GROUP BY [MODELO_CODIGO]
GO

CREATE VIEW [manaOS_BI].PromedioTiempoStockCadaModeloAutoXMES AS 
SELECT [MODELO_CODIGO], AVG(DATEDIFF(MONTH,[AUTO_FECHA_ALTA],SYSDATETIME())) as PromedioTiempoEnStockEnMeses
FROM [manaOS_BI].[Auto]
WHERE [AUTO_ID] NOT IN (select [AUTO_ID] from [manaOS_BI].[FacturacionDeAuto])
GROUP BY [MODELO_CODIGO]
GO

CREATE VIEW [manaOS_BI].PromedioTiempoStockCadaModeloAutoXANIO AS 
SELECT [MODELO_CODIGO], AVG(DATEDIFF(YEAR,[AUTO_FECHA_ALTA],SYSDATETIME())) as PromedioTiempoEnStockEnAnios
FROM [manaOS_BI].[Auto]
WHERE [AUTO_ID] NOT IN (select [AUTO_ID] from [manaOS_BI].[FacturacionDeAuto])
GROUP BY [MODELO_CODIGO]
GO

-- AUTOPARTE

-- Precio promedio de cada autoparte, vendida y comprada.

CREATE VIEW [manaOS_BI].vista_precio_promedio_autopartes_vendidas_y_compradas AS 
	SELECT CASE WHEN (AVG((f.[PRECIO_FACTURADO] + c.[COMPRA_PRECIO])/2)) IS NULL THEN 0
				WHEN (AVG((f.[PRECIO_FACTURADO] + c.[COMPRA_PRECIO])/2)) IS NOT NULL THEN AVG((f.[PRECIO_FACTURADO] + c.[COMPRA_PRECIO])/2)
				END as PrecioPromedio, 
				a.[AUTO_PARTE_CODIGO]
	FROM [GD2C2020].[manaOS_BI].[Factura] f 
	INNER JOIN [GD2C2020].[manaOS_BI].[FacturacionDeAutoParte] fa ON fa.[FACTURA_NRO] = f.[FACTURA_NRO]
	RIGHT OUTER JOIN [GD2C2020].[manaOS_BI].[AutoParte] a ON a.[AUTOPARTE_ID] = fa.[AUTOPARTE_ID]
	LEFT OUTER JOIN [GD2C2020].[manaOS_BI].[CompraDeAutoParte] ca ON ca.[AUTOPARTE_ID] = a.[AUTOPARTE_ID]
	INNER JOIN [GD2C2020].[manaOS_BI].[Compra] c ON c.[COMPRA_NRO] = ca.[COMPRA_NRO]
	GROUP BY a.[AUTO_PARTE_CODIGO]
GO 

-- Ganancias (precio de venta � precio de compra) x Sucursal x mes

CREATE VIEW [manaOS_BI].vista_ganancias_xSucursal_xMes_AUTOPARTE AS 
	SELECT SUM(fa.PRECIO_AUTOPARTE_FACTURADO - ca.COMPRA_AUTOPARTE_PRECIO) as Ganancia, s.SUCURSAL_ID, t.MES_NRO
	FROM [manaOS_BI].Compra c
	INNER JOIN [manaOS_BI].[CompraDeAutoParte] ca ON ca.COMPRA_NRO = c.COMPRA_NRO
	INNER JOIN [manaOS_BI].[FacturacionDeAutoParte] fa ON fa.FACTURACION_AUTOPARTE_ID = ca.AUTOPARTE_ID
	INNER JOIN [manaOS_BI].[Factura] f ON fa.FACTURA_NRO = f.FACTURA_NRO
	INNER JOIN [manaOS_BI].[Sucursal] s ON f.SUCURSAL_ID = s.SUCURSAL_ID
	INNER JOIN [manaOS_BI].[Tiempo] t ON t.MES_NRO = MONTH(f.FACTURA_FECHA) AND t.ANIO_NRO = YEAR(f.FACTURA_FECHA)
	GROUP BY s.SUCURSAL_ID, t.MES_NRO, t.ANIO_NRO
GO

-- M�xima cantidad de stock por cada sucursal (anual)
	
	-- Para esta vista en particular, asumimos que como en el caso de la vista de "Promedio de tiempo en stock de cada autoparte"
	-- No tenemos manera de saber el stock de las autopartes.

COMMIT TRANSACTION transaccion_creacion_vistas
