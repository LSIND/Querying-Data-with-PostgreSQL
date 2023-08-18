-----------------------------------------------------------------------
-----------------------------------------------------------------------

--	Таблица "NewProducts". Создаем и заполняем через SELECT * INTO
DROP TABLE IF EXISTS "public"."NewProducts";

SELECT * INTO "public"."NewProducts"
FROM "Production"."Products" 
WHERE productid >= 70; 

-- Таблица NewOrderDetails. Также создаем и заполняем через SELECT * INTO
DROP TABLE IF EXISTS "public"."NewOrderDetails";

SELECT * INTO "public"."NewOrderDetails"
FROM "Sales"."OrderDetails" WHERE productid >= 70;

-- Удаляем данные из оригинальных таблиц
DELETE FROM "Sales"."OrderDetails"
WHERE productid >= 70;

DELETE FROM "Production"."Products"
WHERE productid >= 70;

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
SELECT productid, productname, supplierid, categoryid, unitprice FROM "public"."NewProducts";

SELECT * FROM "Production"."Products"
WHERE productid >= 70;

-- OrderDetails - INSERT .. SELECT
INSERT INTO "Sales"."OrderDetails" (orderid, productid, unitprice, qty, discount)
SELECT * FROM "public"."NewOrderDetails";

SELECT * FROM "Sales"."OrderDetails"
WHERE productid >= 70;


-- Удаляем объекты демонстрации
DROP TABLE IF EXISTS "public"."NewOrderDetails";
DROP TABLE IF EXISTS "public"."NewProducts";