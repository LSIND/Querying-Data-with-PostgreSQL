---------------------------------------------------------------------
-- LAB 10
--
-- Exercise 1
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий самую последнюю дату заказа из Sales.Orders.
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------
SELECT MAX(orderdate) AS lastorderdate 
FROM "Sales"."Orders";

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий orderid, orderdate, empid и custid из таблицы Sales.Orders.
-- Включите только заказы, дата оформления которых максимальна (использовать запрос Task 1)
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

SELECT orderid, orderdate, empid, custid
FROM "Sales"."Orders"
WHERE orderdate = (SELECT MAX(orderdate) FROM "Sales"."Orders");

---------------------------------------------------------------------
-- Task 3
-- 
-- Есть, запрос, который выводит заказы для всех заказчиков, контактное имя которых начинается на букву I: 
-- Выполните запрос.
--
-- Измените запрос так, чтобы он выводил заказы для всех заказчиков, контактное имя которых начинается на букву B.
-- Выполните запрос. Почему ошибка?
-- 
-- Исправьте запрос.
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

SELECT orderid, orderdate, empid, custid
FROM "Sales"."Orders"
WHERE 
	custid = 
	(
		SELECT custid
		FROM "Sales"."Customers"
		WHERE contactname LIKE N'I%'
	);

-- B - error
SELECT orderid, orderdate, empid, custid
FROM "Sales"."Orders"
WHERE 
	custid = 
	(
		SELECT custid
		FROM "Sales"."Customers"
		WHERE contactname LIKE N'B%'
	);


-- исправленный
SELECT orderid, orderdate, empid, custid
FROM "Sales"."Orders"
WHERE 
	custid IN
	(
		SELECT custid
		FROM "Sales"."Customers"
		WHERE contactname LIKE N'B%'
	);

---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, возвращающий номер заказа таблицы Sales.Orders, а также вычисляемые столбцы: 
--  totalsalesamount (qty * unitprice таблицы Sales.OrderDetails) - общая сумма заказа
--  salespctoftotal (общая сумма заказа, деленная на общую сумму продаж за определенный период) - в процентах
--
-- Заказы должны быть оформлены только в мае 2008.
-- Результирующий набор сравните с Lab Exercise1 - Task4 Result.txt
---------------------------------------------------------------------

SELECT
	o.orderid, 
	SUM(d.qty * d.unitprice) AS totalsalesamount,
	SUM(d.qty * d.unitprice) /
	(
		SELECT SUM(d.qty * d.unitprice) 
		FROM "Sales"."Orders" AS o
		INNER JOIN "Sales"."OrderDetails" AS d 
		ON d.orderid = o.orderid
		WHERE o.orderdate >= '20080501' AND o.orderdate < '20080601'
	) * 100. AS salespctoftotal
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d 
ON d.orderid = o.orderid
WHERE o.orderdate >= '20080501' AND o.orderdate < '20080601'
GROUP BY o.orderid;