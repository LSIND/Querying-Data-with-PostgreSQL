---------------------------------------------------------------------
-- LAB 10
--
-- Exercise 2 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий номер продукта и название продукта (productid, productname) из таблицы production.products.
-- Отфильтруйте результаты, включив только продукты, проданные за раз (в одном заказе) в количестве, превышающем 100 штук. 
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------

SELECT productid, productname
FROM production.products
WHERE 
	productid IN 
	(
		SELECT productid
		FROM sales.orderdetails
		WHERE qty > 100
	);

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий номер и имя заказчика (custid и contactname) из таблицы sales.customers. 
-- Выведите только тех заказчиков, которые не совершали заказы.
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt
---------------------------------------------------------------------

SELECT custid, contactname
FROM sales.customers
WHERE custid NOT IN 
	(
		SELECT custid
		FROM sales.orders
	);

---------------------------------------------------------------------
-- Task 3
-- 
-- Есть запрос, добавляющий заказ в таблицу sales.orders. Номер заказчика (custid) этого заказа равен NULL.
-- Выполните этот запрос.
--
-- Скопируйте запрос Task 2 и выполните его. Сколько строк вернул запрос? Почему?
--
-- Измените запрос Task 2 так, чтобы результирующий набор совпадал с результатом Task 2.
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
---------------------------------------------------------------------

INSERT INTO sales.orders (
custid, empid, orderdate, requireddate, shippeddate, shipperid, freight, 
shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry)
VALUES (NULL, 1, '20111231', '20111231', '20111231', 1, 0, 
'ShipOne', 'ShipAddress', 'ShipCity', 'RA', '1000', 'USA');

---------------------------------------------------------------------

-- NULL issue Task 2
SELECT custid, contactname
FROM sales.customers
WHERE custid NOT IN 
	(
		SELECT custid
		FROM sales.orders
	);

-- исправленный: явная проверка на NULL
SELECT custid, contactname
FROM sales.customers
WHERE custid NOT IN 
	(
		SELECT custid
		FROM sales.orders
        WHERE custid IS NOT NULL
	);
