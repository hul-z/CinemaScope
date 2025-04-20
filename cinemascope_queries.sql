-- 1. List the top 10 movies with the highest IMDB ratings
SELECT TOP 10 Series_Title, IMDB_Rating 
FROM imdb_top_1000
ORDER BY IMDB_Rating DESC

-- 2. Top 10 Years with the Highest Number of Movies Released
SELECT TOP 10 Released_Year, COUNT(*) AS Movie_Count
FROM imdb_top_1000
GROUP BY Released_Year
ORDER BY Movie_Count DESC

-- 3. Top 10 Directors with the Most Movies
SELECT TOP 10 Director, COUNT(*) AS Movie_Count
FROM imdb_top_1000
GROUP BY Director
ORDER BY Movie_Count DESC

-- 4. List the bottom 10 movies with the lowest IMDB ratings
SELECT TOP 10 Series_Title, IMDB_Rating
FROM imdb_top_1000
ORDER BY IMDB_Rating ASC

-- 5. Top 10 Directors with the Highest IMDB Ratings for Their Movies
SELECT TOP 10 Director, Series_Title, IMDB_Rating
FROM imdb_top_1000
ORDER BY IMDB_Rating DESC

-- 6. Top 10 IMDB Rated Movies by Year
SELECT TOP 10 Released_Year, Series_Title, IMDB_Rating
FROM imdb_top_1000 AS movies
WHERE IMDB_Rating = (
    SELECT MAX(IMDB_Rating)
    FROM imdb_top_1000
    WHERE Released_Year = movies.Released_Year
)
ORDER BY IMDB_Rating DESC

-- 7. Top 10 Highest Average IMDB Ratings by Year

SELECT TOP 10 Released_Year, ROUND(AVG(IMDB_Rating), 2) AS Average_Rating
FROM imdb_top_1000
GROUP BY Released_Year
ORDER BY Average_Rating DESC
