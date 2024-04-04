-------------------------------------------------------
--
-- Модуль 12
-- Демонстрация 1
-- Операторы множеств
--
-------------------------------------------------------
 
-- 1. UNION

-- UNION ALL
-- Объединение ВСЕХ строк из двух таблиц - 100

SELECT country, region, city FROM hr.employees
UNION ALL -- 100 rows
SELECT country, region, city FROM sales.customers;

-- UNION 
-- Объединение строк из двух таблиц - 71 - без дубликатов
SELECT country, region, city FROM hr.employees
UNION     -- 71 rows
SELECT country, region, city FROM sales.customers;


-- 2. INTERSECT
-- Пересечение: общие страны, города, регионы как для сотрудников, так и для заказчиков
SELECT country, region, city FROM hr.employees
INTERSECT -- 3 distinct rows 
SELECT country, region, city FROM sales.customers;

-- Сравнение плана запроса INTERSECT с DISTINCT JOIN COMPOSITE
-- Пересечение
EXPLAIN
SELECT country, city FROM hr.employees
INTERSECT 
SELECT country, city FROM sales.customers;

--JOIN
EXPLAIN
SELECT DISTINCT E.country, E.city 
FROM hr.employees as E
JOIN sales.customers as C
ON E.country = C.country and E.city = C.city;

-- 3. EXCEPT
-- Исключение: данные только из левого множества (hr.employees)
SELECT country, region, city FROM hr.employees
EXCEPT 
SELECT country, region, city FROM sales.customers;

-- Исключение: данные только из правого множества (sales.customers)
SELECT country, region, city FROM sales.customers
EXCEPT 
SELECT country, region, city FROM hr.employees;