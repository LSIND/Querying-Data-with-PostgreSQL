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
		orderid int, 
		custid int, 
		orderdate date,
		quantity int,
		amount money
	); 


-- 2. DML: Оператор INSERT. Вставка данных к таблицу
INSERT INTO public.orders(orderid, custid, orderdate, quantity, amount)
VALUES(101,774,NOW(),100,99.98)
      ,(102,775,NOW(),32,49.99)
	  ,(103,775,NOW(),4, 9.99);


-- 3. DML: Оператор UPDATE. Обновление данных к таблице
UPDATE public.orders
SET quantity = 500 
WHERE  orderid = 101;


-- 4. DML: Оператор SELECT. Выбор всех данных из таблицы
SELECT orderid, custid, orderdate, quantity, amount
FROM public.orders;


-- 5. Выражение. Вычисляемый столбец TotalOrderValue
SELECT orderid, custid, orderdate, quantity, amount, (quantity * amount) AS totalordervalue
FROM public.orders;


-- 6. Условие. Инструкция WHERE 
SELECT orderid, custid, orderdate, quantity, amount
FROM public.orders
WHERE quantity > 50;


-- 7. Встроенная функция в инструкции WHERE (CURRENT_TIMESTAMP)
SELECT orderid, custid, orderdate, quantity, amount
FROM public.orders
WHERE orderdate < CURRENT_TIMESTAMP;


-- 8. Анонимный блок PL/pgSQL
DO $$
DECLARE                  			--  объявление переменных
    one int;
    bar text := 'Hello World'; 		-- также допускается = или DEFAULT
BEGIN
    one := 999;          			-- присваивание
    RAISE NOTICE '%, %!', one, bar; -- вывод сообщения
END
$$;


-- 9. DML: Оператор DELETE. Удаление данных из таблицы
DELETE FROM public.orders;


-- 10. DDL: Оператор DROP TABLE. Удаление таблицы 
DROP TABLE public.orders;