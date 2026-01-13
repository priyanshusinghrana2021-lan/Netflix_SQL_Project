-- Netflix Project

DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix
(
show_id	VARCHAR(6),
type    VARCHAR(10),
title	   VARCHAR(150),
director   VARCHAR(208),
casts	   VARCHAR(1000),
country	    VARCHAR(150),
date_added   VARCHAR(50),
release_year   INT,
rating	       VARCHAR(10),
duration         VARCHAR(15),
listed_in        VARCHAR(100),
description      VARCHAR(250)
);

SELECT * FROM netflix;

SELECT 
     COUNT (*) AS total_content
FROM netflix;

SELECT 
     DISTINCT type
FROM netflix;

--  NETFLIX BUSINESS PROBLEMS

-- Find all Movies only

SELECT * 
FROM netflix
WHERE type = 'Movie';

-- Find all TV Shows only

SELECT * 
FROM netflix
WHERE type = 'TV Show';

-- Count the number of movies vs TV Shows

SELECT
     type,
	 COUNT (*) total_count
FROM netflix
GROUP BY type;

-- Find shows released in 2020

SELECT title, type
FROM netflix
WHERE release_year = 2020;

-- Find top 5 latest released shows

SELECT title, release_year
FROM netflix
ORDER BY release_year DESC
LIMIT 5;

-- Find shows where country is India

SELECT title, country
FROM netflix
WHERE country LIKE '%India%';

-- Find shows added after 2019

SELECT title, date_added
FROM netflix
WHERE date_added LIKE '%2020%' 
   OR date_added LIKE '%2021%';

-- Find number of shows released each year

SELECT release_year, COUNT(*) AS total
FROM netflix
GROUP BY release_year
ORDER BY release_year DESC;

-- Find top 10 countries with most content

SELECT country, COUNT(*) AS total
FROM netflix
GROUP BY country
ORDER BY total DESC
LIMIT 10;

-- Find shows with missing director name

SELECT title
FROM netflix
WHERE director IS NULL OR director = '';


-- Find longest movie duration

SELECT title, duration
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INT) DESC
LIMIT 1;

-- Percentage of Movies vs TV Shows

SELECT 
  type,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix), 2) AS percentage
FROM netflix
GROUP BY type;

-- Find number of shows per rating

SELECT rating, COUNT(*) AS total
FROM netflix
GROUP BY rating
ORDER BY total DESC;

-- Find most common genre

SELECT listed_in, COUNT(*) AS total
FROM netflix
GROUP BY listed_in
ORDER BY total DESC
LIMIT 1;

-- find TV shows with more than 3 seasons

SELECT title, duration
FROM netflix
WHERE type = 'TV Show'
  AND CAST(SPLIT_PART(duration, ' ', 1) AS INT) > 3;

-- Delete shows released before 2000

DELETE FROM netflix
WHERE release_year < 2000;

-- Find Indian shows released after 2018

SELECT title, release_year
FROM netflix
WHERE country LIKE '%India%'
  AND release_year > 2018;

-- List distinct directors of Indian content

SELECT DISTINCT director
FROM netflix
WHERE country LIKE '%India%'
  AND director IS NOT NULL;

-- Year-wise count of Indian releases

SELECT release_year, COUNT(*) AS total
FROM netflix
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY release_year DESC;

-- Most common rating for Indian content

SELECT rating, COUNT(*) AS total
FROM netflix
WHERE country LIKE '%India%'
GROUP BY rating
ORDER BY total DESC
LIMIT 1;

-- Indian Movies longer than 2 hours

SELECT title, duration
FROM netflix
WHERE country LIKE '%India%'
  AND type = 'Movie'
  AND CAST(SPLIT_PART(duration, ' ', 1) AS INT) > 120;


-- Percentage of Indian content on Netflix

SELECT 
  ROUND(
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix),
    2
  ) AS indian_content_percentage
FROM netflix
WHERE country LIKE '%India%';


