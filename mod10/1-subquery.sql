-------------------------------------------------------
--
-- Модуль 10
-- Демонстрация 1
-- Подзапросы, возвращающие скаляр и вектор (multi-valued)
--
-------------------------------------------------------

-- 1: Scalar subqueries
-- Самый последний заказ
SELECT MAX(orderid) AS lastorder
FROM sales.orders; -- 11077

-- Информация о самом последнем заказе (по номеру) из sales.orderdetails
SELECT orderid, productid, unitprice, qty
FROM sales.orderdetails
WHERE orderid = 
	(SELECT MAX(orderid) AS lastorder -- 11077
	FROM sales.orders);

-- Какой процент оформленных заказов приходится на каждого сотрудника?
SELECT e.empid, e.lastname, COUNT(o.orderid) as total_orders,
ROUND(COUNT(o.orderid)/(SELECT COUNT(*) FROM sales.orders )::numeric * 100, 2) AS perc
FROM sales.orders as O 
JOIN hr.employees AS e ON O.empid = e.empid
GROUP BY e.empid, e.lastname;

-- Ошибка - подзапрос вернул более одного значения
-- more than one row returned by a subquery used as an expression
SELECT orderid, productid, unitprice, qty
FROM sales.orderdetails
WHERE orderid = 
	(SELECT orderid AS O
	FROM sales.orders
	WHERE empid = 2);


-- 2: Multi-valued subqueries 
-- Исправление запроса на Multi-valued
SELECT orderid, productid, unitprice, qty
FROM sales.orderdetails
WHERE orderid IN  -- IN list
	(SELECT orderid AS O
	FROM sales.orders
	WHERE empid = 2);

-- Все заказы от покупателей из Mexico
SELECT custid, orderid
FROM sales.orders
WHERE custid IN (
	SELECT custid
	FROM sales.customers
	WHERE country = 'Mexico');

-- Тот же результат, но через join:
SELECT c.custid, o.orderid
FROM sales.customers AS c
JOIN sales.orders AS o
ON c.custid = o.custid
WHERE c.country = 'Mexico';