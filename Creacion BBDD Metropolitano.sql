-- CREACIÓN DE TABLAS PARA EL MODELO METROPOLITANO 

CREATE DATABASE DSRP_metropoliano_sistema;
GO

USE DSRP_metropoliano_sistema;
GO

CREATE TABLE TipoServicio (
    id_tipo_servicio INTEGER PRIMARY KEY,
    nombre_servicio VARCHAR(100) NOT NULL
);

CREATE TABLE Ruta (
    id_ruta INTEGER PRIMARY KEY,
    nombre VARCHAR(100),
    id_tipo_servicio INTEGER,
    origen VARCHAR(100) NOT NULL,
    destino VARCHAR(100) NOT NULL,
    horario_dias VARCHAR(50) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    dia_semana INTEGER NOT NULL,
    direccion VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_tipo_servicio) REFERENCES TipoServicio(id_tipo_servicio)
);

CREATE TABLE Chofer (
    id_chofer INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    dni INTEGER NOT NULL,
    licencia VARCHAR(20) NOT NULL,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE Vehiculo (
    id_vehiculo INTEGER PRIMARY KEY,
    placa VARCHAR(20) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo INTEGER NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    capacidad INTEGER NOT NULL
);

CREATE TABLE Viaje (
    id_viaje INTEGER PRIMARY KEY,
    fecha DATE NOT NULL,
    hora_salida TIME NOT NULL,
    hora_llegada TIME NOT NULL,
    ruta_id INTEGER NOT NULL,
    chofer_id INTEGER NOT NULL,
    vehiculo_id INTEGER NOT NULL,
    FOREIGN KEY (ruta_id) REFERENCES Ruta(id_ruta),
    FOREIGN KEY (chofer_id) REFERENCES Chofer(id_chofer),
    FOREIGN KEY (vehiculo_id) REFERENCES Vehiculo(id_vehiculo)
);

CREATE TABLE Estacion (
    id_estacion INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    distrito VARCHAR(100) NOT NULL,
    tipo VARCHAR(30) NOT NULL,
    ubicacion VARCHAR(200) NOT NULL
);

CREATE TABLE Ruta_Estacion (
    id_ruta INTEGER NOT NULL,
    id_estacion INTEGER NOT NULL,
    orden_parada INTEGER NOT NULL,
    PRIMARY KEY (id_ruta, id_estacion),
    FOREIGN KEY (id_ruta) REFERENCES Ruta(id_ruta),
    FOREIGN KEY (id_estacion) REFERENCES Estacion(id_estacion)
);

CREATE TABLE Tarjeta (
    id_tarjeta INTEGER PRIMARY KEY,
    numero BIGINT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    saldo FLOAT NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_emision DATE NOT NULL
);

CREATE TABLE Validacion (
    id_validacion INTEGER PRIMARY KEY,
    tarjeta_id INTEGER NOT NULL,
    viaje_id INTEGER NOT NULL,
    estacion_id INTEGER NOT NULL,
    fecha_hora DATETIME NOT NULL,
    tipo_pago VARCHAR(50) NOT NULL,
    monto FLOAT NOT NULL,
    FOREIGN KEY (tarjeta_id) REFERENCES Tarjeta(id_tarjeta),
    FOREIGN KEY (viaje_id) REFERENCES Viaje(id_viaje),
    FOREIGN KEY (estacion_id) REFERENCES Estacion(id_estacion)
);

-- INSERCION DE DATOS

-- INSERCIÓN DE DATOS EN TABLA TIPOSERVICIO
INSERT INTO [dbo].[TipoServicio] ([id_tipo_servicio], [nombre_servicio])
VALUES
(1, 'Regular'),
(2, 'Expreso'),
(3, 'Super Expreso'),
(4, 'Universitario'),
(5, 'Nocturno');


-- INSERCIÓN DE DATOS EN TABLA CHOFER
INSERT INTO [dbo].[Chofer] ([id_chofer], [nombre], [dni], [licencia], [estado])
VALUES
(1, 'Luis Pérez', 12345678, 'A1', 'Activo'),
(2, 'Ana Torres', 23456789, 'A2', 'Activo'),
(3, 'Carlos Gómez', 34567890, 'A3', 'Inactivo'),
(4, 'Lucía Díaz', 45678901, 'A1', 'Activo'),
(5, 'Jorge Ramos', 56789012, 'A2', 'Activo');


-- INSERCIÓN DE DATOS EN TABLA VEHICULO
INSERT INTO [dbo].[Vehiculo] ([id_vehiculo], [placa], [marca], [modelo], [tipo], [capacidad])
VALUES
(1, 'ABC123', 'Mercedes', 2018, 'Articulado', 120),
(2, 'XYZ789', 'Volvo', 2020, 'Estándar', 90),
(3, 'LMN456', 'Scania', 2019, 'Articulado', 120),
(4, 'QRS321', 'Isuzu', 2021, 'Estándar', 85),
(5, 'TUV654', 'Hyundai', 2022, 'Estándar', 90);


-- INSERCIÓN DE DATOS EN TABLA ESTACION
INSERT INTO [dbo].[Estacion] ([id_estacion], [nombre], [distrito], [tipo], [ubicacion])
VALUES
(1, 'Naranjal', 'Independencia', 'Terminal', 'Av. Túpac Amaru'),
(2, 'Izaguirre', 'Los Olivos', 'Intermedia', 'Av. Izaguirre'),
(3, 'UNI', 'Rímac', 'Intermedia', 'Av. Universitaria'),
(4, 'Central', 'Centro', 'Intermedia', 'Av. Bolivia'),
(5, 'Estación Central', 'Cercado de Lima', 'Terminal', 'Av. España');


-- INSERCIÓN DE DATOS EN TABLA TARJETA
INSERT INTO [dbo].[Tarjeta] ([id_tarjeta], [numero], [tipo], [saldo], [estado], [fecha_emision])
VALUES
(1, 10000001, 'General', 12.5, 'Activa', '2023-01-01'),
(2, 10000002, 'Universitario', 5.0, 'Activa', '2023-06-30'),
(3, 10000003, 'Escolar', 8.75, 'Inactiva', '2023-12-27'),
(4, 10000004, 'General', 20.0, 'Activa', '2024-06-24'),
(5, 10000005, 'General', 3.0, 'Activa', '2024-12-21');


-- INSERCIÓN DE DATOS EN TABLA RUTA
INSERT INTO [dbo].[Ruta] ([id_ruta], [nombre], [id_tipo_servicio], [origen], [destino], [horario_dias], [hora_inicio], [hora_fin], [dia_semana], [direccion])
VALUES
(1, 'Ruta 1', 1, 'Naranjal', 'Matellini', 'L-V', '05:00', '23:00', 1, 'Sur'),
(2, 'Ruta 2', 2, 'Izaguirre', 'Central', 'L-D', '06:00', '22:30', 2, 'Norte'),
(3, 'Ruta 3', 3, 'UNI', 'Estación Central', 'L-V', '05:30', '23:30', 3, 'Sur'),
(4, 'Ruta 4', 4, 'Central', 'Benavides', 'S-D', '06:15', '22:00', 4, 'Norte'),
(5, 'Ruta 5', 5, 'Estación Central', 'Angamos', 'L-D', '04:45', '00:00', 5, 'Ambos');


-- INSERCIÓN DE DATOS EN TABLA RUTA_ESTACION
INSERT INTO [dbo].[Ruta_Estacion] ([id_ruta], [id_estacion], [orden_parada])
VALUES
(1, 1, 1),
(1, 2, 2),
(2, 2, 3),
(2, 3, 4),
(3, 3, 5),
(3, 4, 6),
(4, 4, 7),
(4, 5, 8),
(5, 5, 9),
(5, 1, 10);


-- INSERCIÓN DE DATOS EN TABLA VIAJE
INSERT INTO [dbo].[Viaje] ([id_viaje], [fecha], [hora_salida], [hora_llegada], [ruta_id], [chofer_id], [vehiculo_id])
VALUES
(1, '2025-06-01', '06:00', '06:45', 1, 1, 1),
(2, '2025-06-02', '06:00', '06:45', 2, 2, 2),
(3, '2025-06-03', '06:00', '06:45', 3, 3, 3),
(4, '2025-06-04', '06:00', '06:45', 4, 4, 4),
(5, '2025-06-05', '06:00', '06:45', 5, 5, 5),
(6, '2025-06-06', '06:00', '06:45', 1, 1, 1),
(7, '2025-06-07', '06:00', '06:45', 2, 2, 2),
(8, '2025-06-08', '06:00', '06:45', 3, 3, 3),
(9, '2025-06-09', '06:00', '06:45', 4, 4, 4),
(10, '2025-06-10', '06:00', '06:45', 5, 5, 5),
(11, '2025-06-11', '06:00', '06:45', 1, 1, 1),
(12, '2025-06-12', '06:00', '06:45', 2, 2, 2),
(13, '2025-06-13', '06:00', '06:45', 3, 3, 3),
(14, '2025-06-14', '06:00', '06:45', 4, 4, 4),
(15, '2025-06-15', '06:00', '06:45', 5, 5, 5);


-- INSERCIÓN DE DATOS EN TABLA VALIDACION
INSERT INTO [dbo].[Validacion] ([id_validacion], [tarjeta_id], [viaje_id], [estacion_id], [fecha_hora], [tipo_pago], [monto])
VALUES
(1, 1, 1, 1, '2025-06-01', 'Saldo', 2.5),
(2, 2, 2, 2, '2025-06-01', 'Descuento', 1.5),
(3, 3, 3, 3, '2025-06-01', 'Saldo', 2.0),
(4, 4, 4, 4, '2025-06-01', 'Saldo', 2.5),
(5, 5, 5, 5, '2025-06-01', 'Descuento', 1.2),
(6, 1, 6, 1, '2025-06-01', 'Saldo', 2.5),
(7, 2, 7, 2, '2025-06-01', 'Descuento', 1.5),
(8, 3, 8, 3, '2025-06-01', 'Saldo', 2.0),
(9, 4, 9, 4, '2025-06-01', 'Saldo', 2.5),
(10, 5, 10, 5, '2025-06-01', 'Descuento', 1.2),
(11, 1, 11, 1, '2025-06-01', 'Saldo', 2.5),
(12, 2, 12, 2, '2025-06-01', 'Descuento', 1.5),
(13, 3, 13, 3, '2025-06-01', 'Saldo', 2.0),
(14, 4, 14, 4, '2025-06-01', 'Saldo', 2.5),
(15, 5, 15, 5, '2025-06-01', 'Descuento', 1.2);


