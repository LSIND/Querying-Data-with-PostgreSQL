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
SELECT RANDOM(), FLOOR(RANDOM() * 10 + 1)::int; -- случайное число от 0 до 1.; случайное целое число в диапазоне
SELECT PI(), POWER(2,5);

SELECT CAST(NOW() AS DATE) AS current_date;

SELECT UPPER('some text') as UpperText;

SELECT current_database(); -- имя текущей базы данных (строка)
SELECT pg_database_size(current_database()) AS DBSizeInBytes; -- Размер базы данных на диске в байтах


-- 2. Функции агрегирования 
SELECT COUNT(*) AS numorders, SUM(unitprice) AS totalsales
FROM sales.orderdetails;


-- 3. Оконная функция RANK
SELECT productid, productname, unitprice,
	RANK() OVER(ORDER BY unitprice DESC) AS rankbyprice
FROM production.products
ORDER BY rankbyprice
LIMIT 5;