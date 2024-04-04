---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 4 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос к таблице sales.customers и получите contactname. 
-- Добавьте вычисляемый столбец с псевдонимом lastname, состоящий из всех символов до запятой contactname (фамилия).
--
-- Результирующий набор сравните с Lab Exercise4 - Task1 Result.txt. 
---------------------------------------------------------------------

SELECT
	contactname, 
	SUBSTRING(contactname, 0, strpos(contactname, ',')) AS lastname
FROM sales.customers;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к таблице sales.customers и получите contactname, заменив запятую в contactname пустой строкой. 
-- Добавьте вычисляемый столбец с псевдонимом firstname, состоящий из всех символов после запятой (имя).
--
-- Результирующий набор сравните с Lab Exercise4 - Task2 Result.txt. 
---------------------------------------------------------------------

SELECT
	REPLACE(contactname, ',', '') AS newcontactname,
	SUBSTRING(contactname, strpos(contactname, ',')+2, LENGTH(contactname)-strpos(contactname, ',')+2) AS firstname
FROM sales.customers;

SELECT
	REPLACE(contactname, ',', '') AS newcontactname,
	SPLIT_PART(contactname, ', ', 2) AS firstname
FROM sales.customers;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос к таблице sales.customers, получите custid. 
-- Добавьте вычисляемый столбец, определяющий custid как фиксированный шестизначный код покупателя с префиксом C и последующими 0. 
--   Например, значение custid, равное 1, должно отображаться как C00001.
--
-- Результирующий набор сравните с Lab Exercise4 - Task3 Result.txt. 
---------------------------------------------------------------------

SELECT 
	custid,
	'C' || RIGHT(REPEAT('0', 5) || CAST(custid AS VARCHAR(5)), 5) AS custnewid
FROM sales.customers;

SELECT 
	custid,
	CONCAT('C', LPAD(custid::varchar, 5, '0')) AS custnewid
FROM sales.customers;

---------------------------------------------------------------------
-- Task 4
--
-- Напишите SELECT-запрос к таблице sales.customers, получите contactname. 
-- Добавьте вычисляемый столбец, выводящий количество букв 'а' (регистр не учитывать) в contactname.
-- Упорядочить результат от наибольших повторений к наименьшим.
--
-- Результирующий набор сравните с Lab Exercise4 - Task4 Result.txt. 
---------------------------------------------------------------------

SELECT
	contactname,
	LENGTH(contactname) - LENGTH(REPLACE(LOWER(contactname), 'a', '')) AS numberofa
FROM sales.customers
ORDER BY numberofa DESC, contactname;