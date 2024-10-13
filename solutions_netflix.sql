-- 13 Business Problems & Solutions

Use netflix_sql_db;

	select * from netflix;
	-- 1. Count the number of Movies vs TV Shows
	select type , count(type)
	from netflix
	group by type;

-- 2. Find the most common rating for movies and TV shows

	select type ,rating 
	from(
	select type, rating ,count(*) , rank() over (partition by type order by count(*) desc) as ranking
	from netflix
	group by type,rating
	) as t1
	where ranking = 1;

-- 3. List all movies released in a specific year (e.g., 2020)

	select *from netflix
	where type ='Movie' AND release_year=2020;

-- 4. Find the top 5 countries with the most content on Netflix
	
	select country , count(country)
    from netflix
    group by country
    order by 2 desc
    limit 5 ;

-- 5. Identify the longest movie
    select * from netflix 
    where type ='Movie'
			AND duration =(select max(duration) from netflix);
            
--  6. Find content added in the last 5 years
	SELECT *
	FROM netflix
	WHERE date_added >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
	select * from netflix
    where lower(director) LIKE '%rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons
	SELECT *
	FROM netflix
	WHERE type = 'TV Show'
	AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;

-- 10.Find each year and the average numbers of content release in India on netflix.return top 5 year with highest avg content release!
	

-- 11. List all movies that are documentaries
	SELECT * FROM netflix
WHERE listed_in LIKE '%Documentaries';

-- 12. Find all content without a director
	SELECT * FROM netflix
    WHERE director IS NULL;
    
-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
	select *
    from netflix
    where casts like '%Salman Khan%'
		AND  release_year > YEAR(CURDATE()) - 10 ;
  
-- 14.Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field.
-- Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category.

SELECT category ,  count(category) as category_count
FROM
	(SELECT *, CASE
		WHEN description LIKE '%kill%' OR description LIKE '%voilence%' THEN "Bad"
        ELSE "Good"
        END AS category
	from netflix
    ) as categorized_country
group by 1







