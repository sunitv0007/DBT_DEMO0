{{
    config(
        materialized='table'
    )
}}

WITH trips AS (
    select 
    ride_id,
    --rideable_type,
    date(to_timestamp(started_at)) as trip_date,
    start_statio_id as start_station_id,
    end_station_id,
    member_csual as member_casual,
    TIMESTAMPDIFF(second,to_timestamp(started_at),to_timestamp(ended_at)) as trip_duration_seconds

    FROM 
    {{ ref('stg_bike0') }} --DBT_DEV0. ref() points at the real table in Snowflake
    where RIDE_ID != 'ride_id'
)

select * from trips