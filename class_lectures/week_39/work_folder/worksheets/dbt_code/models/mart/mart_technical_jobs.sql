with
    fct_job_ads as (select * from {{ ref('fct_job_ads') }}),
    dim_occupation as (select * from {{ ref('dim_occupation') }})
select
    f.vacancies,
    f.relevance,
    o.occupation,
    o.occupation_group,
    o.occupation_field,
    f.application_deadline,
from fct_job_ads f
-- En inner join: Koden säger vad den ska göra, where filtrerar på yrkesområden
inner join dim_occupation o on f.occupation_id = o.occupation_id
where o.occupation_field = 'Yrken med teknisk inriktning'