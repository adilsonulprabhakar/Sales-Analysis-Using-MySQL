
# Walmart Sales Analysis Project

## Overview

This project involves analyzing Walmart sales data to extract insights into store performance, department-level trends, and the influence of external factors such as economic conditions and holidays on sales. The goal is to uncover patterns and trends that can help in making data-driven decisions.

## Data

The dataset consists of the following tables:
- **Sales**: Contains sales data including weekly sales, department, and whether the week is a holiday.
- **Stores**: Contains information about the store type and size.
- **Features**: Includes external factors such as temperature, fuel price, CPI, and unemployment rates, along with store and date information.

---

## Data Information

### 1. **Sales Table**
This table contains weekly sales data for different stores and departments.

| Column        | Description                                 | Data Type     |
|---------------|---------------------------------------------|---------------|
| `Store`       | Store identifier                            | `INT`         |
| `Dept`        | Department identifier                       | `INT`         |
| `Date`        | Date of the sales record                    | `DATE`        |
| `Weekly_Sales`| Sales amount for the store and department    | `DECIMAL(10,2)`|
| `IsHoliday`   | Flag to indicate if the week includes a holiday (1 = Holiday, 0 = Non-Holiday) | `TINYINT(1)`  |

### 2. **Stores Table**
This table provides details about the stores, including their types and sizes.

| Column        | Description                                 | Data Type     |
|---------------|---------------------------------------------|---------------|
| `Store`       | Store identifier                            | `INT`         |
| `Type`        | Store type (e.g., A, B, C)                  | `VARCHAR(1)`  |
| `Size`        | Size of the store (in square feet)          | `INT`         |

### 3. **Features Table**
This table contains various economic indicators and factors that might influence sales, such as temperature, fuel prices, and unemployment rates.

| Column        | Description                                 | Data Type     |
|---------------|---------------------------------------------|---------------|
| `Store`       | Store identifier                            | `INT`         |
| `Date`        | Date for the recorded features              | `DATE`        |
| `Temperature` | Average temperature for the given date      | `DECIMAL(5,2)`|
| `Fuel_Price`  | Price of fuel                               | `DECIMAL(5,2)`|
| `MarkDown1`   | MarkDown 1 (promotional discount)           | `DECIMAL(10,2)`|
| `MarkDown2`   | MarkDown 2 (promotional discount)           | `DECIMAL(10,2)`|
| `MarkDown3`   | MarkDown 3 (promotional discount)           | `DECIMAL(10,2)`|
| `MarkDown4`   | MarkDown 4 (promotional discount)           | `DECIMAL(10,2)`|
| `MarkDown5`   | MarkDown 5 (promotional discount)           | `DECIMAL(10,2)`|
| `CPI`         | Consumer Price Index (measures inflation)   | `DECIMAL(10,2)`|
| `Unemployment`| Unemployment rate                          | `DECIMAL(5,2)`|
| `IsHoliday`   | Flag to indicate if the week includes a holiday (1 = Holiday, 0 = Non-Holiday) | `TINYINT(1)`  |

---

### Notes:
- The `Sales` table is linked to the `Stores` and `Features` tables through the `Store` and `Date` columns.
- The `MarkDown` columns indicate promotional discounts that may influence sales performance.
- The `IsHoliday` column in both `Sales` and `Features` helps analyze the effect of holidays on sales performance.

---

## Approach

### 1. Data Wrangling

In this phase, we examined the dataset for missing values and inconsistencies. The data was cleaned and prepared for analysis, ensuring no missing values across the `Sales`, `Stores`, and `Features` tables.

- Checked for null values and confirmed data integrity.
- Ensured correct data types and formats for analysis.
- Imputation Strategy: For missing values in economic data (CPI and Unemployment), the means were calculated and used to replace missing values.
      - Mean CPI: 202.21
      - Mean Unemployment: 6.92
Missing values were replaced using these averages.

### 2. Feature Engineering

We created new features from the existing data to aid in the analysis:
- **Holiday Flag**: Converted the `IsHoliday` field to more descriptive labels (`Holiday` and `Non-Holiday`).
- **Sales Aggregation**: Aggregated sales by store and department to identify top-performing and poorly performing departments.
- **CPI and Unemployment Buckets**: Grouped CPI and Unemployment rates into ranges to analyze their impact on sales.

### 3. Exploratory Data Analysis (EDA)

The EDA phase involved answering key business questions:

#### Product/Department Analysis
- **Top-performing Departments**: Identified the departments with the highest total sales per store using aggregation techniques.
- **Consistently Poor Performing Departments**: Analyzed departments with consistently low sales across stores.

#### Sales Analysis
- **Holiday Impact on Sales**: Analyzed the sales differences between holiday and non-holiday weeks.
- **Seasonality**: Examined sales trends across different times of the year and the impact of markdowns on sales.
- **Temperature and Sales**: Investigated how temperature fluctuations affected weekly sales, finding the optimal temperature range for higher sales.

#### Economic Conditions
- **CPI and Unemployment Impact**: Grouped CPI and Unemployment into ranges and observed how these economic factors influenced total and average weekly sales.


### Business Questions Answered

1. What is the trend of weekly sales over time? Are there any seasonal patterns?
2. How do weekly sales differ by store and department?
3. Which department from each store has the highest sales?
4. What are the total sales during holidays compared to non-holidays?
5. What is the average weekly sales for each store?
6. Which store has the highest total sales across all departments?
7. What is the total sales for each department across all stores?
8. Which department has the highest average weekly sales across all stores?
9. How does the average weekly sales vary by store type?
10. Are there specific holidays that result in significantly higher sales?
11. What is the average temperature on holidays vs. non-holidays affecting sales?
12. What is the impact of Fuel Price on Weekly Sales?
13. What is the unemployment rate across different store types?
14. Are there departments that consistently perform poorly in sales?
15. How does the size of the store relate to its average weekly sales?
16. Are there any trends in sales related to specific store types over time?
17. How does temperature affect weekly sales?
18. Is there a specific temperature range where sales peak?
19. Do economic conditions (CPI and Unemployment) have a noticeable impact on sales trends?

## Key Results

- **Department Sales**: Identified the top and bottom-performing departments across all stores.
- **Holiday vs. Non-Holiday Sales**: Sales were significantly higher during holiday weeks.
- **Economic Impact**: Sales are higher when CPI is low and unemployment is medium.

## Conclusion

This analysis provides valuable insights into Walmart's sales trends, department performance, and the influence of external factors. The findings can be leveraged to optimize marketing strategies, inventory management, and overall business operations.

---

You can expand each section and add visualizations or screenshots if needed before uploading it to GitHub. Would you like any modifications?
