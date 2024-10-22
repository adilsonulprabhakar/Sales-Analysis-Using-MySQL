DESCRIBE sales;
DESCRIBE stores;
DESCRIBE features;

-- Finding Missing Value in table Features
SELECT 
    COUNT(*) AS TotalRows,
    COUNT(*) - COUNT(Temperature) AS MissingTemperature,
    COUNT(*) - COUNT(Fuel_Price) AS MissingFuelPrice,
    COUNT(*) - COUNT(CPI) AS MissingCPI,
    COUNT(*) - COUNT(Unemployment) AS MissingUnemployment,
    COUNT(*) - COUNT(IsHoliday) AS MissingIsHoliday
FROM
    features;

-- Finding Missing Value in table Stores
SELECT 
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(store) AS missing_store,
    COUNT(*) - COUNT(dept) AS missing_dept,
    COUNT(*) - COUNT(date) AS missing_date,
    COUNT(*) - COUNT(weekly_sales) AS missing_sales,
    COUNT(*) - COUNT(isholiday) AS missing_holyday
FROM
    sales;

-- Finding Missing Value in table Sales
SELECT 
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(store) AS missing_store,
    COUNT(*) - COUNT(type) AS missing_type,
    COUNT(*) - COUNT(size) AS missing_size
FROM
    stores;

-- Imputation Strategy (for Features)
-- Calculate the mean for CPI
SELECT round(AVG(CPI),2) AS Avg_CPI FROM features WHERE CPI IS NOT NULL;

-- Calculate the mean for Unemployment
SELECT round(AVG(Unemployment),2) AS Avg_Unemployment FROM features WHERE Unemployment IS NOT NULL;

UPDATE features
SET 
    CPI = COALESCE(CPI, 202.21),  -- Replace missing CPI with mean
    Unemployment = COALESCE(Unemployment, 6.92)  -- Replace missing Unemployment with mean
WHERE 
    CPI IS NULL OR Unemployment IS NULL;
    
--------------------------------------------------------------------------------------------------------------

-- 	What is the trend of weekly sales over time? Are there any seasonal patterns?
SELECT 
    Date, ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales
FROM
    Sales
GROUP BY Date
ORDER BY Date;

----------------------------------------------------------------------------------------------------------------

--  how weekly sales differ by store and department?

SELECT 
    store,
    dept,
    ROUND(SUM(weekly_sales), 2) AS Total_Weekly_Sales
FROM
    sales
GROUP BY store , dept
ORDER BY store , Total_Weekly_Sales DESC;

------------------------------------
-- Which department from each store have the highest Sales?

with Store_dept_Sales as (
SELECT 
    store,
    dept,
    ROUND(SUM(weekly_sales), 2) AS Total_Weekly_Sales
FROM
    sales
GROUP BY store , dept
ORDER BY store , Total_Weekly_Sales DESC
)

SELECT 
    store, dept, total_weekly_sales
FROM
    store_dept_sales
WHERE
    (store , total_weekly_sales) IN (SELECT 
            store, MAX(total_weekly_sales)
        FROM
            store_dept_sales
        GROUP BY store)
ORDER BY store;

------------------------------------------------------------------------------------------------------

-- What are the total sales during holidays compared to non-holidays?

SELECT 
    CASE
        WHEN isholiday = 1 THEN 'Holiday'
        ELSE 'Non-Holiday'
    END AS holiday_status,
    ROUND(SUM(weekly_sales), 2) AS Total_Sales
FROM
    sales
GROUP BY isholiday
ORDER BY total_sales desc;

--------------------------------------------

-- What is the average weekly sales for each store?

SELECT 
    store, ROUND(AVG(weekly_sales), 2) AS Avg_Sales
FROM
    sales
GROUP BY store
ORDER BY store;

-------------------------------------------------

-- Which store has the highest total sales across all departments?

SELECT 
    store, ROUND(SUM(weekly_sales), 2) AS Total_Sales
FROM
    sales
GROUP BY store
ORDER BY Total_sales DESC
limit 1;

