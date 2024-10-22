
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

### 4. Advanced Analysis (Predictive Modeling)

Although MySQL does not directly support advanced predictive models, we documented potential factors for building a predictive model for future sales:
- Key features: **CPI**, **Unemployment**, **Holiday Flag**, **Markdowns**, and **Store Size**.

## Business Questions Addressed

### Product Analysis
1. **Which departments have the highest sales in each store?**
   - Identified top-selling departments by summing total weekly sales for each store.
   
2. **Are there departments that consistently perform poorly in sales?**
   - Analyzed departments with below-average sales performance across different stores.

### Sales Analysis
1. **How do holidays affect sales?**
   - Compared sales during holiday and non-holiday periods to determine the impact of holidays.
   
2. **How do markdowns affect weekly sales?**
   - Investigated the correlation between markdowns and weekly sales.
   
3. **Does store size correlate with higher sales?**
   - Analyzed the relationship between store size and average weekly sales.

### Economic Impact
1. **Do economic conditions (CPI and Unemployment) have a noticeable impact on sales trends?**
   - Grouped CPI and Unemployment into ranges to understand their effect on weekly sales.

## Results

- **Department Sales**: Identified the top and bottom-performing departments across all stores.
- **Holiday vs. Non-Holiday Sales**: Sales were significantly higher during holiday weeks.
- **Economic Impact**: Sales are higher when CPI is low and unemployment is medium.

## Conclusion

This analysis provides valuable insights into Walmart's sales trends, department performance, and the influence of external factors. The findings can be leveraged to optimize marketing strategies, inventory management, and overall business operations.

---

You can expand each section and add visualizations or screenshots if needed before uploading it to GitHub. Would you like any modifications?
