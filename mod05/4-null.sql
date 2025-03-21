-------------------------------------------------------
--
-- Модуль 5
-- Демонстрация 4
-- NULL
--
-------------------------------------------------------

-- Можно получить информацию о столбцах таблицы с помощью psql
-- \d sales.orders
-- Например,
--                                                  Таблица "sales.orders"
--    Столбец     |             Тип             | Правило сортировки | Допустимость NULL |           По умолчанию
------------------+-----------------------------+--------------------+-------------------+----------------------------------
-- orderid        | integer                     |                    | not null          | generated by default as identity
-- custid         | integer                     |                    |                   |
-- empid          | integer                     |                    | not null          |
-- orderdate      | timestamp without time zone |                    | not null          |
-- requireddate   | timestamp without time zone |                    | not null          |
-- shippeddate    | timestamp without time zone |                    |                   |
-- shipperid      | integer                     |                    | not null          |
-- freight        | numeric                     |                    | not null          | 0
-- shipname       | character varying(40)       |                    | not null          |
-- shipaddress    | character varying(60)       |                    | not null          |
-- shipcity       | character varying(15)       |                    | not null          |
-- shipregion     | character varying(15)       |                    |                   |
-- shippostalcode | character varying(10)       |                    |                   |
-- shipcountry    | character varying(15)       |                    | not null          |



-- Сортировка по полю, допускающему значение NULL (shipregion)
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
WHERE shipregion = NULL; -- не работает

SELECT orderid, shipcity, shipregion, orderdate
FROM sales.orders
WHERE shipregion IS NULL; 

SELECT orderid, shipcity, shipregion, orderdate
FROM sales.orders
WHERE shipregion IS NOT NULL; 