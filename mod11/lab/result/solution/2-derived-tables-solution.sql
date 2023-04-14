---------------------------------------------------------------------
-- LAB 11
--
-- Exercise 2
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос к наследуемой таблице, получите productid и productname. 
-- Верните только те строки, где значение в столбце pricetype равно "high". 
-- В качестве внутреннего запроса используйте запрос из exercise 1 - task 4 (исправленный). Не забудьте использовать псевдонимы
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------

SELECT p.productid, p.productname
FROM
(
	SELECT
	productid, productname, supplierid, unitprice, discontinued,
	CASE WHEN unitprice > 100::money THEN N'high' ELSE N'normal' END AS pricetype
FROM "Production"."Products"
WHERE categoryid = 1
) AS p
WHERE p.pricetype = N'high';

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, выводящий столбец custid и два вычисляемых столбца: 
--  totalsalesamount - сумма покупок на каждого покупателя, 
--  avgsalesamount - средняя сумма покупок на каждого покупателя.
-- Определите наследуемую таблицу как JOIN-запрос к Sales.Orders и Sales.OrderDetails и к напишите SELECT-запрос с агрегатами. 
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt
---------------------------------------------------------------------
SELECT
	c.custid,
	SUM(c.totalsalesamountperorder) AS totalsalesamount,
	AVG(c.totalsalesamountperorder::numeric) AS avgsalesamount
FROM
(
	SELECT o.custid, o.orderid, SUM(d.unitprice * d.qty) AS totalsalesamountperorder
	FROM "Sales"."Orders" AS o 
	INNER JOIN "Sales"."OrderDetails" AS d 
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
-- Используйте две наследуемые таблицы. Получить год и общую сумму продаж можно из существующего представления Sales.OrderValues (столбец val объекмы продаж).
-- 2006 год - первый год работы магазина, но он также должен быть включен в результат.
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
	FROM "Sales"."OrderValues"
	GROUP BY EXTRACT(YEAR FROM orderdate)
) AS cy
LEFT OUTER JOIN
(
	SELECT EXTRACT(YEAR FROM orderdate) AS orderyear, SUM(val) AS totalsalesamount
	FROM "Sales"."OrderValues"
	GROUP BY EXTRACT(YEAR FROM orderdate)
) AS py ON cy.orderyear = py.orderyear + 1
ORDER BY cy.orderyear;


-- Решение через CTE
------
WITH cy AS
(SELECT EXTRACT(YEAR FROM orderdate) AS orderyear, SUM(val) AS totalsalesamount
	FROM "Sales"."OrderValues"
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




