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

-- 8. Average IMDb Ratings by Actor  

SELECT TOP 10 Star1, COUNT(*) Movie_count, ROUND(AVG(IMDB_Rating),2) Avg_rating
FROM imdb_top_1000
GROUP BY Star1
HAVING COUNT(*) >= 3
Order by Avg_rating DESC

-- 9. Top 10 Directors with the Highest Average IMDb Ratings 

SELECT TOP 10 Director, COUNT(*) AS Movie_Count, ROUND(AVG(IMDB_Rating), 2) AS Avg_Rating
FROM imdb_top_1000
GROUP BY Director
ORDER BY Avg_Rating DESC

-- 10. Top Genres by Highest IMDB Rating

SELECT Series_Title,IMDB_Rating,Genre,
    TRIM(SUBSTRING(Genre, 1, CHARINDEX(',', Genre + ',') - 1)) AS Genre1,
    CASE 
    WHEN CHARINDEX(',', Genre) > 0 
    THEN TRIM(SUBSTRING(Genre, CHARINDEX(',', Genre + ',') + 1, CHARINDEX(',', Genre + ',', CHARINDEX(',', Genre + ',') + 1) - CHARINDEX(',', Genre + ',') - 1)) 
    ELSE NULL 
    END AS Genre2,
    CASE 
    WHEN LEN(Genre) - LEN(REPLACE(Genre, ',', '')) > 1 
    THEN TRIM(SUBSTRING(Genre, CHARINDEX(',', Genre + ',', CHARINDEX(',', Genre + ',') + 1) + 1, LEN(Genre))) 
    ELSE NULL 
    END AS Genre3
INTO #TempGenres
FROM imdb_top_1000

SELECT 
    Genre1 AS Genre, 
    ROUND(AVG(IMDB_Rating), 2) AS Avg_Rating
FROM #TempGenres
GROUP BY Genre1
ORDER BY Avg_Rating DESC

DROP TABLE #Genre_Table



