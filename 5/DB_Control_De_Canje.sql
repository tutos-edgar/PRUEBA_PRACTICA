CREATE DATABASE CONTROL_DE_CANJE
GO
USE CONTROL_DE_CANJE
GO
CREATE TABLE TIPO(
    ID_TIPO INT IDENTITY PRIMARY KEY,
    NOMBRE VARCHAR(200) NOT NULL,
)

CREATE TABLE SUB_TIPO(
    ID_SUB_TIPO INT IDENTITY PRIMARY KEY,
    NOMBRE VARCHAR(200) NOT NULL,
)

CREATE TABLE ARTICULOS(
    ID_ARTICULO INT IDENTITY PRIMARY KEY,
    ID_TIPO INT NOT NULL,
    ID_SUB_TIPO INT NOT NULL,
    CODIGO INT NOT NULL,
    NOMBRE VARCHAR(200) NOT NULL,
    FOREIGN KEY (ID_TIPO) REFERENCES TIPO(ID_TIPO),
    FOREIGN KEY (ID_SUB_TIPO) REFERENCES SUB_TIPO(ID_SUB_TIPO)
)

CREATE TABLE PRECIOS(
    ID_PRECIO INT IDENTITY PRIMARY KEY,
    ID_ARTICULO INT,
    PRECIO DECIMAL(10,2) NOT NULL
)

CREATE TABLE PROMOCIONES(
    ID_PROMOCION INT IDENTITY PRIMARY KEY,
    FECHA_INICIA DATE NOT NULL,
    FEHCA_TERMINA DATE NOT NULL,
    COSTO_PUNTO DECIMAL(10,2) NOT NULL,
    ID_ARTICULO INT NOT NULL,
)

CREATE TABLE CANJE(
    ID_CANJE INT IDENTITY PRIMARY KEY,
    ID_ARTICULO INT NOT NULL,
    CANTIDAD INT NOT NULL,
    PRECIO DECIMAL(10,2) NOT NULL,
    ID_PROMOCION INT NOT NULL,
    OBSERVACION VARCHAR(500),
    FOREIGN KEY (ID_PROMOCION) REFERENCES PROMOCIONES(ID_PROMOCION),
    FOREIGN KEY (ID_ARTICULO) REFERENCES ARTICULOS(ID_ARTICULO)
)

CREATE TABLE SUCURSAL(
    ID_SUCURSAL INT IDENTITY PRIMARY KEY,
    NOMBRE VARCHAR(100) NOT NULL
)


CREATE TABLE INVENTARIO(
    ID_INVENTARIO INT IDENTITY PRIMARY KEY,
    ID_SUCURSAL INT NOT NULL,
    ID_ARTICULO INT NOT NULL,
    CANTIDAD INT NOT NULL,
    FOREIGN KEY (ID_ARTICULO) REFERENCES ARTICULOS(ID_ARTICULO)
    FOREIGN KEY (ID_SUCURSAL) REFERENCES SUCURSAL(ID_SUCURSAL)
)



