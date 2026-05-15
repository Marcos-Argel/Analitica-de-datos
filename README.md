# 👻 THE GHOST IN THE MACHINE
### 🎬 Base de Datos Analítica de Películas

<div align="center">

![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.11-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![pandas](https://img.shields.io/badge/pandas-2.x-150458?style=for-the-badge&logo=pandas&logoColor=white)

> *"Los datos son el nuevo petróleo... y nosotros somos los refinadores."* 🛢️

</div>

---

## 👥 Equipo de Desarrollo

| 👤 Integrante | 🎓 Rol |
|---|---|
| **Jhover Hincapie Hernandez** | Data Engineer & ETL Dev |
| **Marcos Daniel Argel Avila** | Database Architect |
| **Jhon Kennedy Usuga** | BI & Analytics |

---

## 📋 ¿De qué va esto?

Este proyecto construye una **base de datos relacional completa** del mundo del cine 🎥. Partimos de archivos CSV con datos de géneros y países, los normalizamos, limpiamos y los cargamos en MySQL mediante un pipeline ETL automatizado en Python. Luego conectamos todo a Power BI para generar dashboards y visualizaciones épicas 📊.

---

## 🗂️ Estructura del Proyecto

```
📁 Analitica-de-datos/
├── 📄 Conexion.py                  ← Pipeline ETL completo
├── 📄 peliculas_db.sql             ← Esquema SQL con 19 tablas
├── 📄 generos.csv                  ← 820,000 géneros cinematográficos
├── 📄 paises.csv                   ← 676 países del mundo
├── 📄 peliculas_db_completa.csv    ← Dataset completo (todas las tablas)
├── 📄 selects_con_datos.sql        ← SELECTs con datos reales
├── 📄 inserts_todas_tablas.sql     ← INSERTs para MySQL (10,000 películas)
├── 📄 .env                         ← 🔒 Credenciales (NO subir a Git)
├── 📄 .gitignore
└── 📄 README.md                    ← Estás aquí 👋
```

---

## 🗄️ Modelo de Base de Datos

El esquema cuenta con **19 tablas** relacionadas entre sí:

```
🎬 pelicula          ← Tabla central con 10,000 películas
🎭 persona           ← 1,000 actores, directores, etc.
🎪 reparto           ← 44,967 relaciones persona-película
🏆 premio            ← 2,000 nominaciones y premios
⭐ valoracion        ← 10,000 reseñas de usuarios
👤 usuario           ← 300 usuarios registrados
📋 lista             ← 600 listas personalizadas
🎞️ genero            ← Géneros normalizados (genero_base | subgenero | region)
🌍 pais              ← 676 países con código ISO
🗣️ idioma            ← 15 idiomas
🏭 productora        ← 30 estudios cinematográficos
🎠 franquicia        ← 30 universos y sagas
🖼️ imagen            ← Posters y backdrops
📽️ trailer           ← Links a trailers
```

---

## ⚙️ Pipeline ETL — Cómo funciona

```
📂 generos.csv          📂 paises.csv
      │                       │
      ▼                       ▼
  🔍 EXTRACT            🔍 EXTRACT
  Lee el CSV            Lee el CSV
      │                       │
      ▼                       ▼
  🔧 TRANSFORM          🔧 TRANSFORM
  Separa "Acción         Corrige Namibia
  Clásico Americano"     (NA → no es null)
  en 3 columnas
      │                       │
      ▼                       ▼
  📤 LOAD               📤 LOAD
  → genero_normalizado  → pais_limpio
  → MySQL               → MySQL
```

### 🧹 Normalización aplicada

El campo `nombre` en géneros tenía **3 valores en una sola celda** (violaba 1FN):

| ❌ Antes (sin normalizar) |
|---|
| `"Acción Clásico Americano"` |

| ✅ Después (normalizado) | | |
|---|---|---|
| `genero_base` | `subgenero` | `region` |
| Acción | Clásico | Americano |

---

## 🚀 Instalación y Uso

### 1️⃣ Clona el repositorio
```bash
git clone https://github.com/Analitica-de-datos/peliculas_1m.git
cd peliculas_1m
```

### 2️⃣ Instala las dependencias
```bash
pip install pandas sqlalchemy psycopg2-binary python-dotenv
```

### 3️⃣ Crea tu archivo `.env`
```env
DB_USER=tu_usuario
DB_PASS=tu_contraseña
DB_HOST=localhost
DB_PORT=3306
DB_NAME=peliculas_db
```

### 4️⃣ Crea el esquema en MySQL
```bash
mysql -u root -p < peliculas_db.sql
```

### 5️⃣ Corre el pipeline ETL
```bash
python Conexion.py
```

### 6️⃣ Verifica los datos
```sql
SELECT * FROM genero_normalizado LIMIT 10;
SELECT * FROM pais_limpio WHERE codigo_iso = 'NA'; -- Namibia ✅
```

---

## 📊 Conectar a Power BI

1. Abre **Power BI Desktop**
2. Click en **Obtener datos** → **Base de datos MySQL**
3. Completa:
   ```
   Servidor:       localhost
   Base de datos:  peliculas_db
   ```
4. Usuario: `root` / Contraseña: la tuya
5. Selecciona las **19 tablas** ✅
6. Click **Cargar** 🎉

> 💡 Necesitas tener instalado **MySQL Connector/NET 8.0** para que Power BI detecte MySQL.

---

## 📈 Visualizaciones disponibles en Power BI

- 📊 **Películas por año** — evolución histórica del cine
- 🎭 **Distribución por género** — torta con géneros base
- ⭐ **Top películas mejor valoradas** — ranking por puntuación promedio
- 🏆 **Premios por ceremonia** — Oscar vs BAFTA vs Golden Globe
- 🌍 **Películas por país** — mapa de producción mundial
- 💰 **Presupuesto vs Taquilla** — scatter plot de rentabilidad
- 👤 **Actividad de usuarios** — valoraciones por usuario

---

## 🔒 Seguridad

```
⚠️  NUNCA subas el archivo .env a Git
⚠️  NUNCA escribas contraseñas directamente en el código
✅  Usa siempre variables de entorno
✅  El .gitignore ya excluye el .env
```

---

## 🛠️ Stack Tecnológico

| Herramienta | Uso |
|---|---|
| 🐍 Python 3.11 | Pipeline ETL |
| 🐬 MySQL 8.0 | Motor de base de datos |
| 🐼 pandas | Transformación de datos |
| ⚗️ SQLAlchemy | Conexión ORM a MySQL |
| 📊 Power BI Desktop | Visualizaciones y dashboards |
| 🦦 DBeaver | Administración de BD |
| 🐙 Git / GitHub | Control de versiones |

---

## 📝 Entregables

- [x] 📄 Documento entregable con tabla de contenido
- [x] 🗄️ Esquema SQL normalizado (19 tablas)
- [x] 🐍 Script ETL completo (`Conexion.py`)
- [x] 📊 Conexión a Power BI
- [x] 📋 Template de proyectos BD diligenciado
- [x] 📁 Dataset CSV completo (90,757 registros)
- [x] 📖 README ← ¡Este documento!

---

## 📜 Licencia

Este proyecto fue desarrollado con fines académicos para la materia de **Analítica de Datos**.

---

<div align="center">

Hecho con 💙 y mucho ☕ por el equipo **THE GHOST IN THE MACHINE**

*"No le tengas miedo a los datos... tenles miedo a los datos sucios"* 👻

</div>
