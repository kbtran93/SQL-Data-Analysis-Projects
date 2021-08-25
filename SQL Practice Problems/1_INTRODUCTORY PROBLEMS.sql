-- INTRODUCTORY PROBLEMS
-- 1. Which shippers do we have?
SELECT * 
FROM shippers;

-- 2. Selecting certain categories
SELECT 
    category_name, 
    description
FROM categories;

--3. Show FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative
SELECT
    first_name,
    last_name,
    hire_date
WHERE title = 'Sales Representative'
FROM employees;

--4. Show FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative & in the US
SELECT
    first_name,
    last_name,
    hire_date
WHERE title = 'Sales Representative'
AND country = 'USA'
FROM employees;

--5. Orders placed by a specific employee
SELECT
    order_id,
    order_date
WHERE employee_id = 5
FROM Orders;

--6. Show the supplier ID, contact name & contact title of suppliers whose contact title is not 'Marketing Manager'
SELECT
    supplier_id,
    contact_name,
    contact_title
WHERE NOT contact_title = 'Marketing Manager'
FROM suppliers;

--7. Products with 'queso' in the product name
SELECT
    product_id,
    product_name
WHERE product_name LIKE '%queso%'
FROM products;

--8. Orders shipping to France or Belgium
SELECT
    order_id,
    customer_id,
    ship_country
WHERE ship_country = 'France'
OR ship_country ='Belgium'
FROM orders;

--9. Orders shipping to any Latin America countries
SELECT
    order_id,
    customer_id,
    ship_country
WHERE ship_country IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela')
FROM orders;

--10. Employees in order of age
SELECT
    first_name,
    last_name,
    title,
    birth_date
FROM employees
ORDER BY birth_date;

--11. Showing only the date with DateTime field
SELECT
    first_name,
    last_name,
    title,
	CAST(birth_date AS date) AS DateOnly_birthdate
FROM employees
ORDER BY DateOnly_birthdate;

--12. Employees full name
SELECT
	first_name,
	last_name,
	CONCAT(first_name,' ', last_name) AS full_name
FROM employees;

--13. Order details amount per line item
SELECT
	order_id,
	product_id,
	unit_price,
	quantity,
	(unit_price * quantity) AS total_price
FROM order_details
ORDER BY order_id, product_id;

--14. How many customers
SELECT
	COUNT(*)
FROM customers;

--15. Show the date of the first order ever made
SELECT
	MIN(order_date) AS FirstOrder
FROM orders;

--16. Countries where there are customers
SELECT 
	country
FROM customers
GROUP BY country;

--17. Contact titles for customers
SELECT
    contact_title,
    COUNT(contact_title)
FROM customers
GROUP BY contact_title;

--18. Products with associated supplier names
SELECT
	products.product_id,
	products.product_name,
	suppliers.company_name
FROM products
INNER JOIN suppliers on products.supplier_id = suppliers.supplier_id
ORDER BY product_id;

--19. Orders and the shippers that were used
SELECT
	orders.order_id,
	CAST(orders.order_date AS date),
	shippers.company_name
FROM orders
INNER JOIN shippers ON orders.ship_via = shippers.shipper_id
WHERE order_id < 10300
ORDER BY order_id;