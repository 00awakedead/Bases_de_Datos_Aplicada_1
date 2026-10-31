--=================================--
-- SE CREAN LAS TABLAS PRINCIPALES --
--=================================--

CREATE TABLE CONSOLA (
    id_consola NUMBER(4) PRIMARY KEY,
    nombre_consola VARCHAR2(60) NOT NULL UNIQUE,
    tipo_consola VARCHAR2(20) NOT NULL CHECK (tipo_consola IN ('SOBREMESA', 'PORTATIL', 'HIBRIDA')),
    anio_lanzamiento NUMBER(4) NOT NULL CHECK (anio_lanzamiento BETWEEN 1983 AND 2030),
    precio_referencia_usd NUMBER(6,2) NOT NULL CHECK (precio_referencia_usd > 0),
    estado_fabricacion VARCHAR2(15) DEFAULT 'ACTIVA' NOT NULL CHECK (estado_fabricacion IN ('ACTIVA', 'DESCONTINUADA'))
);

CREATE TABLE FRANQUICIA (
    id_franquicia NUMBER(4) PRIMARY KEY,
    nombre_franquicia VARCHAR2(60) NOT NULL UNIQUE,
    creador_principal VARCHAR2(80),
    anio_debut NUMBER(4) NOT NULL CHECK (anio_debut >= 1980),
    estudio_principal VARCHAR2(60) DEFAULT 'NINTENDO EPD' NOT NULL
);

CREATE TABLE VIDEOJUEGO (
    id_juego NUMBER(6) PRIMARY KEY,
    codigo_catalogo VARCHAR2(10) NOT NULL UNIQUE,
    titulo VARCHAR2(100) NOT NULL,
    id_franquicia NUMBER(4) NOT NULL REFERENCES FRANQUICIA(id_franquicia),
    id_consola NUMBER(4) NOT NULL REFERENCES CONSOLA(id_consola),
    clasificacion_esrb VARCHAR2(5) NOT NULL CHECK (clasificacion_esrb IN ('E', 'E10+', 'T', 'M')),
    precio_clp NUMBER(8) NOT NULL CHECK(precio_clp >= 0),
    puntaje_metacritic NUMBER(3) CHECK (puntaje_metacritic BETWEEN 0 AND 100),
    stock_fisico NUMBER(5) DEFAULT 0 NOT NULL CHECK (stock_fisico >= 0),
    fecha_lanzamiento DATE NOT NULL
);

CREATE TABLE JUGADOR(
    id_jugador NUMBER(6) PRIMARY KEY,
    nickname VARCHAR2(30) NOT NULL UNIQUE,
    email VARCHAR2(100) NOT NULL UNIQUE,
    pais VARCHAR2(40) DEFAULT 'CHILE' NOT NULL,
    monedas_oro NUMBER(6) DEFAULT 0 NOT NULL CHECK (monedas_oro >= 0),
    suscripcion_online VARCHAR2(15) DEFAULT 'GRATUITA' NOT NULL CHECK (suscripcion_online IN ('GRATUITA', 'INDIVIDUAL', 'FAMILIAR', 'EXPANSION')),
    id_juego_favorito NUMBER(6) REFERENCES VIDEOJUEGO(id_juego)
);

CREATE TABLE ACCESORIO_PRUEBA(
    id_accesorio NUMBER(4) PRIMARY KEY,
    nombre_accesorio VARCHAR2(40) NOT NULL,
    precio_usd NUMBER(5,2) CHECK (precio_usd > 0),
    id_consola NUMBER(4) REFERENCES consola(id_consola)
);

COMMIT;

--========================================================--
-- SE MODIFICAN LAS TABLAS, AGREGANDO Y CAMBIANDO COLUMNAS--
--========================================================--

ALTER TABLE JUGADOR 
ADD fecha_registro DATE DEFAULT SYSDATE NOT NULL

ALTER TABLE JUGADOR 
ADD nivel_cuenta NUMBER(3) DEFAULT 1 NOT NULL CHECK(nivel_cuenta BETWEEN 1 AND 99)

ALTER TABLE ACCESORIO_PRUEBA
MODIFY nombre_accesorio VARCHAR2(100) 
ADD color_edicion VARCHAR2(25)

ALTER TABLE ACCESORIO_PRUEBA
DROP COLUMN color_edicion

DROP TABLE ACCESORIO_PRUEBA

