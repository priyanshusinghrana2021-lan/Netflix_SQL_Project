# Netflix Movies and TV Shoes Data Analysis using SQL

![Netflix log](https://github.com/priyanshusinghrana2021-lan/Netflix_SQL_Project/blob/main/netflix-logo%20123.avif)

## Overview
This project analyzes Netflix content data using PostgreSQL to gain insights into movies and TV shows based on country (especially India), release year, ratings, genres, and duration. SQL queries are used to identify content trends, distribution patterns, and key metrics for data-driven analysis.

## Objective
Import and manage large datasets in PostgreSQL.
Write optimized SQL queries using SELECT, WHERE, GROUP BY, ORDER BY, and JOIN concepts.
Perform country-specific analysis (e.g., India-based content).
Handle missing and textual data (duration, genres, ratings).
Generate insights useful for reporting and visualization.

## Dataset
The data for this project is sourced from the kaggle datset.

-- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows)

## Schema

'''sql
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
'''

## --  NETFLIX BUSINESS PROBLEMS

### -- Select all records from Netflix table

'''sql
SELECT * FROM netflix;
'''

### -- Count total number of shows

'''sql
SELECT 
     COUNT (*) AS total_content
FROM netflix;
'''

### -- List unique countries

'''sql
SELECT 
     DISTINCT type
FROM netflix;
'''

### -- Find all Movies only

'''sql
SELECT * 
FROM netflix
WHERE type = 'Movie';
'''

### -- Find all TV Shows only

'''sql
SELECT * 
FROM netflix
WHERE type = 'TV Show';
'''

### -- Count the number of movies vs TV Shows

'''sql
SELECT
     type,
	 COUNT (*) total_count
FROM netflix
GROUP BY type;
'''

### -- Find shows released in 2020

'''sql
SELECT title, type
FROM netflix
WHERE release_year = 2020;
'''

### -- Find top 5 latest released shows

'''sql
SELECT title, release_year
FROM netflix
ORDER BY release_year DESC
LIMIT 5;
'''

### -- Find shows where country is India

'''sql
SELECT title, country
FROM netflix
WHERE country LIKE '%India%';
'''

### -- Find shows added after 2019

'''sql
SELECT title, date_added
FROM netflix
WHERE date_added LIKE '%2020%' 
   OR date_added LIKE '%2021%';
'''

### -- Find number of shows released each year

'''sql
SELECT release_year, COUNT(*) AS total
FROM netflix
GROUP BY release_year
ORDER BY release_year DESC;
'''

### -- Find top 10 countries with most content

'''sql
SELECT country, COUNT(*) AS total
FROM netflix
GROUP BY country
ORDER BY total DESC
LIMIT 10;
'''

### -- Find shows with missing director name

'''sql
SELECT title
FROM netflix
WHERE director IS NULL OR director = '';
'''


### -- Find longest movie duration

'''sql
SELECT title, duration
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SPLIT_PART(duration, ' ', 1) AS INT) DESC
LIMIT 1;
'''

### -- Percentage of Movies vs TV Shows

'''sql
SELECT 
  type,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix), 2) AS percentage
FROM netflix
GROUP BY type;
'''

### -- Find number of shows per rating

'''sql
SELECT rating, COUNT(*) AS total
FROM netflix
GROUP BY rating
ORDER BY total DESC;
'''

###-- Find most common genre

'''sql
SELECT listed_in, COUNT(*) AS total
FROM netflix
GROUP BY listed_in
ORDER BY total DESC
LIMIT 1;
'''

### -- find TV shows with more than 3 seasons

'''sql
SELECT title, duration
FROM netflix
WHERE type = 'TV Show'
  AND CAST(SPLIT_PART(duration, ' ', 1) AS INT) > 3;
'''

### -- Delete shows released before 2000

'''sql
DELETE FROM netflix
WHERE release_year < 2000;
'''

### -- Find Indian shows released after 2018

'''sql
SELECT title, release_year
FROM netflix
WHERE country LIKE '%India%'
  AND release_year > 2018;
'''

### -- List distinct directors of Indian content

'''sql
SELECT DISTINCT director
FROM netflix
WHERE country LIKE '%India%'
  AND director IS NOT NULL;
'''

### -- Year-wise count of Indian releases

'''sql
SELECT release_year, COUNT(*) AS total
FROM netflix
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY release_year DESC;
'''

### -- Most common rating for Indian content

'''sql
SELECT rating, COUNT(*) AS total
FROM netflix
WHERE country LIKE '%India%'
GROUP BY rating
ORDER BY total DESC
LIMIT 1;
'''

### -- Indian Movies longer than 2 hours

'''sql
SELECT title, duration
FROM netflix
WHERE country LIKE '%India%'
  AND type = 'Movie'
  AND CAST(SPLIT_PART(duration, ' ', 1) AS INT) > 120;
'''

### -- Percentage of Indian content on Netflix

'''sql
SELECT 
  ROUND(
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix),
    2
  ) AS indian_content_percentage
FROM netflix
WHERE country LIKE '%India%';
'''

## Finding and Conclusion

The analysis shows that Netflix has more movies than TV shows, with India contributing a significant amount of content. Content releases have increased over recent years, and certain genres and ratings dominate the platform. Overall, the project demonstrates how SQL and PostgreSQL can transform raw Netflix data into meaningful insights for data-driven decisions.


