{{
    config(
        materialized='table'
    )
}}


WITH daily_weather AS (
    SELECT 
    date(time) as daily_weather,
    weather,
    temp,
    pressure,
    humidity,
    clouds
    FROM {{ source('demo0-dbt-source-file-name', 'weather0') }}
),

daily_weather_agg as (
    select
    daily_weather,
    weather,
    round(avg(temp),2) as avg_temp,
    round(avg(pressure),2) as avg_pressure,
    round(avg(humidity),2) as avg_humidity,
    round(avg(clouds),2) as avg_clouds
    from daily_weather
    GROUP BY daily_weather,weather
    QUALIFY ROW_NUMBER() OVER (PARTITION BY daily_weather ORDER BY count(weather) DESC)  = 1
)

SELECT *
FROM daily_weather_agg