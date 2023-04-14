-- Модуль 5

---------------------------------------------
-- ORDER BY
---------------------------------------------

-- Упорядочивание по номеру заказа по возрастанию
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY orderid;

-- Упорядочивание по номеру заказа по убыванию
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY orderid DESC;

-- Упорядочивание по дате заказа по убыванию
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY orderdate DESC;

-- Упорядочивание по городу доставки по алфавиту
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY shipcity ASC;

-- Упорядочивание по вычисляемому столбцу с использованием псевдонима
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY "address" ASC;

-- Упорядочивание по номеру столбца - не рекомендуется
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY 5 ASC;

-- Упорядочивание по городу в алфавитном порядке, внутри каждого города - по дате по убыванию
SELECT orderid, shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY shipcity ASC, orderdate DESC;

---------------------------------------------

---------------------------------------------
-- WHERE + PREDICATES
---------------------------------------------
-- Заказы, отправленные в Берлин
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
WHERE shipcity = 'Berlin'
ORDER BY orderdate DESC;

-- Все заказы, номер которых меньше 10300
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
WHERE orderid < 10300
ORDER BY orderid;

-- Все заказы, оформленные ранее 01 августа 2006
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
WHERE orderdate < '20060801'
ORDER BY orderid;

-- Все заказы, оформленные в период с 01 января 2007 по 31 декабря 2007 включительно
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
WHERE orderdate >= '20070101' AND orderdate < '20080101'
ORDER BY orderdate;

-- Все заказы, оформленные в период с 01 января 2007 по 31 декабря 2007 00:00 включительно
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
WHERE orderdate BETWEEN '20070101' AND '20071231'
ORDER BY orderdate;


SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
WHERE shipcity = 'Berlin' OR shipcity = 'Oulu' OR shipcity = 'London' OR shipcity = 'Kobenhavn'
ORDER BY orderdate;

SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
WHERE shipcity IN ('Berlin', 'Oulu', 'London', 'Kobenhavn')
ORDER BY orderdate;

SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
WHERE shipcity NOT IN ('Berlin', 'Oulu', 'London', 'Kobenhavn')
ORDER BY orderdate;


SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
WHERE orderid IN (11843, 12500, 12550)
ORDER BY orderdate;

SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
WHERE shipname LIKE '%81-%';


SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
WHERE shipname NOT LIKE 'Ship%';

---------------------------------------------

---------------------------------------------
-- LIMIT + OFFSET-FETCH
---------------------------------------------

-- 10 самых последних заказов
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY orderdate DESC
LIMIT (10);

SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY orderdate DESC
LIMIT ALL;

-- Пропустить первые 10, получить следующие 10 (постраничный вывод)
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY orderdate DESC
LIMIT (10) OFFSET 10;

-- 10 самых последних заказов
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY orderdate DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- Пропустить первые 10, получить следующие 10 (постраничный вывод)
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY orderdate DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;

-- 20 первых заказов по алфавиту
SELECT orderid, shipcity,orderdate, shipname, shipcountry || ', ' || shipcity AS "address"
FROM "Sales"."Orders"
ORDER BY shipcity 
FETCH FIRST 20 ROWS ONLY;

-- 20 первых заказов по алфавиту + WITH TIES - 24 строки, пока не закончится значение shipcity
SELECT orderid, shipcity,orderdate, shipname
FROM "Sales"."Orders"
ORDER BY shipcity 
FETCH FIRST 20 ROWS WITH TIES OFFSET 0;

---------------------------------------------

---------------------------------------------
-- NULL
---------------------------------------------

-- Сортировка по полю, допускающему значение NULL
SELECT orderid, shipcity, shipregion, orderdate
FROM "Sales"."Orders"
ORDER BY shipregion; 

-- DISTINCT по полю, допускающему значение NULL
SELECT DISTINCT shipregion
FROM "Sales"."Orders"
ORDER BY shipregion; 

-- ПОИСК пустых значений
SELECT orderid, shipcity, shipregion, orderdate
FROM "Sales"."Orders"
WHERE shipregion = 'NULL'; -- не работает

SELECT orderid, shipcity, shipregion, orderdate
FROM "Sales"."Orders"
WHERE shipregion IS NULL; 

SELECT orderid, shipcity, shipregion, orderdate
FROM "Sales"."Orders"
WHERE shipregion IS NOT NULL; 