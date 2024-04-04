-------------------------------------------------------
--
-- Модуль 2
-- Демонстрация 1
-- Примеры операторов DML, DDL; анонимный блок
--
-------------------------------------------------------


-- 1. DDL: Оператор CREATE TABLE. Создание таблицы public.orders
CREATE TABLE public.Orders
	( 
		OrderId int, 
		CustId int, 
		OrderDate date,
		Quantity int,
		Amount money
	); 


-- 2. DML: Оператор INSERT. Вставка данных к таблицу
INSERT INTO public.orders
VALUES(101,774,NOW(),100,99.98)
      ,(102,775,NOW(),32,49.99)
	  ,(103,775,NOW(),4, 9.99);


-- 3. DML: Оператор UPDATE. Обновление данных к таблице
UPDATE public.orders
SET Quantity = 500 
WHERE  OrderId = 101;


-- 4. DML: Оператор SELECT. Выбор всех данных из таблицы
SELECT OrderId, CustId, OrderDate, Quantity, Amount
FROM public.orders;


-- 5. Выражение. Вычисляемый столбец TotalOrderValue
SELECT OrderId, CustId, OrderDate, Quantity, Amount, (Quantity * Amount) AS TotalOrderValue
FROM public.orders;


-- 6. Условие. Инструкция WHERE 
SELECT OrderId, CustId, OrderDate, Quantity, Amount
FROM public.orders
WHERE Quantity > 50;


-- 7. Встроенная функция в инструкции WHERE (CURRENT_TIMESTAMP)
SELECT OrderId, CustId, OrderDate, Quantity, Amount
FROM public.orders
WHERE OrderDate < CURRENT_TIMESTAMP;


-- 8. Анонимный блок PL/pgSQL
DO $$
DECLARE                  --  объявление переменных
    one int;
    bar text := 'Hello World'; -- также допускается = или DEFAULT
BEGIN
    one := 999;          -- присваивание
    RAISE NOTICE '%, %!', one, bar; -- вывод сообщения
END
$$;


-- 9. DML: Оператор DELETE. Удаление данных из таблицы
DELETE FROM public.orders;


-- 10. DDL: Оператор DROP TABLE. Удаление таблицы 
DROP TABLE public.orders;