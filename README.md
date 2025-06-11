# TRANSPORTE
BBDD Sistema de Transporte

📘 Iniciación: Objetivos y Alcance
Título del Problema:

Gestión Integral del Metropolitano de Lima

Descripción del Problema:
El Metropolitano necesita un sistema centralizado para administrar eficientemente:

Flota de buses (mantenimiento, estado, asignación).

Conductores (licencias, disponibilidad, asignación a rutas).

Rutas y estaciones (horarios, paradas, congestión).

Transacciones con tarjetas (validación, saldos, reportes).

Actualmente, la falta de integración entre estos componentes genera:

  Retrasos en la asignación de buses y conductores.
  Dificultad para programar mantenimientos preventivos.
  Ineficiencia en la gestión de rutas y estaciones congestionadas.

📘 Entidades Principales

Entidad	Descripción:

-Chofer:	Información de conductores (DNI, licencia, estado).

-Vehículo:	Datos de buses (placa, modelo, capacidad, estado).

-Ruta	Trayectos con estaciones, horarios y tipo de servicio.

-Viaje:	Registro de cada viaje realizado (chofer, bus, ruta).

-Estación:	Ubicaciones (nombre, distrito, tipo, capacidad).

-Tarjeta:	Medio de pago (saldo, estado, fecha de emisión).

-Validación	Transacciones: (fecha, monto, estación).

DISEÑO CONCEPTUAL

![diseño conceptual BBDD](https://github.com/user-attachments/assets/60f02ef7-5284-4178-9f69-50f64ce77fe5)


DISEÑO LOGICO

![Diseño logico BBDD](https://github.com/user-attachments/assets/d5fce7c3-6ce2-470a-9ca3-27098ed5d8a3)


DISEÑO FISICO

![Diseño fisico BBDD](https://github.com/user-attachments/assets/dbbba1f7-e103-425b-9513-6112027bb1dc)
