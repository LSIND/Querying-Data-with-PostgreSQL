---------------------------------------------------------------------
-- LAB 11
--
-- Exercise 3
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос аналогичный exercise 2 - task 1, но с использованием CTE. Имя CTE - ProductBeverages 
-- Используйте inline-псевдонимы
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------

WITH "ProductsBeverages" AS
(
	SELECT
		productid, productname, supplierid, unitprice, discontinued,
		CASE WHEN unitprice > 100::money THEN N'high' ELSE N'normal' END AS pricetype
	FROM "Production"."Products"
	WHERE categoryid = 1
)
SELECT
	productid, productname
FROM "ProductsBeverages"
WHERE pricetype = N'high';

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к Sales.OrderValues и получите номер каждого заказчика и общую сумму покупок в 2008 году.
-- Определите CTE с именем c2008 с использованием внешних псевдонимов custid и salesamt2008. 
-- Соедините CTE с таблицей Sales.Customers и получите custid, contactname из Sales.Customers и salesamt2008 из c2008 CTE.
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
---------------------------------------------------------------------

WITH c2008 (custid, salesamt2008) AS
(
	SELECT custid, SUM(val)
	FROM "Sales"."OrderValues"
	WHERE EXTRACT(YEAR FROM orderdate) = 2008
	GROUP BY custid
)
SELECT
	c.custid, c.contactname, c2008.salesamt2008
FROM "Sales"."Customers" AS c
LEFT OUTER JOIN c2008 ON c.custid = c2008.custid;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, выводящий custid и contactname из таблицы Sales.Customers. Также получите вычисляемые столбцы:
--  salesamt2008 - Общее количество продаж за 2008
--  salesamt2007 - Общее количество продаж за 2007 
--  percentgrowth - процентный рост продаж 2008 года к 2007 (Если percentgrowth = NULL- отобразить 0). Упорядочить результат по этому столбцу
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt.
---------------------------------------------------------------------

WITH c2008 (custid, salesamt2008) AS
(
	SELECT custid, SUM(val)
	FROM "Sales"."OrderValues"
	WHERE EXTRACT(YEAR FROM orderdate) = 2008
	GROUP BY custid
),
c2007 (custid, salesamt2007) AS
(
	SELECT custid, SUM(val)
	FROM "Sales"."OrderValues"
	WHERE EXTRACT(YEAR FROM orderdate) = 2007
	GROUP BY custid
)
SELECT
	c.custid, c.contactname, 
	c2008.salesamt2008, 
	c2007.salesamt2007,
	COALESCE((c2008.salesamt2008 - c2007.salesamt2007) / c2007.salesamt2007 * 100., 0) AS percentgrowth
FROM "Sales"."Customers" AS c
LEFT OUTER JOIN c2008 ON c.custid = c2008.custid
LEFT OUTER JOIN c2007 ON c.custid = c2007.custid
ORDER BY percentgrowth DESC;