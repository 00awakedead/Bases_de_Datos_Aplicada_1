-- ============================================================================
-- ANEXO 1: SCRIPT BASE INCOMPLETO — CASO TIENDA AKIBASUR
-- Importante: Corrija los tipos de datos y restricciones de las 4 tablas base
-- y agregue las sentencias CREATE TABLE faltantes.
-- ============================================================================

DROP TABLE detalle_factura CASCADE CONSTRAINTS;
DROP TABLE facturas CASCADE CONSTRAINTS;
DROP TABLE vendedores CASCADE CONSTRAINTS;
DROP TABLE articulos CASCADE CONSTRAINTS;
DROP TABLE clientes CASCADE CONSTRAINTS;
DROP TABLE zonas CASCADE CONSTRAINTS;
DROP TABLE categorias CASCADE CONSTRAINTS;
DROP TABLE marcas CASCADE CONSTRAINTS;
DROP TABLE comunas CASCADE CONSTRAINTS;

CREATE TABLE comunas (
    id_comuna NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_comuna VARCHAR2(40) NOT NULL
);

CREATE TABLE marcas (
    id_marca NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_marca VARCHAR2(40) NOT NULL
);

CREATE TABLE categorias (
    id_categoria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_categoria VARCHAR2(30) NOT NULL,
    porcentaje NUMBER(3, 1) NOT NULL
);

CREATE TABLE zonas (
    id_zona NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_zona VARCHAR2(30) NOT NULL,
    porc NUMBER(4, 2) NOT NULL
);

-- IMPLEMENTE AQUÍ LAS TABLAS CLIENTES, ARTICULOS, VENDEDORES, FACTURAS
-- Y LA TABLA FALTANTE DETALLE_FACTURA:

CREATE TABLE CLIENTES (
    id_cliente NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_cliente VARCHAR2(60) NOT NULL,
    direccion VARCHAR2(60) NOT NULL,
    telefono VARCHAR2(15) NOT NULL,
    comuna_id NUMBER REFERENCES comunas(id_comuna) NOT NULL
);

CREATE TABLE ARTICULOS (
    id_articulo NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_articulo VARCHAR2(50) NOT NULL,
    precio NUMBER(8) CHECK (precio > 0) NOT NULL,
    stock_actual NUMBER(5) CHECK (stock_actual > 10) NOT NULL,
    stock_minimo NUMBER (5) CHECK (stock_minimo > 0) NOT NULL,
    marca_id NUMBER REFERENCES marcas(id_marca) NOT NULL
);

CREATE TABLE VENDEDORES (
    id_vendedor NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rut_vendedor VARCHAR2(12) UNIQUE NOT NULL,
    nombres VARCHAR2(30) NOT NULL,
    paterno VARCHAR2(30) NOT NULL,
    materno VARCHAR2(30),
    fecha_nacimiento DATE NOT NULL,
    fecha_contrato DATE NOT NULL,
    sueldo NUMBER(8) NOT NULL,
    comision NUMBER(4, 2) NOT NULL,
    zona_id NUMBER REFERENCES zonas(id_zona),
    categoria_id NUMBER REFERENCES categorias(id_categoria) NOT NULL
);

CREATE TABLE FACTURAS(
    id_factura NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cliente_id REFERENCES CLIENTES(id_cliente) NOT NULL,
    vendedor_id REFERENCES VENDEDORES(id_vendedor) NOT NULL,
    fecha_factura DATE DEFAULT SYSDATE NOT NULL
);

CREATE TABLE DETALLE_FACTURA(
    id_detalle_factura NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    factura_id REFERENCES FACTURAS(id_factura) NOT NULL,
    articulos_id REFERENCES ARTICULOS(id_articulo) NOT NULL,
    cantidad NUMBER(4) NOT NULL
);