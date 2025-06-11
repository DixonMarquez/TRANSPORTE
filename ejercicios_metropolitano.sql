-- 1. Mostrar todos los viajes con información del chofer y la ruta

SELECT V.id_viaje, V.fecha, V.hora_salida, V.hora_llegada, C.nombre AS chofer, R.nombre AS ruta
FROM Viaje V
JOIN Chofer C ON V.chofer_id = C.id_chofer
JOIN Ruta R ON V.ruta_id = R.id_ruta;

-- 2. Mostrar la cantidad de validaciones por estación

SELECT E.nombre AS estacion, COUNT(*) AS total_validaciones
FROM Validacion V
JOIN Estacion E ON V.estacion_id = E.id_estacion
GROUP BY E.nombre;

-- 3. Mostrar tarjetas activas con saldo mayor a 10

SELECT * FROM Tarjeta
WHERE estado = 'Activa' AND saldo > 10;

-- 4. Listar choferes activos que han hecho viajes

SELECT DISTINCT C.nombre
FROM Chofer C
JOIN Viaje V ON C.id_chofer = V.chofer_id
WHERE C.estado = 'Activo';

-- 5. Listar los vehículos usados en más de 2 viajes

SELECT V.id_vehiculo, V.placa, COUNT(*) AS cantidad_viajes
FROM Vehiculo V
JOIN Viaje VI ON V.id_vehiculo = VI.vehiculo_id
GROUP BY V.id_vehiculo, V.placa
HAVING COUNT(*) > 2;

-- 6. Función escalar para calcular el saldo restante después de un pago

CREATE FUNCTION dbo.fn_CalcularSaldoRestante(@saldo_actual FLOAT, @monto_pago FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN @saldo_actual - @monto_pago;
END;

-- 7. Función escalar para devolver el tipo de día según número (1-7)

CREATE FUNCTION dbo.fn_DiaSemana(@num INT)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @dia VARCHAR(20)
    SET @dia = CASE @num
        WHEN 1 THEN 'Lunes'
        WHEN 2 THEN 'Martes'
        WHEN 3 THEN 'Miércoles'
        WHEN 4 THEN 'Jueves'
        WHEN 5 THEN 'Viernes'
        WHEN 6 THEN 'Sábado'
        WHEN 7 THEN 'Domingo'
        ELSE 'Desconocido' END
    RETURN @dia
END;

-- 8. Función escalar para convertir el tipo de tarjeta a código (ej: General -> G)

CREATE FUNCTION dbo.fn_TipoTarjetaCodigo(@tipo VARCHAR(50))
RETURNS CHAR(1)
AS
BEGIN
    RETURN LEFT(@tipo, 1)
END;

-- 9. Procedimiento para actualizar saldo de tarjeta

CREATE PROCEDURE dbo.sp_ActualizarSaldo
    @id_tarjeta INT,
    @nuevo_saldo FLOAT
AS
BEGIN
    UPDATE Tarjeta SET saldo = @nuevo_saldo WHERE id_tarjeta = @id_tarjeta
END;

-- 10. Procedimiento para listar validaciones por tarjeta

CREATE PROCEDURE dbo.sp_ValidacionesPorTarjeta
    @id_tarjeta INT
AS
BEGIN
    SELECT * FROM Validacion WHERE tarjeta_id = @id_tarjeta
END;

-- 11. Procedimiento para registrar un nuevo viaje

CREATE PROCEDURE dbo.sp_RegistrarViaje
    @fecha DATE,
    @hora_salida TIME,
    @hora_llegada TIME,
    @ruta_id INT,
    @chofer_id INT,
    @vehiculo_id INT
AS
BEGIN
    INSERT INTO Viaje (fecha, hora_salida, hora_llegada, ruta_id, chofer_id, vehiculo_id)
    VALUES (@fecha, @hora_salida, @hora_llegada, @ruta_id, @chofer_id, @vehiculo_id)
END;

-- 12. Procedimiento para obtener tarjetas por tipo

CREATE PROCEDURE dbo.sp_TarjetasPorTipo
    @tipo VARCHAR(50)
AS
BEGIN
    SELECT * FROM Tarjeta WHERE tipo = @tipo
END;

-- 13. Vista de resumen de viajes con chofer y vehículo

CREATE VIEW vw_ResumenViajes AS
SELECT V.id_viaje, V.fecha, C.nombre AS chofer, VE.placa AS vehiculo, R.nombre AS ruta
FROM Viaje V
JOIN Chofer C ON V.chofer_id = C.id_chofer
JOIN Vehiculo VE ON V.vehiculo_id = VE.id_vehiculo
JOIN Ruta R ON V.ruta_id = R.id_ruta;

-- 14. Vista de validaciones por estación

CREATE VIEW vw_ValidacionesEstacion AS
SELECT E.nombre AS estacion, COUNT(V.id_validacion) AS total_validaciones
FROM Validacion V
JOIN Estacion E ON V.estacion_id = E.id_estacion
GROUP BY E.nombre;

-- 15. Vista de tarjetas activas con saldo

CREATE VIEW vw_TarjetasActivas AS
SELECT id_tarjeta, numero, tipo, saldo
FROM Tarjeta
WHERE estado = 'Activa';