CREATE TABLE FOTO(
    id_foto NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    url_imagen VARCHAR2(500),
    tipo_imagen VARCHAR2(130),
    fecha_creacion TIMESTAMP
);

CREATE TABLE REEL(
    id_reel NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    duracion_segundos NUMBER,
    fecha_reel TIMESTAMP
);

CREATE TABLE HISTORIA(
    id_historia NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    duracion_segundos NUMBER

);

CREATE TABLE USUARIO(
    id_usuario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR2(30) NOT NULL UNIQUE,
    nombre_completo VARCHAR2(50),
    biografia VARCHAR2(150),
    esta_privada CHAR(1) NOT NULL CHECK(esta_privada),
    fecha_creacion DATE
);

CREATE TABLE PUBLICACION(
    id_publicacion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_foto NUMBER REFERENCES FOTO(id_foto),
    id_reel NUMBER REFERENCES REEL(id_reel),
    id_historia NUMBER REFERENCES HISTORIA(id_historia),
    id_comentario NUMBER REFERENCES COMENTARIO(id_comentario),
    id_megusta NUMBER REFERENCES MEGUSTA(id_megusta),
    texto VARCHAR2(2200),
    fecha_publicacion TIMESTAMP
);

CREATE TABLE COMENTARIO(
    id_comentario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER REFERENCES USUARIO(id_usuario),
    id_publicacion NUMBER REFERENCES USUARIO(id_publicacion),
    comentario VARCHAR2(150),
    fecha_comentario TIMESTAMP
);

CREATE TABLE MEGUSTA(
    id_megusta NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER REFERENCES USUARIO(id_usuario),
    id_publicacion NUMBER REFERENCES PUBLICACION(id_publicacion),
    fecha_megusta DATE
);

CREATE TABLE GUARDADO(
    id_guardado NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_publicacion NUMBER REFERENCES PUBLICACION(id_publicacion),
    id_usuario NUMBER REFERENCES USUARIO(id_usuario),
    fecha_guardado TIMESTAMP
);

CREATE TABLE ENVIVO(
    id_envivo NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER REFERENCES USUARIO(id_usuario),
    titulo VARCHAR2(70),
    duracion_segundos NUMBER,
    programar_fecha_video TIMESTAMP
);

CREATE TABLE CHAT_USUARIO(
    id_chat_usuario NUMBER GENERATED ALWAYS IDENTITY PRIMARY KEY
);

CREATE TABLE GRUPO_CHAT(
    id_grupo_chat NUMBER GENERATED ALWAYS IDENTITY PRIMARY KEY
);