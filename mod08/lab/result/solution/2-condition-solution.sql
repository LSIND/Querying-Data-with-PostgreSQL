---------------------------------------------------------------------
-- LAB 08
--
-- Exercise 2
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос к таблице Sales.Customers, выводящий custid и contactname.
-- Добавьте вычисляемый столбец segmentgroup с помощью array['Group One', 'Group Two', 'Group Three', 'Group Four']. Распределите заказчиков по custid в каждую группу (как остаток от деления)
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------

SELECT custid, contactname, (array['Group One', 'Group Two', 'Group Three', 'Group Four'])[custid % 4 + 1] AS segmentgroup
FROM "Sales"."Customers";

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, получающий contactname и fax из таблицы Sales.Customers. Если в fax стоит значение NULL - выводить  ‘No information’.
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt
---------------------------------------------------------------------

SELECT contactname, COALESCE(fax, N'No information') AS faxinformation
FROM "Sales"."Customers";


---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, получающий contactname, city, region из таблицы Sales.Customers. 
-- Верните только те строки, которые в столбце region не содержат 2 символа.
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
---------------------------------------------------------------------

SELECT custid, contactname, city, region
FROM "Sales"."Customers" 
WHERE 
	region IS NULL 
	OR LENGTH(region) <> 2;