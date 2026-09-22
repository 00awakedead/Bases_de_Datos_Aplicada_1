DROP TABLE CANCION;

CREATE TABLE CANCION(
  id_cancion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  titulo VARCHAR2(200),
  artista VARCHAR2(100),
  album VARCHAR2(200),
  genero VARCHAR2(100),
  duracion_segundos NUMBER,
  fecha_lanzamiento DATE
);

INSERT INTO CANCION(titulo, artista, album, genero, DURACION_SEGUNDOS, FECHA_LANZAMIENTO)
VALUES ('Dont Cry','Guns and Rose', 'Use you illusions','Rock', 200, DATE '1991-09-17');

INSERT INTO CANCION(titulo, artista, album, genero, DURACION_SEGUNDOS, FECHA_LANZAMIENTO)
VALUES ('November Rain','Guns and Rose', 'Use you illusions','Rock', 240, DATE '1991-09-17');

INSERT INTO CANCION(titulo, artista, album, genero, DURACION_SEGUNDOS, FECHA_LANZAMIENTO)
VALUES ('Strainch','Guns and Rose', 'Use you illusions','Rock', 220, DATE '1991-09-17');

COMMIT;

DELETE FROM CANCION WHERE ID_CANCION = 1;

COMMIT;

SELECT * FROM CANCION;

INSERT INTO CANCION (titulo, artista, album, genero, DURACION_SEGUNDOS, FECHA_LANZAMIENTO)
VALUES (NULL, 'Bad bunny', 'YHLQMDLG', 'Reggaeton', 206, DATE '2020-02-29');

COMMIT;

INSERT INTO CANCION (titulo, artista, album, genero, DURACION_SEGUNDOS, FECHA_LANZAMIENTO)
VALUES ('MIA', 'Bad bunny', 'YHLQMDLG', 'Reggaeton', 206, DATE '2020-02-29');