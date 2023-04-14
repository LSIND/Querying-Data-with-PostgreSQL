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



---

CREATE VIEW "Production"."ProductsBeverages" AS




FROM "Production"."Products"
WHERE categoryid = 1;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к представлению Production.ProductsBeverages, выведите productid и productname.
-- Выведите только продукты от поставщика N 1. 
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите код, изменяющий представление "Production"."ProductsBeverages" (CREATE OR REPLACE)
-- Представление должно выводить первые 5 самых дешевых продуктов
-- Напишите запрос к этому представлению, выведите только productid, productname, unitprice
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

CREATE OR REPLACE VIEW "Production"."ProductsBeverages" AS



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
	CASE WHEN unitprice > 100::money THEN N'high' ELSE N'normal' END
FROM "Production"."Products"
WHERE categoryid = 1;

SELECT * FROM "Production"."ProductsBeverages";


--- испр



---------------------------------------------------------------------
-- Task 5
-- Удалить представление
---------------------------------------------------------------------

DROP VIEW IF EXISTS "Production"."ProductsBeverages";