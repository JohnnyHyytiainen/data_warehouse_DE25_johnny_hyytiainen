# Script för att utforska datan via duckdb lokalt
import duckdb

# dlt kommer döpa om duckDB filen efter pipelinens namn(nice!)
con = duckdb.connect("sandbox_swedavia.duckdb", read_only=True)

# Vilka tables skapade DLT utifrån arrivals datan?
con.sql("""
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'swedavia_raw'
    ORDER BY table_name
    """).show()

# cols i huvud tabellen
con.sql("DESCRIBE swedavia_raw.arrivals").show(max_rows=100)
