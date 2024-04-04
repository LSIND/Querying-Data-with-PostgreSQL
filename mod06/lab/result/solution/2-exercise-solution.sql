---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 2 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий уникальных покупателей (столбец custid) из таблицы sales.orders. 
-- Примените фильтр к заказам: оформлены в феврале 2008.
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt.
---------------------------------------------------------------------

SELECT DISTINCT custid
FROM sales.orders
WHERE 
	orderdate >= '20080201'
	AND orderdate < '20080301'
ORDER BY custid;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос со следующими столбцами:
--  Текущая дата и время
--  Первая дата текущего месяца
--  Последняя дата текущего месяца
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt. 
---------------------------------------------------------------------

SELECT 
	CURRENT_TIMESTAMP AS CurrentT,
	date_trunc('month', current_date)::date AS firstday,
    (date_trunc('month', now()) + interval '1 month - 1 day')::date AS lastday; 

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос к таблице Sales.Orders и получите orderid, custid, orderdate. 
-- Выведите заказы, которые были оформлены в последние 5 дней каждого месяца.
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt.
---------------------------------------------------------------------

SELECT 
	orderid, custid, orderdate
    --, (date_trunc('month', orderdate) + interval '1 month - 1 day') - orderdate
FROM sales.orders
WHERE 
	date_part(
		'day', (date_trunc('month', orderdate) + interval '1 month - 1 day') - orderdate
	) < 5;

---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос к таблицам sales.orders и sales.orderdetails, получите уникальные значения столбца productid. 
-- Выведите только те продукты, которые были куплены в первые 10 недель 2007 года.
--
-- Результирующий набор сравните с Lab Exercise2 - Task4 Result.txt.
---------------------------------------------------------------------

SELECT DISTINCT
	d.productid
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
WHERE 
	EXTRACT(week FROM orderdate) <= 10 
	AND orderdate >= '20070101' AND orderdate < '20070101'::date + '70 days'::interval
	ORDER BY d.productid;