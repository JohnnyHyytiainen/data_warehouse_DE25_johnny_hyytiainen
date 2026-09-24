with src_job_details as (select * from {{ ref('src_job_details') }})

-- en rad per annons: nyckeln är annonsens id
-- Precis så som som README i lecture skriver
select
    {{ dbt_utils.generate_surrogate_key(['job_ad_id']) }} as job_details_id,
    job_ad_id,
    -- duplicate annonserna är samma annons som har hämtats två gånger, så max() väljer bland lika värden
    max(headline) as headline,
    max(description) as description,
    max(description_html_formatted) as description_html_formatted,
    max(employment_type) as employment_type,
    max(duration) as duration,
    max(salary_type) as salary_type,
    max(scope_of_work_min) as scope_of_work_min,
    max(scope_of_work_max) as scope_of_work_max
from src_job_details
group by job_ad_id