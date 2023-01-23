--- Title :-        Restaurant Ratings Analysis
--- Created by :-   Vinit Sangoi & Mausumi Meher
--- Date :-         19-07-2022
--- Tool used:-     PostgreSQL

/*
𝗜𝗻𝘁𝗿𝗼𝗱𝘂𝗰𝘁𝗶𝗼𝗻:
► In this project, we will be analyzing restaurant ratings data to gain insights into the performance of various restaurants.
► We will use SQL to extract, transform and analyze the data.
► The insights gained from this analysis will be used to understand the factors that influence a restaurant's rating and make recommendations for improvement.
► We will examine the relationship between different variables such as the location, cuisine and price range of the restaurants and their ratings.
► We will also do sentiment analysis to analyse most favorable restaurants of customers

𝗙𝗶𝗹𝗲𝗻𝗮𝗺𝗲: 𝗥𝗮𝘁𝗶𝗻𝗴𝘀 𝗔𝗻𝗮𝗹𝘆𝘀𝗶𝘀

This SQL queries analyzes the ratings given by customers to restaurants. This helps to understand the customer choice & restaurants performance better.
*/


--- Q27) Ratings given by customer for restaurants
SELECT 
	   b.consumer_id,
	   a.name,
	   b.overall_rating,
	   b.food_rating,
	   b.service_rating
FROM       restaurants as a 
INNER JOIN customer_ratings as b
ON         a.restaurant_id = b.restaurant_id
ORDER BY   b.restaurant_id


--- Q28) Average ratings of each restaurant including it's cuisine type
SELECT 
	   a.name,
	   ROUND(AVG(b.overall_rating),2)as overall_Rating,
	   ROUND(AVG(b.food_rating),2)as food_rating,
	   ROUND(AVG(b.service_rating),2)as service_rating,
	   c.cuisine
FROM       restaurants as a 
INNER JOIN customer_ratings as b
ON         a.restaurant_id = b.restaurant_id
INNER JOIN restaurant_cuisines AS c
ON         a.restaurant_id = c.restaurant_id
GROUP BY   a.name,c.cuisine
ORDER BY   a.name

--- Q29) Creating new columns for sentiment analysis
ALTER TABLE customer_ratings ADD COLUMN overall_senti Varchar(50)
ALTER TABLE customer_ratings ADD COLUMN food_senti Varchar(50)
ALTER TABLE customer_ratings ADD COLUMN service_senti Varchar(50)

SELECT * FROM customer_ratings


--- Q30) Updating the new columns with the sentiments 

UPDATE customer_ratings
SET overall_senti = CASE WHEN overall_rating = 0 then 'Negative'
			 WHEN overall_rating = 1 then 'Neutral'	
			 WHEN overall_rating = 2 then 'Positive'
			 END
WHERE overall_senti is null

UPDATE customer_ratings
SET food_senti = CASE WHEN food_rating = 0 then 'Negative'
		      WHEN food_rating = 1 then 'Neutral'	
		      WHEN food_rating = 2 then 'Positive'
		      END
WHERE food_senti is null

UPDATE customer_ratings
SET service_senti = CASE WHEN service_rating = 0 then 'Negative'
			 WHEN service_rating = 1 then 'Neutral'	
			 WHEN service_rating = 2 then 'Positive'
			 END
WHERE service_senti is null


--- Q31) Conduct a sentimental analysis of total count of customers
CREATE VIEW overall AS (
SELECT 
	overall_senti,
	count(consumer_id) as total_customers
FROM 	customer_ratings
GROUP BY overall_senti


CREATE VIEW food AS (
SELECT 
	food_senti,
	count(consumer_id) as total_customers
FROM 	customer_ratings
GROUP BY food_senti


CREATE VIEW service AS (
SELECT 
	service_senti,
	count(consumer_id) as total_customers
FROM 	customer_ratings
GROUP BY service_senti


SELECT
	   a.overall_senti as Sentiment,
	   a.total_customers as Overall_Rating,
	   b.total_customers as food_Rating,
	   c.total_customers as service_Rating
FROM       overall as a
INNER JOIN food as b
ON         a.overall_senti = b.food_senti
INNER JOIN service as c
ON         a.overall_senti = c.service_senti


--- Q32) List of Customers visiting local or outside restaurants

SELECT 
	   a.consumer_id,
	   b.city as customer_city,
	   c.name,
	   c.city as restaurant_city,
	   a.overall_senti,
	   a.food_senti,
	   a.service_senti,
	   CASE WHEN b.city = c.city THEN 'Local' ELSE 'Outside' END as Location_preference
FROM       customer_ratings as a
INNER JOIN customer_details as b
ON         a.consumer_id = b.consumer_id
INNER JOIN restaurants as c
ON         a.restaurant_id = c.restaurant_id


--- Q33) Count of customers visiting local and outside restaurants

SELECT 
	Location_preference,
	count(*) as total_customers,
	count( distinct id) as distinct_customers
FROM 	(    SELECT 
			 a.consumer_id as id,
			 b.city as customer_city,
			 c.name,
			 c.city as restaurant_city,
			 a.overall_senti,
			 a.food_senti,
			 a.service_senti,
			 CASE WHEN b.city = c.city THEN 'Local' ELSE 'Outside' END as Location_preference
	      FROM       customer_ratings as a
	      INNER JOIN customer_details as b
	      ON         a.consumer_id = b.consumer_id
	      INNER JOIN restaurants as c
	      ON         a.restaurant_id = c.restaurant_id ) as cte
GROUP BY  Location_preference				
		
		
--- Q34) Trend of customers visiting outside restaurants

