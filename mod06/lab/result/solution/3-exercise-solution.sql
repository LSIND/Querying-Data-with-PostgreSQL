---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 3 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
--
-- Напишите SELECT-запрос к таблице sales.customers и выведите столбцы contactname и city. 
-- Создайте третий столбец contactwithcity, содержащий текст (на базе существующих данных) следующего вида:
--   Allen, Michael (city: Berlin)
--
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt. 
---------------------------------------------------------------------

SELECT  contactname, city,
	CONCAT(contactname, ' (city: ', city, ')') AS contactwithcity
FROM sales.customers;

SELECT  contactname, city,
	contactname || ' (city: ' || city ||  ')' AS contactwithcity 
FROM sales.customers;

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос 1 и измените вычисляемый столбец, добавив информацию о регионе. 
-- Если значение region равно NULL, то третий столбец выводит:
--  Allen, Michael (city: Berlin)
--
-- Если значение region не равно NULL, то третий столбец выводит:
--  Richardson, Shawn (city: Sao Paulo, region: SP)
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt.
---------------------------------------------------------------------

SELECT contactname, city,
	CONCAT(contactname, ' (city: ', city,  ', region: ' || region, ')') AS fullcontact
FROM sales.customers;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос к таблице sales.customers и получите contactname и contacttitle. 
-- Выведите только те строки, где первый символ в contactname от A до G.
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt.
---------------------------------------------------------------------

SELECT contactname, contacttitle
FROM sales.customers
WHERE LOWER(contactname) SIMILAR TO '[a-g]%'
ORDER BY contactname;