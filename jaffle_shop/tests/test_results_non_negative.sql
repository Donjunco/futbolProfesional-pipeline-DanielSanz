--este test se asegura de que no haya resultados negativos en la tabla mart_fact_team_results
SELECT *
FROM {{ ref('mart_fact_team_results') }}
WHERE wins < 0
   OR draws < 0
   OR losses < 0
