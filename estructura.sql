-- Proyecto Capstone - PostgreSQL
-- Estructura y carga inicial de datos

CREATE DATABASE capstone_project;

-- Eliminamos las tablas si ya existen para poder ejecutar el script nuevamente

DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;


-- Tabla de clientes

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    fecha_registro DATE NOT NULL
);


-- Tabla de productos

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    stock INTEGER NOT NULL,
    CONSTRAINT chk_precio_positivo CHECK (precio > 0),
    CONSTRAINT chk_stock_valido CHECK (stock >= 0)
);


-- Cada fila de pedidos representa la compra de un producto
-- por parte de un cliente

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario NUMERIC(10,2),
    fecha_pedido DATE NOT NULL,

    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    CONSTRAINT fk_pedido_producto
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto),

    CONSTRAINT chk_cantidad_positiva
        CHECK (cantidad > 0)
);


-- Clientes

INSERT INTO clientes
    (id_cliente, nombre, email, fecha_registro)
VALUES
    (1, 'Lucas Romero', 'lucas.romero@email.com', '2025-11-10'),
    (2, 'Sofia Martinez', 'sofia.martinez@email.com', '2025-11-22'),
    (3, 'Mateo Gonzalez', 'mateo.gonzalez@email.com', '2025-12-05'),
    (4, 'Valentina Lopez', 'valentina.lopez@email.com', '2025-12-18'),
    (5, 'Tomas Fernandez', 'tomas.fernandez@email.com', '2026-01-07'),
    (6, 'Camila Diaz', 'camila.diaz@email.com', '2026-01-18'),
    (7, 'Nicolas Alvarez', 'nicolas.alvarez@email.com', '2026-02-01'),
    (8, 'Martina Silva', 'martina.silva@email.com', '2026-02-15'),
    (9, 'Franco Torres', 'franco.torres@email.com', '2026-03-03'),
    (10, 'Agustina Castro', 'agustina.castro@email.com', '2026-03-20');


-- Productos

INSERT INTO productos
    (id_producto, nombre, categoria, precio, stock)
VALUES
    (1, 'Teclado mecanico', 'Perifericos', 65000.00, 20),
    (2, 'Mouse gamer', 'Perifericos', 32000.00, 35),
    (3, 'Auriculares gamer', 'Perifericos', 48000.00, 18),
    (4, 'Control USB', 'Accesorios', 41000.00, 25),
    (5, 'Mousepad XL', 'Accesorios', 18000.00, 40),
    (6, 'Webcam HD', 'Perifericos', 39000.00, 15),
    (7, 'Elden Ring', 'Videojuegos', 70000.00, 22),
    (8, 'Cyberpunk 2077', 'Videojuegos', 45000.00, 30),
    (9, 'Stardew Valley', 'Videojuegos', 12000.00, 50),
    (10, 'Figura coleccionable', 'Merchandising', 28000.00, 12),
    (11, 'Remera gamer', 'Merchandising', 22000.00, 20),
    (12, 'Soporte para auriculares', 'Accesorios', 16000.00, 30);


-- Pedidos
-- Hay ventas distribuidas durante varios meses para poder analizar tendencias

INSERT INTO pedidos
    (id_pedido, id_cliente, id_producto, cantidad, precio_unitario, fecha_pedido)
VALUES

    -- Enero
    (1, 1, 7, 1, 70000.00, '2026-01-05'),
    (2, 2, 2, 2, 32000.00, '2026-01-09'),
    (3, 3, 1, 1, 65000.00, '2026-01-12'),
    (4, 4, 5, 2, 18000.00, '2026-01-18'),
    (5, 1, 3, 1, 48000.00, '2026-01-24'),

    -- Febrero
    (6, 5, 8, 1, 45000.00, '2026-02-03'),
    (7, 6, 2, 1, 32000.00, '2026-02-07'),
    (8, 7, 7, 2, 70000.00, '2026-02-11'),
    (9, 3, 4, 1, 41000.00, '2026-02-17'),
    (10, 2, 9, 3, 12000.00, '2026-02-23'),

    -- Marzo
    (11, 8, 3, 1, 48000.00, '2026-03-02'),
    (12, 1, 1, 2, 65000.00, '2026-03-06'),
    (13, 9, 5, 1, 18000.00, '2026-03-12'),
    (14, 3, 8, 2, 45000.00, '2026-03-18'),
    (15, 7, 2, 2, 32000.00, '2026-03-27'),

    -- Abril
    (16, 10, 9, 2, 12000.00, '2026-04-04'),
    (17, 4, 6, 1, 39000.00, '2026-04-08'),
    (18, 1, 7, 1, 70000.00, '2026-04-13'),
    (19, 5, 11, 1, 22000.00, '2026-04-20'),
    (20, 3, 3, 2, 48000.00, '2026-04-26'),

    -- Mayo
    (21, 7, 1, 1, 65000.00, '2026-05-03'),
    (22, 2, 5, 3, 18000.00, '2026-05-09'),
    (23, 1, 8, 2, NULL, '2026-05-14'),
    (24, 6, 4, 1, 41000.00, '2026-05-19'),
    (25, 3, 7, 1, 70000.00, '2026-05-28'),

    -- Junio
    (26, 9, 2, 1, 32000.00, '2026-06-02'),
    (27, 7, 3, 2, 48000.00, '2026-06-07'),
    (28, 1, 4, 2, 41000.00, '2026-06-12'),
    (29, 8, 10, 1, 28000.00, '2026-06-18'),
    (30, 3, 1, 1, 65000.00, '2026-06-25'),
    (31, 5, 9, 2, 12000.00, '2026-06-29'),

    -- Julio
    (32, 2, 8, 1, 45000.00, '2026-07-03'),
    (33, 1, 7, 2, 70000.00, '2026-07-08'),
    (34, 4, 2, 2, 32000.00, '2026-07-12'),
    (35, 7, 4, 1, 41000.00, '2026-07-17'),
    (36, 3, 3, 1, NULL, '2026-07-22'),
    (37, 10, 5, 2, 18000.00, '2026-07-29'),

    -- Agosto
    (38, 6, 9, 4, 12000.00, '2026-08-02'),
    (39, 1, 1, 1, 65000.00, '2026-08-06'),
    (40, 7, 7, 1, 70000.00, '2026-08-11'),
    (41, 5, 2, 1, 32000.00, '2026-08-15'),
    (42, 3, 8, 2, 45000.00, '2026-08-20'),
    (43, 9, 11, 1, 22000.00, '2026-08-27'),

    -- Septiembre
    (44, 1, 3, 2, 48000.00, '2026-09-03'),
    (45, 7, 1, 1, 65000.00, '2026-09-07'),
    (46, 2, 9, 2, 12000.00, '2026-09-12'),
    (47, 3, 7, 1, 70000.00, '2026-09-18'),
    (48, 8, 10, 1, 28000.00, '2026-09-24');


-- Revision rapida de la carga

SELECT COUNT(*) AS total_clientes
FROM clientes;

SELECT COUNT(*) AS total_productos
FROM productos;

SELECT COUNT(*) AS total_pedidos
FROM pedidos;