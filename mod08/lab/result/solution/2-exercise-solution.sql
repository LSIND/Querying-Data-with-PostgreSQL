---------------------------------------------------------------------
-- LAB 08
--
-- Exercise 2 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос к таблице sales.customers, выводящий custid и contactname.
-- Добавьте вычисляемый столбец segmentgroup с помощью массива ['Group One', 'Group Two', 'Group Three', 'Group Four']. 
-- Распределите заказчиков по custid в каждую группу (как остаток от деления).
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------

SELECT custid, contactname, (array['Group One', 'Group Two', 'Group Three', 'Group Four'])[custid % 4 + 1] AS segmentgroup
FROM sales.customers;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, получающий contactname и fax из таблицы sales.customers. 
-- Если в fax стоит значение NULL - выводить  ‘No information’.
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt
---------------------------------------------------------------------

SELECT contactname, COALESCE(fax, 'No information') AS faxinformation
FROM sales.customers;


---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, получающий contactname, city, region из таблицы sales.customers. 
-- Верните только те строки, которые в столбце region содержат любое количество символов (или NULL), кроме 2х.
-- То есть, в результат не должны попасть строки, где регион = WY, SP и т.д.
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
---------------------------------------------------------------------

SELECT custid, contactname, city, region
FROM sales.customers
WHERE 
	region IS NULL 
	OR LENGTH(region) <> 2;