ALTER TABLE VIDEOJUEGO
ADD descuento_porcentaje NUMBER(3) DEFAULT 0 NOT NULL CHECK (descuento_porcentaje BETWEEN 0 AND 80);

--=======================================--
-- SE INSERTAN DATOS EN LA TABLA CONSOLA --
--=======================================--

INSERT INTO CONSOLA (id_consola,nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion)
VALUES (1, 'Nintendo Switch', 'HIBRIDA', 2017, 299.99, 'ACTIVA');

INSERT INTO CONSOLA (id_consola, nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion)
VALUES (2, 'Nintendo Switch 2', 'HIBRIDA', 2025, 449.99, DEFAULT);

INSERT INTO CONSOLA (id_consola, nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion)
VALUES (3, 'Nintendo 3DS', 'PORTATIL', 2011, 169.99, 'DESCONTINUADA');

INSERT INTO CONSOLA (id_consola, nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion)
VALUES (4, 'Nintendo GameCube', 'SOBREMESA', 2001, 199.99, 'DESCONTINUADA');

COMMIT;

--===========================================--
--- SE INSERTAN DATOS EN LA TABLA FRANQUICIA --
--===========================================--

INSERT INTO FRANQUICIA (id_franquicia, nombre_franquicia, creador_principal, anio_debut, estudio_principal)
VALUES (1, 'Super Mario', 'Shigeru Miyamoto', 1985, DEFAULT);

INSERT INTO FRANQUICIA (id_franquicia, nombre_franquicia, creador_principal, anio_debut, estudio_principal)
VALUES (2, 'The Legend of Zelda', 'Shigeru Miyamoto', 1986, DEFAULT);

INSERT INTO FRANQUICIA (id_franquicia, nombre_franquicia, creador_principal, anio_debut, estudio_principal)
VALUES (3, 'Pokemon', 'Satoshi Tajiri', 1996, 'Game Freak');

INSERT INTO FRANQUICIA (id_franquicia, nombre_franquicia, creador_principal, anio_debut, estudio_principal)
VALUES (4, 'Metroid', 'Gunpei Yokoi', 1986, 'MercurySteam');

INSERT INTO FRANQUICIA (id_franquicia, nombre_franquicia, creador_principal, anio_debut, estudio_principal)
VALUES (5, 'Super Smash Bros', 'Masahiro Sakurai', 1999, 'Bandai Namco / Sora');

INSERT INTO FRANQUICIA (id_franquicia, nombre_franquicia, creador_principal, anio_debut, estudio_principal)
VALUES (6, 'Splatoon', NULL, 2015, DEFAULT);

COMMIT;

--===========================================--
--- SE INSERTAN DATOS EN LA TABLA VIDEOJUEGO --
--===========================================--

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (101, 'NSW-001', 'The Legend of Zelda: Breath of the Wild', 2, 1, 'E10+', 54990, 97, 45, TO_DATE('2017-03-03', 'YYYY-MM-DD'));

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (102, 'NSW-002', 'Super Mario Odyssey', 1, 1, 'E10+', 49990, 97, 60, TO_DATE('2017-10-27', 'YYYY-MM-DD'));

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (103, 'NSW-003', 'Metroid Dread', 4, 1, 'T', 44990, 88, 15, TO_DATE('2021-10-08', 'YYYY-MM-DD'));

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (104, 'NSW-004', 'Super Smash Bros. Ultimate', 5, 1, 'E10+', 59990, 93, 80, TO_DATE('2018-12-07', 'YYYY-MM-DD'));

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (105, 'NSW-005', 'Pokemon Escarlata', 3, 1, 'E', 49990, 72, 30, TO_DATE('2022-11-18', 'YYYY-MM-DD'));

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (106, 'NS2-001', 'Mario Kart World', 1, 2, 'E', 69990, NULL, DEFAULT, TO_DATE('2025-06-05', 'YYYY-MM-DD'));

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (107, '3DS-001', 'Pokemon Sol', 3, 3, 'E', 29990, 87, 5, TO_DATE('2016-11-18', 'YYYY-MM-DD'));

COMMIT;

--=======================================--
-- SE INSERTAN DATOS EN LA TABLA JUGADOR --
--=======================================--

