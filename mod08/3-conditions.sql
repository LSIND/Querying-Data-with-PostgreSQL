-- Функции-условия и проверка на NULL

-- 1. GREATEST и LEAST
-- NULL values are ignored while comparing
select GREATEST(1,null,5), LEAST(1,null,-5);

SELECT LEAST('1970-12-10','2000-11-11','2019-01-01');

-- возвращаем либо исходную цену продукта, либо 50, если цена меньше
SELECT 	productid, unitprice, GREATEST(unitprice, 50::money) AS pricepoint
FROM "Production"."Products";


-- 2: ARRAY как альтернатива функциям CHOOSE/ELT

SELECT (array['Beverages', 'Condiments', 'Confections'])[3]  AS choose_result;

SELECT orderid, orderdate,(array['Winter','Winter', 'Spring','Spring','Spring','Summer','Summer',  'Summer','Autumn','Autumn','Autumn','Winter'])[EXTRACT(MONTH FROM orderdate)]
AS season
FROM "Sales"."Orders"
WHERE shipcity = 'Paris'
ORDER BY orderdate;

-- * Array + предикат LIKE
SELECT orderid, orderdate, shipcity, shipname
FROM "Sales"."Orders"
WHERE shipcity LIKE 'Ca%' OR shipcity LIKE 'G%' -- 51 строка
ORDER BY orderdate;

-- LIKE - поиск через массив
SELECT orderid, orderdate, shipcity, shipname
FROM "Sales"."Orders"
WHERE shipcity LIKE ANY (ARRAY['Ca%', 'G%']) -- 51 строка
ORDER BY orderdate;

-- 3. COALESCE возвращает первое не-NULL значение

-- первое не-NULL значение
SELECT COALESCE(NULL, NULL, 'test', 'abc', NULL);

SELECT	custid, country, region, city, country || ',' || COALESCE(region, ' ') || ', ' || city as Loc
FROM "Sales"."Customers";

-- 4. NULLIF
-- Sample table
DROP TABLE IF EXISTS "public"."employee_goals";

CREATE TABLE "public"."employee_goals"(emp_id INT , goal int, actual int);

INSERT INTO "public"."employee_goals"
VALUES(1,100, 110), (2,90, 90), (3,100, 90), (4,100, 80);

-- Данные в таблице
SELECT emp_id, goal, actual
FROM "public"."employee_goals";

-- 'сравнение' данных с помощью NULLIF
SELECT emp_id, NULLIF(actual,goal) AS actual_if_different
FROM "public"."employee_goals";

-- удаление таблицы демонстрации
DROP TABLE IF EXISTS "public"."employee_goals";