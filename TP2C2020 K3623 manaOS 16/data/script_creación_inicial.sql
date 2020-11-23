--Creacion de BD-------------------------------------------------------------------------------------

CREATE DATABASE [TPGDD2020_manaOS]
GO

--Usamos la BD---------------------------------------------------------------------------------------

USE [TPGDD2020_manaOS]
GO

--Creacion de tablas---------------------------------------------------------------------------------
BEGIN TRANSACTION transa

CREATE TABLE Caja (
	CAJA_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CAJA_DESC NVARCHAR(255),
);


-----------------------------------------------------------------------------------------------------

CREATE TABLE Motor (
	MOTOR_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY
);


-----------------------------------------------------------------------------------------------------

CREATE TABLE Transmision (
	TRANSMISION_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	TRANSMISION_DESC NVARCHAR(255),
);



-----------------------------------------------------------------------------------------------------

CREATE TABLE Modelo (
	MODELO_CODIGO DECIMAL(18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	MODELO_NOMBRE NVARCHAR(255),
	MODELO_POTENCIA DECIMAL(18,0),
	TRANSMISION_CODIGO DECIMAL(18,0) NOT NULL,
	MOTOR_CODIGO DECIMAL(18,0) NOT NULL,
	CAJA_CODIGO DECIMAL(18,0) NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE Auto (
	AUTO_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	AUTO_CANT_KMS DECIMAL(18,0),
	AUTO_FECHA_ALTA DATETIME2(3),
	AUTO_NRO_CHASIS NVARCHAR(255),
	AUTO_NRO_MOTOR nvarchar (255),
	AUTO_PATENTE nvarchar (255),
	MODELO_CODIGO decimal(18,0) NOT NULL,
	FABRICANTE_ID int NOT NULL,
);


-----------------------------------------------------------------------------------------------------

CREATE TABLE Fabricante (
	FABRICANTE_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FABRICANTE_NOMBRE VARCHAR(50)
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE AutoParte(
	AUTOPARTE_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	AUTO_PARTE_CODIGO decimal(18,0),
	AUTO_PARTE_DESCRIPCION nvarchar (255),
	FABRICANTE_ID int NOT NULL,
	MODELO_CODIGO decimal(18,0) NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE CompraDeAutoParte(
	COMPRA_AUTOPARTE_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COMPRA_AUTOPARTE_PRECIO float,
	COMPRA_NRO decimal (18,0) NOT NULL,
	AUTOPARTE_ID int NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE FacturacionDeAutoParte(
	FACTURACION_AUTOPARTE_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	PRECIO_AUTOPARTE_FACTURADO float,
	FACTURA_NRO decimal (18,0) NOT NULL,
	AUTOPARTE_ID int NOT NULL
);


-----------------------------------------------------------------------------------------------------

CREATE TABLE FacturacionDeAuto(
	FACTURACION_AUTO_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	PRECIO_AUTO_FACTURADO float,
	FACTURA_NRO decimal (18,0) NOT NULL,
	AUTO_ID int NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE CompraDeAuto(
	COMPRA_AUTO_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COMPRA_AUTO_PRECIO float,
	COMPRA_NRO decimal (18,0) NOT NULL,
	AUTO_ID int NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE Factura(
	FACTURA_NRO decimal (18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FACTURA_FECHA datetime2 (3),
	CANT_FACTURADA decimal (18,0),
	PRECIO_FACTURADO decimal (18,0),
	CLIENTE_ID int NOT NULL,
	SUCURSAL_ID int NOT NULL,
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE Cliente(
	CLIENTE_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CLIENTE_APELLIDO nvarchar (255) NOT NULL,
	CLIENTE_NOMBRE nvarchar (255) NOT NULL,
	CLIENTE_DIRECCION nvarchar (255),
	CLIENTE_DNI decimal (18,0),
	CLIENTE_MAIL nvarchar (255),
	CLIENTE_FECHA datetime2(3),
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE Compra(
	COMPRA_NRO decimal (18,0) NOT NULL IDENTITY(1,1) PRIMARY KEY,
	COMPRA_FECHA datetime2 (3),
	COMPRA_PRECIO decimal (18,0),
	COMPRA_CANT decimal (18,0),
	FACTURA_NRO decimal (18,0) NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE Sucursal(
	SUCURSAL_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	SUCURSAL_DIRECCION nvarchar(255),
	SUCURSAL_MAIL nvarchar (255),
	SUCURSAL_TELEFONO decimal (18,0),
	CIUDAD_ID int NOT NULL
);

-----------------------------------------------------------------------------------------------------

CREATE TABLE Ciudad(
	CIUDAD_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	CIUDAD_NOMBRE nvarchar(255)
);

--Agregamos las FK-----------------------------------------------------------------------------------

ALTER TABLE Modelo
   ADD CONSTRAINT FK_Modelo_Transmision FOREIGN KEY (TRANSMISION_CODIGO)
      REFERENCES Transmision (TRANSMISION_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE Modelo
   ADD CONSTRAINT FK_Modelo_Motor FOREIGN KEY (MOTOR_CODIGO)
      REFERENCES Motor (MOTOR_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE Modelo
   ADD CONSTRAINT FK_Modelo_Caja FOREIGN KEY (CAJA_CODIGO)
      REFERENCES Caja (CAJA_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE Auto
   ADD CONSTRAINT FK_Auto_Modelo FOREIGN KEY (MODELO_CODIGO)
      REFERENCES Modelo(MODELO_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE Auto
   ADD CONSTRAINT FK_Auto_Fabricante FOREIGN KEY (FABRICANTE_ID)
      REFERENCES Fabricante(FABRICANTE_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE AutoParte
   ADD CONSTRAINT FK_AutoParte_Fabricante FOREIGN KEY (FABRICANTE_ID)
      REFERENCES Fabricante(FABRICANTE_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE AutoParte
   ADD CONSTRAINT FK_AutoParte_Modelo FOREIGN KEY (MODELO_CODIGO)
      REFERENCES Modelo(MODELO_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE CompraDeAutoParte
   ADD CONSTRAINT FK_CompraDeAutoParte_Compra FOREIGN KEY (COMPRA_NRO)
      REFERENCES Compra(COMPRA_NRO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE CompraDeAutoParte
   ADD CONSTRAINT FK_CompraDeAutoParte_AutoParte FOREIGN KEY (AUTOPARTE_ID)
      REFERENCES AutoParte(AUTOPARTE_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE FacturacionDeAuto
   ADD CONSTRAINT FK_FacturacionDeAuto_Factura FOREIGN KEY (FACTURA_NRO)
      REFERENCES Factura(FACTURA_NRO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE FacturacionDeAuto
   ADD CONSTRAINT FK_FacturacionDeAuto_Auto FOREIGN KEY (AUTO_ID)
      REFERENCES Auto(AUTO_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE CompraDeAuto
   ADD CONSTRAINT FK_CompraDeAuto_Compra FOREIGN KEY (COMPRA_NRO)
      REFERENCES Compra(COMPRA_NRO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE CompraDeAuto
   ADD CONSTRAINT FK_CompraDeAuto_Auto FOREIGN KEY (AUTO_ID)
      REFERENCES Auto(AUTO_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE Factura
   ADD CONSTRAINT FK_Factura_Cliente FOREIGN KEY (CLIENTE_ID)
      REFERENCES Cliente(CLIENTE_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE Factura
   ADD CONSTRAINT FK_Factura_Sucursal FOREIGN KEY (SUCURSAL_ID)
      REFERENCES Sucursal(SUCURSAL_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE Compra
   ADD CONSTRAINT FK_Compra_Factura FOREIGN KEY (FACTURA_NRO)
      REFERENCES Factura(FACTURA_NRO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE Sucursal
   ADD CONSTRAINT FK_Sucursal_Ciudad FOREIGN KEY (CIUDAD_ID)
      REFERENCES Ciudad(CIUDAD_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE FacturacionDeAutoParte
   ADD CONSTRAINT FK_FacturacionDeAutoParte_Factura FOREIGN KEY (FACTURA_NRO)
      REFERENCES Factura(FACTURA_NRO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE FacturacionDeAutoParte
   ADD CONSTRAINT FK_FacturacionDeAutoParte_AutoParte FOREIGN KEY (AUTOPARTE_ID)
      REFERENCES AutoParte(AUTOPARTE_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

COMMIT TRANSACTION transa

-----------------------------------------------------------------------------------------------------

USE [TPGDD2020_manaOS]
GO

------------------------ Funciones ------------------------
CREATE FUNCTION fx_get_fabricante(@Nombre NVARCHAR(255))  
RETURNS INT  
BEGIN
	DECLARE @Result INT
    SET @Result = (SELECT f.[FABRICANTE_ID] FROM [TPGDD2020_manaOS].[dbo].[Fabricante] f WHERE f.[FABRICANTE_NOMBRE] = @Nombre)
    RETURN @Result  
END 

CREATE FUNCTION fx_get_autoparte(@Codigo DECIMAL(18,0))  
RETURNS INT  
BEGIN
	DECLARE @Result INT
    SET @Result = (SELECT a.[AUTOPARTE_ID] FROM [TPGDD2020_manaOS].[dbo].[AutoParte] a WHERE a.[AUTO_PARTE_CODIGO] = @Codigo)
    RETURN @Result  
END

CREATE FUNCTION fx_get_cliente(@apellido NVARCHAR(255)
,@nombre NVARCHAR(255)
,@direccion NVARCHAR(255)
,@dni DECIMAL(18,0)
,@fecha DATETIME2(3)
,@mail NVARCHAR(255))
RETURNS INT
BEGIN
	DECLARE @Result INT
    SET @Result = (SELECT c.CLIENTE_ID
		FROM [TPGDD2020_manaOS].[dbo].[Cliente] c 
		WHERE c.CLIENTE_APELLIDO = @apellido
			AND c.CLIENTE_NOMBRE = @nombre
			AND c.CLIENTE_DIRECCION = @direccion
			AND c.CLIENTE_DNI = @dni
			AND c.CLIENTE_FECHA= @fecha
			AND c.CLIENTE_MAIL = @mail)
    RETURN @Result  
END

CREATE FUNCTION fx_get_sucursal(@direccion NVARCHAR(255)
      ,@mail NVARCHAR(255)
      ,@telefono DECIMAL(18,0)
      ,@ciudad NVARCHAR(255))
	  RETURNS INT
BEGIN
	DECLARE @Result INT
    SET @Result = (SELECT s.SUCURSAL_ID
		FROM [TPGDD2020_manaOS].[dbo].[Sucursal] s
		INNER JOIN [TPGDD2020_manaOS].[dbo].[Ciudad] c ON c.CIUDAD_NOMBRE = @ciudad
		WHERE s.SUCURSAL_DIRECCION = @direccion
		AND s.[SUCURSAL_MAIL] = @mail
		AND s.[SUCURSAL_TELEFONO] = @telefono
		AND s.CIUDAD_ID = c.CIUDAD_ID)
    RETURN @Result  
END 

CREATE FUNCTION fx_get_ciudad(@Ciudad NVARCHAR(255))  
RETURNS INT  
BEGIN
	DECLARE @Result INT
    SET @Result = (SELECT c.CIUDAD_ID FROM [TPGDD2020_manaOS].[dbo].[Ciudad] c WHERE c.CIUDAD_NOMBRE=@Ciudad)
    RETURN @Result  
END 

CREATE FUNCTION fx_get_factura(@Codigo DECIMAL(18,0))  --La uso por el tema de que no exista la Faactura
RETURNS INT  
BEGIN
	DECLARE @Result INT
    SET @Result = (SELECT f.FACTURA_NRO FROM [TPGDD2020_manaOS].[dbo].[Factura] f WHERE f.FACTURA_NRO = @Codigo)
    RETURN @Result  
END 

CREATE FUNCTION fx_get_auto(@Patente NVARCHAR(255))  
RETURNS INT  
BEGIN
	DECLARE @Result INT
    SET @Result = (SELECT a.AUTO_ID FROM [TPGDD2020_manaOS].[dbo].[Auto] a WHERE a.AUTO_PATENTE = @Patente)
    RETURN @Result  
END 

CREATE FUNCTION fx_get_auto_precio(@Patente NVARCHAR(255))  
RETURNS INT  
BEGIN
	DECLARE @Result INT
    SET @Result = (SELECT a.AUTO_ID FROM [TPGDD2020_manaOS].[dbo].[Auto] a WHERE a.AUTO_PATENTE = @Patente)
    RETURN @Result  
END 
------------------------ Entidades ------------------------
--Caja

INSERT INTO [TPGDD2020_manaOS].[dbo].[Caja]
	([CAJA_CODIGO]
	,[CAJA_DESC])
	SELECT [TIPO_CAJA_CODIGO]
		,[TIPO_CAJA_DESC]
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [TIPO_CAJA_CODIGO] IS NOT NULL
	GROUP BY [TIPO_CAJA_CODIGO]
		,[TIPO_CAJA_DESC]
	ORDER BY [TIPO_CAJA_CODIGO]
GO

--Transmision
INSERT INTO [TPGDD2020_manaOS].[dbo].[Transmision]
	([TRANSMISION_CODIGO]
	,[TRANSMISION_DESC])
	SELECT [TIPO_TRANSMISION_CODIGO]
		,[TIPO_TRANSMISION_DESC]
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [TIPO_TRANSMISION_CODIGO] IS NOT NULL
	GROUP BY [TIPO_TRANSMISION_CODIGO]
		,[TIPO_TRANSMISION_DESC]
	ORDER BY [TIPO_TRANSMISION_CODIGO]
GO

--Motor
INSERT INTO [TPGDD2020_manaOS].[dbo].[Motor]
	([MOTOR_CODIGO])
	SELECT [TIPO_MOTOR_CODIGO]
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [TIPO_MOTOR_CODIGO] IS NOT NULL
	GROUP BY [TIPO_MOTOR_CODIGO]
	ORDER BY [TIPO_MOTOR_CODIGO]
GO

--Modelo
INSERT INTO [TPGDD2020_manaOS].[dbo].[Modelo]
	([MODELO_CODIGO]
	,[MODELO_NOMBRE]
	,[MODELO_POTENCIA]
	,[MOTOR_CODIGO]
	,[TRANSMISION_CODIGO]
	,[CAJA_CODIGO])
	SELECT [MODELO_CODIGO]
		,[MODELO_NOMBRE]
		,[MODELO_POTENCIA]
		,[TIPO_MOTOR_CODIGO]
		,[TIPO_TRANSMISION_CODIGO]
		,[TIPO_CAJA_CODIGO]
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [MODELO_CODIGO] IS NOT NULL
		and [MODELO_NOMBRE] IS NOT NULL
		and [MODELO_POTENCIA] IS NOT NULL
		and [TIPO_MOTOR_CODIGO] IS NOT NULL
		and [TIPO_TRANSMISION_CODIGO] IS NOT NULL
		and [TIPO_CAJA_CODIGO] IS NOT NULL
	GROUP BY [MODELO_CODIGO]
		,[MODELO_NOMBRE]
		,[MODELO_POTENCIA]
		,[TIPO_MOTOR_CODIGO]
		,[TIPO_TRANSMISION_CODIGO]
		,[TIPO_CAJA_CODIGO]
	ORDER BY [MODELO_CODIGO]
GO

--Fabricante

INSERT INTO [TPGDD2020_manaOS].[dbo].[Fabricante]
([FABRICANTE_NOMBRE])
	SELECT [FABRICANTE_NOMBRE]
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [FABRICANTE_NOMBRE] IS NOT NULL
	GROUP BY [FABRICANTE_NOMBRE]
	ORDER BY [FABRICANTE_NOMBRE]
GO

--AutoParte
INSERT INTO [TPGDD2020_manaOS].[dbo].[AutoParte]
	([AUTO_PARTE_CODIGO]
	,[AUTO_PARTE_DESCRIPCION]
	,[FABRICANTE_ID]
	,[MODELO_CODIGO])
	SELECT m.[AUTO_PARTE_CODIGO]
		,m.[AUTO_PARTE_DESCRIPCION]
		,([dbo].fx_get_fabricante(m.[FABRICANTE_NOMBRE])) AS FABRICANTE_ID
		,m.[MODELO_CODIGO]
	FROM [GD2C2020].[gd_esquema].[Maestra] m
	WHERE m.[AUTO_PARTE_CODIGO] IS NOT NULL
		AND m.[AUTO_PARTE_DESCRIPCION] IS NOT NULL
		AND m.[FABRICANTE_NOMBRE] IS NOT NULL
		AND m.[MODELO_CODIGO] IS NOT NULL
	GROUP BY m.[AUTO_PARTE_CODIGO]
		,m.[AUTO_PARTE_DESCRIPCION]
		,m.[FABRICANTE_NOMBRE]
		,m.[MODELO_CODIGO]
		,m.[FABRICANTE_NOMBRE]
	ORDER BY m.[AUTO_PARTE_CODIGO]
		,FABRICANTE_ID
GO

--Auto
INSERT INTO [TPGDD2020_manaOS].[dbo].[Auto]
	([AUTO_CANT_KMS]
	,[AUTO_FECHA_ALTA]
	,[AUTO_NRO_CHASIS]
	,[AUTO_NRO_MOTOR]
	,[AUTO_PATENTE]
	,[FABRICANTE_ID]
	,[MODELO_CODIGO])
	SELECT [AUTO_CANT_KMS]
		,m.[AUTO_FECHA_ALTA]
		,m.[AUTO_NRO_CHASIS]
		,m.[AUTO_NRO_MOTOR]
		,m.[AUTO_PATENTE]
		,([dbo].fx_get_fabricante(m.[FABRICANTE_NOMBRE])) AS FABRICANTE_ID
		,m.[MODELO_CODIGO]
	FROM [GD2C2020].[gd_esquema].[Maestra] m
	WHERE m.[AUTO_CANT_KMS] IS NOT NULL
		AND m.[AUTO_FECHA_ALTA] IS NOT NULL
		AND m.[AUTO_NRO_CHASIS] IS NOT NULL
		AND m.[AUTO_NRO_MOTOR] IS NOT NULL
		AND m.[AUTO_PATENTE] IS NOT NULL
		AND m.[FABRICANTE_NOMBRE] IS NOT NULL
		AND m.[MODELO_CODIGO] IS NOT NULL
	GROUP BY m.[AUTO_CANT_KMS]
		,m.[AUTO_FECHA_ALTA]
		,m.[AUTO_NRO_CHASIS]
		,m.[AUTO_NRO_MOTOR]
		,m.[AUTO_PATENTE]
		,m.[FABRICANTE_NOMBRE]
		,m.[MODELO_CODIGO]
	ORDER BY m.[AUTO_PATENTE]
		,FABRICANTE_ID
GO

--CompraDeAutoParte
INSERT INTO [TPGDD2020_manaOS].[dbo].[CompraDeAutoParte]
	([AUTOPARTE_ID]
	,[COMPRA_AUTOPARTE_PRECIO]
	,[COMPRA_NRO])
	SELECT [dbo].fx_get_autoparte(m.[AUTO_PARTE_CODIGO]) AS AUTO_PARTE_ID
		,m.[COMPRA_PRECIO]
		,m.[COMPRA_NRO]
	FROM [GD2C2020].[gd_esquema].[Maestra] m
	WHERE m.[COMPRA_NRO] IS NOT NULL
		AND m.[COMPRA_PRECIO] IS NOT NULL
		AND m.[AUTO_PARTE_CODIGO] IS NOT NULL
	GROUP BY m.[COMPRA_NRO]
		,m.[COMPRA_PRECIO]
		,m.[AUTO_PARTE_CODIGO]
	ORDER BY m.[AUTO_PARTE_CODIGO]
GO

--Cliente
INSERT INTO [TPGDD2020_manaOS].[dbo].[Cliente]
	([CLIENTE_APELLIDO]
	,[CLIENTE_NOMBRE]
	,[CLIENTE_DIRECCION]
	,[CLIENTE_DNI]
	,[CLIENTE_FECHA]
	,[CLIENTE_MAIL])
	SELECT [CLIENTE_APELLIDO]
		,[CLIENTE_NOMBRE]
		,[CLIENTE_DIRECCION]
		,[CLIENTE_DNI]
		,[CLIENTE_FECHA_NAC]
		,[CLIENTE_MAIL]
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [CLIENTE_APELLIDO] IS NOT NULL
		AND [CLIENTE_NOMBRE] IS NOT NULL
		AND [CLIENTE_DIRECCION] IS NOT NULL
		AND [CLIENTE_DNI] IS NOT NULL
		AND [CLIENTE_FECHA_NAC] IS NOT NULL
		AND [CLIENTE_MAIL] IS NOT NULL
	GROUP BY [CLIENTE_APELLIDO]
		,[CLIENTE_NOMBRE]
		,[CLIENTE_DIRECCION]
		,[CLIENTE_DNI]
		,[CLIENTE_FECHA_NAC]
		,[CLIENTE_MAIL]
	ORDER BY [CLIENTE_DNI]
GO

--Cliente 2
INSERT INTO [TPGDD2020_manaOS].[dbo].[Cliente]
	([CLIENTE_APELLIDO]
	,[CLIENTE_NOMBRE]
	,[CLIENTE_DIRECCION]
	,[CLIENTE_DNI]
	,[CLIENTE_FECHA]
	,[CLIENTE_MAIL])
	SELECT [FAC_CLIENTE_APELLIDO]
		,[FAC_CLIENTE_NOMBRE]
		,[FAC_CLIENTE_DIRECCION]
		,[FAC_CLIENTE_DNI]
		,[FAC_CLIENTE_FECHA_NAC]
		,[FAC_CLIENTE_MAIL]
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [FACTURA_NRO] IS NOT NULL
		AND [FAC_CLIENTE_APELLIDO] IS NOT NULL
		AND [FAC_CLIENTE_NOMBRE] IS NOT NULL
		AND [FAC_CLIENTE_DIRECCION] IS NOT NULL
		AND [FAC_CLIENTE_DNI] IS NOT NULL
		AND [FAC_CLIENTE_FECHA_NAC] IS NOT NULL
		AND [FAC_CLIENTE_MAIL] IS NOT NULL
		AND NOT([FAC_CLIENTE_NOMBRE] = ANY (SELECT [CLIENTE_NOMBRE] FROM [TPGDD2020_manaOS].[dbo].[Cliente]))
		AND NOT([FAC_CLIENTE_APELLIDO] = ANY (SELECT [CLIENTE_APELLIDO] FROM [TPGDD2020_manaOS].[dbo].[Cliente]))
		AND NOT([FAC_CLIENTE_DNI] = ANY (SELECT [CLIENTE_DNI] FROM [TPGDD2020_manaOS].[dbo].[Cliente]))
	GROUP BY [FACTURA_NRO]
		,[FAC_CLIENTE_APELLIDO]
		,[FAC_CLIENTE_NOMBRE]
		,[FAC_CLIENTE_DIRECCION]
		,[FAC_CLIENTE_DNI]
		,[FAC_CLIENTE_FECHA_NAC]
		,[FAC_CLIENTE_MAIL]
	ORDER BY [FACTURA_NRO]
GO

--Ciudad
INSERT INTO [TPGDD2020_manaOS].[dbo].[Ciudad]
	(CIUDAD_NOMBRE)
	SELECT [SUCURSAL_CIUDAD]
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [SUCURSAL_CIUDAD] IS NOT NULL
	GROUP BY [SUCURSAL_CIUDAD]
GO

--Sucursal
INSERT INTO [TPGDD2020_manaOS].[dbo].[Sucursal]
	([SUCURSAL_DIRECCION]
	,[SUCURSAL_MAIL]
	,[SUCURSAL_TELEFONO]
	,[CIUDAD_ID])
	SELECT [SUCURSAL_DIRECCION]
		,[SUCURSAL_MAIL]
		,[SUCURSAL_TELEFONO]
		,(SELECT [dbo].fx_get_ciudad([SUCURSAL_CIUDAD]) AS CIUDAD_ID)
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [SUCURSAL_DIRECCION] IS NOT NULL
		AND [SUCURSAL_MAIL] IS NOT NULL
		AND [SUCURSAL_TELEFONO] IS NOT NULL
		AND [SUCURSAL_CIUDAD] IS NOT NULL
	GROUP BY [SUCURSAL_DIRECCION]
		,[SUCURSAL_MAIL]
		,[SUCURSAL_TELEFONO]
		,[SUCURSAL_CIUDAD]
GO
-- Hasta aca llegue, da error con el cliente_id

--TEMPORAL FACTURA
SELECT m.[FACTURA_NRO]
	,(SELECT [dbo].fx_get_cliente(m.[FAC_CLIENTE_APELLIDO]
	,m.[FAC_CLIENTE_NOMBRE]
	,m.[FAC_CLIENTE_DIRECCION]
	,m.[FAC_CLIENTE_DNI]
	,m.[FAC_CLIENTE_FECHA_NAC]
	,m.[FAC_CLIENTE_MAIL])) AS CLIENTE_ID
INTO [TPGDD2020_manaOS].[dbo].[Temporal_Factura]
FROM [GD2C2020].[gd_esquema].[Maestra] m
WHERE m.[FACTURA_NRO] IS NOT NULL
	AND m.[FAC_CLIENTE_APELLIDO] IS NOT NULL
	AND m.[FAC_CLIENTE_NOMBRE] IS NOT NULL
	AND m.[FAC_CLIENTE_DIRECCION] IS NOT NULL
	AND m.[FAC_CLIENTE_DNI] IS NOT NULL
	AND m.[FAC_CLIENTE_FECHA_NAC] IS NOT NULL
	AND m.[FAC_CLIENTE_MAIL] IS NOT NULL
GROUP BY m.[FACTURA_NRO]
	,m.[FAC_CLIENTE_APELLIDO]
	,m.[FAC_CLIENTE_NOMBRE]
	,m.[FAC_CLIENTE_DIRECCION]
	,m.[FAC_CLIENTE_DNI]
	,m.[FAC_CLIENTE_FECHA_NAC]
	,m.[FAC_CLIENTE_MAIL]
GO



--Factura 
INSERT INTO [TPGDD2020_manaOS].[dbo].[Factura]
	([FACTURA_NRO]
	,[FACTURA_FECHA]
	,[PRECIO_FACTURADO]
	,[CLIENTE_ID]
	,[SUCURSAL_ID])
	SELECT m.[FACTURA_NRO]
		,m.[FACTURA_FECHA]
		,m.[PRECIO_FACTURADO]
		,(SELECT tf.CLIENTE_ID 
			FROM [TPGDD2020_manaOS].[dbo].[Temporal_Factura] tf 
			WHERE tf.[FACTURA_NRO] = m.[FACTURA_NRO] 
			AND tf.CLIENTE_ID IS NOT NULL) AS CLIENTE_ID
		,(SELECT [dbo].fx_get_sucursal(m.[FAC_SUCURSAL_DIRECCION]
		,m.[FAC_SUCURSAL_MAIL]
		,m.[FAC_SUCURSAL_TELEFONO]
		,m.[FAC_SUCURSAL_CIUDAD])) AS SUCURSAL_ID
	FROM [GD2C2020].[gd_esquema].[Maestra] m
	WHERE m.[FACTURA_NRO] IS NOT NULL
		AND m.[FACTURA_FECHA] IS NOT NULL
		AND m.[PRECIO_FACTURADO] IS NOT NULL
		AND m.[FAC_CLIENTE_APELLIDO] IS NOT NULL
		AND m.[FAC_CLIENTE_NOMBRE] IS NOT NULL
		AND m.[FAC_CLIENTE_DIRECCION] IS NOT NULL
		AND m.[FAC_CLIENTE_DNI] IS NOT NULL
		AND m.[FAC_CLIENTE_FECHA_NAC] IS NOT NULL
		AND m.[FAC_CLIENTE_MAIL] IS NOT NULL
		AND m.[FAC_SUCURSAL_DIRECCION] IS NOT NULL
		AND m.[FAC_SUCURSAL_MAIL] IS NOT NULL
		AND m.[FAC_SUCURSAL_TELEFONO] IS NOT NULL
		AND m.[FAC_SUCURSAL_CIUDAD] IS NOT NULL
	GROUP BY m.[FACTURA_NRO]
		,m.[FACTURA_FECHA]
		,m.[PRECIO_FACTURADO]
		,m.[FAC_CLIENTE_APELLIDO]
		,m.[FAC_CLIENTE_NOMBRE]
		,m.[FAC_CLIENTE_DIRECCION]
		,m.[FAC_CLIENTE_DNI]
		,m.[FAC_CLIENTE_FECHA_NAC]
		,m.[FAC_CLIENTE_MAIL]
		,m.[FAC_SUCURSAL_DIRECCION]
		,m.[FAC_SUCURSAL_MAIL]
		,m.[FAC_SUCURSAL_TELEFONO]
		,m.[FAC_SUCURSAL_CIUDAD]
		,m.[FAC_SUCURSAL_DIRECCION]
		,m.[FAC_SUCURSAL_MAIL]
		,m.[FAC_SUCURSAL_TELEFONO]
		,m.[FAC_SUCURSAL_CIUDAD]
	ORDER BY m.[FACTURA_NRO], CLIENTE_ID
GO

--FacturacionDeAutoParte
INSERT INTO [TPGDD2020_manaOS].[dbo].[FacturacionDeAutoParte]
	([FACTURA_NRO]
	,[PRECIO_AUTOPARTE_FACTURADO]
	,[AUTOPARTE_ID])
	SELECT [dbo].fx_get_factura(m.[FACTURA_NRO])
		,m.[PRECIO_FACTURADO]
		,[dbo].fx_get_autoparte(m.[AUTO_PARTE_CODIGO]) AS AUTO_PARTE_ID
	FROM [GD2C2020].[gd_esquema].[Maestra] m
	WHERE m.[FACTURA_NRO] IS NOT NULL
		AND m.[PRECIO_FACTURADO] IS NOT NULL
		AND m.[AUTO_PARTE_CODIGO] IS NOT NULL
	GROUP BY m.[FACTURA_NRO]
		,m.[PRECIO_FACTURADO]
		,m.[AUTO_PARTE_CODIGO]
	ORDER BY m.[FACTURA_NRO],AUTO_PARTE_ID
GO

--FacturacionDeAuto

INSERT INTO [TPGDD2020_manaOS].[dbo].[FacturacionDeAuto]
	([FACTURA_NRO]
	,[AUTO_ID]
	,[PRECIO_AUTO_FACTURADO])
	SELECT [dbo].fx_get_factura(m.[FACTURA_NRO])
	  ,[dbo].fx_get_auto(m.[AUTO_PATENTE])
	  ,m.[PRECIO_FACTURADO]
	FROM [GD2C2020].[gd_esquema].[Maestra] m
	WHERE m.[FACTURA_NRO] IS NOT NULL
	  AND m.[PRECIO_FACTURADO] IS NOT NULL
	  AND m.[AUTO_PATENTE] IS NOT NULL
	GROUP BY m.[FACTURA_NRO]
	  ,m.[PRECIO_FACTURADO]
	  ,m.[AUTO_PATENTE]
	ORDER BY m.[AUTO_PATENTE]
GO

--Compra
SELECT [COMPRA_NRO], [dbo].fx_get_factura([FACTURA_NRO]) AS FAC_NRO
INTO [TPGDD2020_manaOS].[dbo].[Temporal_Compra]
FROM [GD2C2020].[gd_esquema].[Maestra]
WHERE [COMPRA_NRO] IS NOT NULL
	AND [FACTURA_NRO] IS NOT NULL
GROUP BY [COMPRA_NRO]
	,[COMPRA_FECHA]
	,[COMPRA_PRECIO]
	,[COMPRA_CANT]
	,[FACTURA_NRO]
ORDER BY [COMPRA_NRO]
,[FACTURA_NRO]


INSERT INTO [TPGDD2020_manaOS].[dbo].[Compra]
	([COMPRA_NRO]
	,[COMPRA_FECHA]
	,[COMPRA_PRECIO]
	,[COMPRA_CANT]
	,[FACTURA_NRO])
	SELECT m.[COMPRA_NRO]
		  ,m.[COMPRA_FECHA]
		  ,m.[COMPRA_PRECIO]
		  ,m.[COMPRA_CANT]
		  , (select tc.FAC_NRO from [TPGDD2020_manaOS].[dbo].[Temporal_Compra] tc where tc.COMPRA_NRO = m.[COMPRA_NRO]) as Factura_Numero
	  FROM [GD2C2020].[gd_esquema].[Maestra] m
	  WHERE m.[COMPRA_NRO] IS NOT NULL
		AND m.[COMPRA_CANT] IS NOT NULL
	  GROUP BY m.[COMPRA_NRO]
		  ,m.[COMPRA_FECHA]
		  ,m.[COMPRA_PRECIO]
		  ,m.[COMPRA_CANT]
	  ORDER BY m.[COMPRA_NRO]
GO

--CompraDeAuto
INSERT INTO [TPGDD2020_manaOS].[dbo].[CompraDeAuto]
([AUTO_ID]
,[COMPRA_NRO]
,[COMPRA_AUTO_PRECIO])
SELECT [dbo].fx_get_auto([AUTO_PATENTE])
	  ,[COMPRA_NRO]
	  ,[COMPRA_PRECIO]
	  FROM [GD2C2020].[gd_esquema].[Maestra]
	  WHERE [COMPRA_NRO] IS NOT NULL
	  AND [COMPRA_PRECIO] IS NOT NULL
	  AND [AUTO_PATENTE] IS NOT NULL
	  GROUP BY [COMPRA_NRO]
	  ,[COMPRA_PRECIO]
	  ,[AUTO_PATENTE]
	  ORDER BY [AUTO_PATENTE]
GO
