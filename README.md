# Proyecto Capstone - Analisis de Datos con PostgreSQL

## Contexto

Este proyecto simula el analisis de datos de una tienda online relacionada con videojuegos, perifericos, accesorios y merchandising.

El objetivo es trabajar con una base de datos PostgreSQL y utilizar consultas SQL para analizar clientes, productos y pedidos.

La base de datos utilizada en el proyecto se llama:

capstone_project

Los datos representan compras realizadas durante distintos meses del año 2026.

## Objetivo

El objetivo principal del proyecto es aplicar consultas SQL para obtener informacion a partir de los datos almacenados.

Las preguntas principales que se analizaron fueron:

- Que clientes generan mayor cantidad de ventas.
- Como evolucionaron las ventas a traves de los meses.
- Que productos tienen menor cantidad de ventas.
- Como se posicionan los productos dentro de cada categoria.

## Estructura de la base de datos

El proyecto utiliza el schema public y contiene tres tablas principales:

- clientes
- productos
- pedidos

### clientes

Contiene informacion de las personas registradas en la tienda.

Campos principales:

- id_cliente
- nombre
- email
- fecha_registro

El campo id_cliente funciona como clave primaria.

### productos

Contiene informacion de los productos disponibles en la tienda.

Campos principales:

- id_producto
- nombre
- categoria
- precio
- stock

El campo id_producto funciona como clave primaria.

Tambien se agregaron restricciones para evitar precios menores o iguales a cero y valores negativos de stock.

### pedidos

Contiene las compras realizadas por los clientes.

Campos principales:

- id_pedido
- id_cliente
- id_producto
- cantidad
- precio_unitario
- fecha_pedido

El campo id_pedido funciona como clave primaria.

La tabla pedidos se relaciona con clientes mediante id_cliente y con productos mediante id_producto.

Estas relaciones se realizaron utilizando claves foraneas.

Tambien se agrego una restriccion para evitar cantidades menores o iguales a cero.

## Datos utilizados

Para poder realizar diferentes analisis se cargaron:

- 10 clientes
- 12 productos
- 48 pedidos

Los pedidos fueron distribuidos entre enero y septiembre de 2026 para poder analizar cambios en las ventas a traves del tiempo.

Tambien se dejaron algunos valores NULL de forma intencional en precio_unitario para poder realizar una etapa de revision y limpieza de datos.

## Limpieza de datos

Antes de comenzar los analisis se revisaron los pedidos para detectar precios faltantes.

Se encontraron algunos registros donde precio_unitario tenia un valor NULL.

Para evitar que estos valores afectaran los calculos se utilizo COALESCE junto con el precio almacenado en la tabla productos.

De esta manera, cuando precio_unitario estaba vacio se utilizaba el precio correspondiente del producto.

Despues de realizar la limpieza se hizo una nueva consulta para verificar que no quedaran precios nulos.

Tambien se revisaron los tipos de datos utilizados en las tablas.

Entre los principales tipos utilizados se encuentran:

- INTEGER para identificadores, cantidades y stock.
- VARCHAR para textos.
- NUMERIC para precios.
- DATE para fechas.

## Analisis realizados

### 1. Top 5 clientes por gasto total

Se utilizaron las tablas clientes y pedidos.

Mediante JOIN se relacionaron ambas tablas y luego se utilizaron GROUP BY y SUM para calcular cuanto dinero gasto cada cliente.

Tambien se utilizo COUNT para mostrar la cantidad de pedidos realizados.

Los cinco clientes con mayor gasto fueron:

1. Lucas Romero - 791000
2. Mateo Gonzalez - 635000
3. Nicolas Alvarez - 541000
4. Sofia Martinez - 223000
5. Valentina Lopez - 139000

Los primeros tres clientes presentan un nivel de gasto bastante superior al resto.

Este analisis permite detectar cuales son los clientes con mayor participacion dentro de las ventas registradas.

### 2. Ventas totales por mes

Las ventas fueron agrupadas por mes utilizando DATE_TRUNC.

Para cada mes se calcularon:

- cantidad de pedidos
- unidades vendidas
- ventas totales

El mes con mayor facturacion fue julio con un total de 374000.

El mes con menor facturacion fue abril con un total de 251000.

Las ventas aumentaron durante los primeros meses, tuvieron una disminucion en abril y luego mostraron una recuperacion que alcanzo su valor mas alto en julio.

Esto muestra que las ventas no se mantuvieron constantes durante todo el periodo analizado.

