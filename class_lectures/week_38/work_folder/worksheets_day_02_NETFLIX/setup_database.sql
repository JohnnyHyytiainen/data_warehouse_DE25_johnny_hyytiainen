-- Välj rollen
USE ROLE SYSADMIN;

-- setup för databas + staging layer
CREATE DATABASE IF NOT EXISTS class_movies;

-- Skapa staging layer(schema) som landing zone där min data ska ingestas/loadas
CREATE SCHEMA IF NOT EXISTS class_movies.staging;

-- Dubbelkolla att db är skapad
DESCRIBE DATABASE class_movies;