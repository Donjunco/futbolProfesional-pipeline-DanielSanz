
WITH joined AS (
    SELECT
        ts.team_id,
        m.season_id,
        ts.points,
        ts.goals_for,
        ts.goals_against,
        ts.is_win,
        ts.is_draw,
        ts.is_loss
    FROM {{ ref('stg_fact_team_stats') }} ts
    JOIN {{ ref('stg_fact_matches') }} m
        ON ts.match_id = m.match_id
),

agg AS (
    SELECT
        team_id,
        season_id,
        SUM(points) AS total_points,
        SUM(goals_for) AS goals_for,
        SUM(goals_against) AS goals_against,
        -- El uso de SUM con CASE permite contar el número de victorias, empates y derrotas para cada equipo en cada temporada.
        SUM(CASE WHEN is_win = 1 THEN 1 ELSE 0 END) AS wins,
        SUM(CASE WHEN is_draw = 1 THEN 1 ELSE 0 END) AS draws,
        SUM(CASE WHEN is_loss = 1 THEN 1 ELSE 0 END) AS losses
    FROM joined
    GROUP BY 1,2
)

SELECT *
FROM agg
