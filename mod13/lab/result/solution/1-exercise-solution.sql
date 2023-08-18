---------------------------------------------------------------------
-- LAB 13
--
-- Exercise 1
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий столбцы orderid, orderdate, val, а также вычисляемый столбец rowno из view Sales.OrderValues. 
-- Для вывода rowno использовать функцию ROW_NUMBER. Упорядочить номера строк по дате заказа.
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------

SELECT orderid, orderdate,val,
	ROW_NUMBER() OVER (ORDER BY orderdate) AS rowno
FROM "Sales"."OrderValues";

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос Task 1 и добавьте еще один вычисляемый столбец rankno. 
-- Для вывода rankno использовать функцию RANK. Упорядочить ранг по дате заказа.
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
--
-- В чем отличие функций RANK и ROW_NUMBER?
---------------------------------------------------------------------

SELECT orderid, orderdate, val,
	ROW_NUMBER() OVER (ORDER BY orderdate) AS rowno,
	RANK() OVER (ORDER BY orderdate) AS rankno
FROM "Sales"."OrderValues";

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, выводящий столбцы orderid, orderdate, custid, val, а также  вычисляемый столбец orderrankno из view Sales.OrderValues
-- Столбец orderrankno отображает ранг кажого покупателя, относительно суммы его покупок (от наибольшей к наименьшей). 
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------
SELECT orderid, orderdate, custid, val,
	RANK() OVER (PARTITION BY custid ORDER BY val DESC) AS orderrankno
FROM "Sales"."OrderValues";

---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, выводящий столбцы custid и val из Sales.OrderValues. Добавьте два вычисляемых столбца: 
--  orderyear - год от даты orderdate  
--  orderrankno - ранг с разбиением по заказчику и году, упорядоченный по номеру заказа по убыванию
-- Результирующий набор сравните с Lab Exercise1 - Task4 Result.txt
---------------------------------------------------------------------
SELECT custid, val,
	EXTRACT(YEAR FROM orderdate) as orderyear,
	RANK() OVER (PARTITION BY custid, EXTRACT(YEAR FROM orderdate) ORDER BY val DESC) AS orderrankno
FROM "Sales"."OrderValues";

---------------------------------------------------------------------
-- Task 5
-- 
-- Скопируйте запрос Task 4. Отобразите только те заказы, где ранг равен 1 или 2.
-- Помните, что оконные функции нельзя применять в конструкции WHERE
-- Результирующий набор сравните с Lab Exercise1 - Task5 Result.txt
---------------------------------------------------------------------

-- решение через derived table
SELECT s.custid, s.orderyear, s.orderrankno, s.val
FROM
(
	SELECT 
		custid, val,
		EXTRACT(YEAR FROM orderdate) as orderyear,
		RANK() OVER (PARTITION BY custid, EXTRACT(YEAR FROM orderdate) ORDER BY val DESC) AS orderrankno
	FROM "Sales"."OrderValues"
) AS s
WHERE s.orderrankno <= 2;

-- решение через CTE
WITH orders_rank
AS
(
	SELECT 
		custid,
		val,
		EXTRACT(YEAR FROM orderdate) as orderyear,
		RANK() OVER (PARTITION BY custid, EXTRACT(YEAR FROM orderdate) ORDER BY val DESC) AS orderrankno
	FROM "Sales"."OrderValues"
) 
SELECT custid, val, orderyear, orderrankno
FROM orders_rank
WHERE orderrankno <= 2;