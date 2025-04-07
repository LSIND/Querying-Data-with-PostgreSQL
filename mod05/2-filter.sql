-------------------------------------------------------
--
-- Модуль 5
-- Демонстрация 2
-- WHERE + PREDICATES
--
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

-- Список заказов, оформленных ранее 01 августа 2021
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE orderdate < '20210801'
ORDER BY orderid;

-- Все заказы с номерами в промежутке от 10400 до 10410 включительно
SELECT orderid, shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE orderid >= 10400 AND orderid <= 10410
ORDER BY orderid;

-- Все заказы с номерами в промежутке от 10400 до 10410 включительно (BETWEEN >= <=)
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE orderid BETWEEN 10400 AND 10410
ORDER BY orderid;

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
-- Все заказы, в столбце shipname которых содержится '81-'
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE shipname LIKE '%81-%';

-- Все заказы, значение в столбце shipname которых начинается на 'Ship'
SELECT orderid,shipcity, orderdate, shipname, shipcountry || ', ' || shipcity AS address
FROM sales.orders
WHERE shipname NOT LIKE 'Ship%';
