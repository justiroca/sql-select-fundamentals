¿Por qué es mala práctica usar SELECT * en producción?

Porque puede afectar el rendimiento: SELECT * devuelve todas las columnas de una tabla, incluso aquellas que no son necesarias para el análisis.

Por ejemplo:

SELECT *
FROM sales;

Esta consulta devuelve las nueve columnas de la tabla sales, aunque quizás el equipo de Finanzas solo necesite conocer el cliente, el producto y el monto total:

SELECT
    customer_id,
    product_id,
    total_amount
FROM sales;

Al seleccionar únicamente las columnas necesarias, se reduce la cantidad de información que la base de datos debe procesar y transferir. 
Esto puede mejorar el rendimiento, especialmente cuando las tablas contienen muchas columnas o grandes volúmenes de datos.



¿Por qué son importantes los alias para un stakeholder no técnico?

Los alias permiten cambiar temporalmente el nombre de una columna en el resultado de una consulta.

Los nombres originales de una base de datos suelen estar diseñados para desarrolladores o analistas. Por ejemplo:

total_amount

Puede no ser inmediatamente claro para una persona del área de Finanzas.

Con un alias, podemos presentar la misma información de una forma más fácil de interpretar:

SELECT
    total_amount AS monto_total
FROM sales;

En este caso, la columna total_amount aparecerá en el resultado como:

monto_total

El dato no cambia y tampoco se modifica la estructura de la tabla. Solo cambia el nombre con el que se muestra el resultado de la consulta.

Los alias son especialmente útiles cuando los datos se presentan a stakeholders de otras áreas, porque permiten transformar nombres técnicos en etiquetas más claras y comprensibles.

Por ejemplo:

SELECT
    order_date AS fecha_pedido,
    product_name AS nombre_producto,
    quantity AS cantidad_unidades
FROM sales;

El resultado será más fácil de interpretar para un usuario de negocio:

fecha_pedido	nombre_producto	cantidad_unidades
2024-01-05	Laptop Pro 15	2

De esta manera, el equipo puede comprender rápidamente la información sin necesidad de conocer los nombres técnicos utilizados en la base de datos.

Consultas incluidas
SELECT * para explorar la estructura completa de la tabla.
Selección de columnas específicas para un reporte de Finanzas.
Uso de AS para crear nombres de columnas amigables en español y con formato snake_case.
