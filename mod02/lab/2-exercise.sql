---------------------------------------------------------------------
-- Module 02
--
-- Exercise 2
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Выполните запрос. Что это за результат?
---------------------------------------------------------------------

SELECT  firstname
		,lastname
		,city
		,country
FROM	hr.employees
WHERE	country = 'USA';

---------------------------------------------------------------------
-- Task 2
-- 
-- Раскомментируйте код и выполните запрос.
---------------------------------------------------------------------

/*SELECT  firstname
		,lastname		
FROM	hr.employees
WHERE	country = 'USA';*/

---------------------------------------------------------------------
-- Task 3
-- 
-- Выполните запрос. Чем отличается результат от результата Task 2?
---------------------------------------------------------------------
SELECT	firstname
		,lastname
FROM	hr.employees
WHERE	country = 'USA'
ORDER BY lastname;
---------------------------------------------------------------------