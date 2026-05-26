CREATE TABLE punto_venta (
    id_punto_venta SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(120) NOT NULL
);


CREATE TABLE cliente (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellido VARCHAR(60) NOT NULL,
    telefono VARCHAR(25)
);


CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    tipo VARCHAR(40) NOT NULL,
    precio NUMERIC(10,2) NOT NULL CHECK (precio >= 0),
    unidad_medida VARCHAR(20) NOT NULL
);


CREATE TABLE receta_producto (
    id_receta SERIAL PRIMARY KEY,
    id_producto INTEGER NOT NULL,
    kg_harina_por_unidad NUMERIC(10,3) NOT NULL CHECK (kg_harina_por_unidad >= 0),

    CONSTRAINT fk_receta_producto
        FOREIGN KEY (id_producto)
        REFERENCES producto(id_producto)
        ON DELETE CASCADE
);


CREATE TABLE venta (
    id_venta SERIAL PRIMARY KEY,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_punto_venta INTEGER NOT NULL,
    id_cliente INTEGER,
    total NUMERIC(12,2) NOT NULL CHECK (total >= 0),

    CONSTRAINT fk_venta_punto
        FOREIGN KEY (id_punto_venta)
        REFERENCES punto_venta(id_punto_venta),

    CONSTRAINT fk_venta_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente)
);


CREATE TABLE detalle_venta (
    id_detalle SERIAL PRIMARY KEY,
    id_venta INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad NUMERIC(10,2) NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal NUMERIC(12,2) NOT NULL CHECK (subtotal >= 0),

    CONSTRAINT fk_detalle_venta
        FOREIGN KEY (id_venta)
        REFERENCES venta(id_venta)
        ON DELETE CASCADE,

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (id_producto)
        REFERENCES producto(id_producto)
);