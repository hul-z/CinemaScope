-- 1. List the top 10 movies with the highest IMDB ratings
SELECT TOP 10 Series_Title, IMDB_Rating 
FROM imdb_top_1000
ORDER BY IMDB_Rating DESC

-- 2. Count the number of movies released each year
SELECT Released_Year, COUNT(*) Movie_Count 
FROM imdb_top_1000
GROUP BY Released_Year
ORDER BY Released_Year

-- 3. Count the number of movies directed by each director, ordered by most movies
SELECT Director, COUNT(*) Movie_Count
FROM imdb_top_1000
GROUP BY Director
ORDER BY Movie_Count DESC