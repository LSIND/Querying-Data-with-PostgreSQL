-- Модуль 4

---------------------------------------------
-- SQL'89 vs SQL'92
---------------------------------------------

-- Продукты и их категории: SQL'89
-- Без WHERE - Декартово множество (77 строк продуктов * 8 строк категорий)
--EXPLAIN
SELECT P.productid, P.productname, C.categoryname
FROM "Production"."Products" AS P, "Production"."Categories" AS C
WHERE P.categoryid = C.categoryid; --


-- Продукты и их категории: SQL'92
-- Планы запросов (EXPLAIN) одинаковые
--EXPLAIN
SELECT P.productid, P.productname, C.categoryname
FROM "Production"."Products" AS P
INNER JOIN "Production"."Categories" AS C
ON P.categoryid = C.categoryid;


-- ошибка: JOIN только с ON
SELECT P.productid, P.productname, C.categoryname
FROM "Production"."Products" AS P
INNER JOIN "Production"."Categories" AS C;


---------------------------------------------
-- INNER JOIN
---------------------------------------------

-- Продукты и их категории
SELECT P.productid, P.productname, C.categoryname, P.unitprice
FROM "Production"."Products" AS P
INNER JOIN "Production"."Categories" AS C
ON P.categoryid = C.categoryid;

-- inner composite join.
SELECT e.city, e.country
FROM "Sales"."Customers" AS c
JOIN "HR"."Employees" AS e 
ON c.city = e.city AND c.country = e.country;

-- inner composite join + distinct filter
SELECT DISTINCT  e.city, e.country
FROM "Sales"."Customers" AS c
JOIN "HR"."Employees" AS e 
ON c.city = e.city AND c.country = e.country;

-- INNER JOIN на 3 таблицы
SELECT c.custid, c.companyname, o.orderid, o.orderdate, od.productid, od.qty
FROM "Sales"."Customers" AS c 
JOIN "Sales"."Orders" AS o
ON c.custid = o.custid
JOIN "Sales"."OrderDetails" AS od
ON o.orderid = od.orderid;


---------------------------------------------
-- CROSS JOIN
---------------------------------------------

-- Декартово множество (77 строк продуктов * 8 строк категорий)
SELECT P.productid, P.productname, C.categoryname
FROM "Production"."Products" AS P, "Production"."Categories" AS C;

-- SQL'92 - CROSS JOIN
SELECT P.productid, P.productname, C.categoryname
FROM "Production"."Products" AS P
CROSS JOIN "Production"."Categories" AS C;