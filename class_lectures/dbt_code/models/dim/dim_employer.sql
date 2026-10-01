with src_employer as (select * from {{ ref('src_employer') }})

-- En rad per arbetsplats och kommun. Samma nyckel som i README lecture 10
select
    {{ dbt_utils.generate_surrogate_key(['employer_workplace', 'workplace_municipality']) }} as employer_id,
    COALESCE(employer_workplace, 'Ej angivet') AS employer_workplace,
    COALESCE(workplace_municipality, 'Ej angivet') AS workplace_municipality,
    -- max() väljer ett värde när annonserna för samma workplace skiljer sig. 
    -- COALESCE() fångar upp om max-värdet ändå är NULL.
    COALESCE(max(employer_name), 'Ej angivet') as employer_name,
    COALESCE(max(employer_organization_number), 'Ej angivet') as employer_organization_number,
    COALESCE(max(workplace_street_address), 'Ej angivet') as workplace_street_address,
    COALESCE(max(workplace_postcode), 'Ej angivet') as workplace_postcode,
    COALESCE(max(workplace_city), 'Ej angivet') as workplace_city,
    COALESCE(max(workplace_region), 'Ej angivet') as workplace_region,
    COALESCE(max(workplace_country), 'Ej angivet') as workplace_country
from src_employer
group by employer_workplace, workplace_municipality