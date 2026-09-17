-- Välj roll vid skapandet
USE ROLE SYSADMIN;

-- Skapa databasen för lecture 07
CREATE DATABASE IF NOT EXISTS class_job_ads;

-- Skapa mitt schema
CREATE SCHEMA IF NOT EXISTS class_job_ads.staging;