with stg_job_ads as (select * from {{ source('job_ads', 'stg_ads') }})

-- en rad per hämtad annons, 
-- bara annonsens ja/nej booleans
select
    id as job_ad_id,
    experience_required,
    driving_license_required as driver_license,
    access_to_own_car
from stg_job_ads