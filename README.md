# futbolProfesional-pipeline-DanielSanz
# Descripción del dominio y problemática que aborda
El dominio del proyecto es el **fútbol profesional**, a partir de datos de partidos obtenidos en formato JSON (ingestados en la tabla `PARTIDOS_RAW`).  
El sistema recoge información de:

- Partidos (marcador, fecha, jornada, competición, temporada)
- Equipos (local y visitante, país, género)
- Árbitros
- Estadios
- Países
- Managers

La problemática principal es que los datos llegan en formato semiestructurado (JSON), dispersos en múltiples estructuras anidadas (home_team, away_team, competition, stadium, referee, managers, etc.), lo que dificulta:

- Analizar resultados por competición, temporada, equipo o país
- Calcular métricas de rendimiento (puntos, victorias, derrotas, goles a favor/en contra)
- Construir rankings y estadísticas históricas de forma consistente

El objetivo del Data Warehouse es modelar estos datos en un esquema dimensional
# Las tres preguntas analíticas que el proyecto responderá
1. **Rendimiento por equipo y temporada**  
   - ¿Cuántos puntos, victorias, empates y derrotas tiene cada equipo por temporada y competición?  
   - ¿Cuál es la diferencia de goles (GF–GC) por equipo?

2. **Evolución del rendimiento del equipo**  
    - ¿Cómo cambia el rendimiento del equipo a lo largo de las jornadas (match_week)?
    - ¿Hay rachas positivas o negativas (victorias consecutivas, derrotas, empates)?
  

3. **Impacto del factor campo**  
    - ¿Rinde mejor el equipo jugando en casa o fuera?
    - ¿Cuántos puntos obtiene como local vs visitante?


# Esquema dimensional propuesto (tablas de hechos y dimensiones)
 -tablas de dimensiones:
    dim_country
    dim_competition
    dim_team
    dim_manager
    dim_season
    dim_stadium
    dim_referee

 -tablas de hechos:
    fact_matches
    fact_team_stats
    

# Justificación de la elección de fuente de datos
Elegí datos de fútbol porque es un tema que me gusta y me resulta fácil de entender. Al conocer bien cómo funcionan los partidos, equipos y competiciones, trabajar con este tipo de datos me hace el proyecto más llevadero y me permite centrarme en el modelado sin complicarme con un dominio que no controlo. Los datos los he sacado de un repositorio de github: https://github.com/statsbomb/open-data.git. A la hora de meter nuevos datos los he creado cambiando algunos datos de algun partido por unos nuevos.

# Estrategia de carga incremental
La carga se realiza mediante un TASK diario en Snowflake (task_ingesta_diaria2), que:

    Copia los nuevos ficheros JSON desde el STAGE interno a la tabla PARTIDOS_RAW (COPY INTO PROYECTO2_DBT.RAW.PARTIDOS_RAW). (En caso de AWS no me funcionaba por lo que decidi utilizar uno interno que basicamente es muy parecido)

    Inserta solo nuevos registros en las dimensiones (dim_country, dim_competition, dim_team, dim_manager, dim_season, dim_stadium, dim_referee) usando WHERE NOT EXISTS sobre las claves naturales (id, name).

    Carga incremental de hechos:

        FACT_MATCHES: inserta solo partidos cuyo match_id no exista ya en la tabla.

        fact_team_stats: inserta solo combinaciones nuevas de (match_id, team_id).

La estrategia incremental se basa en:

    Claves de negocio estables (match_id, team_id, competition_id, etc.).

    Uso de NOT EXISTS para evitar duplicados.

    Programación periódica con SCHEDULE = 'USING CRON 0 17 * * * Europe/Madrid', lo que permite una ingesta diaria automática. En caso de que no se hace manual.

En una fase posterior, estos hechos RAW son refinados con modelos incrementales en dbt , usando estrategias tipo incremental_strategy='merge' y unique_key='match_id' o ['match_id', 'team_id'].