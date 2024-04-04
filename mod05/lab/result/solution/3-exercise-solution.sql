---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 3 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос к таблице sales.orders и выведите столбцы orderid и orderdate. 
-- Получите 20 последних заказов (упорядочить по дате orderdate).
--
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------
SELECT orderid, orderdate
FROM sales.orders
ORDER BY orderdate DESC
LIMIT 20;


---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий результат как в Task 1, но с использованием OFFSET-FETCH.
---------------------------------------------------------------------

SELECT 	orderid, orderdate
FROM sales.orders
ORDER BY orderdate DESC
OFFSET 0 ROWS FETCH FIRST 20 ROWS ONLY;

---------------------------------------------------------------------
-- Task 3 *
-- 
-- Напишите SELECT-запрос, возвращающий столбцы productname и unitprice из таблицы Production.Products.
-- Выполните запрос (77 строк)
-- Измените запрос, получив только 10% строк от всего набора (упорядочить по unitprice).
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt
---------------------------------------------------------------------

SELECT productname, unitprice
FROM production.products
ORDER BY unitprice DESC
LIMIT (SELECT count(*) FROM production.products) * 0.1;