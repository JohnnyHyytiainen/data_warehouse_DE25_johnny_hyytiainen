-- Välj rollen
USE ROLE SYSADMIN;

-- setup för databas + staging layer
CREATE DATABASE IF NOT EXISTS movies;

-- Skapa staging layer(schema(CC?)) som landing zone där min data ska ingestas/loadas
CREATE SCHEMA IF NOT EXISTS movies.staging;

-- Dubbelkolla att db är skapad
DESCRIBE DATABASE movies;