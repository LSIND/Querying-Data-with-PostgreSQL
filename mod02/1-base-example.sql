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

-- 7. Переменная в Anonymous block с использованием курсора и динамического sql

BEGIN;
DO $$
DECLARE 
customerId int:= 774;
_query text;  
_cursor CONSTANT refcursor := '_cursor';
BEGIN _query := 
'SELECT  OrderId, CustId, OrderDate, Quantity, Amount
FROM "public"."Orders"
WHERE CustId = ' || customerId;

OPEN _cursor FOR EXECUTE _query;
END $$;
FETCH ALL FROM _cursor;
COMMIT;


-- 8. Удаление таблицы 
-- DDL
DROP TABLE "public"."Orders";