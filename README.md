# 🎬 THE GHOST IN THE MACHINE
### Proyecto de Analítica de Datos — Base de Datos de Películas

> **Integrantes:** Jhover Inchapie · Marcos Argel · Jhon Usuga  
> **Repositorio:** [github.com/Marcos-Argel/Analitica-de-datos](https://github.com/Marcos-Argel/Analitica-de-datos)

---

## 📌 ¿De qué trata este proyecto?

Este proyecto construye una base de datos relacional de películas desde cero, conectada con Python para análisis de datos. La idea es poder consultar, cruzar y visualizar información sobre películas, géneros, países, personas, valoraciones y más, usando SQL + pandas.

---

## 🗂️ Estructura del proyecto

```
Proyecto-Analitica/
│
├── Conexion.py               # Clase principal de conexión y consultas
├── peliculas_db.sql          # Script SQL con toda la estructura de la BD
├── generos.csv               # Datos de géneros cinematográficos
├── paises.csv                # Datos de países con código ISO
├── Template_llenado.xlsx     # Plantilla de datos para poblar la BD
├── primer documento entregable.docx  # Documento académico del proyecto
└── README.md                 # Este archivo
```

---

## 🗃️ Base de datos — Modelo relacional

La base de datos `PELICULA` fue diseñada con un modelo relacional normalizado. Estas son sus tablas principales:

| Tabla | Descripción |
|---|---|
| `pelicula` | Tabla central: título, año, duración, sinopsis, presupuesto, taquilla |
| `genero` | Géneros cinematográficos con descripción |
| `pais` | Países de producción con código ISO |
| `idioma` | Idiomas originales y de doblaje |
| `persona` | Actores, directores y guionistas |
| `productora` | Casas productoras con país y año de fundación |
| `franquicia` | Sagas o franquicias cinematográficas |
| `reparto` | Relación película ↔ persona con rol y personaje |
| `valoracion` | Puntuaciones de usuarios por película |
| `premio` | Premios y nominaciones por película o persona |
| `imagen` | Posters y backdrops |
| `trailer` | Teasers, trailers y clips |
| `pelicula_genero` | Relación muchos a muchos: película ↔ género |
| `pelicula_pais` | Relación muchos a muchos: película ↔ país |
| `pelicula_idioma` | Relación muchos a muchos: película ↔ idioma |
| `pelicula_productora` | Relación muchos a muchos: película ↔ productora |

---

## 🐍 Conexion.py — ¿Qué hace?

La clase `Conexion` centraliza toda la comunicación entre Python y MySQL. Soporta uso con `with` (context manager) para cerrar conexiones automáticamente.

```python
# Uso básico
with Conexion() as db:
    db.contar_registros()
    df = db.top_peliculas_taquilla(10)
    print(df)
```

### Métodos disponibles

| Método | Qué hace |
|---|---|
| `conectar()` | Abre la conexión a MySQL |
| `desconectar()` | Cierra el cursor y la conexión |
| `ejecutar(sql)` | Ejecuta un SELECT y retorna lista de dicts |
| `ejecutar_escritura(sql)` | INSERT / UPDATE / DELETE con commit y rollback |
| `cargar_csv(path, tabla, columnas)` | Carga un CSV directo a una tabla |
| `peliculas_por_genero()` | Top 20 géneros con más películas |
| `top_peliculas_taquilla(n)` | Top N por taquilla con ganancia calculada |
| `valoracion_promedio()` | Películas mejor valoradas (mín. 5 reseñas) |
| `peliculas_por_pais()` | Top 20 países productores |
| `contar_registros()` | Conteo de filas por cada tabla |

---

## ⚙️ Instalación y configuración

### 1. Requisitos previos
- Python 3.x
- MySQL Server 8.0+
- Git

### 2. Clonar el repositorio

```bash
git clone https://github.com/Marcos-Argel/Analitica-de-datos.git
cd Analitica-de-datos
```

### 3. Instalar dependencias de Python

```bash
py -m pip install pandas mysql-connector-python python-dotenv
```

### 4. Crear la base de datos

Abre MySQL y ejecuta:

```bash
mysql -u root -p < peliculas_db.sql
```

O manualmente en MySQL Workbench:
```sql
SOURCE peliculas_db.sql;
```

### 5. Configurar credenciales

Crea un archivo `.env` en la raíz del proyecto:

```
DB_HOST=localhost
DB_PORT=3306
DB_NAME=PELICULA
DB_USER=root
DB_PASSWORD=tu_contraseña
```

> ⚠️ El archivo `.env` está en `.gitignore` y **nunca debe subirse a GitHub**.

### 6. Cargar los datos CSV

```python
with Conexion() as db:
    db.cargar_csv("generos.csv", "genero", ["id", "nombre", "descripcion"])
    db.cargar_csv("paises.csv", "pais", ["id", "nombre", "codigo_iso"])
```

### 7. Probar la conexión

```bash
py Conexion.py
```

Deberías ver:
```
Conexion exitosa - MySQL Server v8.x.x
Base de datos: PELICULA
--- Registros por tabla ---
genero: 250
pais: 195
pelicula: 0
...
```

---

## 📊 Consultas analíticas disponibles

```python
with Conexion() as db:

    # ¿Cuántos registros hay en cada tabla?
    db.contar_registros()

    # Top 10 películas más taquilleras
    df = db.top_peliculas_taquilla(10)

    # Géneros con más películas
    df = db.peliculas_por_genero()

    # Películas mejor valoradas por usuarios
    df = db.valoracion_promedio()

    # Países que más producen películas
    df = db.peliculas_por_pais()
```

---

## 🛠️ Tecnologías usadas

| Tecnología | Uso |
|---|---|
| **Python 3.14** | Lenguaje principal |
| **MySQL 8.0** | Motor de base de datos |
| **pandas** | Manipulación y análisis de datos |
| **mysql-connector-python** | Conexión Python ↔ MySQL |
| **python-dotenv** | Gestión segura de credenciales |
| **MySQL Workbench** | Administración visual de la BD |
| **Git + GitHub** | Control de versiones |

---

## 🚧 Estado actual del proyecto

- [x] Diseño del modelo relacional
- [x] Script SQL de creación de tablas (`peliculas_db.sql`)
- [x] Clase de conexión Python ↔ MySQL (`Conexion.py`)
- [x] Carga de datos: géneros y países desde CSV
- [x] Consultas analíticas base
- [ ] Carga completa de películas, personas y valoraciones
- [ ] Visualizaciones con matplotlib / seaborn
- [ ] Dashboard de análisis

---

## 👥 Equipo

| Nombre | GitHub |
|---|---|
| Jhover Inchapie | — |
| Marcos Argel | [@Marcos-Argel](https://github.com/Marcos-Argel) |
| Jhon Usuga | — |
