-- Dinero recaudado por cada punto de venta
SELECT
    pv.nombre AS punto_venta,
    SUM(v.total) AS total_recaudado
FROM venta v
INNER JOIN punto_venta pv
    ON v.id_punto_venta = pv.id_punto_venta
GROUP BY pv.nombre;

-- Mayor monto recaudado entre los mostradores
SELECT MAX(total_recaudado) AS mayor_recaudacion
FROM (
    SELECT
        id_punto_venta,
        SUM(total) AS total_recaudado
    FROM venta
    GROUP BY id_punto_venta
) AS recaudaciones;

-- Mostrador o mostradores con mayor recaudación
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

-- Los 3 productos más vendidos
SELECT
    p.nombre,
    SUM(dv.cantidad) AS cantidad_vendida
FROM detalle_venta dv
INNER JOIN producto p
    ON dv.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY cantidad_vendida DESC
LIMIT 3;

-- Cantidad de kg de harina consumidos
SELECT
    SUM(dv.cantidad * rp.kg_harina_por_unidad) AS kg_harina_consumidos
FROM detalle_venta dv
INNER JOIN receta_producto rp
    ON dv.id_producto = rp.id_producto;