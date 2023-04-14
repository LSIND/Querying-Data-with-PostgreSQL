-----------------------------------------------------------------------
-----------------------------------------------------------------------

--	Таблица "NewProducts". Заполняем через SELECT * INTO
DROP TABLE IF EXISTS "public"."NewProducts";

SELECT * INTO "NewProducts"
FROM "Production"."Products" WHERE ProductID >= 70; -- может не работать в AZ Data Studio

-- Таблица NewOrderDetails. Также заполняем через SELECT * INTO
DROP TABLE IF EXISTS "public"."NewOrderDetails";

SELECT * INTO "NewOrderDetails"
FROM "Sales"."OrderDetails" WHERE ProductID >= 70;

-- Удаляем данные из оригинальных таблиц
DELETE FROM "Sales"."OrderDetails"
WHERE ProductID >= 70;

DELETE FROM "Production"."Products"
WHERE ProductID >= 70;

-- Проверяем данные в новых таблицах
SELECT * FROM "public"."NewProducts";
SELECT * FROM "public"."NewOrderDetails";

-- Проверяем, что данные удалены из оригинальных таблиц
SELECT * FROM "Sales"."OrderDetails"	
WHERE productid >= 70;

SELECT * FROM "Production"."Products"
WHERE productid >= 70;

-----------------------------------------------------------------------
-----------------------------------------------------------------------

-- Возвращаем данные с помощью INSERT ... SELECT

INSERT INTO "Production"."Products" (productid, productname, supplierid, categoryid, unitprice)
SELECT Productid, productname, SUpplierID, CategoryID, Unitprice FROM "public"."newproducts";

SELECT * FROM "Production"."Products"
WHERE productid >= 70;

-- OrderDetails - INSERT .. SELECT
INSERT INTO "Sales"."OrderDetails" (orderid, productid, unitprice, qty, discount)
SELECT * FROM "public"."NewOrderDetails";

SELECT * FROM "Sales"."OrderDetails"
WHERE productid >= 70;

-- Удаляем новые объекты

DROP TABLE IF EXISTS "public"."NewOrderDetails";

DROP TABLE IF EXISTS "public"."NewProducts";