--Case 4: Analyzing Sales using Window Frames & Window Functions

--Calculate total sales amount day by day for 2018
SELECT 
	sales_transaction_date::DATE,
	sum(sales_amount) as total_sales_amount
FROM sales
WHERE sales_transaction_date >='2018-01-01'
AND sales_transaction_date < '2019-01-01'
GROUP BY 1
ORDER BY 1;

--Calculate 30-day rolling average for daily sales
WITH daily_sales AS(
	SELECT sale_transaction_date::DATE,
	SUM(sales_amount) AS total_sales
	FROM sales
	GROUP BY 1
),
moving_average_30_calc AS(
	SELECT sales_transaction_date, total_sales,
	AVG(total_sales) OVER(ORDER BY sales_transaction_date ROWS BETWEEN 30 
						  PRECEDING and CURRENT ROW) AS sales_moving_average_30,
	ROW_NUMBER() OVER(ORDER BY sales_transaction_date) as row_number
	FROM daily_sales
	ORDER BY 1
)
SELECT sales_transaction_date,
CASE WHEN row_number>=30 THEN sales_moving_average_30 ELSE NULL END AS sales_moving_average_30
FROM moving_average_30_calc
WHERE sales_transaction_date >= '2018-01-01'
AND sales_transaction_date < '2019-01-01';

--Calculate which decile each dealership would be in comparing to other dealerships
WITH total_dealership_sales AS(
	SELECT dealership_id,
	SUM(sales_amount) AS total_sales_amount
	FROM sales
	WHERE sales_transaction_date >= '2018-01-01'
	AND sales_transaction_date < '2019-01-01'
	AND channel = 'dealership'
	GROUP BY 1
)
SELECT *,
NTILE(10) OVER(ORDER BY total_sales_amount)
FROM total_dealership_sales;