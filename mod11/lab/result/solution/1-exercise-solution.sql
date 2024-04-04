---------------------------------------------------------------------
-- LAB 11
--
-- Exercise 1 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий productid, productname, supplierid, unitprice, discontinued из production.products. 
-- Выведите только продукты из категории напитки (Beverages): categoryid = 1.
--
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
--
-- Создайте представление production.productbeverages, включив в него код запроса. 
-- Найдите созданное представление в графической среде
---------------------------------------------------------------------

SELECT productid, productname, supplierid, unitprice, discontinued
FROM production.products
WHERE categoryid = 1;

--- Представление production.productbeverages

CREATE VIEW production.productbeverages AS
SELECT
	productid, productname, supplierid, unitprice, discontinued
FROM production.products
WHERE categoryid = 1;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к представлению production.productbeverages, выведите productid и productname.
-- Выведите только продукты от поставщика N 1. 
--
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

SELECT productid, productname
FROM production.productbeverages
WHERE supplierid = 1;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите код, изменяющий код представления production.productbeverages (CREATE OR REPLACE)
-- ** Инструкция CREATE OR REPLACE либо создаст представление (если оно не существует),
--     либо заменит код запроса, при этом порядок, названия и типы данных столбцов должны совпадать;
--     тем не менее можно добавлять дополнительные столбцы в конец списка.
-- Представление теперь должно выводить 5 самых дешевых продуктов из категории Beverages (categoryid = 1).
-- Напишите запрос к этому представлению, выведите только productid, productname, unitprice.
--
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

CREATE OR REPLACE VIEW production.productbeverages AS
SELECT productid, productname, supplierid, unitprice, discontinued
FROM production.products
WHERE categoryid = 1
ORDER BY unitprice
LIMIT 5;

-- выбор данных из измененного представления
SELECT productid, productname, unitprice 
FROM production.productbeverages;

---------------------------------------------------------------------
-- Task 4
-- 
-- Коллеги написали запрос, добавляющий дополнительный вычисляемый столбец в представление production.productbeverages.
-- Выполните код. В чем недостаток такого изменения?
--
-- Предложите исправления и измените представление
--
---------------------------------------------------------------------

CREATE OR REPLACE VIEW production.productbeverages AS
SELECT
	productid, productname, supplierid, unitprice, discontinued,
	CASE WHEN unitprice > 100::money THEN 'high' ELSE 'normal' END
FROM production.products
WHERE categoryid = 1;

SELECT * FROM production.productbeverages;

-- Проблема: вычисляемый столбец с CASE не имеет псевдонима ('псевдоним' взят из инструкции столбца)
-- Решение 1: Удалить представление и создать заново.
DROP VIEW IF EXISTS production.productbeverages;
CREATE OR REPLACE VIEW production.productbeverages AS
SELECT
	productid, productname, supplierid, unitprice, discontinued,
	CASE WHEN unitprice > 100::money THEN 'high' ELSE 'normal' END AS pricetype
FROM production.products
WHERE categoryid = 1;

-- * Решение 2. Переименовать вычисляемый столбец представления
ALTER VIEW production.productbeverages RENAME COLUMN "case" to pricetype;

---------------------------------------------------------------------
-- Task 5
-- Удалить представление
---------------------------------------------------------------------

DROP VIEW IF EXISTS production.productbeverages;