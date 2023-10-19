CREATE DATABASE PRUEBA_PROMERICA;
GO
USE PRUEBA_PROMERICA;
GO

CREATE TABLE TIPO_INFORMACION(
    COD_TIPO_INFORMACION INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
    NOMBRE VARCHAR(200) NOT NULL
);


CREATE TABLE TIPO(
    COD_TIPO INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
    NOMBRE VARCHAR(200) NOT NULL
);

CREATE TABLE FORMATO_MENSAJE(
    COD_FORMATO INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
    COD_TIPO INTEGER NOT NULL,
    COD_TIPO_INFORMACION INTEGER NOT NULL,
    NOMBRE VARCHAR(200) NOT NULL,
    REMITENTE VARCHAR(200) NOT NULL,
    ASUNTO VARCHAR(500) NOT NULL,
    FOREIGN KEY (COD_TIPO) REFERENCES TIPO(COD_TIPO),
    FOREIGN KEY (COD_TIPO_INFORMACION) REFERENCES TIPO_INFORMACION(COD_TIPO_INFORMACION)
);


CREATE TABLE PROYECTO(
    PROYECTO INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
    NOMBRE VARCHAR(200) NOT NULL
);


CREATE TABLE PRODUCTO(
    PRODUCTO INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
    DESCRIPCION VARCHAR(200) NOT NULL
);

CREATE TABLE PRODUCTO_PROYECTO(
    COD_TIPO_INFORMACION INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
    PROYECTO INTEGER NOT NULL,
    PRODUCTO INTEGER NOT NULL,
    FOREIGN KEY(PROYECTO) REFERENCES PROYECTO(PROYECTO),
    FOREIGN KEY(PROYECTO) REFERENCES PRODUCTO(PRODUCTO)
);


CREATE TABLE MENSAJE(
    COD_MENSAJE INTEGER PRIMARY KEY IDENTITY(1,1) NOT NULL,
    COD_FORMATO INTEGER NOT NULL,
    PROYECTO INTEGER NOT NULL,
    PRODUCTO INTEGER NOT NULL,
    FOREIGN KEY (COD_FORMATO) REFERENCES FORMATO_MENSAJE(COD_FORMATO),
    FOREIGN KEY (PROYECTO) REFERENCES PROYECTO(PROYECTO),
    FOREIGN KEY (PRODUCTO) REFERENCES PRODUCTO(PRODUCTO)
    -- CONSTRAINT PRODUCTO_PROYECTO FOREIGN KEY (PROYECTO) REFERENCES PRODUCTO_PROYECTO(PROYECTO),
    -- CONSTRAINT PRODUCTO_PROYECTO FOREIGN KEY (PRODUCTO) REFERENCES PRODUCTO_PROYECTO(PRODUCTO)
);


--INSERCION DE DATOS
BEGIN
INSERT INTO PROYECTO(NOMBRE) VALUES('Premia');
INSERT INTO PROYECTO(NOMBRE) VALUES('Konmi');
INSERT INTO PROYECTO(NOMBRE) VALUES('Yujule');

INSERT INTO PRODUCTO(DESCRIPCION) VALUES('Premia Clásica');
INSERT INTO PRODUCTO(DESCRIPCION) VALUES('Premia Oro');
INSERT INTO PRODUCTO(DESCRIPCION) VALUES('Premia Platinum');

INSERT INTO TIPO(NOMBRE) VALUES('Texto');
INSERT INTO TIPO(NOMBRE) VALUES('Mail');
INSERT INTO TIPO(NOMBRE) VALUES('Estado_Cuenta');

INSERT INTO TIPO_INFORMACION(NOMBRE) VALUES('Bienvenida');
INSERT INTO TIPO_INFORMACION(NOMBRE) VALUES('Mora');
INSERT INTO TIPO_INFORMACION(NOMBRE) VALUES('Promoción');

INSERT INTO FORMATO_MENSAJE(COD_TIPO, COD_TIPO_INFORMACION, NOMBRE, REMITENTE, ASUNTO) VALUES(1, 1, 'EDGAR', 'DOUGLAS', 'BIENVENIDO');
INSERT INTO FORMATO_MENSAJE(COD_TIPO, COD_TIPO_INFORMACION, NOMBRE, REMITENTE, ASUNTO) VALUES(2, 2, 'RONALD', 'MELGAR', 'BIENVENIDO');
INSERT INTO FORMATO_MENSAJE(COD_TIPO, COD_TIPO_INFORMACION, NOMBRE, REMITENTE, ASUNTO) VALUES(3, 2, 'NUEVO', 'SABADO', 'BIENVENIDO');
INSERT INTO FORMATO_MENSAJE(COD_TIPO, COD_TIPO_INFORMACION, NOMBRE, REMITENTE, ASUNTO) VALUES(1, 3, 'EDGAR', 'NEW', 'BIENVENIDO');
INSERT INTO FORMATO_MENSAJE(COD_TIPO, COD_TIPO_INFORMACION, NOMBRE, REMITENTE, ASUNTO) VALUES(1, 3, 'JORGE', 'RUIZ', 'BIENVENIDO');
INSERT INTO FORMATO_MENSAJE(COD_TIPO, COD_TIPO_INFORMACION, NOMBRE, REMITENTE, ASUNTO) VALUES(2, 1, 'JONATAN', 'RAMIREZ', 'BIENVENIDO');
INSERT INTO FORMATO_MENSAJE(COD_TIPO, COD_TIPO_INFORMACION, NOMBRE, REMITENTE, ASUNTO) VALUES(3, 2, 'DUEÑA', 'DOUGLAS', 'BIENVENIDO');


