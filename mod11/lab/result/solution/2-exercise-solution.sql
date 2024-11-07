---------------------------------------------------------------------
-- LAB 11
--
-- Exercise 2 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Скопируйте запрос представления из Exercise 1 - Task 4 (исправленный, с псевдонимом столбца).
-- Напишите SELECT-запрос к скопированному запросу (как наследуемая таблица, SELECT FROM SELECT), получите productid и productname. 
-- Верните только те строки, где значение в столбце pricetype равно 'high'. 
--  Не забудьте использовать псевдонимы
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------

SELECT p.productid, p.productname
FROM
(
	SELECT
	productid, productname, supplierid, unitprice, discontinued,
	CASE WHEN unitprice > 100 THEN 'high' ELSE 'normal' END AS pricetype
FROM production.products
WHERE categoryid = 1
) AS p
WHERE p.pricetype = 'high';

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, выводящий столбец custid и два вычисляемых столбца: 
--  totalsalesamount - сумма покупок на каждого покупателя, 
--  avgsalesamount - средняя сумма покупок на каждого покупателя.
-- Определите наследуемую таблицу как JOIN-запрос к sales.orders и sales.orderdetails и к ней напишите SELECT-запрос с агрегатами. 
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt
---------------------------------------------------------------------
SELECT
	c.custid,
	SUM(c.totalsalesamountperorder) AS totalsalesamount,
	AVG(c.totalsalesamountperorder) AS avgsalesamount
FROM
(
	SELECT o.custid, o.orderid, SUM(d.unitprice * d.qty) AS totalsalesamountperorder
	FROM sales.orders AS o 
	INNER JOIN sales.orderdetails AS d 
    ON d.orderid = o.orderid
	GROUP BY o.custid, o.orderid
) AS c
GROUP BY c.custid
ORDER BY c.custid;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, выводящий следующие столбцы: 
--  orderyear - год от даты заказа
--  curtotalsales - общее количество продаж за текущий год
--  prevtotalsales - общее количество продаж за предыдущий год
--  percentgrowth - отношение роста продаж текущего года к предыдущему (в процентах) 
-- Используйте две наследуемые таблицы. Получить год и общую сумму продаж можно из существующего представления sales.ordervalues (столбец val - объемы продаж).
-- 2006 год - первый год работы магазина, но он также должен быть включен в результат.
--
-- * Попробуйте также решить задачу с помощью CTE.
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
---------------------------------------------------------------------
SELECT
	cy.orderyear, 
	cy.totalsalesamount AS curtotalsales, 
	py.totalsalesamount AS prevtotalsales,
	(cy.totalsalesamount - py.totalsalesamount) / py.totalsalesamount * 100. AS percentgrowth
FROM
(
	SELECT EXTRACT(YEAR FROM orderdate) AS orderyear, SUM(val) AS totalsalesamount
	FROM sales.ordervalues
	GROUP BY EXTRACT(YEAR FROM orderdate)
) AS cy
LEFT OUTER JOIN
(
	SELECT EXTRACT(YEAR FROM orderdate) AS orderyear, SUM(val) AS totalsalesamount
	FROM sales.ordervalues
	GROUP BY EXTRACT(YEAR FROM orderdate)
) AS py ON cy.orderyear = py.orderyear + 1
ORDER BY cy.orderyear;


-- * Решение через CTE
WITH cy AS
(SELECT EXTRACT(YEAR FROM orderdate) AS orderyear, SUM(val) AS totalsalesamount
	FROM sales.ordervalues
	GROUP BY EXTRACT(YEAR FROM orderdate) )
SELECT
	cy.orderyear, 
	cy.totalsalesamount AS curtotalsales,
	py.totalsalesamount AS prevtotalsales,
	(cy.totalsalesamount - py.totalsalesamount) / py.totalsalesamount * 100. AS percentgrowth
FROM cy
LEFT OUTER JOIN cy AS py
ON cy.orderyear = py.orderyear + 1
ORDER BY cy.orderyear;