---------------------------------------

--  What is the total sales for each department across all stores?

SELECT 
    dept, ROUND(SUM(weekly_sales), 2) AS Total_dept_Sales
FROM
    sales
GROUP BY dept
ORDER BY Total_dept_Sales DESC;

------------------------------------------

-- Which department has the highest average weekly sales across all stores?

SELECT 
    dept, ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales
FROM
    sales
GROUP BY dept
ORDER BY avg_weekly_sales DESC
LIMIT 1;

------------------------------------

-- How does the average weekly sales vary by store type?

SELECT 
    st.type AS Store_Type,
    ROUND(AVG(sa.weekly_sales), 2) AS Total_Weekly_Sales
FROM
    stores st
        JOIN
    sales sa ON st.store = sa.store
GROUP BY st.type
ORDER BY Total_Weekly_Sales DESC;

------------------------------------------------------

-- What is the total weekly sales trend over time?

SELECT 
    DATE_FORMAT(Date, '%Y-%m-%d') AS Sales_Date,
    ROUND(SUM(Weekly_Sales), 2) AS Total_Weekly_Sales
FROM 
    sales
GROUP BY 
    Sales_Date
ORDER BY 
    Sales_Date;

------------------------------------------------

-- Are there specific holidays that result in significantly higher sales?

SELECT 
    f.date AS holiday_date,
    ROUND(SUM(s.weekly_sales), 2) AS total_sales
FROM 
    sales s
JOIN 
    features f ON s.date = f.date AND s.Store = f.Store
WHERE 
    f.IsHoliday = 1
GROUP BY 
    f.date
ORDER BY 
    total_sales DESC;
    
------------------------------------------------------------

-- What is the average temperature on holidays vs. non-holidays affecting sales?

SELECT 
    CASE
        WHEN isholiday = 1 THEN 'holiday'
        ELSE 'non-holiday'
    END AS holiday_Status,
    ROUND(AVG(temperature), 2) AS Avg_weekly_sales
FROM
    features
GROUP BY isholiday;

-----------------------------------------------

-- What is the impact of Fuel Price on Weekly Sales?

SELECT 
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales,
    ROUND(AVG(Fuel_Price), 2) AS Average_Fuel_Price
FROM
    sales sa
        JOIN
    features f ON sa.Store = f.Store AND sa.Date = f.Date
GROUP BY f.Fuel_Price
ORDER BY f.Fuel_Price;

--------------------------------------------------------
-- What is the unemployment rate across different store types?

SELECT 
    s.Type AS Store_Type,
    ROUND(AVG(f.Unemployment), 2) AS Average_Unemployment
FROM 
    stores s
JOIN 
    features f ON s.Store = f.Store
GROUP BY 
    s.Type
ORDER BY 
    Store_Type;

-----------------------------------------------------------------

-- Are there departments that consistently perform poorly in sales?

-- Step 1: Calculate total weekly sales per department
WITH department_sales AS (
    SELECT 
        Dept,
        SUM(Weekly_Sales) AS Total_Sales,
        COUNT(DISTINCT Date) AS Weeks_Active
    FROM 
        Sales
    GROUP BY 
        Dept
),

-- Step 2: Calculate average weekly sales per department
average_sales AS (
    SELECT 
        Dept,
        Total_Sales,
        Weeks_Active,
        ROUND(Total_Sales / Weeks_Active, 2) AS Average_Weekly_Sales
    FROM 
        department_sales
)

-- Step 3: Identify poorly performing departments (below overall average)
SELECT 
    Dept,
    Total_Sales,
    Average_Weekly_Sales
FROM 
    average_sales
WHERE 
    Average_Weekly_Sales < (SELECT AVG(Average_Weekly_Sales) FROM average_sales)
ORDER BY 
    Average_Weekly_Sales ASC;

-- OR

SELECT 
    Dept,
    round(SUM(Weekly_Sales),2) AS Total_Sales,
    ROUND(AVG(Weekly_Sales), 2) AS Average_Weekly_Sales
