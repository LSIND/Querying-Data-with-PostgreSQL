---------------------------------------------------------------------
-- LAB 08
--
-- Exercise 1
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос к таблице Production.Products с единственным вычисляемым столбцом productdesc. 
-- productdesc должен содержать строки следующего вида:
--  The unit price for the Product HHYDP is $18.00..
--
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------

SELECT CONCAT(N'The unit price for the ', productname, N' is ',  CAST(unitprice AS VARCHAR(10)), N'.') AS productdesc
FROM "Production"."Products";


---------------------------------------------------------------------
-- Task 2
-- 
-- Отдел маркетинга предоставил дату начала 4/1/2007 (April 1, 2007) и дату окончания 11/30/2007 (November 30, 2007) периода. 
-- Напишите SELECT-запрос к таблице Sales.Orders и получите столбцы orderid, orderdate, shippeddate, shipregion.
-- Включите только те строки, которые подходят под условие отдела маркетинга (в их формате), а также имеют более 30 дней в промежутке между датой отправки и датой заказа
-- Если в столбце region есть значение NULL - при выводе заменить его на 'No region'.
--
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

SELECT orderid, orderdate, shippeddate, COALESCE(shipregion, 'No region') AS shipregion
FROM "Sales"."Orders"
WHERE 
	orderdate >= to_timestamp('4/1/2007', 'MM/DD/YYYY') 
	AND orderdate <= to_timestamp('11/30/2007','MM/DD/YYYY')
	AND shippeddate > orderdate + INTERVAL '30 day';

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, конвертирующий номера телефонов из таблицы Sales.Customers в числовые значения int / bigint.
-- Удалите все лишние символы в номерах перед конвертацией. 
--
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

SELECT CAST(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, N'-', N''), N'(', ''), N')', ''), ' ', ''), '.', '') AS BIGINT) AS phonenoasint
FROM "Sales"."Customers";


SELECT CAST(TRANSLATE(phone, '-(), .', '') AS BIGINT) AS phonenoasint
FROM "Sales"."Customers";