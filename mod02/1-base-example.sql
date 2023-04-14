-- Модуль 2

-- 1: Создание таблицы public.orders
-- DDL

CREATE TABLE "public"."Orders"
	( 
		OrderId int, 
		CustId int, 
		OrderDate date,
		Quantity int,
		Amount money
	); 


-- 2. Вставка данных к таблицу
-- DML INSERT

INSERT INTO "public"."Orders"
VALUES(101,774,NOW(),100,99.98)
      ,(102,775,NOW(),32,49.99)
	  ,(103,775,NOW(),4, 9.99);

-- 3. Запрос к таблице
-- DML SELECT

SELECT OrderId, CustId, OrderDate, Quantity, Amount
FROM "public"."Orders";

DELETE FROM "public"."Orders";

-- 4. Выражение - вычисляемый столбец TotalOrderValue

SELECT OrderId, CustId, OrderDate, Quantity, Amount, (Quantity * Amount) AS TotalOrderValue
FROM "public"."Orders";

-- 5. Инструкция WHERE 

SELECT OrderId, CustId, OrderDate, Quantity, Amount
FROM "public"."Orders"
WHERE Quantity > 50;

-- 6. Функция в инструкции WHERE
-- CURRENT_TIMESTAMP

SELECT OrderId, CustId, OrderDate, Quantity, Amount
FROM "public"."Orders"
WHERE OrderDate < CURRENT_TIMESTAMP;

-- 7. Переменная в Anonymous block

DO $$
DECLARE customerId int DEFAULT 774;
rec record;

BEGIN
SELECT INTO rec OrderId, CustId, OrderDate, Quantity, Amount
FROM "public"."Orders"
WHERE CustId = customerId;

raise notice '%', rec;

END;
$$


-- 8. Удаление таблицы 
-- DDL
DROP TABLE "public"."Orders";