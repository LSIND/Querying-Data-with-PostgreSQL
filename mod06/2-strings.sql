-------------------------------------------------------
--
-- Модуль 6
-- Демонстрация 2
-- Функции для работы со строками
--
-------------------------------------------------------

-- функция CONCAT vs concatenation (||)

SELECT custid, contactname, city, region, country,
city || ', ' ||  region || ', ' || country AS Addr
FROM sales.customers;

SELECT custid, contactname, city, region, country,
CONCAT(city, ', ',  region, ', ', country) AS Addr
FROM sales.customers;

-- CONCAT_WS *
SELECT custid, contactname, city, region, country,
CONCAT_WS('; ', city, region, country) AS Addr
FROM sales.customers;


-- STRING FUNCTIONS

SELECT SUBSTRING('Изучаем язык SQL',14,3) AS Result; -- Подстрока
SELECT LEFT('Изучаем язык SQL', 7) AS left_example, RIGHT('Изучаем язык SQL',3) as right_example;

-------
SELECT LENGTH('SQL Language  ') AS LE, CHAR_LENGTH('SQL Language  '); -- длина строки в символах
SELECT LENGTH('Год'), octet_length('Год') AS LCyr, 
octet_length('Red') as LLat, octet_length('象形字') AS LCh; -- длина строки в байтах (зависит от кодировки)

-------

SELECT position('SQL' in 'Изучаем язык SQL') pos, strpos('Изучаем язык SQL', 'SQL') AS strpos;

SELECT UPPER('Изучаем язык SQL') AS UP, LOWER('Изучаем язык SQL') AS LOW;

SELECT INITCAP('изучаем язык sql') AS FirstLetter;

SELECT REPLACE('Изучаем SQL и функции SQL','SQL','PostgreSQL') AS Result; -- замена всех вхождений

SELECT TRANSLATE('abcdecd', 'abc', '123');

SELECT OVERLAY('Изучаем SQL и функции SQL' placing 'PostgreSQL' from 9 for 3) AS Result; -- замена подстроки

SELECT REPEAT('Тест', 5);

SELECT REVERSE('проверка');

SELECT SPLIT_PART('test;some;words;psql', ';', 2);