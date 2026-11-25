{{
    config(
        materialized='table'
    )
}}

WITH CTE AS (
    SELECT 
    t.*,
    w.*
    FROM {{ ref('trip_fact0') }} t
    left join {{ ref('daily_weather0') }} w 
    ON t.TRIP_DATE=w.daily_weather
)

SELECT * FROM cte