-- Kolla in child tables i duckdb ui
SELECT * FROM swedavia_raw.arrivals__code_share_data limit 10;


-- Koppla child till parent: Vilka codeshare nummer har varje flyg
SELECT
    a.flight_id,
    a.airline_operator__name,
    c.value AS codeshare_flight_id,   -- en lista med strängar hamnar i kolumnen "value"
    c._dlt_list_idx                   -- elementets plats i listan
FROM swedavia_raw.arrivals AS a
JOIN swedavia_raw.arrivals__code_share_data AS c
    ON c._dlt_parent_id = a._dlt_id   -- barnet pekar på förälderns radnyckel
ORDER BY a.flight_id, c._dlt_list_idx;


-- Mest försenade ankomst (2026-10-07) på Arlanda.
SELECT
    flight_id,
    airline_operator__name,
    arrival_time__scheduled_utc,
    arrival_time__actual_utc,
    -- skillnaden i minuter mellan planerad och faktisk ankomst
    date_diff('minute', arrival_time__scheduled_utc, arrival_time__actual_utc) AS delay_minutes
FROM swedavia_raw.arrivals
WHERE location_and_status__flight_leg_status = 'LAN'
ORDER BY delay_minutes DESC
LIMIT 10;


-- Vilka kandidatnycklar förekommer mer än en gång?
-- arrivals
SELECT
    flight_leg_identifier__flight_id,
    flight_leg_identifier__flight_departure_date_utc,
    flight_leg_identifier__departure_airport_iata,
    flight_leg_identifier__arrival_airport_iata,
    count(*) AS rows_per_key,
    -- visar statusarna sida vid sida, t.ex. "DEL, LAN"
    string_agg(location_and_status__flight_leg_status, ', ') AS statuses
FROM swedavia_raw.arrivals
GROUP BY all
HAVING count(*) > 1
ORDER BY rows_per_key DESC;

-- Vilka kandidatnycklar förekommer mer än en gång?
-- departures
