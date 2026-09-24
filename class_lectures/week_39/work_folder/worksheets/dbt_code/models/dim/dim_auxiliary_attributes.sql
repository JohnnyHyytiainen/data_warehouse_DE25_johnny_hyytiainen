with src_auxiliary_attributes as (select * from {{ ref('src_auxiliary_attributes') }})

-- en rad per annons: README i lecture 10 ger mig nyckeln från annonsens id
select
    {{ dbt_utils.generate_surrogate_key(['job_ad_id']) }} as auxiliary_attributes_id,
    experience_required,
    driver_license,
    access_to_own_car
from src_auxiliary_attributes
-- gruppera på alla kolumner i stället för max(), som kanske inte tar BOOLEAN
group by job_ad_id, experience_required, driver_license, access_to_own_car