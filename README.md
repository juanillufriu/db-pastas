# Base de Datos – Ejercicio 1: Fábrica de Pastas

## 1. Análisis del Dominio

La fábrica de pastas posee 4 puntos de venta y necesita registrar:

* Ventas realizadas.
* Tickets emitidos.
* Productos vendidos.
* Cantidades vendidas.
* Recaudación por punto de venta.
* Productos más vendidos.
* Consumo de harina utilizado en las ventas.

Para resolver el problema se propone una base de datos relacional normalizada en Tercera Forma Normal (3FN).

---

# 2. Modelo Relacional

## Entidades principales

### Punto_Venta

Representa cada mostrador o punto de venta de la fábrica.

### Cliente

Representa a los clientes que realizan compras.

### Producto

Representa los productos vendidos por la fábrica.

### Receta_Producto

Permite almacenar la cantidad de harina necesaria para fabricar 1 kg o unidad del producto.

### Venta

Representa el ticket emitido.

### Detalle_Venta

Representa los productos vendidos en cada ticket.

---

# 3. Sentencias SQL – Creación de Tablas (PostgreSQL)

```sql
CREATE TABLE punto_venta (
    id_punto_venta SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(120) NOT NULL
);


CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    telefono VARCHAR(25)
);


CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    tipo VARCHAR(40) NOT NULL,
    precio NUMERIC(10,2) NOT NULL CHECK (precio >= 0),
    unidad_medida VARCHAR(20) NOT NULL
);


CREATE TABLE receta_producto (
    id_receta SERIAL PRIMARY KEY,
    id_producto INTEGER NOT NULL,
    kg_harina_por_unidad NUMERIC(10,3) NOT NULL CHECK (kg_harina_por_unidad >= 0),

    CONSTRAINT fk_receta_producto
        FOREIGN KEY (id_producto)
        REFERENCES producto(id_producto)
        ON DELETE CASCADE
);


CREATE TABLE venta (
    id_venta SERIAL PRIMARY KEY,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_punto_venta INTEGER NOT NULL,
    id_cliente INTEGER,
    total NUMERIC(12,2) NOT NULL CHECK (total >= 0),

    CONSTRAINT fk_venta_punto
        FOREIGN KEY (id_punto_venta)
        REFERENCES punto_venta(id_punto_venta),

    CONSTRAINT fk_venta_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);


CREATE TABLE detalle_venta (
    id_detalle SERIAL PRIMARY KEY,
    id_venta INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad NUMERIC(10,2) NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal NUMERIC(12,2) NOT NULL CHECK (subtotal >= 0),

    CONSTRAINT fk_detalle_venta
        FOREIGN KEY (id_venta)
        REFERENCES venta(id_venta)
        ON DELETE CASCADE,

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (id_producto)
        REFERENCES producto(id_producto)
);
```

---

# 4. DER – Diagrama Entidad Relación

