---------------------------------------------------------------------
-- LAB 13
--
-- Exercise 3 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий столбцы custid, orderid, orderdate, val из представления sales.ordervalues. 
-- Добавьте вычисляемый столбец percoftotalcust, содержащий отношение суммы одного заказа к итоговой сумме покупок конкретного покупателя (в процентах)
--
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------

SELECT 
	custid,
	orderid, orderdate,
	val,
	(100 * val / SUM(val) OVER (PARTITION BY custid))::numeric(5,2) AS percoftotalcust
FROM sales.ordervalues
ORDER BY custid, percoftotalcust DESC;

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос Task 1, добавьте к нему вычисляемый столбец runval - нарастающий итог по сумме покупок для каждого заказчика с упорядочиванием по дате заказа и номеру заказа
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
---------------------------------------------------------------------

SELECT 
	custid,
	orderid, orderdate,
	val,
	(100 * val / SUM(val) OVER (PARTITION BY custid))::numeric(5,2) AS percoftotalcust,
    SUM(val) OVER (PARTITION BY custid 
				   ORDER BY orderdate, orderid 
				   ROWS BETWEEN UNBOUNDED PRECEDING
                         AND CURRENT ROW) AS runval
FROM sales.ordervalues
ORDER BY custid, orderid;


---------------------------------------------------------------------
-- Task 3
-- 
-- Скопируйте CTE SalesMonth2007 CTE из exercise 2 - Task 3. Напишите SELECT-запрос к CTE и получите столбцы monthno и val, а также два вычисляемых столбца:
--  avglast3months - среднее количество продаж за предыдущие три месяца (относительно текущей строки) с использованием оконной функции агрегирования AVG.
--  ytdval - совокупный объем продаж до и включая текущий месяц
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt 
-- Сравните данные в столбце avglast3months с результатом exercise 2 - Task 3.
---------------------------------------------------------------------

WITH SalesMonth2007 AS
(
	SELECT
		EXTRACT(MONTH FROM orderdate) AS monthno,
		SUM(val) AS val
	FROM sales.ordervalues
	WHERE orderdate >= '20070101' AND orderdate < '20080101'
	GROUP BY monthno
)
SELECT
    monthno::int,
	val,
	COALESCE(AVG(val) OVER (ORDER BY monthno ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING), 0)::numeric(10,3) AS avglast3months,
	SUM(val) OVER (ORDER BY monthno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ytdval
FROM SalesMonth2007;