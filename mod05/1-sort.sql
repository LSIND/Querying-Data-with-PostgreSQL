-------------------------------------------------------
--
-- Модуль 5
-- Демонстрация 1
-- ORDER BY
--
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


-- Список всех заказов, упорядоченный по стране в алфавитном порядке,
-- по городу в алфавитном порядке, а внутри каждого города - по дате заказа по убыванию
SELECT orderid, shipcountry, shipcity, orderdate, shipname
FROM sales.orders
ORDER BY shipcountry ASC, shipcity ASC, orderdate DESC;
