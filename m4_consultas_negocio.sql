-- ============================================================
-- PRE-ENTREGA 4: CONSULTAS SQL DE NEGOCIO
-- Base de datos: Ventas_Tech_DB
-- Motor utilizado: SQL Server
-- ============================================================

USE Ventas_Tech_DB;
GO


-- ============================================================
-- CONSULTA 1: RESUMEN EJECUTIVO MENSUAL
-- Total facturado, cantidad de pedidos y ticket promedio
-- agrupados por mes.
-- ============================================================

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    CAST(AVG(cantidad * precio_unitario) AS DECIMAL(10,2)) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes ASC;

-- ============================================================
-- CONSULTA 2: RANKING DE PRODUCTOS
-- Top 5 de productos según el total facturado.
-- También se muestran las unidades vendidas.
-- ============================================================

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
GO


-- ============================================================
-- CONSULTA 3: CLIENTES RECURRENTES
-- Clientes que realizaron más de un pedido.
-- Se muestra cantidad de pedidos y total gastado.
-- ============================================================

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;
GO


-- ============================================================
-- CONSULTA 4: MESES POR ENCIMA / POR DEBAJO DEL PROMEDIO
-- Se calcula la facturación mensual y se compara contra
-- el promedio mensual general.
-- ============================================================

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) >
             (
                SELECT
                    SUM(cantidad * precio_unitario)
                    / COUNT(DISTINCT MONTH(fecha_venta))
                FROM ventas
             )
        THEN 'Por encima'

        WHEN SUM(cantidad * precio_unitario) <
             (
                SELECT
                    SUM(cantidad * precio_unitario)
                    / COUNT(DISTINCT MONTH(fecha_venta))
                FROM ventas
             )
        THEN 'Por debajo'

        ELSE 'Igual al promedio'
    END AS comparacion_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes ASC;
GO


-- ============================================================
-- HALLAZGOS DEL ANÁLISIS
-- ============================================================

-- 1. En marzo se facturaron $6.444,00 en 10 pedidos,
--    con un ticket promedio de $644,40.

-- 2. El producto con id_producto = 1 fue el que generó
--    mayor facturación: $3.600,00, aproximadamente el
--    55,9% de la facturación total.

-- 3. Los cinco clientes realizaron más de un pedido.
--    El cliente con id_cliente = 1 fue el que más gastó,
--    con un total de $2.640,00.

-- Nota:
-- La base creada en el Módulo 3 contiene ventas únicamente
-- del mes de marzo. Por este motivo, la facturación mensual
-- de marzo coincide con el promedio mensual general.
-- ============================================================