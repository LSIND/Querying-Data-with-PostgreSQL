---------------------------------------------------------------------
-- LAB 11
--
-- Exercise 3 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос аналогичный Exercise 2 - Task 1, но с использованием CTE. Имя CTE - productsbeverages 
-- Используйте inline-псевдонимы.
--
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------

WITH productsbeverages AS
(
	SELECT
		productid, productname, supplierid, unitprice, discontinued,
		CASE WHEN unitprice > 100::money THEN 'high' ELSE 'normal' END AS pricetype
	FROM production.products
	WHERE categoryid = 1
)
SELECT productid, productname
FROM productsbeverages
WHERE pricetype = 'high';

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к sales.ordervalues и получите список всех заказчиков и общую сумму покупок каждого их них в 2008 году.
-- Определите CTE с именем c2008 с использованием внешних псевдонимов custid и salesamt2008.
--   Если заказчик ничего не купил в 2008 году, в столбце salesamt2008 должно стоять значение 0. 
-- Соедините CTE с таблицей sales.customers и получите custid, contactname из sales.customers и salesamt2008 из c2008 CTE.
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
---------------------------------------------------------------------

WITH c2008 (custid, salesamt2008) AS
(
	SELECT custid, SUM(val)
	FROM sales.ordervalues 
	WHERE EXTRACT(YEAR FROM orderdate) = 2008
	GROUP BY custid
)
SELECT
	c.custid, c.contactname, COALESCE(c2008.salesamt2008, 0)
FROM sales.customers AS c
LEFT OUTER JOIN c2008 ON c.custid = c2008.custid;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, выводящий custid и contactname из таблицы sales.customers. Также получите вычисляемые столбцы:
--  salesamt2008 - Общая сумма покупок за 2008 год (создайте CTE с именем c2008)
--  salesamt2007 - Общая сумма покупок за 2007 год (создайте CTE с именем c2007)
--  percentgrowth - процентный рост продаж 2008 года к 2007 (Если percentgrowth = NULL- отобразить 0). Упорядочить результат по этому столбцу
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt.
---------------------------------------------------------------------

WITH c2008 (custid, salesamt2008) AS
(
	SELECT custid, SUM(val)
	FROM sales.ordervalues
	WHERE EXTRACT(YEAR FROM orderdate) = 2008
	GROUP BY custid
),
c2007 (custid, salesamt2007) AS
(
	SELECT custid, SUM(val)
	FROM sales.ordervalues
	WHERE EXTRACT(YEAR FROM orderdate) = 2007
	GROUP BY custid
)
SELECT
	c.custid, c.contactname, 
	c2008.salesamt2008, 
	c2007.salesamt2007,
	COALESCE((c2008.salesamt2008 - c2007.salesamt2007) / c2007.salesamt2007 * 100., 0) AS percentgrowth
FROM sales.customers AS c
LEFT OUTER JOIN c2008 ON c.custid = c2008.custid
LEFT OUTER JOIN c2007 ON c.custid = c2007.custid
ORDER BY percentgrowth DESC;



---------------------------------------------------------------------
-- Task 4 * 
-- 
-- Определите рекурсивное CTE, выводящее значение факториала числа (n!).
--  определите начальное значение в CTE (1, 1)
--  определите формулу факториала числа для заданного значения
--
---------------------------------------------------------------------

WITH RECURSIVE factorial_cte(n, factorial) AS (
  SELECT 1, 1   -- initial values
  UNION ALL
  SELECT n + 1, (n + 1) * factorial
  FROM factorial_cte
  WHERE n < 6   -- условие (n = 6): n - 1
)
SELECT n, factorial
FROM factorial_cte
WHERE n = 6;    -- условие. 6! = 720