FROM 
    Sales
GROUP BY 
    Dept
HAVING 
    Average_Weekly_Sales < (SELECT AVG(Weekly_Sales) FROM Sales)
ORDER BY 
    Average_Weekly_Sales ASC;
    
-------------------------------------------------------------------

-- How does the size of the store relate to its average weekly sales?

SELECT 
    st.store,
    st.size,
    ROUND(AVG(sa.weekly_sales), 2) AS avg_weekly_sales
FROM
    stores st
        JOIN
    sales sa ON st.store = sa.store
GROUP BY st.store , st.size
ORDER BY avg_weekly_sales DESC;

----------------------

-- Are there any trends in sales related to specific store types over time?

SELECT 
    st.type,
    YEAR(s.date) AS year,
    MONTH(s.date) AS month,
    ROUND(SUM(weekly_sales), 2) AS total_sales
FROM
    stores st
        JOIN
    sales s ON st.store = s.store
GROUP BY st.type , year , month
ORDER BY st.type , year , month;
 
-----------------------------------------------------------

-- How does temperature affect weekly sales?

with temp_sales as
(
select f.temperature ,round(sum(s.weekly_sales),2) as total_sales
from features f
join sales s
on f.store=s.store and f.date=s.date
group by f.temperature)

select temperature,total_sales
from temp_sales
where (total_sales) in (select max(total_sales) from temp_sales);

-- OR

select f.temperature ,round(sum(s.weekly_sales),2) as total_sales
from features f
join sales s
on f.store=s.store and f.date=s.date
group by f.temperature
order by total_sales desc;

------------------------------------------------------
--  Is there a specific temperature range where sales peak?

 SELECT 
    MAX(temperature), MIN(temperature)
FROM
    features; -- find the range of temperatures in the data set

SELECT 
    CASE
        WHEN f.temperature BETWEEN - 15 AND 0 THEN 'coldest'
        WHEN f.temperature BETWEEN 0 AND 50 THEN 'cold'
        WHEN f.temperature BETWEEN 50 AND 68 THEN 'moderate'
        WHEN f.temperature BETWEEN 68 AND 86 THEN 'hot'
        WHEN f.temperature > 86 THEN 'hottest'
    END AS weather,
    ROUND(SUM(s.weekly_sales), 2) AS total_sales,
    ROUND(AVG(s.weekly_sales), 2) AS avg_sales
FROM
    sales s
        JOIN
    features f ON f.store = s.store AND f.date = s.date
GROUP BY weather
ORDER BY total_sales DESC , avg_sales DESC;

-----------------------------------------------------

-- What is the relationship between fuel prices and sales?

SELECT 
    f.fuel_price,
    ROUND(SUM(s.weekly_sales), 2) AS total_sales,
    ROUND(AVG(s.weekly_sales), 2) AS total_avg_sales
FROM
    features f
        JOIN
    sales s ON f.store = s.store AND f.date = s.date
GROUP BY f.fuel_price
ORDER BY total_avg_sales DESC;

--------------------------------------------------------------

-- Do economic conditions (CPI and Unemployment) have a noticeable impact on sales trends?

SElect max(cpi),min(cpi)
from features;

select max(unemployment),min(unemployment)
from features;
	
select 
case 
	when f.cpi between 100 and 150 then 'low : 100-150'
    when f.cpi between 150 and 200 then 'medium : 150-200'
    when f.cpi>200 then 'High : >200'
end as CPI_Rate,
case
	when f.unemployment between 0 and 4 then 'low : 0%-4%'
    when f.unemployment between 4 and 8 then 'medium : 4%-8%'
    when f.unemployment >8 then 'High : >8%'
end as Unemployment_rate,
round(sum(s.Weekly_Sales),2) as total_weekly_sales,
round(avg(s.Weekly_Sales),2) as total_avg_sales
from features f 
join sales s
on f.store=s.store and f.date=s.date
group by cpi_rate,unemployment_rate
order by total_weekly_sales desc,total_avg_sales desc;

--------------------------------------------------------------------




