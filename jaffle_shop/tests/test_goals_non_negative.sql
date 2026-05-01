--este test se asegura de que no haya goles negativos en la tabla mart_fact_team_results
SELECT *
FROM {{ ref('mart_fact_team_results') }}
WHERE goals_for < 0
   OR goals_against < 0
