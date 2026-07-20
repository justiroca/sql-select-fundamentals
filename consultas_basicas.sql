-- ══════════════════════════════════════════
-- TechStore — Consultas Básicas SELECT
-- Autor: Justina Roca
-- Fecha: 2026-07-20
-- ══════════════════════════════════════════
-- ══════════════════════════════════════════
-- Consulta 1: Exploración general de la tabla sales
-- ══════════════════════════════════════════

-- SELECT * permite visualizar todas las columnas de una tabla.
-- Es útil durante la exploración inicial de una base de datos,
-- cuando todavía necesitamos conocer su estructura y contenido.
-- No se recomienda usarlo en producción porque puede
-- traer datos innecesarios, afectar el rendimiento y hacer que las
-- consultas sean más difíciles de mantener.

SELECT *
FROM sales;

-- ══════════════════════════════════════════
-- Consulta 2: Selección de columnas específicas para finanzas
-- ══════════════════════════════════════════

SELECT
customer_id,
product_id,
total_amount
FROM sales;

-- ══════════════════════════════════════════
-- Consulta 3: Selección con alias en español para stakeholders
-- ══════════════════════════════════════════
SELECT
order_date AS fecha_pedido,
product_name AS nombre_producto,
quantity AS cantidad_unidades
FROM sales;
