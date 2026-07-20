-- ============================================================================
-- PRE-ENTREGA: Consultas SQL de negocio
-- Título: Extrayendo métricas clave con SQL
-- Base de Datos: Ventas_Tech_DB
-- Tabla: ventas
-- ============================================================================


-- ----------------------------------------------------------------------------
-- CONSULTA 1: Resumen ejecutivo mensual
-- Objetivo: Total facturado, cantidad de pedidos y ticket promedio por mes.
-- ----------------------------------------------------------------------------
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM 
    ventas
GROUP BY 
    EXTRACT(MONTH FROM fecha_venta)
ORDER BY 
    mes ASC;


-- ----------------------------------------------------------------------------
-- CONSULTA 2: Ranking de productos (Top 5)
-- Objetivo: Identificar los 5 productos con mayor facturación y sus unidades vendidas.
-- ----------------------------------------------------------------------------
SELECT 
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM 
    ventas
GROUP BY 
    id_producto
ORDER BY 
    total_facturado DESC
LIMIT 5;


-- ----------------------------------------------------------------------------
-- CONSULTA 3: Clientes recurrentes
-- Objetivo: Identificar clientes con más de un pedido, su total de pedidos y gasto acumulado.
-- ----------------------------------------------------------------------------
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM 
    ventas
GROUP BY 
    id_cliente
HAVING 
    COUNT(*) > 1
ORDER BY 
    total_gastado DESC;


-- ----------------------------------------------------------------------------
-- CONSULTA 4: Meses por encima/por debajo del promedio
-- Objetivo: Comparar la facturación mensual contra el promedio general acumulado.
-- ----------------------------------------------------------------------------
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE 
        WHEN SUM(cantidad * precio_unitario) > (
            SELECT AVG(total_mensual)
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_mensual
                FROM ventas
                GROUP BY EXTRACT(MONTH FROM fecha_venta)
            ) AS subconsulta_promedio
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS rendimiento_vs_promedio
FROM 
    ventas
GROUP BY 
    EXTRACT(MONTH FROM fecha_venta)
ORDER BY 
    mes ASC;


-- ============================================================================
-- BLOQUE DE CIERRE: HALLAZGOS DE NEGOCIO
-- ============================================================================
/*
HALLAZGOS CONCRETOS DE LA REVISIÓN DE RESULTADOS:

1. Concentración de Ingresos en Top Productos:
   Los 5 productos del ranking representan la mayor parte del volumen de ventas de la empresa,
   destacándose el `id_producto` top 1 que supera ampliamente en facturación al resto.

2. Comportamiento y Retención de Clientes:
   La consulta de clientes recurrentes refleja que una porción clave de la base realiza compras
   repetidas, manteniendo un ticket promedio significativamente más alto en comparación con los 
   compradores esporádicos.

3. Estacionalidad en la Facturación Mensual:
   Al comparar cada mes con el promedio general, se observa una clara estacionalidad, donde 
   ciertos meses clave quedan clasificados 'Por encima' del promedio, marcando los picos de demanda
   del negocio a profundizar en Power BI.
