# -*- coding: utf-8 -*-
"""
Conexion.py - Proyecto: THE GHOST IN THE MACHINE
Integrantes: JHOVER INCHAPIE | MARCOS ARGEL | JHON USUGA
Repositorio: https://github.com/Marcos-Argel/Analitica-de-datos
"""

import mysql.connector
import pandas as pd
from mysql.connector import Error

CONFIG = {
    "host":     "localhost",
    "port":     3306,
    "database": "pelicula",
    "user":     "root",
    "password": "jhon",
    "charset":  "utf8mb4",
    "use_unicode": True,
    "connect_timeout": 10,
}


class Conexion:

    def __init__(self, config=CONFIG):
        self.config = config
        self.connection = None
        self.cursor = None

    def conectar(self):
        try:
            self.connection = mysql.connector.connect(**self.config)
            if self.connection.is_connected():
                self.cursor = self.connection.cursor(dictionary=True)
                version = self.connection.get_server_info()
                print("Conexion exitosa - MySQL Server v" + version)
                print("Base de datos: " + self.config["database"])
        except Error as e:
            print("Error al conectar: " + str(e))
            raise

    def desconectar(self):
        if self.cursor:
            self.cursor.close()
        if self.connection and self.connection.is_connected():
            self.connection.close()
            print("Conexion cerrada.")

    def __enter__(self):
        self.conectar()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.desconectar()

    def ejecutar(self, sql, params=None):
        try:
            self.cursor.execute(sql, params or ())
            return self.cursor.fetchall()
        except Error as e:
            print("Error en consulta: " + str(e))
            raise

    def ejecutar_escritura(self, sql, params=None, many=False):
        try:
            if many:
                self.cursor.executemany(sql, params)
            else:
                self.cursor.execute(sql, params or ())
            self.connection.commit()
            print("Operacion exitosa - filas afectadas: " + str(self.cursor.rowcount))
        except Error as e:
            self.connection.rollback()
            print("Error en escritura: " + str(e))
            raise

    def cargar_csv(self, csv_path, tabla, columnas):
        df = pd.read_csv(csv_path)
        df = df[columnas]
        df = df.where(pd.notnull(df), None)
        placeholders = ", ".join(["%s"] * len(columnas))
        cols = ", ".join(columnas)
        sql = "INSERT IGNORE INTO " + tabla + " (" + cols + ") VALUES (" + placeholders + ")"
        datos = [tuple(row) for row in df.itertuples(index=False, name=None)]
        self.ejecutar_escritura(sql, datos, many=True)
        print(str(len(datos)) + " registros cargados en " + tabla)

    def peliculas_por_genero(self):
        sql = """
            SELECT g.nombre AS genero, COUNT(pg.pelicula_id) AS total
            FROM genero g
            LEFT JOIN pelicula_genero pg ON g.id = pg.genero_id
            GROUP BY g.nombre
            ORDER BY total DESC
            LIMIT 20
        """
        return pd.DataFrame(self.ejecutar(sql))

    def top_peliculas_taquilla(self, top=10):
        sql = """
            SELECT titulo, anio, taquilla, presupuesto,
                   (taquilla - presupuesto) AS ganancia
            FROM pelicula
            WHERE taquilla IS NOT NULL
            ORDER BY taquilla DESC
            LIMIT %s
        """
        return pd.DataFrame(self.ejecutar(sql, (top,)))

    def valoracion_promedio(self):
        sql = """
            SELECT p.titulo, ROUND(AVG(v.puntuacion), 2) AS promedio,
                   COUNT(v.id) AS num_valoraciones
            FROM pelicula p
            JOIN valoracion v ON p.id = v.pelicula_id
            GROUP BY p.titulo
            HAVING num_valoraciones >= 5
            ORDER BY promedio DESC
            LIMIT 20
        """
        return pd.DataFrame(self.ejecutar(sql))

    def peliculas_por_pais(self):
        sql = """
            SELECT pa.nombre AS pais, COUNT(pp.pelicula_id) AS total
            FROM pais pa
            LEFT JOIN pelicula_pais pp ON pa.id = pp.pais_id
            GROUP BY pa.nombre
            ORDER BY total DESC
            LIMIT 20
        """
        return pd.DataFrame(self.ejecutar(sql))

    def contar_registros(self):
        tablas = ["genero", "pais", "pelicula", "persona", "usuario", "valoracion"]
        print("\n--- Registros por tabla ---")
        for tabla in tablas:
            try:
                resultado = self.ejecutar("SELECT COUNT(*) AS total FROM " + tabla)
                print(tabla + ": " + str(resultado[0]["total"]))
            except:
                print(tabla + ": tabla no encontrada")


if __name__ == "__main__":
    with Conexion() as db:
        db.contar_registros()

        print("\n--- Top generos ---")
        df_generos = db.peliculas_por_genero()
        if not df_generos.empty:
            print(df_generos.to_string(index=False))
        else:
            print("Sin datos aun en pelicula_genero")

        print("\n--- Top paises ---")
        df_paises = db.peliculas_por_pais()
        if not df_paises.empty:
            print(df_paises.to_string(index=False))
        else:
            print("Sin datos aun en pelicula_pais")