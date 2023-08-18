-- Demonstration A

-- 1: Scalar subqueries:
-- Самый последний заказ
SELECT MAX(orderid) AS lastorder
FROM "Sales"."Orders";

-- 2: Информация о последнем заказе из Sales.OrderDetails
SELECT orderid, productid, unitprice, qty
FROM "Sales"."OrderDetails"
WHERE orderid = 
	(SELECT MAX(orderid) AS lastorder
	FROM "Sales"."Orders");


-- 3: Ошибка - подзапрос вернул более одного значения
SELECT orderid, productid, unitprice, qty
FROM "Sales"."OrderDetails"
WHERE orderid = 
	(SELECT orderid AS O
	FROM "Sales"."Orders"
	WHERE empid =2);

-- Исправление запроса 3 на Multi-valued
SELECT orderid, productid, unitprice, qty
FROM "Sales"."OrderDetails"
WHERE orderid IN 
	(SELECT orderid AS O
	FROM "Sales"."Orders"
	WHERE empid =2);

-- 4: Multi-valued subqueries 
-- Все заказы от покупателей из Mexico
SELECT custid, orderid
FROM "Sales"."Orders"
WHERE custid IN (
	SELECT custid
	FROM "Sales"."Customers"
	WHERE country = 'Mexico');

-- 5: Тот же результат, но через join:
SELECT c.custid, o.orderid
FROM "Sales"."Customers" AS c
JOIN "Sales"."Orders" AS o
ON c.custid = o.custid
WHERE c.country = 'Mexico';