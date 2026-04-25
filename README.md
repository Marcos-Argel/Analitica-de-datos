🎬 The Ghost in the Machine

📊 Proyecto de Analítica de Datos


“Los datos cuentan historias que las palabras no pueden.”


Proyecto académico enfocado en el análisis de datos del mundo cinematográfico 🎥.
Permite gestionar, consultar y analizar información sobre películas, géneros, países, actores, directores, productoras, valoraciones y premios, todo a través de una base de datos relacional optimizada.


👥 Integrantes

🧑‍💻 Jhover Inchapie Santos Hernandez

🧑‍💻 Marcos Daniel Argel Avila

🧑‍💻 Jhon Kennedy Usuga

🛠️ Tecnologías utilizadas

🐍 Python 3.11

🗄️ MySQL 8.0

🧰 MySQL Workbench / DBeaver

🐼 pandas

🔌 mysql-connector-python

🌐 Git & GitHub

📁 Estructura del proyecto

Proyecto-Analitica/

├── 🐍 Conexion.py            # Script principal de conexión y consultas

├── 🗄️ peliculas_db.sql       # Esquema completo de la base de datos

├── 🌍 paises.csv             # Datos de países (676 registros)

├── 🎭 generos.csv            # Datos de géneros (820.000 registros) ⚠️

└── 📊 Template_llenado.xlsx  # Documentación del proyecto

🗄️ Base de datos


La base de datos peliculas_db está diseñada con múltiples tablas interrelacionadas:



🎬 pelicula — Información principal (título, año, presupuesto, taquilla)

🎭 genero — Categorías cinematográficas (820.000 registros)

🌍 pais — Países con código ISO (676 registros)

🧑 persona — Actores, directores y equipo técnico

🏢 productora — Empresas productoras

🎪 reparto — Relación entre películas y personas

⭐ valoracion — Puntuaciones de usuarios

🏆 premio — Premios y nominaciones

📋 lista — Listas personalizadas de usuarios

🚀 Instalación y uso

1️⃣ Clonar el repositorio

git clone https://github.com/Marcos-Argel/Analitica-de-datos.git

cd Analitica-de-datos

2️⃣ Instalar dependencias

pip install mysql-connector-python pandas


3️⃣ Crear la base de datos



Abre MySQL Workbench o DBeaver y ejecuta:


peliculas_db.sql

4️⃣ Cargar los archivos CSV

LOAD DATA INFILE 'generos.csv'

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

5️⃣ Configurar la conexión

Editar en Conexion.py:

CONFIG = {
    "host":     "localhost",
    "port":     3306,
    "database": "peliculas_db",
    "user":     "root",
    "password": "tu_password",
}

6️⃣ Ejecutar el proyecto

python Conexion.py

📊 Consultas analíticas disponibles

📋 contar_registros() → Conteo de registros por tabla

🎭 peliculas_por_genero() → Ranking de géneros con más películas

💰 top_peliculas_taquilla() → Top 10 por recaudación

⭐ valoracion_promedio() → Películas mejor valoradas

🌍 peliculas_por_pais() → Producción cinematográfica por país

⚠️ Nota importante



El archivo generos.csv pesa aproximadamente 110 MB, lo que supera el límite de GitHub (100 MB).

Por esta razón, no está incluido en el repositorio.


👉 Debe cargarse manualmente en MySQL usando LOAD DATA INFILE.


🎓 Licencia

Proyecto académico — 2026
