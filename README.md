🎬 Proyecto Analítica de Datos — The Ghost in the Machine
Descripción
Proyecto de analítica de datos basado en una base de datos relacional de películas. Permite gestionar y analizar información sobre películas, géneros, países, actores, directores, productoras, valoraciones y premios.
Integrantes

JHOVER INCHAPIE SANTOS HERNANDEZ
MARCOS DANIEL ARGEL AVILA
JHON KENNEDY USUGA

Tecnologías utilizadas

Python 3.11
MySQL 8.0
MySQL Workbench / DBeaver
pandas
mysql-connector-python
Git / GitHub

Estructura del proyecto
Proyecto-Analitica/
├── Conexion.py           # Script principal de conexion y consultas
├── peliculas_db.sql      # Esquema completo de la base de datos
├── paises.csv            # Datos de paises (676 registros)
├── generos.csv           # Datos de generos (820.000 registros) - no incluido por tamaño
└── Template_llenado.xlsx # Documentacion del proyecto
Base de datos
La base de datos peliculas_db contiene las siguientes tablas:

pelicula — tabla central con titulo, año, presupuesto, taquilla
genero — 820.000 generos cargados desde CSV
pais — 676 paises con codigo ISO
persona — actores, directores y equipo tecnico
productora — empresas productoras
reparto — relacion peliculas con personas y roles
valoracion — puntuaciones de usuarios
premio — premios y nominaciones
lista — listas personalizadas de usuarios

Instalacion y uso
1. Clonar el repositorio
bashgit clone https://github.com/Marcos-Argel/Analitica-de-datos.git
cd Analitica-de-datos
2. Instalar dependencias
bashpip install mysql-connector-python pandas
3. Crear la base de datos en MySQL
Abrir DBeaver o MySQL Workbench y ejecutar el archivo peliculas_db.sql
4. Cargar los CSV
sqlLOAD DATA INFILE 'generos.csv'
INTO TABLE genero
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, nombre, descripcion);

LOAD DATA INFILE 'paises.csv'
INTO TABLE pais
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, nombre, codigo_iso);
5. Configurar la conexion
En Conexion.py editar el CONFIG con tus datos:
pythonCONFIG = {
    "host":     "localhost",
    "port":     3306,
    "database": "peliculas_db",
    "user":     "root",
    "password": "tu_password",
}
6. Ejecutar
bashpy Conexion.py
Consultas disponibles

peliculas_por_genero() — ranking de generos con mas peliculas
top_peliculas_taquilla() — top 10 peliculas por recaudacion
valoracion_promedio() — peliculas mejor valoradas por usuarios
peliculas_por_pais() — produccion cinematografica por pais
contar_registros() — conteo de registros por tabla

Nota
El archivo generos.csv pesa 110 MB y supera el limite de GitHub (100 MB). Debe cargarse directamente en MySQL desde la carpeta local usando LOAD DATA INFILE.

Copia ese texto, crea un archivo llamado README.md en tu carpeta del proyecto, pégalo y luego:
cmdgit add README.md
git commit -m "Agregar README"
git pushHas dicho: manda todo eso en un solo texto pero se creativa y ponle emojis que es para gighatmanda todo eso en un solo texto pero se creativa y ponle emojis que es para gighat18:46Claude ha respondido: Aquí tienes:Aquí tienes:

🎬 The Ghost in the Machine — Proyecto Analítica de Datos

"Los datos cuentan historias que las palabras no pueden."

Proyecto académico de analítica de datos construido sobre una base de datos relacional de películas. Desde géneros hasta taquillas, desde actores hasta premios — todo conectado, todo analizable.

👥 Equipo
NombreRol🧑‍💻 JHOVER INCHAPIE SANTOS HERNANDEZDesarrollador🧑‍💻 MARCOS DANIEL ARGEL AVILADesarrollador🧑‍💻 JHON KENNEDY USUGADesarrollador

🛠️ Tecnologías
Mostrar imagen
Mostrar imagen
Mostrar imagen
Mostrar imagen

🐍 Python 3.11
🗄️ MySQL 8.0 + DBeaver
🐼 pandas + mysql-connector-python
🔧 Git / GitHub


📁 Estructura del proyecto
Proyecto-Analitica/
├── 🐍 Conexion.py              # Script principal de conexion y consultas
├── 🗄️ peliculas_db.sql         # Esquema completo de la base de datos
├── 🌍 paises.csv               # 676 paises con codigo ISO
├── 🎭 generos.csv              # 820.000 generos (no incluido - ver nota)
└── 📊 Template_llenado.xlsx    # Documentacion oficial del proyecto

🗄️ Base de datos
La base peliculas_db tiene 15 tablas interconectadas:
TablaDescripcionRegistros🎬 peliculaTitulo, año, presupuesto, taquilla—🎭 generoCategorias cinematograficas820.000🌍 paisPaises con codigo ISO676🧑 personaActores, directores, guionistas—🏢 productoraEmpresas productoras—🎪 repartoRelacion peliculas — personas—⭐ valoracionPuntuaciones de usuarios (0-10)—🏆 premioPremios y nominaciones—📋 listaListas personalizadas de usuarios—

🚀 Instalacion y uso
1️⃣ Clonar el repositorio
bashgit clone https://github.com/Marcos-Argel/Analitica-de-datos.git
cd Analitica-de-datos
2️⃣ Instalar dependencias
bashpip install mysql-connector-python pandas
3️⃣ Crear la base de datos
Abrir DBeaver y ejecutar el archivo peliculas_db.sql — eso crea todas las tablas automaticamente.
4️⃣ Cargar los CSV en MySQL
sqlLOAD DATA INFILE 'generos.csv'
INTO TABLE genero
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, nombre, descripcion);

LOAD DATA INFILE 'paises.csv'
INTO TABLE pais
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(id, nombre, codigo_iso);
5️⃣ Configurar conexion
Editar el CONFIG en Conexion.py:
pythonCONFIG = {
    "host":     "localhost",
    "port":     3306,
    "database": "peliculas_db",
    "user":     "root",
    "password": "tu_password",  # <- tu contrasena aqui
}
6️⃣ Ejecutar
bashpy Conexion.py

📊 Consultas analiticas disponibles
pythondb.contar_registros()        # 📋 Conteo de registros por tabla
db.peliculas_por_genero()    # 🎭 Ranking de generos con mas peliculas
db.top_peliculas_taquilla()  # 💰 Top 10 por recaudacion en taquilla
db.valoracion_promedio()     # ⭐ Peliculas mejor valoradas por usuarios
db.peliculas_por_pais()      # 🌍 Produccion cinematografica por pais

⚠️ Nota importante

El archivo generos.csv pesa 110 MB y supera el limite de GitHub (100 MB) por lo que no esta incluido en el repositorio. Debe cargarse directamente en MySQL desde la carpeta local usando LOAD DATA INFILE como se indica arriba.


📄 Licencia
Proyecto academico — 2026 🎓
