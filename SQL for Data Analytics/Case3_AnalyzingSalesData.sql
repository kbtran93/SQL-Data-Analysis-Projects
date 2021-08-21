--Case 3: Analyzing sales data

--Total number of unit sales
SELECT COUNT(*)
FROM sales;

--Total sales amount in dollars for each state
SELECT c.state, SUM(sales_amount) AS total_sales_amount
FROM sales s
INNER JOIN customers c ON c.customer_id = s.customer_id
GROUP BY state
ORDER BY state

--Identify top 5 best dealerships in term of the most units sold
SELECT s.dealership_id, COUNT(*) 
FROM sales s
WHERE channel = 'dealership'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Calculate the average sales amount by each channel
SELECT s.channel, s.product_id, AVG(sales_amount) as avg_sales_amount
FROM sales s
GROUP BY
GROUPING SETS(
	(s.channel),(s.product_id),
	(s.channel, s.product_id)
)
ORDER BY 1,2