--este macro se utiliza para obtener la fecha máxima de carga de datos en una tabla específica, lo que es útil para determinar el rango de fechas que se deben procesar en las transformaciones posteriores.
{% macro get_max_loaded_date(table_ref) %}
    (
        SELECT COALESCE(MAX(match_date), '1900-01-01')
        FROM {{ table_ref }}
    )
{% endmacro %}
