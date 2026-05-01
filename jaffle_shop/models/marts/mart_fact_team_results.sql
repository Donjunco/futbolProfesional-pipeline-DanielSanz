{{ config(
    materialized='incremental',
    unique_key=['team_id', 'season_id'],
    incremental_strategy='merge',
    tags=['incremental']
) }}

SELECT
    team_id,
    season_id,
    total_points,
    goals_for,
    goals_against,
    wins,
    draws,
    losses
FROM {{ ref('int_fact_team_results') }}
