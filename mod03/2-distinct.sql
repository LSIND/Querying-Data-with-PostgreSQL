-------------------------------------------------------
--
-- Модуль 3
-- Демонстрация 2
-- Оператор DISTINCT
--
-------------------------------------------------------


-- 1. Все страны, в которых проживают заказчики 
SELECT country 
FROM sales.customers
ORDER BY country; -- 91 строка = кол-во заказиков


-- 2. Все страны, в которых проживают заказчики (без дублей)
SELECT DISTINCT country
FROM sales.customers
ORDER BY country;


-- 3. Страны и города, в которых проживают заказчики (без дублей)
SELECT DISTINCT country, city
FROM sales.customers
ORDER BY country, city;