INSERT INTO JUGADOR (id_jugador, nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES (1, 'LinkHyrule99', 'link@hyrule.cl', DEFAULT, 1200, 'EXPANSION', 101);

INSERT INTO JUGADOR (id_jugador, nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES (2, 'SamusHunter', 'samus@zebes.cl', 'Chile', 450, 'INDIVIDUAL', 103);

INSERT INTO JUGADOR (id_jugador, nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES (3, 'PikaTrainer', 'ash@kanto.pe', 'Peru', DEFAULT, DEFAULT, NULL);

INSERT INTO JUGADOR (id_jugador, nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES (4, 'MarioSpeedrun', 'mario@champinon.ar', 'Argentina', 3500, 'FAMILIAR', 102);

COMMIT;

--=================================--
-- SE PROVOCA UN FALLO (ORA-02290) --
--=================================--

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (108, 'NSW-008', 'The Legend of Zelda: Tears of the Kingdom', 2, 1, 'TODOS', 64990, 105, 50, TO_DATE('2023-05-12', 'YYYY-MM-DD'));

-- SE CORRIGE EL FALLO --

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (108, 'NSW-008', 'The Legend of Zelda: Tears of the Kingdom', 2, 1, 'E10+', 64990, 96, 50, TO_DATE('2023-05-12', 'YYYY-MM-DD'));

COMMIT;

--=============================================--
-- SE PROVOCA UN FALLO FOREIGN KEY (ORA-02291) --
--=============================================--

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (109, 'GCN-001', 'Super Smash Bros. Melee', 5, 99, 'T', 39990, 92, 0, TO_DATE('2001-11-21', 'YYYY-MM-DD'));

-- SE CORRIGE EL FALLO --

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (109, 'GCN-001', 'Super Smash Bros. Melee', 5, 4, 'T', 39990, 92, 0, TO_DATE('2001-11-21', 'YYYY-MM-DD'));

COMMIT;

--=======================================--
--SE PROVOCA UN FALLO UNIQUE (ORA-00001) --
--=======================================--

INSERT INTO JUGADOR (id_jugador, nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES (5, 'LinkHyrule99', 'zelda@hyrule.cl', 'Chile', 800, 'EXPANSION', 108);

-- SE CORRIGE EL FALLO --

INSERT INTO JUGADOR (id_jugador, nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES (5, 'ZeldaWisdom', 'zelda@hyrule.cl', 'Chile', 800, 'EXPANSION', 108);

INSERT INTO JUGADOR (id_jugador, nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES (6, 'KirbyGourmet', 'kirby@dreamland.mx', 'Mexico', 150, 'GRATUITA', NULL);

COMMIT;

--==========================================================--
-- SE INSERTA UN REGISTRO TEMPORAL PARA AUDITORIA POSTERIOR --
--==========================================================--

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (110, 'NSW-999', 'Proyecto Secreto Cancelado', 6, 1, 'T', 10000, NULL, 0, SYSDATE);

INSERT INTO JUGADOR (id_jugador, nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES (99, 'BotSpam01', 'spam@bot.com', 'Desconocido', 0, 'GRATUITA', 110);

COMMIT;

--========================================--
-- SE ACTUALIZA EL STOCK DE UN VIDEOJUEGO --
--========================================--

UPDATE VIDEOJUEGO
SET stock_fisico = 75
WHERE id_juego = 105;

COMMIT;

--========================================================--
-- SE ACTUALIZA MULTIPLE COLUMNAS EN UNA SOLA SENTENCIA --
--========================================================--

UPDATE JUGADOR
SET suscripcion_online = 'INDIVIDUAL', id_juego_favorito = 105
WHERE id_jugador = 3;

COMMIT;

--========================================================--
-- SE REMPLAZA UN VALOR NULL POR CLASIFICACION OFICIAL --
--========================================================--

UPDATE VIDEOJUEGO
SET puntaje_metacritic = 94, stock_fisico = 120
WHERE id_juego = 106;

COMMIT;

--====================================================================--
-- SE INCREMENTA LAS MONEDAS DE LOS JUGADORES QUE SEAN DEL PAIS CHILE --
--====================================================================--

UPDATE JUGADOR
SET monedas_oro = monedas_oro + 250
WHERE pais = 'CHILE';

COMMIT;

--==========================================================--
-- SE REALIZA UN DESCUENTO DEL 15 % CON CONDICION COMPUESTA --
--==========================================================--
UPDATE VIDEOJUEGO
SET precio_clp = ROUND(precio_clp * 0.85)
WHERE id_consola = 1
AND precio_clp > 50000;

COMMIT;
--==============================================--
-- SE ACTUALIZAN LOS VALORES DE LAS FRANQUICIAS --
--==============================================--

UPDATE FRANQUICIA
SET estudio_principal = 'Nintendo EPD Kyoto'
WHERE id_franquicia IN (1, 2);

COMMIT;

--===================================================================================================================--
-- SE AGREGAN 30 UNIDADES AL STOCK DE LOS VIDEOJUEGOS DE LA CONSOLA SWITCH QUE TENGAN ENTRE 1 Y 20 UNIDADES EN STOCK --
--===================================================================================================================--

UPDATE VIDEOJUEGO
SET stock_fisico = stock_fisico + 30
WHERE id_consola = 1
AND stock_fisico BETWEEN 1 AND 20;

COMMIT;

--========================================--
-- SE PONE A PRUEBA EL CHECK EN UN UPDATE --
--========================================--

UPDATE JUGADOR
SET monedas_oro = monedas_oro - 500
WHERE id_jugador = 6;

-- SE CORRIGE --

UPDATE JUGADOR
SET monedas_oro = 0
WHERE id_jugador = 6;

COMMIT;

--===================================================================================================--
-- SE PREPARA LA ELIMINACION DE UN JUEGO, ASI QUE SE DESVINCULA LA CLAVE FORANEA A CIERTOS JUGADORES --
--===================================================================================================--

UPDATE JUGADOR
SET id_juego_favorito = NULL
WHERE id_juego_favorito = 110;

COMMIT;

--================================================--
-- SE AGREGA UNA BONIFICACION A CIERTOS JUGADORES --
--================================================--

UPDATE JUGADOR
SET monedas_oro = monedas_oro + 500
WHERE (suscripcion_online = 'EXPANSION' OR suscripcion_online = 'FAMILIAR') AND id_juego_favorito IS NOT NULL;

COMMIT;

--==========================--
-- SE ELIMINA LA CUENTA BOT --
--==========================--

DELETE FROM JUGADOR
WHERE id_jugador = 99;

COMMIT;

--=========================================================--
-- SE ELIMINA EL PROYECTO CANCELADO DE LA TABLA VIDEOJUEGO --
--=========================================================--

DELETE FROM VIDEOJUEGO
WHERE codigo_catalogo = 'NSW-999';

COMMIT;

--===================================--
-- SE ELIMINA LA FRANQUICIA SPLATOON --
--===================================--

DELETE FROM FRANQUICIA
WHERE id_franquicia = 6;

COMMIT;

--=================================================--
-- SE COMPRUEBA UN BLOQUEO REFERENCIAL (ORA-02292) --
--=================================================--

DELETE FROM CONSOLA 
WHERE id_consola = 1;

--====================================================--
-- SE INSERTA UNA CONSOLA Y SE ELIMINA INMEDIATAMENTE --
--====================================================--

INSERT INTO CONSOLA (id_consola, nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion)
VALUES (5, 'Virtual Boy', 'PORTATIL', 1995, 179.99, 'DESCONTINUADA');

DELETE FROM CONSOLA 
WHERE id_consola = 5;

COMMIT;

--==================================--
-- SE HACE UNA LIMPIEZA DE CATALOGO --
--==================================--

DELETE FROM VIDEOJUEGO
WHERE id_consola = 4 AND stock_fisico = 0;

COMMIT;

--==============================--
-- SE DEPURAN CUENTAS INACTIVAS --
--==============================--

DELETE FROM JUGADOR
WHERE suscripcion_online = 'GRATUITA' AND monedas_oro = 0 AND id_juego_favorito IS NULL;

COMMIT;

--===============================--
-- SE ELIMINA VIDEOJUEGO ANTIGUO --
--===============================--

DELETE FROM VIDEOJUEGO
WHERE fecha_lanzamiento < TO_DATE('2017-01-01', 'YYYY-MM-DD') AND  stock_fisico < 10;

COMMIT;
--=====================================--
-- SE ELIMINAN CONSOLAS DESCONTINUADAS --
--=====================================--

DELETE FROM CONSOLA
WHERE estado_fabricacion = 'DESCONTINUADA' AND anio_lanzamiento < 2015;

COMMIT;

--==================================--
-- SE REALIZA UN SIMULACRO ROLLBACK --
--==================================--

COMMIT;

DELETE FROM JUGADOR;

SELECT * FROM JUGADOR;

ROLLBACK;

--===================================================================--
-- SE HACE UNA PURGA POR PATRON DE TEXTO (LIKE) Y CLASIFICACION ESRB --
--===================================================================--

INSERT INTO VIDEOJUEGO (id_juego, codigo_catalogo, titulo, id_franquicia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES (120, 'NSW-120', 'DEMO: Metroid Prime 4', 4, 1, 'M', 0, 0, 0, SYSDATE);

DELETE FROM VIDEOJUEGO
WHERE titulo LIKE 'DEMO:%' AND precio_clp = 0;

COMMIT;
--==============================================--
-- SE RENOMBRAN COLUMNAS DE LA TABLA VIDEOJUEGO --
--==============================================--

SELECT codigo_catalogo AS codigo, titulo AS nombre_videojuego, clasificacion_esrb AS esrb, precio_clp AS precio_actual FROM VIDEOJUEGO;

--================================================================--
-- SE CONSULTA CON COLUMNAS CALCULADAS Y CON CONVERSION A DOLARES --
--================================================================--

SELECT titulo, precio_clp, ROUND(precio_clp * 1.19) AS precio_con_iva, ROUND(precio_clp / 950, 2) AS precio_estimado_usd FROM VIDEOJUEGO;

--======================================--
-- SE HACE UN RANKING DE OBRAS MAESTRAS --
--======================================--

SELECT titulo, puntaje_metacritic, precio_clp FROM VIDEOJUEGO
WHERE puntaje_metacritic >= 90
ORDER BY puntaje_metacritic DESC, titulo ASC;

--===========================================--
-- SE HACE UN FILTRO FAMILIAR (IN + BETWEEN) --
--===========================================--

SELECT titulo, clasificacion_esrb, stock_fisico FROM VIDEOJUEGO
WHERE clasificacion_esrb IN ('E', 'E10+') AND stock_fisico BETWEEN 40 AND 150;

--=========================================================--
-- SE BUSCA POR SAGAS CON LIKE Y CON CONDICIONES AGRUPADAS --
--=========================================================--

SELECT codigo_catalogo, titulo, precio_clp FROM VIDEOJUEGO
WHERE (titulo LIKE '%Zelda%' OR titulo LIKE '%Mario%') AND precio_clp < 60000;

--=======================================--
-- SE HACE UN REPORTE ESTADISTICO GLOBAL --
--=======================================--

SELECT COUNT(*) AS total_juegos, 
ROUND(AVG(puntaje_metacritic), 1) AS promedio_metacritic, 
MIN(precio_clp) AS precion_minimo, 
MAX(precio_clp) AS precio_maximo,
SUM(stock_fisico) AS stock_total
FROM VIDEOJUEGO; 
--============================================--
-- SE UNE LOS VIDEOJUEGOS CON SUS FRANQUICIAS --
--============================================--

SELECT v.titulo, f.nombre_franquicia, f.creador_principal, v.precio_clp FROM VIDEOJUEGO v INNER JOIN FRANQUICIA f ON v.id_franquicia = f.id_franquicia
ORDER BY f.nombre_franquicia ASC;

--========================================================================================--
-- SE REALIZA UN INNER JOIN DE 3 TABLAS, CATALOGO COMPLETO (JUEGO + FRANQUICIA + CONSOLA) --
--========================================================================================--

SELECT v.codigo_catalogo, v.titulo, f.nombre_franquicia, c.nombre_consola, v.puntaje_metacritic 
FROM VIDEOJUEGO v INNER JOIN FRANQUICIA f 
ON v.id_franquicia = f.id_franquicia
INNER JOIN CONSOLA c 
ON v.id_consola = c.id_consola
WHERE c.nombre_consola = 'Nintendo Switch';

--===========================================================--
-- SE UNEN JUGADORES DE MY NINTENTO Y SU VIDEOJUEGO FAVORITO --
--===========================================================--

SELECT j.nickname, j.pais, j.suscripcion_online, j.monedas_oro, v.titulo FROM JUGADOR j INNER JOIN VIDEOJUEGO v ON j.id_juego_favorito = v.id_juego
ORDER BY monedas_oro DESC;

--============================================================--
-- SE HACE UN INNER JOIN + GROUP BY + FUNCIONES DE AGREGACION --
--============================================================--

SELECT f.nombre_franquicia, 
COUNT(v.id_juego) AS cantidad_juegos,
ROUND(AVG(v.puntaje_metacritic), 1) AS promedio_metacritic,
SUM(v.stock_fisico) AS stock_total
FROM FRANQUICIA f INNER JOIN VIDEOJUEGO v 
ON f.id_franquicia = v.id_franquicia 
GROUP BY f.nombre_franquicia 
ORDER BY stock_total DESC;