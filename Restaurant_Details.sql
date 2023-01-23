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

𝗙𝗶𝗹𝗲𝗻𝗮𝗺𝗲: 𝗥𝗲𝘀𝘁𝗮𝘂𝗿𝗮𝗻𝘁 𝗗𝗲𝘁𝗮𝗶𝗹𝘀

This SQL queries analyzes the restaurants & their cuisine type. This helps to understand the types of restaurants & their cuisines.
*/



--- Q16) Total restaurants in each state
SELECT 
	 State,
	 count(restaurant_id) as Total_restaurant
FROM 	 restaurants
GROUP BY State
Order BY Total_restaurant DESC

--- Q17) Total restaurants in each city
SELECT 
	 city,
	 count(restaurant_id) as Total_restaurant
FROM 	 restaurants
GROUP BY city
Order BY Total_restaurant DESC

--- Q18) Restaurants count by alcohol service 
SELECT 
	 alcohol_service,
	 count(restaurant_id) as Total_restaurant
FROM 	 restaurants
GROUP BY alcohol_service
Order BY Total_restaurant DESC

--- Q19) Restaurants count by smoking allowed
SELECT 
	 smoking_allowed,
	 count(restaurant_id) as Total_restaurant
FROM 	 restaurants
GROUP BY smoking_allowed
Order BY Total_restaurant DESC

--- Q20) Alcohol & Smoking analysis
SELECT 
	 alcohol_service,smoking_allowed,
	 count(restaurant_id) as Total_restaurant
FROM 	 restaurants
GROUP BY alcohol_service,smoking_allowed
Order BY Total_restaurant DESC

--- Q21)Restaurants count by Price
SELECT 
	 price,
	 count(restaurant_id) as Total_restaurant
FROM 	 restaurants
GROUP BY price
Order BY Total_restaurant DESC

--- Q22)Restaurants count by packing
SELECT 
	 parking,
	 count(restaurant_id) as Total_restaurant
FROM 	 restaurants
GROUP BY parking
Order BY Total_restaurant DESC

--- Q23) Count of Restaurants by cuisines
SELECT 
        cuisine,
	count(restaurant_id) AS Total_restaurant
FROM 	restaurant_cuisines
GROUP BY cuisine
ORDER BY Total_restaurant DESC

--- Q24) Preferred cuisines of each customer
SELECT 
	   name,
	   count(cuisine) AS Total_cuisines,
	   String_agg (cuisine, ',') as Cuisines
FROM 	   restaurant_cuisines as a
INNER JOIN restaurants as b
ON         a.restaurant_id = b.restaurant_id
GROUP BY   name
ORDER BY   Total_cuisines DESC


--- Q25) Restaurant price analysis for each cuisine

SELECT
	   b.cuisine,
	   SUM(CASE WHEN a.price = 'High' Then 1 Else 0 END) AS High,
           SUM(CASE WHEN a.price = 'Medium' Then 1 Else 0 END) AS Medium,
	   SUM(CASE WHEN a.price = 'Low' Then 1 Else 0 END) AS Low
FROM 	   restaurants AS a
INNER JOIN restaurant_cuisines AS b
ON         a.restaurant_id = b.restaurant_id
GROUP BY   b.cuisine
ORDER BY   b.cuisine


--- Q26) Finding out count of each cuisine in each state

SELECT
	   b.cuisine,
	   SUM(CASE WHEN a.state = 'Morelos' Then 1 Else 0 END) AS Morelos,
	   SUM(CASE WHEN a.state = 'San Luis Potosi' Then 1 Else 0 END) AS San_Luis_Potosi,
	   SUM(CASE WHEN a.state = 'Tamaulipas' Then 1 Else 0 END) AS Tamaulipas
FROM 	   restaurants AS a
INNER JOIN restaurant_cuisines AS b
ON         a.restaurant_id = b.restaurant_id
GROUP BY   b.cuisine
ORDER BY   b.cuisine