[![](https://mermaid.ink/img/pako:eNqVVMtu6jAQ_ZXIa4qS8gh4F4VURTyVhi6qSJFrD2A1sSPjVG2Bf7-G0ts2D6R6k3jsmXN8zth7RCUDhBGoEScbRbJYxMIyY7maR4vkMZhHnrX_DJ3GeB5ZnCV5IbRMXkFoYi0n38uPXujfe6ElZPasoBpnXAGlXF5Ajl9o_nRskIIaJJpygwJ_QiE5pClnsrqiIYW1FLIEvwwXo5UfLepOqiQrqJZ_IqB5_gN8vpoF4di3cnN2XkOqEJwRlmTAzLfELAz8IPKSKwRNUSi5UKZ-N6mSedkkW6K4IEkuVfJJoYTdZH7V9mg8Cx4ib7a01kC35Gq73E0aPa7jqaUmaYnYyEgynQaN3cmMIGkKdZo0crgqFiVCfwtU9fSknzZq1pi-K57rjvDzeh0ONzdyf5EbWwpIyj9I-Wpc3_Wr0m99sEWloQ8CKu3esD8Hpc12Wp9wOFS60qTIHQBqoY3iDGGtCmihDFRGTlN0tihGegsZxAibX0bUS4xicTQ5ORFPUmZfaUoWmy3Ca5LuzKzIGdFweZz-RxUIBsqXpq8Q7vTONRDeozeEb4dO23GcfsftDu1B1x72W-jdhAdt57Y7dF3bdpye2-kfW-jjjGq3B27v-A8dFXYb?type=png)](https://mermaid.live/edit#pako:eNqVVMtu6jAQ_ZXIa4qS8gh4F4VURTyVhi6qSJFrD2A1sSPjVG2Bf7-G0ts2D6R6k3jsmXN8zth7RCUDhBGoEScbRbJYxMIyY7maR4vkMZhHnrX_DJ3GeB5ZnCV5IbRMXkFoYi0n38uPXujfe6ElZPasoBpnXAGlXF5Ajl9o_nRskIIaJJpygwJ_QiE5pClnsrqiIYW1FLIEvwwXo5UfLepOqiQrqJZ_IqB5_gN8vpoF4di3cnN2XkOqEJwRlmTAzLfELAz8IPKSKwRNUSi5UKZ-N6mSedkkW6K4IEkuVfJJoYTdZH7V9mg8Cx4ib7a01kC35Gq73E0aPa7jqaUmaYnYyEgynQaN3cmMIGkKdZo0crgqFiVCfwtU9fSknzZq1pi-K57rjvDzeh0ONzdyf5EbWwpIyj9I-Wpc3_Wr0m99sEWloQ8CKu3esD8Hpc12Wp9wOFS60qTIHQBqoY3iDGGtCmihDFRGTlN0tihGegsZxAibX0bUS4xicTQ5ORFPUmZfaUoWmy3Ca5LuzKzIGdFweZz-RxUIBsqXpq8Q7vTONRDeozeEb4dO23GcfsftDu1B1x72W-jdhAdt57Y7dF3bdpye2-kfW-jjjGq3B27v-A8dFXYb)

---

# 5. Explicación de la Normalización (3FN)

La base de datos se encuentra en Tercera Forma Normal porque:

## Primera Forma Normal (1FN)

* No existen grupos repetitivos.
* Todos los atributos son atómicos.

## Segunda Forma Normal (2FN)

* Todos los atributos dependen completamente de su clave primaria.
* No existen dependencias parciales.

## Tercera Forma Normal (3FN)

* No existen dependencias transitivas.
* Cada atributo depende únicamente de la clave primaria.

Ejemplo:

* Los datos del producto se almacenan solo en PRODUCTO.
* Los datos del cliente se almacenan solo en CLIENTE.
* DETALLE_VENTA solo guarda referencias y cantidades.

---

# 6. Inserción de Datos de Ejemplo

## Puntos de Venta

```sql
INSERT INTO punto_venta (nombre, direccion)
VALUES
('Mostrador Centro', 'San Martin 120'),
('Mostrador Terminal', 'Bv. España 540'),
('Mostrador Costanera', 'Costanera 210'),
('Mostrador Sur', 'Av. Peron 1500');
```

---

## Clientes

```sql
INSERT INTO cliente (nombre, apellido, telefono)
VALUES
('Juan', 'Perez', '3534123456'),
('Maria', 'Lopez', '3534987654'),
('Carlos', 'Gomez', '3534556677'),
('Lucia', 'Martinez', '3534778899');
```

---

## Productos

```sql
INSERT INTO producto (nombre, tipo, precio, unidad_medida)
VALUES
('Ravioles Ricota', 'Pastas Rellenas', 4500.00, 'kg'),
('Tallarines', 'Pastas Simples', 3200.00, 'kg'),
('Sorrentinos JyQ', 'Pastas Rellenas', 5200.00, 'kg'),
('Ñoquis', 'Pastas Simples', 2800.00, 'kg'),
('Lasagna', 'Pastas Especiales', 6000.00, 'unidad');
```

---

## Recetas de Productos

```sql
INSERT INTO receta_producto (id_producto, kg_harina_por_unidad)
VALUES
(1, 0.550),
(2, 0.700),
(3, 0.600),
(4, 0.650),
(5, 1.200);
```

---

## Ventas

```sql
INSERT INTO venta (fecha, id_punto_venta, id_cliente, total)
VALUES
('2026-05-20 10:15:00', 1, 1, 7700.00),
('2026-05-20 11:20:00', 2, 2, 8400.00),
('2026-05-20 13:40:00', 3, 3, 6000.00),
('2026-05-20 18:00:00', 1, 4, 7300.00),
('2026-05-20 19:10:00', 4, 1, 5600.00);
```

---

## Detalle de Ventas

```sql
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
```

---

# 7. Consultas SQL para Resolver los Requerimientos

## 7.1 Dinero recaudado por cada punto de venta

```sql
SELECT
    pv.nombre AS punto_venta,
    SUM(v.total) AS total_recaudado
FROM venta v
INNER JOIN punto_venta pv
    ON v.id_punto_venta = pv.id_punto_venta
GROUP BY pv.nombre;
```

---

## 7.2 Mayor monto recaudado entre los mostradores

```sql
SELECT MAX(total_recaudado) AS mayor_recaudacion
FROM (
    SELECT
        id_punto_venta,
        SUM(total) AS total_recaudado
    FROM venta
    GROUP BY id_punto_venta
) AS recaudaciones;
```

---

## 7.3 Mostrador o mostradores con mayor recaudación

```sql
WITH recaudacion AS (
    SELECT
        pv.nombre,
        SUM(v.total) AS total_recaudado
    FROM venta v
    INNER JOIN punto_venta pv
        ON v.id_punto_venta = pv.id_punto_venta
    GROUP BY pv.nombre
)
SELECT *
FROM recaudacion
WHERE total_recaudado = (
    SELECT MAX(total_recaudado)
    FROM recaudacion
);
```

---

## 7.4 Los 3 productos más vendidos

```sql
SELECT
    p.nombre,
    SUM(dv.cantidad) AS cantidad_vendida
FROM detalle_venta dv
INNER JOIN producto p
    ON dv.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY cantidad_vendida DESC
LIMIT 3;
```

---

## 7.5 Cantidad de kg de harina consumidos

```sql
SELECT
    SUM(dv.cantidad * rp.kg_harina_por_unidad) AS kg_harina_consumidos
FROM detalle_venta dv
INNER JOIN receta_producto rp
    ON dv.id_producto = rp.id_producto;
```

---

# 8. Conclusión

La solución propuesta:

* Cumple con los requerimientos del problema.
* Está desarrollada en PostgreSQL.
* Se encuentra normalizada en 3FN.
* Permite generar reportes de ventas y producción.
* Facilita futuras ampliaciones del sistema.
* Mantiene integridad referencial mediante claves primarias y foráneas.
