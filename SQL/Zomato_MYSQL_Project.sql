CREATE DATABASE Zomato_Sales_Analysis;
use `Zomato_Sales_Analysis`;
select * from main;
select * from countrycode;
select * from currency;
show tables;
desc countrycode;

select count('restaurant name') from main;

---- No of Restaurants -----
select count(RestaurantID) from main;

----- Total Country -------
select count(country) from countrycode;

------ Total City ---------
select count(Distinct city) as Total_Cities from main;

-------- Total Votes -------
select SUM(votes) from main;

------- Average Rating ------------
select AVG(Rating) from main;

-------- Total sales --------------
SELECT SUM(`Average_Cost_for_two` * Votes) FROM main;


 -----  1 .Find the numbers of Restaurants based on city and country-----------
 
 --------- No of Restaurants by CITY wise  --------
select city, count(RestaurantID) as No_of_Restaurants from main
group by city;

----------- No of Restaurants by Country wise  --------

select C.Country, count(M.RestaurantID) as Restaurant_Count
from main M
LEFT JOIN CountryCode C
ON M.countrycode = c.`Country code`
Group by C.Country;


--------- 2. Number of Restaruarants opening based on Year, Month, Quarter ---------------

------- Total Restaurtants open Yearwise -----------
Select year, count(year) as No_of_Resturant 
from main
group by year;


--------- Total Restaurants open Monthwise --------
SELECT 
MONTHNAME(Datekey_Opening) AS MonthName,
COUNT(*) AS No_of_Restaurant
FROM main
GROUP BY MONTHNAME(Datekey_Opening);

------------- Total Restaurants open Quarter wise -----------
Select quarter, count(quarter) as No_of_Resturant
from main
group by quarter;

----------- Numbers of Resturants opening based on Year , Quarter , Month -----------
SELECT 
    YEAR(Datekey_Opening) AS Year,
    QUARTER(Datekey_Opening) AS Quarter,
    MONTH(Datekey_Opening) AS Month,
    COUNT(RestaurantID) AS Total_Restaurants
FROM main
GROUP BY 
    YEAR(Datekey_Opening),
    QUARTER(Datekey_Opening),
    MONTH(Datekey_Opening)
ORDER BY 
    Year, Quarter, Month;
    
---------- 7 . Percentage of Resturants based on "Has_Table_booking" ---------------

SELECT has_table_booking,
COUNT(*) AS count_of_value,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM main), 2) AS percentage FROM main
GROUP BY has_table_booking;

---------- 8 .Percentage of Resturants based on "Has_Online_delivery" ----------

SELECT has_online_delivery,
COUNT(*) AS count_of_value,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM main), 2) AS percentage FROM main
GROUP BY has_online_delivery;

---------- 5.Count of Resturants based o n Average Ratings -------------

SELECT rating, count(rating) as No_Resturant
from main
group by rating
order by count(rating) desc;

----------- 6 .Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets -----------
SELECT 
    CASE 
        WHEN Average_Cost_for_two <= 500 THEN '0-500'
        WHEN Average_Cost_for_two <= 1000 THEN '501-1000'
        WHEN Average_Cost_for_two <= 2000 THEN '1001-2000'
        WHEN Average_Cost_for_two <= 5000 THEN '2001-5000'
        ELSE '5000+'
    END AS Price_Bucket,
    COUNT(*) AS No_of_Restaurants
FROM main
GROUP BY Price_Bucket
ORDER BY Price_Bucket;
