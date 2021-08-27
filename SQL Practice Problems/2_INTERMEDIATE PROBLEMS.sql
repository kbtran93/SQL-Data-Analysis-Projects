--INTERMEDIATE PROBLEMS

--20. Categories and the total number of products in each category
SELECT
	categories.category_name,
	COUNT(product_id)
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
GROUP BY categories.category_name
ORDER BY categories.category_name;

--21. Total customers per country/city
SELECT 
	country,
	city,
	COUNT(customer_id)
FROM customers
GROUP BY country, city
ORDER BY country, city;

--22. Products that need re-ordering
SELECT
	product_id,
	product_name,
	units_in_stock,
	reorder_level
FROM products
WHERE units_in_stock < reorder_level;

--23. Products that need re-ordering pt. 2
SELECT
	product_id,
	product_name,
	units_in_stock,
	units_on_order,
	reorder_level,
	discontinued
FROM products
WHERE (units_in_stock + units_on_order) < reorder_level
AND discontinued = 0;

--24. Customer list by region
SELECT
	customer_id,
	company_name,
	region
FROM customers
ORDER BY 
	CASE
		WHEN region IS NULL THEN 1
		ELSE 0
	END,
	region, 
	customer_id;

--25. High freight charges
SELECT
	ship_country,
	AVG(freight) as AverageFreight
FROM orders
GROUP BY ship_country
ORDER BY AverageFreight DESC
LIMIT 3;

--26. High freight charges 2015
SELECT
	ship_country,
	AVG(freight) as AverageFreight
FROM orders
WHERE 
	order_date >= '20150101'
AND order_date < '20160101'
GROUP BY ship_country
ORDER BY AverageFreight DESC;

--27. Inventory list
SELECT
	employees.employee_id,
	employees.last_name,
	orders.order_id,
	products.product_name,
	order_details.quantity
FROM employees
JOIN orders ON employees.employee_id = orders.order_id
JOIN order_details ON order_details.order_id = orders.order_id
JOIN products ON products.product_id = order_details.order_id
ORDER BY
	orders.order_id,
	products.product_id;

--28. Customers with no orders
SELECT
	customers.customer_id AS Customer_CustomerID,
	orders.customer_id AS Orders_CustomerID
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.customer_id IS NULL;

--29. Customers with no orders for EmployeeID 4
SELECT
	customers.customer_id AS Customer_CustomerID,
	orders.customer_id AS Orders_CustomerID,
	orders.employee_id
FROM customers
	LEFT JOIN orders ON customers.customer_id = orders.customer_id
	AND orders.employee_id = 4
WHERE orders.customer_id IS NULL;