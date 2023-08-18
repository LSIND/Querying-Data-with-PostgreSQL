---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 3
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
--
-- Напишите SELECT-запрос к таблице Sales.Customers и выведите столбцы contactname и city. Создайте третий столбец contactwithcity, содержащий текст следующего вида:
--   Allen, Michael (city: Berlin)
--
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt. 
---------------------------------------------------------------------

SELECT 
	CONCAT(contactname, ' (city: ', city, ')') AS contactwithcity
FROM "Sales"."Customers";

SELECT 
	contactname || ' (city: ' || city ||  ')' AS contactwithcity 
FROM "Sales"."Customers";

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос 1 и измените его, добавив вычисляемый столбец с информацией о регионе. Если значение region равно NULL, то третий столбец выводит:
--  Allen, Michael (city: Berlin, region: )
--
-- Если значение region не равно NULL, то третий столбец выводит
--  Richardson, Shawn (city: Sao Paulo, region: SP)
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt.
---------------------------------------------------------------------

SELECT 
	CONCAT(contactname, ' (city: ', city,  ', region: ', region, ')') AS fullcontact
FROM "Sales"."Customers";

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос к таблице Sales.Customers и получите contactname и contacttitle. Выведите только те строки, где первый символ в contactname  от A до G.
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt.
---------------------------------------------------------------------

SELECT contactname, contacttitle
FROM "Sales"."Customers"
WHERE LOWER(contactname) SIMILAR TO '[a-g]%'
ORDER BY contactname;