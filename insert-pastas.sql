// Puntos de Venta
INSERT INTO punto_venta (nombre, direccion)
VALUES
('Mostrador Centro', 'San Martin 120'),
('Mostrador Terminal', 'Bv. España 540'),
('Mostrador Costanera', 'Costanera 210'),
('Mostrador Sur', 'Av. Peron 1500');

// Clientes
INSERT INTO cliente (nombre, apellido, telefono)
VALUES
('Juan', 'Perez', '3534123456'),
('Maria', 'Lopez', '3534987654'),
('Carlos', 'Gomez', '3534556677'),
('Lucia', 'Martinez', '3534778899');

// Productos
INSERT INTO producto (nombre, tipo, precio, unidad_medida)
VALUES
('Ravioles Ricota', 'Pastas Rellenas', 4500.00, 'kg'),
('Tallarines', 'Pastas Simples', 3200.00, 'kg'),
('Sorrentinos JyQ', 'Pastas Rellenas', 5200.00, 'kg'),
('Ñoquis', 'Pastas Simples', 2800.00, 'kg'),
('Lasagna', 'Pastas Especiales', 6000.00, 'unidad');

// Recetas de Productos
INSERT INTO receta_producto (id_producto, kg_harina_por_unidad)
VALUES
(1, 0.550),
(2, 0.700),
(3, 0.600),
(4, 0.650),
(5, 1.200);

// Ventas
INSERT INTO venta (fecha, id_punto_venta, id_cliente, total)
VALUES
('2026-05-20 10:15:00', 1, 1, 7700.00),
('2026-05-20 11:20:00', 2, 2, 8400.00),
('2026-05-20 13:40:00', 3, 3, 6000.00),
('2026-05-20 18:00:00', 1, 4, 7300.00),
('2026-05-20 19:10:00', 4, 1, 5600.00);

// Detalles de Venta
INSERT INTO detalle_venta
(id_venta, id_producto, cantidad, precio_unitario, subtotal)
VALUES
(1, 1, 1.00, 4500.00, 4500.00),
(1, 2, 1.00, 3200.00, 3200.00),

(2, 3, 1.00, 5200.00, 5200.00),
(2, 4, 1.00, 2800.00, 2800.00),

(3, 5, 1.00, 6000.00, 6000.00),

(4, 1, 1.00, 4500.00, 4500.00),
(4, 4, 1.00, 2800.00, 2800.00),

(5, 2, 1.00, 3200.00, 3200.00),
(5, 4, 1.00, 2800.00, 2800.00);


