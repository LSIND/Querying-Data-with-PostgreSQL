---------------------------------------------------------------------
-- LAB 10
--
-- Exercise 2
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий номер продукта и название продукта (productid, productname) из таблицы Production.Products.
-- Отфильтруйте результаты, включив только продукты, проданные за раз в количестве, превышающем 100 штук. 
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий номер и имя заказчика (custid и contactname) из таблицы Sales.Customers. 
-- Выведите только тех заказчиков, которые не совершали заказы.
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 3
-- 
-- Есть запрос, добавляющий заказ в таблицу Sales.Orders. Номер заказчика (custid) этого заказа равен NULL.
-- Выполните этот запрос.
--
-- Скопируйте запрос Task 2 и выполните его. Сколько строк вернул запрос? Почему?
--
-- Измените запрос Task 2 так, чтобы результирующий набор совпадал с результатом Task 2.
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
---------------------------------------------------------------------

INSERT INTO "Sales"."Orders" (
custid, empid, orderdate, requireddate, shippeddate, shipperid, freight, 
shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry)
VALUES
(NULL, 1, '20111231', '20111231', '20111231', 1, 0, 
'ShipOne', 'ShipAddress', 'ShipCity', 'RA', '1000', 'USA');

---------------------------------------------------------------------

-- NULL issue Task 2



-- исправленный: явная проверка на NULL
