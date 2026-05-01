--este test se asegura de que el número total de resultados (wins + draws + losses) coincida con el número de partidos jugados por cada equipo en cada temporada
WITH calc AS (
    SELECT
        r.team_id AS team_id,
        r.season_id AS season_id,
        r.wins,
        r.draws,
        r.losses,
        (r.wins + r.draws + r.losses) AS results_count,
        COUNT(ts.match_id) AS matches_played
    FROM {{ ref('mart_fact_team_results') }} r
    JOIN {{ ref('stg_fact_team_stats') }} ts
        ON r.team_id = ts.team_id
    JOIN {{ ref('stg_fact_matches') }} m
        ON ts.match_id = m.match_id
       AND r.season_id = m.season_id
    GROUP BY
        r.team_id,
        r.season_id,
        r.wins,
        r.draws,
        r.losses
)

SELECT *
FROM calc
WHERE results_count != matches_played
