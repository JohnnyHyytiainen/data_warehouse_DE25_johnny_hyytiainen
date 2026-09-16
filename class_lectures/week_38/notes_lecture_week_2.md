# Lecture notes for week 2 of data warehouse lifecycle course
## Class notes.
*Johnny Hyytiäinen*

- [Snowflake users and roles](weekly_slides/snowflake_users_and_roles.pdf)
- [Slides regarding DLT - Extract, Load CSV](weekly_slides/slides_what_is_dlt.pdf)
- [Slides regarding DLT - Extract, Load API](weekly_slides/slides_dlt_api.pdf)

---

### Access control i Snowflake
- DAC (Discretionary access control)
    - varje objekt har en ägare
    - En ägare kan ge tillstånd(privilege) till objektet.

- RBAC (Role based access control)
    - Tillstånd(privilege) blir givet till ROLE
    - ROLES blir assigned till USERS och andra ROLES

- Kedjan ser ut så här:

```
rättighet(privilege)  →  ges till  →  ROLL(ROLE)  →  ges till  →  ANVÄNDARE(USER)
```
---


### Vilka roller och ansvarsområden finns och vad har varje roll för tillstånd?:

| Roll | Ansvar |
|---|---|
| `ORGADMIN` | organisationen: konton, regioner |
| `ACCOUNTADMIN` | toppen av kontot. Ser allt, kan allt, inklusive fakturering |
| `SECURITYADMIN` | hanterar rättigheter och kan bevilja på hela kontot |
| `USERADMIN` | skapar och hanterar användare och roller |
| `SYSADMIN` | äger databaser, scheman och warehouses |
| `PUBLIC` | alla har den automatiskt. Ge den nästan aldrig något |


* Den praktiska regeln: **`ACCOUNTADMIN` används för att sätta upp kontot och för fakturering, inte för
att arbeta.** Att göra allt som `ACCOUNTADMIN` fungerar utmärkt, ända fram tills något ska delegeras, och då visar det sig att ingen struktur finns.

Egna roller skapas under `SYSADMIN`, så att den rollen kan se och förvalta allt som byggs.

### Ägarskap:

Den roll som skapade ett objekt äger det. Det låter oskyldigt men är den vanligaste orsaken till förvirring i grupparbeten: skapar du en tabell som `ACCOUNTADMIN` äger `ACCOUNTADMIN` den, och en kollega med en vanlig roll ser den inte förrän någon uttryckligen delat den.

---

### Två axlar och inte en - Sluta tänka linjärt.
- Vanligtvis tänker man linjärt, exempel här under:

```
warehouse  →  databas  →  schema  →  tabell
```

- Så hänger de inte ihop. Databas, schema och tabell ligger *inuti varandra* och bildar en kedja. Warehouset ligger inte inuti någonting, det är motorn som utför arbetet, och den har ingenting med var datan bor att göra. Det är egentligen två axlar och *inte* en axel:

```
                  ┌──► USAGE  på WAREHOUSE ──► motorn som gör jobbet
                  │
  [ Din fråga ] ──┤
                  │
                  └──► USAGE  på DATABAS ──► USAGE  på SCHEMA ──► SELECT  på TABELL
                         "få gå in"           "få gå in"           "få läsa"
```