SELECT 
	customer_id,
	customer_city,
	restaurant_city,
	concat_ws(' - ',customer_city , restaurant_city) as direction,
	restaurant_name		
FROM 	(  SELECT 
		     a.consumer_id as customer_id,
		     b.city as customer_city,
		     c.name as restaurant_name,
		     c.city as restaurant_city,
	             a.overall_senti,
	             a.food_senti,
	             a.service_senti,
	  CASE WHEN  b.city = c.city THEN 'Local' ELSE 'Outside' END as Location_preference
	  FROM       customer_ratings as a
	  INNER JOIN customer_details as b
	  ON         a.consumer_id = b.consumer_id
	  INNER JOIN restaurants as c
	  ON         a.restaurant_id = c.restaurant_id )	as cte
WHERE  Location_preference = 'Outside'

		
		
--- Q35) Count of direction trend from above query

SELECT
	direction,
	count(customer_id) as total_customers

FROM    (  SELECT 
		customer_id,
		customer_city,
		restaurant_city,
		concat_ws(' - ',customer_city , restaurant_city) as direction,
		restaurant_name
		
	    FROM    (  SELECT 
				   a.consumer_id as customer_id,
				   b.city as customer_city,
				   c.name as restaurant_name,
				   c.city as restaurant_city,
				   a.overall_senti,
				   a.food_senti,
				   a.service_senti,
			CASE WHEN  b.city = c.city THEN 'Local' ELSE 'Outside' END as Location_preference
			FROM       customer_ratings as a
			INNER JOIN customer_details as b
			ON         a.consumer_id = b.consumer_id
			INNER JOIN restaurants as c
			ON         a.restaurant_id = c.restaurant_id )	as cte
	     WHERE   Location_preference = 'Outside' ) cte2
GROUP BY direction


--- Q36) Cuisine preferences vs cuisine consumed

SELECT 
	   a.consumer_id,
	   string_agg(b.preferred_cuisine,',') as customer_preferences,
	   d.name,
	   c.cuisine as restaurant_cuisine
FROM       customer_ratings as a
INNER JOIN customer_preference as b
ON         a.consumer_id = b.consumer_id
INNER JOIN restaurant_cuisines as c
ON         a.restaurant_id = c.restaurant_id
INNER JOIN restaurants as d
ON         a.restaurant_id = d.restaurant_id
GROUP BY   a.consumer_id, d.name, c.cuisine


--- Q37) Best restaurants for each cuisines by different ratings
CREATE VIEW average_analysis as (
SELECT 
	   a.name,
	   ROUND(AVG(b.overall_rating),2)as overall_Rating,
	   ROUND(AVG(b.food_rating),2)as food_rating,
	   ROUND(AVG(b.service_rating),2)as service_rating,
	   c.cuisine
FROM       restaurants as a 
INNER JOIN customer_ratings as b
ON         a.restaurant_id = b.restaurant_id
INNER JOIN restaurant_cuisines AS c
ON         a.restaurant_id = c.restaurant_id
GROUP BY   a.name,c.cuisine
ORDER BY   c.cuisine)
	

CREATE VIEW best  as (
SELECT 
     cuisine,
     First_value(name) OVER(partition by cuisine ORDER BY overall_rating desc) as best_for_overall,
     First_value(name) OVER(partition by cuisine ORDER BY food_rating desc) as best_for_food,
     First_value(name) OVER(partition by cuisine ORDER BY service_rating desc) as best_for_service
FROM average_analysis

SELECT   *
FROM     best
GROUP BY cuisine, best_for_overall, best_for_food, best_for_service
ORDER BY cuisine	

	
--- Q38) Best restaurants for each cuisines by different ratings
	
CREATE VIEW count_cuisines as (
SELECT 	
		cuisine,
		count(cuisine)	as count
FROM average_analysis
GROUP BY cuisine	)	
		
CREATE VIEW bad as (
SELECT 
		cuisine,
		First_value(name) OVER(partition by cuisine ORDER BY overall_rating ) as bad_for_overall,
		First_value(name) OVER(partition by cuisine ORDER BY food_rating ) as bad_for_food,
		First_value(name) OVER(partition by cuisine ORDER BY service_rating ) as bad_for_service	
FROM ( 	
		SELECT 
				a.name,
				ROUND(AVG(a.overall_rating),2)as overall_Rating,
				ROUND(AVG(a.food_rating),2)as food_rating,
				ROUND(AVG(a.service_rating),2)as service_rating,
				a.cuisine,
				cc.count
		FROM average_analysis as a
		INNER JOIN count_cuisines as cc
		ON a.cuisine = cc.cuisine
		WHERE cc.count > 1	
		GROUP BY a.name,a.cuisine,cc.count
		ORDER BY a.cuisine	) as least )


SELECT 
		*
FROM bad
GROUP BY cuisine, bad_for_overall, bad_for_food, bad_for_service
ORDER BY cuisine	

	
--- Q39) Best cuisines by different ratings
	
SELECT 
		First_value(cuisine) OVER(ORDER BY overall_rating desc) as overall,
		First_value(cuisine) OVER(ORDER BY food_rating desc) as food,
		First_value(cuisine) OVER(ORDER BY service_rating desc) as service
FROM average_analysis
LIMIT 1	


--- Q40) Total customers with highest ratings in all different criteria
SELECT 
		count(consumer_id) as total_customers
FROM 	customer_ratings
WHERE 	overall_rating = 2 and
		food_rating = 2 and
		service_rating = 2
