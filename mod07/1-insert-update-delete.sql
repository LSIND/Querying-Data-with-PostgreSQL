-------------------------------------------------------
--
-- Модуль 7
-- Демонстрация 1
-- Обзор DML-операций
--
-------------------------------------------------------

--	Таблица newProducts на схеме public. Создаем и заполняем через SELECT * INTO
DROP TABLE IF EXISTS public.newproducts;

SELECT * INTO public.newproducts
FROM production.products
WHERE productid >= 70; 

-- Таблица newOrderDetails на схеме public. Также создаем и заполняем через SELECT * INTO
DROP TABLE IF EXISTS public.neworderdetails;

SELECT * INTO public.neworderdetails
FROM sales.orderdetails WHERE productid >= 70;

-- Проверяем данные в новых таблицах
SELECT * FROM public.newproducts;
SELECT * FROM public.neworderdetails;

-- Удаляем данные из оригинальных таблиц
DELETE FROM sales.orderdetails 
WHERE productid >= 70;

DELETE FROM production.products
WHERE productid >= 70;

-- Проверяем, что данные удалены из оригинальных таблиц
SELECT * FROM sales.orderdetails 	
WHERE productid >= 70;

SELECT * FROM production.products
WHERE productid >= 70;

-----------------------------------------------------------------------
-----------------------------------------------------------------------

-- Возвращаем данные с помощью INSERT ... SELECT

INSERT INTO production.products (productid, productname, supplierid, categoryid, unitprice)
SELECT productid, productname, supplierid, categoryid, unitprice FROM public.newproducts;

SELECT * FROM production.products
WHERE productid >= 70;

-- OrderDetails - INSERT .. SELECT
INSERT INTO sales.orderdetails  (orderid, productid, unitprice, qty, discount)
SELECT * FROM public.neworderdetails;

SELECT * FROM sales.orderdetails 
WHERE productid >= 70;


-- Удаляем объекты демонстрации
DROP TABLE IF EXISTS public.neworderdetails;
DROP TABLE IF EXISTS public.newproducts;