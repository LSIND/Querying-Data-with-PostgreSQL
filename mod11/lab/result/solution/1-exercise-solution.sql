---------------------------------------------------------------------
-- LAB 11
--
-- Exercise 1
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий productid, productname, supplierid, unitprice, discontinued из Production.Products. 
-- Выведите только продукты из категории Beverages (categoryid = 1).
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
--
-- Создайте представление Production.ProductBeverages, включив в него код запроса. Найдите созданное представление в обозревателе объектов
---------------------------------------------------------------------

SELECT productid, productname, supplierid, unitprice, discontinued
FROM "Production"."Products"
WHERE categoryid = 1;

---

CREATE VIEW "Production"."ProductsBeverages" AS
SELECT
	productid, productname, supplierid, unitprice, discontinued
FROM "Production"."Products"
WHERE categoryid = 1;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к представлению Production.ProductsBeverages, выведите productid и productname.
-- Выведите только продукты от поставщика N 1. 
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

SELECT productid, productname
FROM "Production"."ProductsBeverages"
WHERE supplierid = 1;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите код, изменяющий представление "Production"."ProductsBeverages" (CREATE OR REPLACE)
-- Представление теперь должно выводить 5 самых дешевых продуктов из категории Beverages (categoryid = 1).
-- Напишите запрос к этому представлению, выведите только productid, productname, unitprice
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

CREATE OR REPLACE VIEW "Production"."ProductsBeverages" AS
SELECT productid, productname, supplierid, unitprice, discontinued
FROM "Production"."Products"
WHERE categoryid = 1
ORDER BY unitprice
LIMIT 5;

-- выбор данных из измененного представления
SELECT productid, productname, unitprice 
FROM "Production"."ProductsBeverages";

---------------------------------------------------------------------
-- Task 4
-- 
-- Коллеги написали запрос, добавляющий дополнительный вычисляемый столбец в представление "Production"."ProductsBeverages"
-- Выполните код. В чем недостаток такого изменения?
-- Предложите исправления и измените представление
--
---------------------------------------------------------------------

CREATE OR REPLACE VIEW "Production"."ProductsBeverages" AS
SELECT
	productid, productname, supplierid, unitprice, discontinued,
	CASE WHEN unitprice > 100::money THEN 'high' ELSE 'normal' END
FROM "Production"."Products"
WHERE categoryid = 1;

SELECT * FROM "Production"."ProductsBeverages";

--- испр
DROP VIEW IF EXISTS "Production"."ProductsBeverages";
CREATE OR REPLACE VIEW "Production"."ProductsBeverages" AS
SELECT
	productid, productname, supplierid, unitprice, discontinued,
	CASE WHEN unitprice > 100::money THEN 'high' ELSE 'normal' END AS pricetype
FROM "Production"."Products"
WHERE categoryid = 1;

-- * другое решение через переименование столбца представления
ALTER TABLE "Production"."ProductsBeverages" RENAME COLUMN "case" to pricetype;

---------------------------------------------------------------------
-- Task 5
-- Удалить представление
---------------------------------------------------------------------

DROP VIEW IF EXISTS "Production"."ProductsBeverages";