

---

# 📊 Retail Sales Data Analysis Using SQL

A Complete End-to-End SQL Project

## 📌 Overview

This project focuses on analyzing a **Retail Sales Dataset** using SQL. The goal is to understand customer behavior, sales patterns, and key business insights by writing efficient SQL queries.

The dataset contains details about **transactions, customers, products, categories, sales amount, date, and time**, which makes it suitable for performing real-world analysis similar to what data analysts do in organizations.

---

## 🧠 Why SQL for Data Analysis?

SQL (Structured Query Language) is the **core tool for working with structured data** stored in relational databases.
It helps analysts to:

* Retrieve specific data using filters
* Clean data by removing NULL or inconsistent values
* Generate business insights from millions of rows
* Perform aggregations, grouping, ranking, and time-based analytics
* Improve decision-making with accurate results

In this project, SQL is used for **data cleaning**, **exploration**, and **answering 10 real business questions**.

---

# 📁 Dataset Description

The dataset is stored in a table named **`retail_sales_analysis`**, containing fields such as:

* `transactions_id`
* `sale_date`
* `sale_time`
* `customer_id`
* `category`
* `gender`
* `age`
* `quantiy`
* `total_sale`

---

# 🧹 1. Data Cleaning

### ✅ Checking Null Values

```sql
SELECT *
FROM retail_sales_analysis
WHERE total_sale IS NULL
      OR
      sale_date IS NULL
      OR
      sale_time IS NULL
      OR
      customer_id IS NULL
      OR
      category IS NULL
      OR
      gender IS NULL
      OR
      age IS NULL
      OR
      quantiy IS NULL
      OR
      total_sale IS NULL
;
```

### 🗑️ Removing Rows with Null Values (only 3 rows)

```sql
DELETE FROM retail_sales_analysis
WHERE transactions_id IN (679,746,1225);
```

---

# 🔍 2. Data Exploration

### View the full dataset:

```sql
SELECT * FROM retail_sales_analysis;
```

### Total Number of Sales:

```sql
SELECT COUNT(*) AS total_sale
FROM retail_sales_analysis;
```

### Total Unique Customers:

```sql
SELECT COUNT(DISTINCT customer_id) AS customers
FROM retail_sales_analysis;
```

### List of Unique Categories:

```sql
SELECT DISTINCT category
FROM retail_sales_analysis;
```

---

# 🧠 3. Business Questions & SQL Solutions

Below are the **10 key business problems** and their SQL-based solutions.

---

## **Q1️⃣ — Retrieve all columns for sales made on ‘2022-11-05’**

```sql
SELECT *
FROM retail_sales_analysis
WHERE sale_date = '2022-11-05';
```

---

## **Q2️⃣ — Transactions of 'Clothing' category where quantity ≥ 4 (Nov-2022)**

```sql
SELECT *
FROM retail_sales_analysis
WHERE category = 'Clothing'
    AND quantiy >= 4
    AND MONTH(sale_date) = 11
    AND YEAR(sale_date) = 2022
ORDER BY sale_date;
```

---

## **Q3️⃣ — Total sales for each category**

```sql
SELECT
    category,
    SUM(total_sale) AS total_sale_by_category
FROM retail_sales_analysis
GROUP BY category
ORDER BY total_sale_by_category DESC;
```

---

## **Q4️⃣ — Average age of customers who bought ‘Beauty’ items**

```sql
SELECT AVG(age) AS avg_age
FROM retail_sales_analysis
WHERE category = 'Beauty';
```

---

## **Q5️⃣ — Transactions with total sale > 1000**

```sql
SELECT *
FROM retail_sales_analysis
WHERE total_sale > 1000;
```

---

## **Q6️⃣ — Number of transactions by gender in each category**

```sql
SELECT
    category,
    gender,
    COUNT(transactions_id) AS transactions_id_count
FROM retail_sales_analysis
GROUP BY category, gender;
```

---

## **Q7️⃣ — Best-selling month of each year (based on average sales)**

```sql
SELECT
    year,
    month,
    avg_sale
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date)
                     ORDER BY AVG(total_sale) DESC) AS numbering
    FROM retail_sales_analysis
    GROUP BY MONTH(sale_date), YEAR(sale_date)
) t
WHERE numbering = 1;
```

---

## **Q8️⃣ — Top 5 customers by highest total sales**

```sql
SELECT TOP 5
    customer_id,
    SUM(total_sale) AS sum_sale
FROM retail_sales_analysis
GROUP BY customer_id
ORDER BY sum_sale DESC;
```

---

## **Q9️⃣ — Number of unique customers for each category**

```sql
SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales_analysis
GROUP BY category;
```

---

## **Q🔟 — Create shift-based orders count (Morning, Afternoon, Evening)**

```sql
SELECT
    shift,
    COUNT(*) AS total_orders
FROM (
    SELECT
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift,
        total_sale
    FROM retail_sales_analysis
) t
GROUP BY shift;
```

---

# 📈 Insights Gained from Analysis

Based on the SQL queries above, we observed the following key insights:

### ✔ There were **very few NULL values**, so cleaning did not affect the dataset.

### ✔ The dataset contains multiple categories like Clothing, Electronics, Beauty, etc.

### ✔ The best-selling month varies for each year based on average sales.

### ✔ Clothing had many high-quantity sales in November 2022.

### ✔ Top customers significantly contribute to total revenue.

### ✔ Beauty category attracts customers with a specific age profile (avg age from query).

### ✔ Evening orders tend to be higher (based on shift analysis).

### ✔ Categories show strong variation in total sale volume.

---

# 🛠️ Tools & Technologies Used

* **SQL (MySQL / SQL Server syntax)**
* **Retail sales dataset**
* **Window functions, aggregation, filtering, date functions**

---

# 🚀 Conclusion

This SQL project demonstrates complete end-to-end data analysis, including:

* Data cleaning
* Data exploration
* Solving real business questions
* Extracting insights using SQL queries

It represents a strong foundation for data analytics, business intelligence, and dashboard development.

---

