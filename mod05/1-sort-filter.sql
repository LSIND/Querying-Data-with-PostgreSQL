-------------------------------------------------------
--
-- Модуль 5
-- Демонстрация 1
--
-------------------------------------------------------

-------------------------------------------------------
-- 1. ORDER BY
-------------------------------------------------------

-- Список всех заказов, упорядоченный по номеру заказа по возрастанию
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY orderid;

-- Список всех заказов, упорядоченный по номеру заказа по убыванию
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY orderid DESC;

-- Список всех заказов, упорядоченный по дате заказа по убыванию
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY orderdate DESC;

-- Список всех заказов, упорядоченный по городу доставки по алфавиту
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY shipcity ASC;

-- Список всех заказов, упорядоченный по вычисляемому столбцу с использованием псевдонима
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY address ASC;

-- Список всех заказов, упорядоченный по номеру столбца - не рекомендуется
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY 5 ASC;

-- Список всех заказов, упорядоченный по городу в алфавитном порядке, внутри каждого города - по дате по убыванию
SELECT orderid, shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY shipcity ASC, orderdate DESC;


-------------------------------------------------------
-- 2. WHERE + PREDICATES
-------------------------------------------------------

-- Список заказов, отправленных в Берлин
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE shipcity = 'Berlin'
ORDER BY orderdate DESC;

-- Список заказов, номер которых меньше 10300
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE orderid < 10300
ORDER BY orderid;

-- Список заказов, оформленных ранее 01 августа 2006
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE orderdate < '20060801'
ORDER BY orderid;

-- Все заказы, оформленные в период с 01 января 2007 по 31 декабря 2007 включительно
SELECT orderid, shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE orderdate >= '20070101' AND orderdate < '20080101'
ORDER BY orderdate;

-- Все заказы, оформленные в период с 01 января 2007 по 31 декабря 2007 00:00 включительно
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE orderdate BETWEEN '20070101' AND '20071231'
ORDER BY orderdate;

-- Заказы, отправленные в Берлин, Оулу, Лондон и Копенгаген
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE shipcity = 'Berlin' OR shipcity = 'Oulu' OR shipcity = 'London' OR shipcity = 'Kobenhavn'
ORDER BY orderdate;

-- Заказы, отправленные в Берлин, Оулу, Лондон и Копенгаген с предикатом IN
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE shipcity IN ('Berlin', 'Oulu', 'London', 'Kobenhavn')
ORDER BY orderdate;

-- Заказы, отправленные в любые города, кроме городов Берлин, Оулу, Лондон и Копенгаген
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE shipcity NOT IN ('Berlin', 'Oulu', 'London', 'Kobenhavn')
ORDER BY orderdate;

-- Заказы с номерами 11043, 10500, 10900
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE orderid IN (11043, 10500, 10900)
ORDER BY orderdate;

-- Предикат LIKE
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE shipname LIKE '%81-%';

SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE shipname NOT LIKE 'Ship%';


-------------------------------------------------------
-- 3. LIMIT + OFFSET-FETCH
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

-- стандарт sql'2011
-- 10 самых последних заказов (по дате оформления)
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
ORDER BY orderdate DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

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
FETCH FIRST 20 ROWS WITH TIES OFFSET 0;


-------------------------------------------------------
-- 4. NULL
-------------------------------------------------------

-- Сортировка по полю, допускающему значение NULL
SELECT orderid, shipcity, shipregion, orderdate
FROM sales.orders
ORDER BY shipregion; 

-- DISTINCT по полю, допускающему значение NULL
SELECT DISTINCT shipregion
FROM sales.orders
ORDER BY shipregion; 

-- ПОИСК пустых значений
SELECT orderid, shipcity, shipregion, orderdate
FROM sales.orders
WHERE shipregion = 'NULL'; -- не работает

SELECT orderid, shipcity, shipregion, orderdate
FROM sales.orders
WHERE shipregion IS NULL; 

SELECT orderid, shipcity, shipregion, orderdate
FROM sales.orders
WHERE shipregion IS NOT NULL; 