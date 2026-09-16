--
-- Purge script för att rensa tidigare data från home_lecture/ som skapades INNAN jag satte home_ prefixet för att särskilja på home lectures vs in class lectures
-- 1. Välj rätt roll(SYSADMIN), droppa databas, 
-- 2. Välj rätt roll(USERADMIN) som äger skapade roller OCH användarna, droppa skapade roller + användare.
-- 3. Dubbelkolla att ingenting ligger kvar och skräpar
-- 4. Dubbelkolla alla roller
-- 5. Dubbelkolla alla users
--
--
-- 1. Databasen först, tabellerna försvinner med den
USE ROLE SYSADMIN;
DROP DATABASE IF EXISTS movies;

-- 2. Roller och användare, USERADMIN skapade dem och äger dem
USE ROLE USERADMIN;
DROP ROLE IF EXISTS movies_dlt_role;
DROP ROLE IF EXISTS movies_reader_role;
DROP ROLE IF EXISTS movies_reader;
DROP USER IF EXISTS extract_loader;

-- 3. Kontrollera att inget ligger kvar
SHOW ROLES LIKE 'movies%';
SHOW USERS LIKE 'extract%';

-- 4. Dubbelkolla rollerna
SHOW ROLES;

-- 5. Dubbelkolla användare
SHOW USERS;