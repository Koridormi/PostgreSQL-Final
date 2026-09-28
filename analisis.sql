-- Proyecto Capstone - Analisis de datos
-- Este archivo contiene la limpieza y las consultas principales del proyecto


-- =========================================================
-- 1. REVISION Y LIMPIEZA DE DATOS
-- =========================================================

-- Revisamos si existen precios faltantes en pedidos
-- Esto es importante porque un precio nulo afectaria los calculos de ventas

SELECT
    id_pedido,
    id_producto,
    precio_unitario
FROM pedidos
WHERE precio_unitario IS NULL;


-- Completamos los precios faltantes usando el precio actual del producto
-- COALESCE mantiene el precio del pedido si existe y usa el del producto si es NULL

UPDATE pedidos pe
SET precio_unitario = COALESCE(pe.precio_unitario, pr.precio)
FROM productos pr
WHERE pe.id_producto = pr.id_producto
  AND pe.precio_unitario IS NULL;


-- Verificamos que ya no queden precios faltantes

SELECT COUNT(*) AS precios_nulos_restantes
FROM pedidos
WHERE precio_unitario IS NULL;


-- Revisamos los tipos de datos principales del proyecto

SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN ('clientes', 'productos', 'pedidos')
ORDER BY table_name, ordinal_position;



-- =========================================================
-- 2. TOP 5 CLIENTES POR GASTO TOTAL
-- =========================================================

-- Buscamos los clientes que mas dinero generaron
-- Esto permite identificar a los clientes con mayor nivel de compra

SELECT
    c.id_cliente,
    c.nombre AS cliente,
    COUNT(pe.id_pedido) AS cantidad_pedidos,
    SUM(pe.cantidad * pe.precio_unitario) AS gasto_total
FROM clientes c
JOIN pedidos pe
    ON c.id_cliente = pe.id_cliente
GROUP BY
    c.id_cliente,
    c.nombre
ORDER BY gasto_total DESC
LIMIT 5;



-- =========================================================
-- 3. VENTAS TOTALES POR MES
-- =========================================================

-- Agrupamos las ventas por mes para detectar cambios en el nivel de ventas
-- Esto permite comparar periodos y encontrar meses con mayor o menor actividad

SELECT
    DATE_TRUNC('month', pe.fecha_pedido)::DATE AS mes,
    COUNT(pe.id_pedido) AS cantidad_pedidos,
    SUM(pe.cantidad) AS unidades_vendidas,
    SUM(pe.cantidad * pe.precio_unitario) AS ventas_totales
FROM pedidos pe
GROUP BY
    DATE_TRUNC('month', pe.fecha_pedido)
ORDER BY mes;



-- =========================================================
-- 4. TRES PRODUCTOS MENOS VENDIDOS
-- =========================================================

-- Usamos LEFT JOIN para incluir tambien productos que nunca fueron vendidos
-- Esto ayuda a detectar productos con baja rotacion o sin ventas

SELECT
    pr.id_producto,
    pr.nombre AS producto,
    pr.categoria,
    COALESCE(SUM(pe.cantidad), 0) AS unidades_vendidas
FROM productos pr
LEFT JOIN pedidos pe
    ON pr.id_producto = pe.id_producto
GROUP BY
    pr.id_producto,
    pr.nombre,
    pr.categoria
ORDER BY
    unidades_vendidas ASC,
    pr.id_producto ASC
LIMIT 3;



-- =========================================================
-- 5. RANKING DE PRODUCTOS POR CATEGORIA
-- =========================================================

-- Primero calculamos las unidades vendidas por producto
-- Luego usamos RANK para comparar cada producto contra otros de su categoria

WITH ventas_producto AS (
    SELECT
        pr.id_producto,
        pr.nombre AS producto,
        pr.categoria,
        COALESCE(SUM(pe.cantidad), 0) AS unidades_vendidas
    FROM productos pr
    LEFT JOIN pedidos pe
        ON pr.id_producto = pe.id_producto
    GROUP BY
        pr.id_producto,
        pr.nombre,
        pr.categoria
)

SELECT
    categoria,
    producto,
    unidades_vendidas,
    RANK() OVER (
        PARTITION BY categoria
        ORDER BY unidades_vendidas DESC
    ) AS ranking_categoria
FROM ventas_producto
ORDER BY
    categoria,
    ranking_categoria,
    producto;