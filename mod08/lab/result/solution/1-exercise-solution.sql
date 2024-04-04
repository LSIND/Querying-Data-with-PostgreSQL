---------------------------------------------------------------------
-- LAB 08
--
-- Exercise 1 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос к таблице production.products с единственным вычисляемым столбцом productdesc. 
-- productdesc должен содержать строки следующего вида:
--  The unit price for the Product HHYDP is $18.00.
--
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------

SELECT CONCAT('The unit price for the ', productname, ' is ',  CAST(unitprice AS VARCHAR(10)), '.') AS productdesc
FROM production.products ;


---------------------------------------------------------------------
-- Task 2
-- 
-- Отдел маркетинга предоставил дату начала 4/1/2007 (1 апреля 2007 г.) и дату окончания 11/30/2007 (30 ноября 2007 г.) периода. 
-- Напишите SELECT-запрос к таблице sales.orders и получите столбцы orderid, orderdate, shippeddate, shipregion.
-- Включите только те строки, которые подходят под условие отдела маркетинга (в их формате месяц/день/год), а также имеют более 30 дней в промежутке между датой отправки и датой заказа.
-- Если в столбце region есть значение NULL - при выводе заменить его на 'No region'.
--
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

SELECT orderid, orderdate, shippeddate, COALESCE(shipregion, 'No region') AS shipregion
FROM sales.orders
WHERE 
	orderdate >= to_timestamp('4/1/2007', 'MM/DD/YYYY') 
	AND orderdate <= to_timestamp('11/30/2007','MM/DD/YYYY')
	AND shippeddate > orderdate + '30 days'::interval;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, конвертирующий номера телефонов из таблицы sales.customers в числовые значения int / bigint.
-- Удалите все лишние символы в номерах перед конвертацией. 
--
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

SELECT CAST(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, '-', ''), '(', ''), ')', ''), ' ', ''), '.', '') AS BIGINT) AS phonenoasint
FROM sales.customers;

SELECT CAST(TRANSLATE(phone, '-(), .', '') AS BIGINT) AS phonenoasint
FROM sales.customers;