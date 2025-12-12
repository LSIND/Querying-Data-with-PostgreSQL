-------------------------------------------------------
--
-- Модуль 8
-- Демонстрация 1
-- Обзор встроенных функций
--
-------------------------------------------------------

-- 1. Скалярные функции

SELECT orderid, EXTRACT(YEAR FROM orderdate) AS orderyear
FROM sales.orders;

SELECT ABS(-1.0), ABS(0.0), ABS(1.0);

-- случайное число в диапазоне [0.0, 1.0); случайное целое число в диапазоне [1, 10]
SELECT RANDOM(), (RANDOM() * 9)::int + 1 AS rand1_10;

SELECT PI(), POWER(2,5);

SELECT CAST(NOW() AS DATE) AS current_date;

SELECT UPPER('some text') as uppertext;

SELECT current_database(); -- имя текущей базы данных (строка)

-- Размер базы данных на диске в байтах
SELECT pg_database_size(current_database()) AS dbsize_InBytes; 
-- Размер базы данных на диске в KB / MB / GB / TB
SELECT pg_size_pretty(pg_database_size(current_database())) AS dbsize; 


-- 2. Функции агрегирования 
SELECT COUNT(*) AS numorders, SUM(unitprice) AS totalsales
FROM sales.orderdetails;


-- 3. Оконная функция RANK
SELECT productid, productname, unitprice,
	RANK() OVER(ORDER BY unitprice DESC) AS rankbyprice
FROM production.products
ORDER BY rankbyprice
LIMIT 5;