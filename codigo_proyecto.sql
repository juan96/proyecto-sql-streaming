-- 1. Habilitar el soporte de claves foráneas en SQLite (por defecto viene apagado)
PRAGMA foreign_keys = ON;

-- 2. ELIMINAR TABLAS SI YA EXISTEN (Para poder reiniciar el script limpiamente)
DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS historial_reproduccion;
DROP TABLE IF EXISTS contenido;
DROP TABLE IF EXISTS usuarios;

-- 3. CREACIÓN DE LAS TABLAS

CREATE TABLE usuarios (
    id_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    pais TEXT NOT NULL,
    fecha_registro TEXT NOT NULL, -- Formato: 'YYYY-MM-DD'
    tipo_plan TEXT CHECK(tipo_plan IN ('Básico', 'Estándar', 'Premium')) NOT NULL
);

CREATE TABLE contenido (
    id_contenido INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    genero TEXT NOT NULL,
    duracion_minutos INTEGER NOT NULL,
    costo_licencia REAL NOT NULL
);

CREATE TABLE historial_reproduccion (
    id_reproduccion INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_contenido INTEGER,
    fecha_visto TEXT NOT NULL, -- Formato: 'YYYY-MM-DD'
    minutos_reproducidos INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_contenido) REFERENCES contenido(id_contenido) ON DELETE CASCADE
);

CREATE TABLE pagos (
    id_pago INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    monto REAL NOT NULL,
    fecha_pago TEXT NOT NULL, -- Formato: 'YYYY-MM-DD'
    metodo_pago TEXT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- 4. INSERCIÓN DE DATOS DE PRUEBA (DATA FICTICIA)

-- Usuarios de distintos países y planes
INSERT INTO usuarios (nombre, pais, fecha_registro, tipo_plan) VALUES
('Alejandro Gomez', 'México', '2025-01-15', 'Premium'),
('Maria Silva', 'Colombia', '2025-02-10', 'Estándar'),
('Carlos Perez', 'Argentina', '2025-03-01', 'Básico'),
('Laura Martinez', 'México', '2025-04-12', 'Premium'),
('Ana Rodriguez', 'Chile', '2025-05-20', 'Estándar'),
('Diego Fernandez', 'Colombia', '2025-06-05', 'Básico'),
('Elena Gomez', 'España', '2025-01-20', 'Premium'),
('Juan Lopez', 'México', '2025-02-28', 'Estándar'),
('Sofia Castro', 'Chile', '2025-07-01', 'Premium'), -- Usuario nuevo
('Luis Morales', 'Argentina', '2025-03-15', 'Premium'); -- Usuario inactivo (no verá nada reciente)

-- Catálogo de contenido con duraciones y costos variados
INSERT INTO contenido (titulo, genero, duracion_minutos, costo_licencia) VALUES
('Stranger Hits', 'Ciencia Ficción', 50, 15000.00),
('La Casa de Papelitos', 'Drama', 45, 12000.00),
('El Conjuro 4', 'Terror', 120, 8000.00),
('Scary Movie 2026', 'Comedia', 90, 5000.00),
('Interestelar 2', 'Ciencia Ficción', 160, 25000.00),
('Bake Off Local', 'Documental', 60, 3000.00),
('Monólogos de Pie', 'Comedia', 75, 2000.00),
('El Payaso Asesino', 'Terror', 105, 4500.00);

-- Historial de reproducción (Simula patrones reales)
INSERT INTO historial_reproduccion (id_usuario, id_contenido, fecha_visto, minutos_reproducidos) VALUES
(1, 1, '2026-06-01', 50),  -- Vio completa
(1, 5, '2026-06-02', 160), -- Vio completa
(2, 2, '2026-06-05', 45),  -- Vio completa
(2, 3, '2026-06-06', 15),  -- Abandonó a los 15 minutos (Terror)
(3, 4, '2026-06-10', 90),  -- Vio completa
(4, 3, '2026-06-12', 20),  -- Abandonó a los 20 minutos (Terror)
(4, 1, '2026-06-15', 50),  -- Vio completa
(5, 6, '2026-06-20', 60),  -- Vio completa
(6, 4, '2026-06-22', 85),  -- Casi completa
(7, 2, '2026-06-25', 45),  -- Vio completa
(7, 8, '2026-06-26', 10),  -- Abandonó muy rápido (Terror)
(8, 7, '2026-06-28', 75),  -- Vio completa
(9, 1, '2026-07-02', 50),  -- Actividad reciente (Julio)
(9, 5, '2026-07-05', 120), -- Actividad reciente (Julio)
(1, 7, '2026-07-10', 75);  -- Actividad reciente de Alejandro

-- Historial de pagos mensuales (Junio y Julio)
INSERT INTO pagos (id_usuario, monto, fecha_pago, metodo_pago) VALUES
(1, 15.99, '2026-06-15', 'Tarjeta de Crédito'),
(2, 11.99, '2026-06-10', 'PayPal'),
(3, 7.99,  '2026-06-01', 'Tarjeta de Débito'),
(4, 15.99, '2026-06-12', 'Tarjeta de Crédito'),
(5, 11.99, '2026-06-20', 'PayPal'),
(6, 7.99,  '2026-06-05', 'Efectivo/Oxxo'),
(7, 15.99, '2026-06-20', 'Tarjeta de Crédito'),
(8, 11.99, '2026-06-28', 'Tarjeta de Débito'),
(10, 15.99, '2026-06-15', 'Tarjeta de Crédito'), -- Pagó junio pero no consumió nada
-- Pagos de Julio
(1, 15.99, '2026-07-15', 'Tarjeta de Crédito'),
(9, 15.99, '2026-07-01', 'PayPal'); -- Pago nuevo usuario