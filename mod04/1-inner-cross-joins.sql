-------------------------------------------------------
--
-- Модуль 4
-- Демонстрация 1
-- INNER JOIN + CROSS JOIN (Cartesian Product)
--
-------------------------------------------------------

-------------------------------------------------------
-- 1. SQL:89 vs SQL:92
-------------------------------------------------------

-- Продукты и их категории: SQL:89
-- Без WHERE - Декартово множество (77 строк продуктов * 8 строк категорий)
-- EXPLAIN
SELECT P.productid, P.productname, C.categoryname
FROM production.products AS P, production.categories AS C
WHERE P.categoryid = C.categoryid; 


-- Продукты и их категории: SQL:92
-- Инструкцию ON удалить нельзя - синтаксическая ошибка
-- EXPLAIN
SELECT P.productid, P.productname, C.categoryname
FROM production.products AS P
INNER JOIN production.categories AS C
ON P.categoryid = C.categoryid;
-- * Планы запросов (EXPLAIN) одинаковые

-- ошибка: JOIN только с ON
SELECT P.productid, P.productname, C.categoryname
FROM production.products AS P
INNER JOIN production.categories AS C;


-------------------------------------------------------
-- 2. INNER JOIN
-------------------------------------------------------

-- Продукты и их категории
SELECT P.productid, P.productname, C.categoryname, P.unitprice
FROM production.products AS P
INNER JOIN production.categories AS C
ON P.categoryid = C.categoryid;

-- inner composite join
SELECT e.city, e.country
FROM sales.customers AS c
JOIN hr.employees AS e 
ON c.city = e.city AND c.country = e.country;

-- inner composite join + distinct filter
-- общие страны и города для заазчиков и сотрудников
SELECT DISTINCT  e.city, e.country
FROM sales.customers AS c
JOIN hr.employees AS e 
ON c.city = e.city AND c.country = e.country;

-- INNER JOIN на 3 таблицы
-- Заказчики, их заказы и позиции в этих заказах
SELECT c.custid, c.companyname, o.orderid, o.orderdate, od.productid, od.qty
FROM sales.customers AS c 
JOIN sales.orders AS o
ON c.custid = o.custid
JOIN sales.orderDetails AS od
ON o.orderid = od.orderid;


-------------------------------------------------------
-- 3. CROSS JOIN
-------------------------------------------------------

-- SQL:89. Декартово множество (77 строк продуктов * 8 строк категорий)
SELECT P.productid, P.productname, C.categoryname
FROM production.products AS P, production.categories AS C;

-- SQL:92. CROSS JOIN - Декартово множество
SELECT P.productid, P.productname, C.categoryname
FROM production.products AS P
CROSS JOIN production.categories AS C;