# Quick exercise at end of day that will be reviewed tomorrow(day 02 week 38)
Debbie: Hi @everyone , here are an inclass-exercise for today. I will go through question 1 tomorrow morning when we start the lecture:

## Question 1
Based on the lecture/code along sql worksheets:
- using the ice_cream_writer role, create a new table under the public schema. This is a table called suppliers with the columns: supplier_id and supplier_name
- as an object manager, can you use the role SYSADMIN to drop this table. Because we find out that this is a wrong table to be created
- by going through this step, can you conclude that our lecture/code along sql worksheets follows strictly the snowflake best practice of access control

---

## Question 2/reading
- go to this link here: https://docs.snowflake.com/en/user-guide/security-access-control-considerations#example
    - Right panel: "Aligning object access with business functions" and read it.
        - Documentation is regarding Snowflake best practices.

---

## Answers

Script will be found in `class_lectures/week_38/work_folder/worksheets_day_01/setup_db_class_exercise.sql`

- By using these statements in a new file I was able to create it all. 
- But since I granted the role of `icecream_writer` to my `SYSADMIN` role I was able to drop it without having to grant that privilage by using these statements:
```sql
-- Grant role som min reader, writer och analyst har till SYSTEM ADMIN (DB relaterad SYSADMIN)
GRANT ROLE icecream_reader TO ROLE SYSADMIN;
GRANT ROLE icecream_writer TO ROLE SYSADMIN;
GRANT ROLE icecream_analyst TO ROLE SYSADMIN;
```
- The purpose of this small exercise was to see it fail. Which is WHY it is important to be thorough with your access control in snowflake.