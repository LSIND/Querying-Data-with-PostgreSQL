---------------------------------------------------------------------
-- LAB 10
--
-- Exercise 1 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий дату самого последнего заказа/заказов из sales.orders.
--
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------

SELECT MAX(orderdate::date) AS lastorderdate 
FROM sales.orders;


---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий orderid, orderdate, empid и custid из таблицы sales.orders.
-- Включите только самые последние заказы (использовать запрос Task 1)
--
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

SELECT orderid, orderdate, empid, custid
FROM sales.orders
WHERE orderdate::date = (SELECT MAX(orderdate::date) FROM sales.orders);

---------------------------------------------------------------------
-- Task 3
-- 
-- Есть запрос, который выводит заказы для всех заказчиков, контактное имя которых начинается на букву I.
-- Выполните запрос. Просмотрите результат
--
-- Измените запрос так, чтобы он выводил заказы для всех заказчиков, контактное имя которых начинается на букву B.
-- Выполните запрос. Почему ошибка?
-- 
-- Исправьте запрос.
--
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

SELECT orderid, orderdate, empid, custid
FROM sales.orders
WHERE 
	custid = 
	(
		SELECT custid
		FROM sales.customers
		WHERE contactname LIKE 'I%'
	);

-- B - error: подзапрос вернул более одной строки
SELECT orderid, orderdate, empid, custid
FROM sales.orders
WHERE 
	custid = 
	(
		SELECT custid
		FROM sales.customers
		WHERE contactname LIKE 'B%' -- more than one row returned by a subquery used as an expression
	);

-- исправленный
SELECT orderid, orderdate, empid, custid
FROM sales.orders
WHERE 
	custid IN --
	(
		SELECT custid
		FROM sales.customers
		WHERE contactname LIKE 'B%'
	);

---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, возвращающий номер заказа таблицы sales.orders, а также вычисляемые столбцы: 
--  totalsalesamount (qty * unitprice таблицы sales.orderdetails) - общая сумма заказа
--  salespctoftotal (общая сумма заказа, деленная на общую сумму продаж за определенный период) - в процентах
--
-- Заказы должны быть оформлены только в мае 2023.
--
-- Результирующий набор сравните с Lab Exercise1 - Task4 Result.txt
---------------------------------------------------------------------

SELECT
	o.orderid, 
	SUM(d.qty * d.unitprice) AS totalsalesamount,
	SUM(d.qty * d.unitprice) /
	(
		SELECT SUM(d.qty * d.unitprice) 
		FROM sales.orders AS o
		INNER JOIN sales.orderdetails AS d 
		ON d.orderid = o.orderid
		WHERE o.orderdate >= '20230501' AND o.orderdate < '20230601'
	) * 100. AS salespctoftotal
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
WHERE o.orderdate >= '20230501' AND o.orderdate < '20230601'
GROUP BY o.orderid;