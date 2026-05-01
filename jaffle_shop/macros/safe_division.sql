--este macro se utiliza para realizar una división segura entre dos valores, evitando errores de división por cero o valores nulos. Si el denominador es cero o nulo, el resultado será cero en lugar de generar un error.
{% macro safe_division(numerator, denominator) %}
    CASE 
        WHEN {{ denominator }} = 0 OR {{ denominator }} IS NULL THEN 0
        ELSE {{ numerator }} / {{ denominator }}
    END
{% endmacro %}
