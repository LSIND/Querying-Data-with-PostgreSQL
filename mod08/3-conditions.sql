-- Функции-условия и проверка на NULL

-- 1. GREATEST и LEAST
-- NULL values are ignored while comparing
select GREATEST(1,null,5), LEAST(1,null,-5);

SELECT least('1970-12-10','2000-11-11','2019-01-01');

-- возвращаем либо цену, либо 50, если цена меньше
SELECT 	productid, unitprice, GREATEST(unitprice, 50::money) AS pricepoint
FROM "Production"."Products";


-- 2: ARRAY как зальтернатива функциям CHOOSE/ELT
-- SELECT CHOOSE (3, 'Beverages', 'Condiments', 'Confections') AS choose_result;

SELECT (array['Beverages', 'Condiments', 'Confections'])[3]  AS choose_result;

select orderid, orderdate,(array['Winter','Winter', 'Spring','Spring','Spring','Summer','Summer',  'Summer','Autumn','Autumn','Autumn','Winter'])[EXTRACT(MONTH FROM orderdate)]
AS quarter
FROM "Sales"."Orders"
WHERE shipcity = N'Paris'
ORDER BY orderdate;

-- COALESCE

-- первое не-NULL значение
SELECT COALESCE(NULL, NULL, 'test', 'abc', NULL);

SELECT	custid, country, region, city, country || ',' || COALESCE(region, ' ') || ', ' || city as Loc
FROM "Sales"."Customers";

-- NULLIF
-- Sample table
DROP TABLE IF EXISTS "public"."employee_goals";

CREATE TABLE "public"."employee_goals"(emp_id INT , goal int, actual int);

INSERT INTO "public"."employee_goals"
VALUES(1,100, 110), (2,90, 90), (3,100, 90), (4,100, 80);

-- Данные в таблице
SELECT emp_id, goal, actual
FROM "public"."employee_goals";

-- NULLIF
SELECT emp_id, NULLIF(actual,goal) AS actual_if_different
FROM "public"."employee_goals";

-- drop table
DROP TABLE IF EXISTS "public"."employee_goals";