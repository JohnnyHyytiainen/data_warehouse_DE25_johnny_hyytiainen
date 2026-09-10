## Class notes.

- [Modern data stack slide](weekly_slides/slides_data_warehouse_intro.pdf)
- [Kursstruktur för denna kurs](weekly_slides/slides_data_warehouse_intro.pdf)
- [Vad är snowflake?](weekly_slides/slides_what_is_snowflake.pdf)
- Genomgång av data warehouse i den morderna datastacken.
    - Äldre typer av 'data warehouses' (Traditional datastack <LÄS PÅ MER OM>):
        - On prem, tight coupled hardware(Tänk innan cloud -> LAN över en stor serverhall t.ex)
        - Microsoft verktyg: SSIS / SSAS 
    
**Modern datastack:**
- Istället för att låsa sig i Microsoft/Oracle miljöer finns fler leverantörer och fler lösningar som kan integreras med varandra för att lösa företags lagring, förflyttning, transformering och analys av data.

----

## Genomgång av data (page 2-4)
- Prat och jämförelser av olika källor data kan komma ifrån, hur formen kan se ut på dom och vilka typer av format datan kan ha.

- Structured / semi-structured.
- Olika typer av DBs (OLTP - psql, SQL server. - OLAP, DuckDb, MongoDB etc etc.)
- Olika typer av ostrukturerad data, t.ex PDF's eller .docx.

---

## Källan för data kan vara spridda över flera olika områden.
- On prem, olika datorer
- Cloud tjänster
- Olika API'er
- Olika lagringssystem (one drive, google drive, sharepoint etc etc)

---

## Kostnader för snowflake.
Det man betalar för är:

Beräkningen, varje sekund ens warehouse är igång * storleken.

Lagring, genomsnittlig mängd per månad med historiken inräknad.

Så om jag gör en query mot en db som innehåller miljontals rader och t.ex en med tusentals rader kan kosta lika exakt lika mycket om dom tar exakt lika lång tid att köra om jag förstår det helt rätt.