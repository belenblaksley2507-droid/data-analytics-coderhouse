-- ============================================================
-- PRE-ENTREGA 5: CONSULTAS CON JOINS PARA EL PROYECTO
-- Base de datos: Ventas_Tech_DB
-- Motor utilizado: SQL Server
-- ============================================================

USE Ventas_Tech_DB;
GO


-- ============================================================
-- CONSULTA 1: VISTA BASE DEL PROYECTO (INNER JOIN)
-- Propósito: construir una vista enriquecida de las ventas con
-- información del cliente, producto y categoría para Power BI.
-- ============================================================

SELECT
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    CAST(v.cantidad * v.precio_unitario AS DECIMAL(10,2)) AS total_venta
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;
GO

-- Hallazgo: las 10 ventas cargadas tienen coincidencia con
-- clientes, productos y categorías. La vista devuelve 10 registros
-- completos que pueden utilizarse como fuente para Power BI.


-- ============================================================
-- CONSULTA 2: CLIENTES SIN VENTAS (LEFT JOIN)
-- Propósito: detectar clientes registrados que nunca realizaron
-- una compra, para que el área de CRM pueda identificarlos.
-- ============================================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.fecha_registro;
GO

-- Hallazgo: aparecen 0 clientes sin ventas. Esto significa que
-- todos los clientes registrados realizaron al menos una compra,
-- por lo que CRM no tiene clientes inactivos en estos datos.


-- ============================================================
-- CONSULTA 3: PRODUCTOS SIN VENTAS (LEFT JOIN)
-- Propósito: detectar productos del catálogo que todavía no tienen
-- movimiento de ventas, para que el área de producto los revise.
-- ============================================================

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL
ORDER BY p.nombre_producto;
GO

-- Hallazgo: aparecen 0 productos sin ventas. Los 6 productos del
-- catálogo registran al menos una venta, por lo que actualmente
-- no hay artículos sin movimiento para revisar.


-- ============================================================
-- CONSULTA 4: CONSOLIDADO POR ORIGEN CON UNION ALL
-- Propósito: dividir las ventas en dos períodos de marzo y
-- comparar la facturación total de cada origen.
--
-- La columna canal se crea dentro de cada SELECT como texto fijo.
-- No existe originalmente en la tabla ventas.
-- ============================================================

SELECT
    canal,
    CAST(SUM(total) AS DECIMAL(10,2)) AS total_canal
FROM (

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Inicio de marzo' AS canal
    FROM ventas
    WHERE fecha_venta BETWEEN '2024-03-05' AND '2024-03-10'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Resto de marzo' AS canal
    FROM ventas
    WHERE fecha_venta BETWEEN '2024-03-11' AND '2024-03-15'

) AS consolidado
GROUP BY canal
ORDER BY total_canal DESC;
GO

-- Hallazgo: el período "Inicio de marzo" facturó $3.620,00
-- y el período "Resto de marzo" facturó $2.824,00.
-- El inicio de marzo tuvo la mayor facturación.