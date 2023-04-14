---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 3
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Выполните запрос. Предполагается, что запрос вернет количество заказов и количество заказчиков по годам.
-- Что на самом деле вернул запрос? Почему количество заказов и заказчиков одинаковое?
--
-- Исправьте запрос.
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------

SELECT
	EXTRACT (YEAR FROM orderdate) AS orderyear, 
	COUNT(orderid) AS nooforders, 
	COUNT(custid) AS noofcustomers
FROM "Sales"."Orders"
GROUP BY EXTRACT (YEAR FROM orderdate);

--исправленный
SELECT
	EXTRACT (YEAR FROM orderdate)::int AS orderyear, 
	COUNT(orderid) AS nooforders, 
	COUNT(DISTINCT custid) AS noofcustomers
FROM "Sales"."Orders"
GROUP BY EXTRACT (YEAR FROM orderdate);

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий количество заказчиков, сгруппированных по первой букве имени (столбец contactname) таблицы Sales.Customers
-- Добавьте дополнительный столбец, рассчитывающий общее количество заказов для групп.
-- Псевдонимы -  firstletter, noofcustomers и nooforders. Упорядочить по первому столбцу firstletter.
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
---------------------------------------------------------------------

SELECT
	SUBSTRING(c.contactname,1,1) AS firstletter,
	COUNT(DISTINCT c.custid) AS noofcustomers, 
	COUNT(o.orderid) AS nooforders
FROM "Sales"."Customers" AS c
LEFT OUTER JOIN "Sales"."Orders" AS o ON o.custid = c.custid
GROUP BY SUBSTRING(c.contactname,1,1)
ORDER BY firstletter;


---------------------------------------------------------------------
-- Task 3
-- 
-- Скопируйте запрос Exercise 1 - Task 4, возвращающий группы по categoryname из таблицы Production.Categories. 
-- Включите только те категории, продукты которых были оформлены в 2008 году.
-- Для каждой категории продуктов добавьте информацию: общее количество продаж, количество заказов и среднее количество заказов за год
-- Псевдонимы totalsalesamount, nooforders и avgsalesamountperorder.
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt
---------------------------------------------------------------------

SELECT
	c.categoryid, c.categoryname, 
	SUM(d.qty * d.unitprice) AS totalsalesamount, 
	COUNT(DISTINCT o.orderid) AS nooforders,
	SUM(d.qty * d.unitprice) / COUNT(DISTINCT o.orderid) AS avgsalesamountperorder
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d ON d.orderid = o.orderid
INNER JOIN "Production"."Products" AS p ON p.productid = d.productid
INNER JOIN "Production"."Categories" AS c ON c.categoryid = p.categoryid
WHERE orderdate >= '20080101' AND orderdate < '20090101'
GROUP BY c.categoryid, c.categoryname;