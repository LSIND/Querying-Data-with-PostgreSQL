-- 1. UNION

-- UNION ALL
-- Объединение ВСЕХ строк из двух таблиц - 100

SELECT country, region, city FROM "HR"."Employees"
UNION ALL -- 100 rows
SELECT country, region, city FROM "Sales"."Customers";

-- UNION 
-- Объединение строк из двух таблиц - 71 - без дубликатов
SELECT country, region, city FROM "HR"."Employees"
UNION 
SELECT country, region, city FROM "Sales"."Customers";


-- 2. Using INTERSECT
-- Пересечение
SELECT country, region, city FROM "HR"."Employees"
INTERSECT -- 3 distinct rows 
SELECT country, region, city FROM "Sales"."Customers";

-- Сравнение плана запроса с DISTINCT JOIN COMPOSITE
-- Пересечение
EXPLAIN
SELECT country, city FROM "HR"."Employees"
INTERSECT 
SELECT country, city FROM "Sales"."Customers";

--JOIN
EXPLAIN
SELECT DISTINCT E.country, E.city 
FROM "HR"."Employees" as E
JOIN "Sales"."Customers" as C
ON E.country = C.country and E.city = C.city;

-- 3. EXCEPT
-- Исключение
-- Только из левой таблицы (Hr.Employees)
SELECT country, region, city FROM "HR"."Employees"
EXCEPT 
SELECT country, region, city FROM "Sales"."Customers";

--Только из Sales.Customers
SELECT country, region, city FROM "Sales"."Customers"
EXCEPT 
SELECT country, region, city FROM "HR"."Employees";