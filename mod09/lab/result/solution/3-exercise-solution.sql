---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 3 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Выполните запрос. Предполагается, что запрос вернет количество заказов и количество заказчиков по годам.
-- Что на самом деле вернул запрос? Почему количество заказов и заказчиков одинаковое?
--
-- Исправьте запрос.
--
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------

SELECT
	EXTRACT (YEAR FROM orderdate) AS orderyear, 
	COUNT(orderid) AS nooforders, 
	COUNT(custid) AS noofcustomers
FROM sales.orders
GROUP BY EXTRACT (YEAR FROM orderdate);

--исправленный
SELECT
	EXTRACT (YEAR FROM orderdate) AS orderyear, 
	COUNT(orderid) AS nooforders, 
	COUNT(DISTINCT custid) AS noofcustomers -- distinct
FROM sales.orders
GROUP BY EXTRACT (YEAR FROM orderdate);

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий количество заказчиков, сгруппированных по первой букве имени (столбец contactname) таблицы Sales.Customers
-- Добавьте дополнительный столбец, рассчитывающий общее количество заказов для каждой группы (A, B, C...).
-- Псевдонимы на столбцы: firstletter, noofcustomers и nooforders. Упорядочить по первому столбцу firstletter (по алфавиту).
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
---------------------------------------------------------------------

SELECT
	SUBSTRING(c.contactname,1,1) AS firstletter,
	COUNT(DISTINCT c.custid) AS noofcustomers, 
	COUNT(o.orderid) AS nooforders
FROM sales.customers AS c
LEFT OUTER JOIN sales.orders AS o ON o.custid = c.custid
GROUP BY SUBSTRING(c.contactname,1,1)
ORDER BY firstletter;


---------------------------------------------------------------------
-- Task 3
-- 
-- Скопируйте запрос Exercise 1 - Task 4, возвращающий категории (categoryid и categoryname) из таблицы Production.Categories. 
-- Включите категории, продукты которых были проданы за весь 2023 год.
-- Для каждой категории продуктов расчитайте: общую сумму продаж, количество заказов и средняя сумма продаж за год
-- Псевдонимы totalsalesamount (SUM), nooforders (COUNT distinct) и avgsalesamountperorder (SUM/COUNT).
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt
---------------------------------------------------------------------

SELECT
	c.categoryid, c.categoryname, 
	SUM(d.qty * d.unitprice) AS totalsalesamount, 
	COUNT(DISTINCT o.orderid) AS nooforders,
	ROUND(SUM(d.qty * d.unitprice) / COUNT(DISTINCT o.orderid), 2) AS avgsalesamountperorder
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
INNER JOIN production.products AS p ON p.productid = d.productid
INNER JOIN production.categories AS c ON c.categoryid = p.categoryid
WHERE orderdate >= '20230101' AND orderdate < '20240101'
GROUP BY c.categoryid, c.categoryname;