### 3. Productos menos vendidos

Para este analisis se utilizo LEFT JOIN entre productos y pedidos.

LEFT JOIN permite incluir tambien aquellos productos que nunca tuvieron una venta registrada.

Los tres productos con menor cantidad de unidades vendidas fueron:

- Soporte para auriculares: 0 unidades
- Webcam HD: 1 unidad
- Figura coleccionable: 2 unidades

La Remera gamer tambien registro 2 unidades vendidas, pero queda fuera de los primeros tres resultados debido al criterio de desempate utilizado en la consulta.

El soporte para auriculares no tuvo ninguna venta durante el periodo analizado.

Este resultado permite detectar productos con poca rotacion o productos que directamente no tuvieron movimiento.

### 4. Ranking de productos por categoria

Para realizar este analisis primero se calcularon las unidades vendidas de cada producto.

Luego se utilizo RANK como funcion de ventana para generar un ranking dentro de cada categoria.

Para separar los rankings se utilizo PARTITION BY categoria.

Algunos resultados destacados fueron:

- En Accesorios, Mousepad XL obtuvo el primer puesto.
- En Videojuegos, Stardew Valley obtuvo el primer puesto.
- En Perifericos, Mouse gamer y Auriculares gamer quedaron empatados.
- En Merchandising, Figura coleccionable y Remera gamer tambien quedaron empatados.

RANK permite mantener correctamente los empates cuando dos productos tienen la misma cantidad de unidades vendidas.

## Conceptos de SQL utilizados

Durante el proyecto se utilizaron diferentes herramientas de PostgreSQL:

- CREATE DATABASE
- CREATE TABLE
- PRIMARY KEY
- FOREIGN KEY
- CHECK
- INSERT INTO
- SELECT
- UPDATE
- JOIN
- LEFT JOIN
- GROUP BY
- ORDER BY
- LIMIT
- SUM
- COUNT
- COALESCE
- DATE_TRUNC
- CTE
- RANK
- PARTITION BY
- funciones de ventana

## Hallazgos principales

El analisis permitio encontrar varias diferencias entre clientes, productos y periodos.

Lucas Romero, Mateo Gonzalez y Nicolas Alvarez fueron los clientes con mayor gasto dentro del dataset.

Julio fue el mes con mayor nivel de facturacion.

Abril fue el mes con menor facturacion.

Tambien se encontraron productos con muy pocas ventas e incluso un producto que no tuvo ninguna venta registrada.

El ranking por categoria permitio comparar productos que pertenecen a grupos similares y tambien detectar empates entre algunos de ellos.

## Conclusion

El proyecto permitio aplicar diferentes conceptos de PostgreSQL sobre una base de datos relacionada con ventas.

Se trabajo con creacion de tablas, relaciones entre datos, restricciones, limpieza de valores nulos, agregaciones, funciones de fecha y funciones de ventana.

Los resultados muestran que las ventas no se distribuyen de la misma forma entre todos los clientes, productos y meses.

Algunos clientes concentran una parte importante de las compras, mientras que determinados productos presentan muy poca actividad.

Tambien se observaron cambios en el nivel de ventas dependiendo del mes.

Como mejora futura se podria aumentar la cantidad de clientes, productos y pedidos para analizar un periodo mas largo y comprobar si los patrones encontrados se mantienen.

## Archivos del proyecto

El repositorio contiene los siguientes archivos:

- estructura.sql: crea la base de datos, las tablas y carga los datos iniciales.
- analisis.sql: contiene la revision, limpieza y consultas utilizadas para el analisis.
- README.md: contiene la descripcion del proyecto, resultados y conclusiones.

## Como ejecutar el proyecto

1. Abrir PostgreSQL o una herramienta como pgAdmin.
2. Ejecutar la instruccion CREATE DATABASE de estructura.sql para crear la base capstone_project.
3. Conectarse a la base de datos capstone_project.
4. Ejecutar el resto de estructura.sql para crear las tablas y cargar los datos.
5. Ejecutar analisis.sql para realizar la limpieza y los diferentes analisis.
6. Revisar los resultados obtenidos por cada consulta.

Si la base capstone_project ya existe, no es necesario volver a ejecutar CREATE DATABASE.

## Orden recomendado

El orden de ejecucion es:

1. estructura.sql
2. analisis.sql

Una vez terminados ambos scripts, la base queda preparada para revisar los resultados del proyecto.