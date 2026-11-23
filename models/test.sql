select 
*
from {{ source('demo0-dbt-source-file-name', 'bike0') }}