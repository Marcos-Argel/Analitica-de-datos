CREATE DATABASE PELICULA;
USE PELICULA;
CREATE TABLE franquicia (
    id          SERIAL PRIMARY KEY,
    nombre      VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE genero (
    id          SERIAL PRIMARY KEY,
    nombre      VARCHAR(80)  NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE pais (
    id          SERIAL PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL UNIQUE,
    codigo_iso  CHAR(2)      NOT NULL UNIQUE
);

CREATE TABLE idioma (
    id          SERIAL PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL UNIQUE,
    codigo      VARCHAR(10)  NOT NULL UNIQUE
);

-- ------------------------------------------------------------
-- 2. PRODUCTORA
-- ------------------------------------------------------------

CREATE TABLE productora (
    id               SERIAL PRIMARY KEY,
    nombre           VARCHAR(150) NOT NULL,
    pais_id          INT          REFERENCES pais(id) ON DELETE SET NULL,
    anio_fundacion   SMALLINT,
    sitio_web        VARCHAR(255)
);

-- ------------------------------------------------------------
-- 3. PERSONA  (actores, directores, guionistas, etc.)
-- ------------------------------------------------------------

CREATE TABLE persona (
    id                  SERIAL PRIMARY KEY,
    nombre              VARCHAR(150) NOT NULL,
    fecha_nacimiento    DATE,
    fecha_fallecimiento DATE,
    nacionalidad        VARCHAR(100),
    biografia           TEXT
);

-- ------------------------------------------------------------
-- 4. PELÍCULA  (tabla central)
-- ------------------------------------------------------------

CREATE TABLE pelicula (
    id               SERIAL PRIMARY KEY,
    titulo           VARCHAR(255)   NOT NULL,
    titulo_original  VARCHAR(255),
    anio             SMALLINT       NOT NULL CHECK (anio BETWEEN 1888 AND 2100),
    duracion_min     SMALLINT       CHECK (duracion_min > 0),
    sinopsis         TEXT,
    presupuesto      NUMERIC(15,2),
    taquilla         NUMERIC(15,2),
    clasificacion    VARCHAR(10),
    poster_url       VARCHAR(500),
    franquicia_id    INT            REFERENCES franquicia(id) ON DELETE SET NULL,
    created_at       TIMESTAMP      NOT NULL DEFAULT NOW()
);

-- ------------------------------------------------------------
-- 5. TABLAS DE UNIÓN  (relaciones muchos a muchos)
-- ------------------------------------------------------------

-- Película ↔ Género
CREATE TABLE pelicula_genero (
    pelicula_id  INT NOT NULL REFERENCES pelicula(id)  ON DELETE CASCADE,
    genero_id    INT NOT NULL REFERENCES genero(id)    ON DELETE CASCADE,
    PRIMARY KEY (pelicula_id, genero_id)
);

-- Película ↔ País de producción
CREATE TABLE pelicula_pais (
    pelicula_id  INT NOT NULL REFERENCES pelicula(id)  ON DELETE CASCADE,
    pais_id      INT NOT NULL REFERENCES pais(id)      ON DELETE CASCADE,
    PRIMARY KEY (pelicula_id, pais_id)
);

-- Película ↔ Idioma  (original, doblaje, subtítulos)
CREATE TABLE pelicula_idioma (
    pelicula_id  INT         NOT NULL REFERENCES pelicula(id)  ON DELETE CASCADE,
    idioma_id    INT         NOT NULL REFERENCES idioma(id)    ON DELETE CASCADE,
    tipo         VARCHAR(20) NOT NULL CHECK (tipo IN ('original','doblaje','subtitulos')),
    PRIMARY KEY (pelicula_id, idioma_id, tipo)
);

-- Película ↔ Productora
CREATE TABLE pelicula_productora (
    pelicula_id    INT NOT NULL REFERENCES pelicula(id)    ON DELETE CASCADE,
    productora_id  INT NOT NULL REFERENCES productora(id)  ON DELETE CASCADE,
    PRIMARY KEY (pelicula_id, productora_id)
);

-- ------------------------------------------------------------
-- 6. REPARTO Y EQUIPO TÉCNICO
-- ------------------------------------------------------------

CREATE TABLE reparto (
    id           SERIAL PRIMARY KEY,
    pelicula_id  INT         NOT NULL REFERENCES pelicula(id) ON DELETE CASCADE,
    persona_id   INT         NOT NULL REFERENCES persona(id)  ON DELETE CASCADE,
    personaje    VARCHAR(150),
    rol          VARCHAR(80) NOT NULL,
    orden        SMALLINT,
    UNIQUE (pelicula_id, persona_id, rol)
);

-- ------------------------------------------------------------
-- 7. MULTIMEDIA
-- ------------------------------------------------------------

CREATE TABLE imagen (
    id           SERIAL PRIMARY KEY,
    pelicula_id  INT          NOT NULL REFERENCES pelicula(id) ON DELETE CASCADE,
    url          VARCHAR(500) NOT NULL,
    tipo         VARCHAR(20)  NOT NULL CHECK (tipo IN ('poster','backdrop','still')),
    idioma_id    INT          REFERENCES idioma(id) ON DELETE SET NULL,
    resolucion   VARCHAR(20)
);

CREATE TABLE trailer (
    id           SERIAL PRIMARY KEY,
    pelicula_id  INT          NOT NULL REFERENCES pelicula(id) ON DELETE CASCADE,
    url          VARCHAR(500) NOT NULL,
    tipo         VARCHAR(30)  NOT NULL CHECK (tipo IN ('teaser','trailer','clip','featurette')),
    idioma_id    INT          REFERENCES idioma(id) ON DELETE SET NULL,
    duracion_seg INT
);

-- ------------------------------------------------------------
-- 8. PREMIOS
-- ------------------------------------------------------------

CREATE TABLE premio (
    id             SERIAL PRIMARY KEY,
    pelicula_id    INT          REFERENCES pelicula(id) ON DELETE SET NULL,
    persona_id     INT          REFERENCES persona(id)  ON DELETE SET NULL,
    nombre_premio  VARCHAR(150) NOT NULL,
    categoria      VARCHAR(150) NOT NULL,
    anio           SMALLINT     NOT NULL,
    ganador        BOOLEAN      NOT NULL DEFAULT FALSE
);

-- ------------------------------------------------------------
-- 9. USUARIOS Y PLATAFORMA
-- ------------------------------------------------------------

CREATE TABLE usuario (
    id            SERIAL PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    email         VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    avatar_url    VARCHAR(500),
    created_at    TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE valoracion (
    id           SERIAL PRIMARY KEY,
    usuario_id   INT          NOT NULL REFERENCES usuario(id)  ON DELETE CASCADE,
    pelicula_id  INT          NOT NULL REFERENCES pelicula(id) ON DELETE CASCADE,
    puntuacion   NUMERIC(3,1) NOT NULL CHECK (puntuacion BETWEEN 0 AND 10),
    comentario   TEXT,
    fecha        TIMESTAMP    NOT NULL DEFAULT NOW(),
    UNIQUE (usuario_id, pelicula_id)
);

CREATE TABLE lista (
    id           SERIAL PRIMARY KEY,
    usuario_id   INT          NOT NULL REFERENCES usuario(id) ON DELETE CASCADE,
    nombre       VARCHAR(150) NOT NULL,
    tipo         VARCHAR(20)  NOT NULL CHECK (tipo IN ('watchlist','favoritos','vistas','personalizada')),
    publica      BOOLEAN      NOT NULL DEFAULT FALSE,
    created_at   TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE lista_pelicula (
    lista_id     INT       NOT NULL REFERENCES lista(id)    ON DELETE CASCADE,
    pelicula_id  INT       NOT NULL REFERENCES pelicula(id) ON DELETE CASCADE,
    added_at     TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (lista_id, pelicula_id)
);

-- ------------------------------------------------------------
-- 10. ÍNDICES DE RENDIMIENTO
-- ------------------------------------------------------------

CREATE INDEX idx_pelicula_titulo      ON pelicula   (titulo);
CREATE INDEX idx_pelicula_anio        ON pelicula   (anio);
CREATE INDEX idx_pelicula_franquicia  ON pelicula   (franquicia_id);
CREATE INDEX idx_reparto_persona      ON reparto    (persona_id);
CREATE INDEX idx_reparto_pelicula     ON reparto    (pelicula_id);
CREATE INDEX idx_valoracion_pelicula  ON valoracion (pelicula_id);
CREATE INDEX idx_lista_usuario        ON lista      (usuario_id);
CREATE INDEX idx_premio_anio          ON premio     (anio);
CREATE INDEX idx_premio_pelicula      ON premio     (pelicula_id);
