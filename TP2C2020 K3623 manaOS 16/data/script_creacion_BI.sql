--Creacion de esquema--------------------------------------------------------------------------------

USE GD2C2020
GO

CREATE SCHEMA [manaOS_BI]
GO

--Creacion de tablas---------------------------------------------------------------------------------

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
	CLIENTE_MAIL nvarchar (255),
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
	POTENCIA_DESC NVARCHAR(255),
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

CREATE TABLE GD2C2020.manaOS_BI.Fabricante (
	FABRICANTE_ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FABRICANTE_NOMBRE VARCHAR(50)
);

--Agregamos las FK-----------------------------------------------------------------------------------

ALTER TABLE GD2C2020.manaOS.Modelo
   ADD CONSTRAINT FK_Modelo_Transmision FOREIGN KEY (TRANSMISION_CODIGO)
      REFERENCES GD2C2020.manaOS.Transmision (TRANSMISION_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS.Modelo
   ADD CONSTRAINT FK_Modelo_Motor FOREIGN KEY (MOTOR_CODIGO)
      REFERENCES GD2C2020.manaOS.Motor (MOTOR_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS.Modelo
   ADD CONSTRAINT FK_Modelo_Caja FOREIGN KEY (CAJA_CODIGO)
      REFERENCES GD2C2020.manaOS.Caja (CAJA_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

-----------------------------------------------------------------------------------------------------

ALTER TABLE GD2C2020.manaOS.AutoParte
   ADD CONSTRAINT FK_AutoParte_Fabricante FOREIGN KEY (FABRICANTE_ID)
      REFERENCES GD2C2020.manaOS.Fabricante(FABRICANTE_ID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

ALTER TABLE GD2C2020.manaOS.AutoParte
   ADD CONSTRAINT FK_AutoParte_Modelo FOREIGN KEY (MODELO_CODIGO)
      REFERENCES GD2C2020.manaOS.Modelo(MODELO_CODIGO)
      ON DELETE CASCADE
      ON UPDATE CASCADE
;

--Vistas---------------------------------------------------------------------------------------------

--Inserts--------------------------------------------------------------------------------------------