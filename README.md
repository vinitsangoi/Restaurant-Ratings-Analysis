![Welcome to my Github Profile](https://github.com/vinitsangoi/Restaurant-Ratings-Analysis/blob/main/Restaurantanalysisbg.png)

* Title :-        **Restaurant Ratings Analysis**
* Created by :-   Vinit Sangoi & Mausumi Meher
* Date :-         19-01-2023
* Tool used:-     ![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=flat&logo=postgresql&logoColor=white) 

# Introduction :- 
* In this project, we will be analyzing restaurant ratings data to gain insights into the performance of various restaurants.
* We will use SQL to extract, transform and analyze the data.
* The insights gained from this analysis will be used to understand the factors that influence a restaurant's rating and make recommendations for improvement.
* We will examine the relationship between different variables such as the location, cuisine and price range of the restaurants and their ratings.
* We will also do sentiment analysis to analyse most favorable restaurants of customers

# Data :- 
* We found this dataset from Maven Analytics. Restaurant ratings in Mexico by real consumers from 2012 with 5 CSV Files.
* Customer Details: The table contains customer information.
* Customer preference: This table contains customer cuisine preferences.
* Restaurants: The dataset includes restaurant details
* Restaurant's Cuisine: The table contains cuisines offered by each restaurant.
* Customer Ratings: This dataset is the main table in the project. It includes information regarding customer ratings.

# Approach :
* Acquired the restaurant ratings data from a publicly available source and import it into a SQL database.
* Used SQL to clean the data and ensure that it is in a format that can be easily analyzed. This will involve tasks such as removing duplicate records, handling missing values, and standardizing data formats.
* Use SQL to extract relevant information from the data, such as the average rating for each restaurant, the number of reviews, and the location of the restaurant.
* Analyzed the datasets using advanced SQL to identify patterns and trends in the data.
* We analyzed various metrics using SQL commands & functions.
* We used the insights gained from the analysis to make recommendations for improvement for the restaurants, and suggest ways in which the data can be used to drive business decisions.

# SQL Functions Used :
* DDL
* DML
* Joins
* Subqueries
* Multiple joins
* Case statements
* Logical conditions
* Nested subqueries
* Windows functions

-------
# Key Insights:-
## 1. Customer Demographics: [Click Here](https://github.com/vinitsangoi/Restaurant-Ratings-Analysis/blob/main/customer_demographics.sql)
* 62% customers are from "San Luis Potosi". 
* 70% customers have medium budget & 0.4% customers have high budget.
* Most of the drinkers & smokers are students and they are casual drinkers or social drinkers.
* 80% of our customers are in the age bucket of 18-25
* Most preferred cuisines are Mexican, American, Pizzeria, Cafeteria & Coffee shop.

## 2. Restaurant Details: [Click Here](https://github.com/vinitsangoi/Restaurant-Ratings-Analysis/blob/main/Restaurant_Details.sql)
* There are a total 129 restaurants & majority are in the city of "San Luis Potosi".
* Only 41 restaurants are serving drinks & 65 restaurants don't have parking.
* Most restaurants offer cuisines like Mexican, Bar, Cafeteria, Fast Food, Brewery, Seafood, Burgers.
* 18% of restaurants are of High budget, 49% of them are of Medium budget & 33% are low budget.

## Ratings Analysis: [Click Here](https://github.com/vinitsangoi/Restaurant-Ratings-Analysis/blob/main/Ratings_Analysis.sql)
* There are 26 restaurants who received an average overall rating of more than 1.50.
* 44% responses from the customers were positive for the food experience.
* 22% responses from the customers were negative for overall experience.
* 131 customers are visiting their local restaurants & 14 customers are visiting outside of their locality.
* Customers from cities of Ciudad Victoria, Cuernavaca & jiutepec are visiting restaurants of San Luis Potosi.
* We analyzed the best restaurants for each cuisine based on average ratings.
* We analyzed bad restaurants for each cuisine based on average ratings.
* For overall & food experience best average cuisine is International & for food experience it is Mexican.
* There are 293 responses (25%) of customers who gave the highest ratings in all the experiences.

