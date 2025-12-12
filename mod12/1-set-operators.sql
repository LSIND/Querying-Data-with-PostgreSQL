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


-- Категории продуктов, которые есть и у поставщиков из Финляндии, и у поставщиков из Германии:
SELECT c.categoryid, c.categoryname -- Категории продуктов от финских поставщиков
FROM production.categories c
JOIN production.products p ON c.categoryid = p.categoryid
JOIN production.suppliers s ON p.supplierid = s.supplierid
WHERE s.country = 'Finland'

INTERSECT

SELECT c.categoryid, c.categoryname -- Категории продуктов от немецких поставщиков
FROM production.categories c
JOIN production.products p ON c.categoryid = p.categoryid
JOIN production.suppliers s ON p.supplierid = s.supplierid
WHERE s.country = 'Germany'
ORDER BY categoryname;


-- * Сравнение плана запроса INTERSECT с DISTINCT JOIN COMPOSITE
-- Пересечение
EXPLAIN
SELECT country, city FROM hr.employees
INTERSECT 
SELECT country, city FROM sales.customers;

-- JOIN
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

-- Продукты, которые поставляет только Финляндия и больше никто:
SELECT p.productid, p.productname    -- Продукты, которые поставляет Финляндия
FROM production.products p
JOIN production.suppliers s ON p.supplierid = s.supplierid
WHERE s.country = 'Finland'

EXCEPT

SELECT p.productid, p.productname    -- Продукты, которые поставляют другие страны
FROM production.products p
JOIN production.suppliers s ON p.supplierid = s.supplierid
WHERE s.country != 'Finland'
ORDER BY productname;