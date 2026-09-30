with src_employer as (select * from {{ ref('src_employer') }})

-- En rad per arbetsplats och kommun. Samma nyckel som i README lecture 10
select
    {{ dbt_utils.generate_surrogate_key(['employer_workplace', 'workplace_municipality']) }} as employer_id,
    employer_workplace,
    workplace_municipality,
    -- max() väljer ett värde när annonserna för samma workplace skiljer sig
    max(employer_name) as employer_name,
    max(employer_organization_number) as employer_organization_number,
    max(workplace_street_address) as workplace_street_address,
    max(workplace_postcode) as workplace_postcode,
    max(workplace_city) as workplace_city,
    max(workplace_region) as workplace_region,
    max(workplace_country) as workplace_country
from src_employer
group by employer_workplace, workplace_municipality