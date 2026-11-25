{{
    config(
        materialized='table'
    )
}}

WITH CTE AS (
    select to_timestamp(started_at) as STARTED_AT,
    DATE(TO_TIMESTAMP(STARTED_AT)) AS DATE_STARTED_AT,
    HOUR(TO_TIMESTAMP(STARTED_AT)) AS HOUR_STARTED_AT,
    {{day_type('started_at')}} AS DAY_TYPE,
   {{get_season('started_at')}} AS STATION_OF_YEAR
    FROM 
    {{ source('demo0-dbt-source-file-name', 'bike0') }}
    WHERE started_at != 'started_at'
)

SELECT * FROM cte