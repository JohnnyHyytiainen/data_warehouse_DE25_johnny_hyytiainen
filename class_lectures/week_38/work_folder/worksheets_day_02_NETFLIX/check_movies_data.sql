USE ROLE class_movies_reader_role;

USE DATABASE class_movies;

SHOW SCHEMAS;

DESCRIBE DATABASE class_movies;

DESCRIBE SCHEMA staging;

DESCRIBE TABLE staging.netflix;


SELECT * FROM staging.netflix;

SELECT title, genre, imdb_score FROM staging.netflix
ORDER BY imdb_score DESC;
