-------------------------------------------------------
--
-- Модуль 5
-- Демонстрация 3
-- LIMIT + OFFSET-FETCH
--
-------------------------------------------------------


-- 10 самых последних заказов (по дате оформления)
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY orderdate DESC
LIMIT (10);

-- Постраничный вывод
-- Вторая страница с 10 следующими заказами
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY orderdate DESC
LIMIT (10) OFFSET 10;



-- SQL:2008
-- 10 самых последних заказов (по дате оформления)
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY orderdate DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


-- 10 самых последних заказов (по дате оформления)
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY orderdate DESC
FETCH FIRST 10 ROWS ONLY;


-- Постраничный вывод
-- Вторая страница с 10 следующими заказами
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY orderdate DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- 20 первых заказов, упорядоченных по городу доставки по алфавиту
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY shipcity 
FETCH FIRST 20 ROWS ONLY;


-- 20 первых заказов, упорядоченных по городу доставки по алфавиту
-- + WITH TIES - 24 строки, пока не закончится значение shipcity
SELECT orderid, shipcity,orderdate, shipname
FROM sales.orders
ORDER BY shipcity 
FETCH FIRST 20 ROWS WITH TIES;
