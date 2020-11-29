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

--Vistas---------------------------------------------------------------------------------------------


USE GD2C2020
GO

BEGIN TRANSACTION transaccion_creacion_vistas

COMMIT TRANSACTION transaccion_creacion_vistas


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
      ,CASE WHEN (YEAR(GETDATE()) - YEAR([CLIENTE_FECHA])) BETWEEN 18 AND 30 THEN '18-30 años'
			WHEN (YEAR(GETDATE()) - YEAR([CLIENTE_FECHA])) BETWEEN 31 AND 50 THEN '31-50 años'
			WHEN (YEAR(GETDATE()) - YEAR([CLIENTE_FECHA])) >51 THEN '>50 años'
			END AS Edad
  FROM [GD2C2020].[manaOS].[Cliente]

SET IDENTITY_INSERT [GD2C2020].[manaOS_BI].[Cliente] OFF
GO

COMMIT TRANSACTION transaccion_migracion_datos