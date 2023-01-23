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

𝗙𝗶𝗹𝗲𝗻𝗮𝗺𝗲: 𝗖𝘂𝘀𝘁𝗼𝗺𝗲𝗿 𝗗𝗲𝗺𝗼𝗴𝗿𝗮𝗽𝗵𝗶𝗰𝘀 𝗔𝗻𝗮𝗹𝘆𝘀𝗶𝘀

This SQL queries analyzes the customers & their cuisines preferences. This helps to understand the types of customers & their preferences.
*/


--- Q1) Total Customers in each state
SELECT 
	 State,
	 count(consumer_id) as Total_Customers
FROM 	 customer_details
GROUP BY State
Order BY Total_Customers DESC
	
	
--- Q2) Total Customers in each city
SELECT 
	 city,
	 count(consumer_id) as Total_Customers
FROM 	 customer_details
GROUP BY city
Order BY Total_Customers DESC	

--- Q2) Total Customers in each city
SELECT 
	 city,
	 count(consumer_id) as Total_Customers
FROM 	 customer_details
GROUP BY city
Order BY Total_Customers DESC	


--- Q3) Budget level of customers
SELECT 
	 budget,
	 count(consumer_id) as Total_Customers
FROM 	 customer_details
WHERE 	 budget is not null
GROUP BY budget

--- Q4) Total Smokers by Occupation
SELECT 
	 occupation,
	 count(consumer_id) as Smokers
FROM 	 customer_details
WHERE 	 smoker = 'Yes'
GROUP BY occupation

--- Q5) Drinking level of students
SELECT 
	 drink_level,
	 count(consumer_id) as student_count
FROM 	 customer_details
WHERE 	 occupation = 'Student' and occupation is not null
GROUP BY drink_level

--- Q6) Transportation methods of customers
SELECT 
	 transportation_method,
	 count(consumer_id) as Total_Customers
FROM 	 customer_details
WHERE 	 transportation_method is not null	
GROUP BY transportation_method
Order BY Total_Customers DESC

--- Q7) Adding Age Bucket Column 
ALTER TABLE customer_details 
ADD COLUMN  Age_Bucket Varchar(50)


--- Q8) Updating the Age Bucket column with case when condition
UPDATE customer_details
SET age_bucket = CASE WHEN age > 60 then '61 and Above'
		      WHEN age > 40 then '41 - 60'	
		      WHEN age > 25 then '26 - 40'
		      WHEN age >= 18 then '18 - 25'
		      END
WHERE age_bucket is null					  
	
	
--- Q9) Total customers in each age bucket
SELECT 
	 age_bucket,
	 count(consumer_id) as Total_Customers
FROM 	 customer_details
GROUP BY age_bucket
Order BY age_bucket
	

--- Q10) Total customers count & smokers count in each age percent 
SELECT 
	 age_bucket,
	 count(consumer_id) as total,
	 count(case when smoker = 'Yes' Then consumer_id end) as smokerscount
FROM 	 customer_details
GROUP BY age_bucket
Order BY age_bucket	


SELECT * FROM customer_preference
	
--- Q11) Top 20 preferred cuisines
SELECT 
	 preferred_cuisine,
	 count(consumer_id) AS total_customers
FROM 	 customer_preference	
GROUP BY preferred_cuisine
ORDER BY total_customers DESC
LIMIT 20


--- Q12) Preferred cuisines of each customer
SELECT 
        consumer_id,
	count(preferred_cuisine) AS total_cuisines,
	String_agg (preferred_cuisine, ',') as Cuisines
FROM 	customer_preference
GROUP BY consumer_id
ORDER BY total_cuisines DESC


--- Q13) Customer Budget analysis for each cuisine

SELECT
	   b.preferred_cuisine,
	   SUM(CASE WHEN a.budget = 'High' Then 1 Else 0 END) AS High,
	   SUM(CASE WHEN a.budget = 'Medium' Then 1 Else 0 END) AS Medium,
	   SUM(CASE WHEN a.budget = 'Low' Then 1 Else 0 END) AS Low
FROM 	   customer_details AS a
INNER JOIN customer_preference AS b
ON 	   a.consumer_id = b.consumer_id
GROUP BY   b.preferred_cuisine
ORDER BY   b.preferred_cuisine


--- Q14) Finding out count of each cuisine in each state

SELECT
	   a.state,
	   b.preferred_cuisine
FROM 	   customer_details AS a
INNER JOIN customer_preference AS b
ON         a.consumer_id = b.consumer_id
GROUP BY   a.state, b.preferred_cuisine
ORDER BY   a.state

SELECT
	   b.preferred_cuisine,
	   SUM(CASE WHEN a.state = 'Morelos' Then 1 Else 0 END) AS Morelos,
	   SUM(CASE WHEN a.state = 'San Luis Potosi' Then 1 Else 0 END) AS San_Luis_Potosi,
	   SUM(CASE WHEN a.state = 'Tamaulipas' Then 1 Else 0 END) AS Tamaulipas
FROM 	   customer_details AS a
INNER JOIN customer_preference AS b
ON         a.consumer_id = b.consumer_id
GROUP BY   b.preferred_cuisine
ORDER BY   b.preferred_cuisine


--- Q15) Finding out count of each cuisine in each age bucket
SELECT
	   b.preferred_cuisine,
	   SUM(CASE WHEN a.age_bucket = '18 - 25' Then 1 Else 0 END) AS "18 - 25",
	   SUM(CASE WHEN a.age_bucket = '26 - 40' Then 1 Else 0 END) AS "26 - 40",
           SUM(CASE WHEN a.age_bucket = '41 - 60' Then 1 Else 0 END) AS "41 - 60",
	   SUM(CASE WHEN a.age_bucket = '61 and Above' Then 1 Else 0 END) AS "61+"
FROM 	   customer_details AS a
INNER JOIN customer_preference AS b
ON         a.consumer_id = b.consumer_id
GROUP BY   b.preferred_cuisine
ORDER BY   b.preferred_cuisine
