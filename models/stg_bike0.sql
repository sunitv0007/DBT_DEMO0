{{
    config(
        materialized='table'
    )
}}

WITH bike as (
    select 
     RIDE_ID,
	 REPLACE(STARTED_AT,'"','') as started_at,
		REPLACE(ended_at,'"','') as ended_at,
		START_STATION_NAME,
		START_STATIO_ID,
		END_STATION_NAME,
		END_STATION_ID,
		START_LAT,
		START_LNG,
		END_LAT,
		END_LNG,
		MEMBER_CSUAL
        FROM {{ source('demo0-dbt-source-file-name', 'bike0') }}
        WHERE RIDE_ID !='"bikeid"' and started_at != '"starttime"'  and started_at != 'starttime'
    )

    SELECT * FROM bike