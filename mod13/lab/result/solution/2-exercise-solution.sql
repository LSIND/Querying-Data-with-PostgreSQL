---------------------------------------------------------------------
-- LAB 13
--
-- Exercise 2
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Определите CTE с именем OrderRows, которое выбирает orderid, orderdate, val из представления Sales.OrderValues. 
-- Добавьте вычисляемый столбец rowno с помощью фукнции ROW_NUMBER, упорядочив данные по orderdate и orderid. 
--
-- Напишите SELECT-запрос к CTE, а также LEFT JOIN к нему же, чтобы получить текущую и предыдущую строки (основываясь на столбце rowno).
-- Выведите столбцы orderid, orderdate, val для текущей строки и столбец val из предыдущей строки с псевдонимом prevval. 
-- Добавьте вычисляемый столбец diffprev, показывающий разницу между текущим значением и предыдущим значением val.
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------
WITH OrderRows AS
(
	SELECT 
		orderid, 
		orderdate,
		ROW_NUMBER() OVER (ORDER BY orderdate, orderid) AS rowno,
		val
	FROM "Sales"."OrderValues"
)
SELECT 
	o.orderid,
	o.orderdate,
	o.val,
	o2.val as prevval,
	o.val - o2.val as diffprev
FROM OrderRows AS o
LEFT OUTER JOIN OrderRows AS o2 ON o.rowno = o2.rowno + 1;


---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос с использованием функции LAG для получения тех же результатов, что и в Task 1 (без CTE)
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt
---------------------------------------------------------------------

SELECT 
	orderid, 
	orderdate,
	val,
	LAG(val) OVER (ORDER BY orderdate, orderid) AS prevval,
	val - LAG(val) OVER (ORDER BY orderdate, orderid) AS diffprev
FROM "Sales"."OrderValues";

---------------------------------------------------------------------
-- Task 3
-- 
-- Определите CTE с именем SalesMonth2007 с двумя столбцами:
--   monthno (месяц от столбца orderdate). Столбец группировки
--   val (сумма по столбцу val).
--  Месяца и суммы должны быть только за 2007 год
--
-- Напишите SELECT-запрос к CTE и получите monthno и val columns, а также три вычисляемых столбца:
--  avglast3months - среднее количество продаж за предыдущие три месяца (относительно текущей строки). (LAG(1) + LAG(2) +LAG(3)) / 3
--  diffjanuary - разница между текущей строкой и значением за Январь. FIRST_VALUE 
--  nextval - следующее значение val для текущей строки. LEAD
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
-- Обратите внимание, что среднее за предыдущие три месяца рассчитано неверно для строки 2
---------------------------------------------------------------------

WITH SalesMonth2007 AS
(
	SELECT
		EXTRACT(MONTH FROM orderdate) AS monthno,
		SUM(val) AS val
	FROM "Sales"."OrderValues"
	WHERE orderdate >= '20070101' AND orderdate < '20080101'
	GROUP BY monthno
)
SELECT
	monthno::int,
	val,
	((LAG(val, 1, 0.0) OVER (ORDER BY monthno) + LAG(val, 2, 0.0) OVER (ORDER BY monthno) + LAG(val, 3, 0.0) OVER (ORDER BY monthno)) / 3)::numeric(10,3) AS avglast3months,
	val - FIRST_VALUE(val) OVER (ORDER BY monthno ROWS UNBOUNDED PRECEDING) AS diffjanuary,
	LEAD(val) OVER (ORDER BY monthno) AS nextval
FROM SalesMonth2007;