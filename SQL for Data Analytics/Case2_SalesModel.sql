-- Building a sales model using SQL

--Joining tables
SELECT 
	c.*, p.*,
	COALESCE(s.dealership_id, -1),
	CASE WHEN p.base_msrp - s.sales_amount <= 500 THEN 1 ELSE 0 END AS high_savings
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id;