INSERT INTO MENSAJE(COD_FORMATO, PROYECTO, PRODUCTO) VALUES(1, 2, 3);
INSERT INTO MENSAJE(COD_FORMATO, PROYECTO, PRODUCTO) VALUES(1, 1, 1);
INSERT INTO MENSAJE(COD_FORMATO, PROYECTO, PRODUCTO) VALUES(1, 3, 2);
INSERT INTO MENSAJE(COD_FORMATO, PROYECTO, PRODUCTO) VALUES(1, 2, 3);

INSERT INTO PRODUCTO_PROYECTO(PROYECTO, PRODUCTO) VALUES(2, 3);
INSERT INTO PRODUCTO_PROYECTO( PROYECTO, PRODUCTO) VALUES(1, 1);
INSERT INTO PRODUCTO_PROYECTO( PROYECTO, PRODUCTO) VALUES(3, 2);
INSERT INTO PRODUCTO_PROYECTO( PROYECTO, PRODUCTO) VALUES(2, 1);
INSERT INTO PRODUCTO_PROYECTO( PROYECTO, PRODUCTO) VALUES(3, 1);
INSERT INTO PRODUCTO_PROYECTO( PROYECTO, PRODUCTO) VALUES(2, 3);

END;

-- FORMATO_MENSAJE: son los formatos de los mensajes existentes.
-- MENSAJE: si el mensaje aplica a que proyecto y que producto


-- INSISO  A
-- A.	Escriba la consulta en SQL que devuelva el nombre del proyecto 
-- y sus productos correspondientes del proyecto premia cuyo código es 1
SELECT PY.NOMBRE, PD.DESCRIPCION FROM PRODUCTO_PROYECTO AS PP
INNER JOIN PRODUCTO AS PD
ON PD.PRODUCTO = PP.PRODUCTO
INNER JOIN PROYECTO AS PY
ON PY.PROYECTO = PP.PROYECTO
WHERE PY.NOMBRE = 'Premia'

-- INSISO  B
-- B.	Escriba una consulta SQL que devuelva los distintos mensajes que hay, 
-- indicando a qué proyecto y producto pertenecen.
SELECT FM.NOMBRE, FM.REMITENTE, FM.ASUNTO, PY.NOMBRE AS PROYECTO, PD.DESCRIPCION AS PRODUCTO 
FROM FORMATO_MENSAJE AS FM
INNER JOIN MENSAJE AS MS
ON FM.COD_FORMATO = MS.COD_FORMATO
INNER JOIN PRODUCTO AS PD
ON MS.PRODUCTO = PD.PRODUCTO
INNER JOIN PROYECTO AS PY
ON MS.PROYECTO = PY.PROYECTO


-- C.	Escriba una consulta SQL que devuelva los distintos mensajes que hay, 
-- indicando a qué proyecto y producto pertenecen. Pero si el mensaje está en 
-- todos los productos de un proyecto, en lugar de mostrar cada producto, 
-- debe mostrar el nombre del proyecto y un solo producto que diga “TODOS”.

SELECT PRD.PROYECTO, PRD.Resulatados AS PRODUCTO
FROM(
SELECT  
d.NOMBRE AS PROYECTO,
c.DESCRIPCION AS producto,
CASE
WHEN  x.resultado is not null THEN 'TODOS'
ELSE ''
    END AS Resulatados
 FROM formato_mensaje a
INNER JOIN mensaje b ON a.cod_formato = b.COD_FORMATO
INNER JOIN producto c ON c.PRODUCTO = b.PRODUCTO
INNER JOIN proyecto d ON d.PROYECTO = b.PROYECTO
left JOIN (SELECT  d.NOMBRE ,COUNT(1) AS resultado
 FROM formato_mensaje a
INNER JOIN mensaje b ON a.cod_formato = b.COD_FORMATO
INNER JOIN producto c ON c.PRODUCTO = b.PRODUCTO
INNER JOIN proyecto d ON d.PROYECTO = b.PROYECTO
GROUP BY d.NOMBRE
having COUNT(1) >= (SELECT COUNT(1) FROM producto)
) AS X
ON x.nombre = d.nombre
GROUP BY D.NOMBRE, C.DESCRIPCION, X.resultado
--ORDER BY d.NOMBRE
)PRD
GROUP BY PRD.PROYECTO, PRD.Resulatados









