-------------------------------------------------------
--
-- Модуль 9
-- Демонстрация 2
-- GROUP BY
--
-------------------------------------------------------


-- Количество заказов, оформленных каждым сотрудником
SELECT empid, COUNT(*) AS Total_Orders
FROM sales.orders
GROUP BY empid
ORDER BY Total_Orders asc;

-- Количество заказов, оформленных сотрудником N 8 для каждого покупателя в каждом конкретном году
SELECT custid, EXTRACT (YEAR FROM OrderDate) AS yearOrder, COUNT(*) AS Total_Orders
FROM sales.orders
WHERE empid = 8
GROUP BY custid, EXTRACT (YEAR FROM OrderDate)
ORDER BY custid, yearOrder;

-- DISTINCT с функциями агрегирования
SELECT EXTRACT (YEAR FROM OrderDate) AS order_year,
COUNT(custid) as all_customers,
COUNT(DISTINCT custid) as unique_customers
FROM sales.orders
GROUP BY EXTRACT (YEAR FROM OrderDate);


---------------------------------------------
-- Workflow of grouping 1
---------------------------------------------

-- Источник данных
SELECT orderid, productid, unitprice
FROM sales.orderdetails;

-- Условие
SELECT orderid, productid, unitprice
FROM sales.orderdetails
WHERE orderid IN (10248, 10251,10259);

-- Группа
SELECT orderid, COUNT(productid), SUM(unitprice)
FROM sales.orderdetails
WHERE orderid IN (10248, 10250,10259)
GROUP BY orderid;

---------------------------------------------

---------------------------------------------
-- Workflow of grouping 2
---------------------------------------------

-- Источник данных
SELECT custid, orderid
FROM sales.orders;

-- Условие
SELECT custid, orderid
FROM sales.orders
WHERE shipcity = 'Madrid';

-- Группа
SELECT custid, COUNT(orderid)
FROM sales.orders
WHERE shipcity = 'Madrid'
GROUP BY custid;

---------------------------------------------

-- Количество заказов каждого заказчика
SELECT custid, COUNT(*) AS Total_Orders
FROM sales.orders
GROUP BY custid
ORDER BY Total_Orders DESC;


-- Максимальное количество определенного продукта в заказе (купленного в количестве за раз)
SELECT ProductID, MAX(qty) AS largest_order
FROM sales.orderdetails
GROUP BY productid
ORDER BY largest_order DESC;


-- Статистика заказов по дням недели: общее количество заказов и сумма продаж
SELECT to_char(orderdate, 'D') as n, to_char(orderdate, 'DAY'), COUNT(*) AS total_orders, SUM(qty*unitprice) as total
FROM sales.orders as o
JOIN sales.orderdetails as od
ON o.orderid = od.orderid
GROUP BY to_char(orderdate, 'D'), to_char(orderdate, 'DAY')
ORDER BY n;


-- * Статистика по заказам каждого месяца: количество завершенных заказов, количество заказов в работе
SELECT EXTRACT(YEAR FROM orderdate) as yyyy, EXTRACT(MONTH FROM orderdate) as mm,
SUM(CASE WHEN shippeddate IS NOT NULL THEN 1 ELSE 0 END) AS closed,
SUM(CASE WHEN shippeddate IS NULL THEN 1 ELSE 0 END) AS notsend
FROM sales.orders as o
GROUP BY EXTRACT(YEAR FROM orderdate), EXTRACT(MONTH FROM orderdate)
ORDER BY yyyy, mm;