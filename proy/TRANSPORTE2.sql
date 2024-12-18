-- =============================================
-- Creación de la Base de Datos
-- =============================================

USE master;
go

IF( EXISTS ( SELECT name FROM master.sys.databases WHERE name = 'TRANSPORTE' ) )
BEGIN
	DROP DATABASE TRANSPORTE;
END;
go

CREATE DATABASE TRANSPORTE;
go


-- =============================================
-- Seleccionar la Base de Datos
-- =============================================

USE TRANSPORTE;
go

--Tabla de Estado
CREATE TABLE EST_CARRO(
	id_estado INT IDENTITY PRIMARY KEY,
	descripcion Varchar(50) NOT NULL
);
go
-- Tabla de Carro
CREATE TABLE CARRO(
    id_carro INT IDENTITY PRIMARY KEY,
	id_estado INT NOT NULL FOREIGN KEY REFERENCES est_carro(id_estado),
    placa VARCHAR(6) NOT NULL UNIQUE,
	prox_mant DATE NOT NULL
);
go
--Tabla de estado_mantenimiento
CREATE TABLE EST_MANTENIMIENTO (
    id_est_mant INT IDENTITY PRIMARY KEY,
	descripcion Varchar(50) NOT NULL
);
go
CREATE TABLE EST_CONDUCTOR(
	id_estado INT IDENTITY PRIMARY KEY,
	descripcion Varchar(50) NOT NULL
);
go
-- Tabla de Conductor
CREATE TABLE CONDUCTOR (
    id_conductor INT IDENTITY PRIMARY KEY,
	id_estado INT NOT NULL FOREIGN KEY REFERENCES est_conductor(id_estado),
    nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(8) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);
go
-- Tabla de Empleado
CREATE TABLE EMPLEADO (
    id_empleado INT IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
    dni VARCHAR(8) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
	usuario VARCHAR(50) NOT NULL,
	clave VARCHAR(50) NOT NULL
);
go
-- Tabla de Rutas
CREATE TABLE RUTA (
    id_ruta INT IDENTITY PRIMARY KEY,
    nombre_ruta VARCHAR(100) NOT NULL,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    distancia_km DECIMAL(10,2) NOT NULL
);
go
-- Tabla de Taller
CREATE TABLE TALLER (
    id_taller INT IDENTITY PRIMARY KEY,
    nombre_taller VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
	calificacion DECIMAL(5,1) NOT NULL
);
go
-- Tabla de Mantenimientos
CREATE TABLE MANTENIMIENTO (
    id_mantenimiento INT IDENTITY PRIMARY KEY,
	id_empleado INT NOT NULL FOREIGN KEY REFERENCES empleado(id_empleado),
	id_taller INT NOT NULL FOREIGN KEY REFERENCES taller(id_taller),
	id_est_mant INT NOT NULL FOREIGN KEY REFERENCES est_mantenimiento(id_est_mant),
    id_carro INT NOT NULL FOREIGN KEY REFERENCES carro(id_carro),
	calificacion DECIMAL(5,1) NOT NULL,
    fecha_inicio DATE NOT NULL,
	fecha_salida_programada DATE NOT NULL,
	fecha_salida_real DATE,
    costo DECIMAL(10,2) NOT NULL,
	detalle VARCHAR(2000) NOT NULL
);
go

-- Tabla tipo-incidente
CREATE TABLE TIPO_INCIDENTE(
	id_tipo INT IDENTITY PRIMARY KEY,
	descripcion VARCHAR(50) NOT NULL
);
go
-- Tabla de Historial de Asignación
CREATE TABLE PROGRAMACION(
    id_programacion INT IDENTITY PRIMARY KEY,
    id_carro INT NOT NULL FOREIGN KEY REFERENCES carro(id_carro),
	id_empleado INT NOT NULL FOREIGN KEY REFERENCES empleado(id_empleado),
    id_conductor INT NOT NULL FOREIGN KEY REFERENCES conductor(id_conductor),
    id_ruta INT NOT NULL FOREIGN KEY REFERENCES ruta(id_ruta),
    fecha_asignacion DATE NOT NULL,
    fecha_fin_programada DATE NOT NULL,
	fecha_fin_real DATE
);
go
-- Tabla de Incidentes
CREATE TABLE INCIDENTE (
    id_incidente INT IDENTITY PRIMARY KEY,
	id_empleado INT NOT NULL FOREIGN KEY REFERENCES empleado(id_empleado),
    id_programacion INT NOT NULL FOREIGN KEY REFERENCES programacion(id_programacion),
    id_tipo INT NOT NULL FOREIGN KEY REFERENCES  tipo_incidente(id_tipo),
	fecha_incidente DATE NOT NULL,
	detalle VARCHAR(2000) NOT NULL
);
go
-- Tabla de Reparaciones
CREATE TABLE REPARACION (
    id_reparacion INT IDENTITY PRIMARY KEY,
	id_empleado INT FOREIGN KEY REFERENCES empleado(id_empleado),
    id_incidente INT FOREIGN KEY REFERENCES incidente(id_incidente),
    id_taller INT FOREIGN KEY REFERENCES taller(id_taller),
    fecha_reparacion DATE NOT NULL,
	calificacion DECIMAL(5,1) NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
	detalle VARCHAR(2000) NOT NULL
);
go
