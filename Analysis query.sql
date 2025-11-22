select 
*
from retail_sales_analysis;

-- Check NUll values
SELECT
*
FROM retail_sales_analysis
WHERE total_sale IS NULL;

-- By writing this query we delete our null values entire row because null values were very less only 3 rows
delete from retail_sales_analysis
where transactions_id in (679,746,1225)

-- Data Exploration
select
*
from retail_sales_analysis

-- Q) How many sales we have?
select
COUNT(*) as total_sale
from retail_sales_analysis

-- Q) How many unique customer we have?
select
COUNT(distinct customer_id) as customers
from retail_sales_analysis

-- Q) How many unique category we have?
select
distinct category
from retail_sales_analysis

-- =======================================
-- Data Analysis or bussiness key problems
-- =======================================
-- Q-1) Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select
*
from retail_sales_analysis
where sale_date = '2022-11-05';

-- Q-2) Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
--      the quantity sold is more than 4 in the month of Nov-2022:
select
*
from retail_sales_analysis
where category = 'Clothing' 
		and 
		quantiy >=4 
		and 
		month(sale_date) =11 
		and 
		YEAR(sale_date) = 2022 
order by sale_date
-- OR
select
*
from retail_sales_analysis
where category = 'Clothing' 
		and 
		quantiy >=4 
		and  
		FORMAT(sale_date, 'yyyy-MM') = '2022-11'
order by sale_date

-- Q-3) Write a SQL query to calculate the total sales (total_sale) for each category.:
select
	category,
sum(total_sale) total_sale_by_category
from retail_sales_analysis
group by category
order by total_sale_by_category desc

-- Q-4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select
	AVG(age) avg_age
from retail_sales_analysis
where category = 'Beauty'

-- Q-5) Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select
	*
from retail_sales_analysis
where total_sale > 1000

-- Q-6) Write a SQL query to find the total 
-- number of transactions (transaction_id) made by each gender in each category.:

select
	category,
	gender,
	count(transactions_id) transactions_id_count
from retail_sales_analysis
group by category,gender

-- Q-7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select
	year,
	month,
	avg_sale
From(select
	YEAR(sale_date) year,
	MONTH(sale_date) month,
	AVG(total_sale) avg_sale,
	RANK() over(partition by YEAR(sale_date) order by AVG(total_sale) desc) numbering
from retail_sales_analysis
group by MONTH(sale_date),YEAR(sale_date))t
where numbering =1


-- Extra info

select
	month(sale_date),
	sum(total_sale) sale_of_eachM
from retail_sales_analysis
where year(sale_date) = 2022
group by month(sale_date)
order by sale_of_eachM desc

select
	month(sale_date),
	sum(total_sale) sale_of_eachM
from retail_sales_analysis
where year(sale_date) = 2023
group by month(sale_date)
order by sale_of_eachM desc

-- Q-8) **Write a SQL query to find the top 5 customers based on the highest total sales **:
select
	top 5
	customer_id,
	sum(total_sale) sum_sale
from retail_sales_analysis
group by customer_id
order by sum_sale desc

-- Q-9) Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT
    category,
    COUNT(DISTINCT customer_id) as unique_customers
FROM retail_sales_analysis
GROUP BY category;
-- Extra Info
select
	distinct customer_id dis_cus,
	category
from retail_sales_analysis
where category in ('Electronics','Clothing','Beauty')
order by dis_cus


SELECT
    category,
    COUNT(DISTINCT customer_id) as unique_customers
FROM retail_sales_analysis
WHERE category IN ('Electronics', 'Clothing', 'Beauty')
GROUP BY category

-- Q-10) Write a SQL query to create each shift and number of orders 
--       (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
select
	shift,
	count(*) as total_orders
from(SELECT
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift,
	total_sale
FROM retail_sales_analysis)t
group by shift

-- End of query