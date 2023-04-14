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


---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий количество заказчиков, сгруппированных по первой букве имени (столбец contactname) таблицы Sales.Customers
-- Добавьте дополнительный столбец, рассчитывающий общее количество заказов для групп.
-- Псевдонимы -  firstletter, noofcustomers и nooforders. Упорядочить по первому столбцу firstletter.
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
---------------------------------------------------------------------




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
