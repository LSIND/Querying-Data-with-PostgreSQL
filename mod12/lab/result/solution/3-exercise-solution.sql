---------------------------------------------------------------------
-- LAB 12
--
-- Exercise 3 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий custid из таблицы sales.orders. 
-- Выведите только тех заказчиков, которые купили более 20 различных продуктов (productid из sales.orderdetails).
--
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------

SELECT o.custid
FROM sales.orders AS o 
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
GROUP BY o.custid
HAVING COUNT(DISTINCT d.productid) > 20;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, выводящий custid из таблицы sales.orders.
-- Выведите только заказчиков из USA и исключите заказчиков, полученных в Task 1.
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
---------------------------------------------------------------------

SELECT custid
FROM sales.customers
WHERE country = 'USA'
EXCEPT
SELECT o.custid
FROM sales.orders AS o 
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
GROUP BY o.custid
HAVING COUNT(DISTINCT d.productid) > 20
ORDER BY custid;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, выводящий custid из таблицы sales.orders.
-- Выведите только тех заказчиков, кто купил на суммму более 10,000 у.е. (qty * unitprice из sales.orderdetails).
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt
---------------------------------------------------------------------

SELECT o.custid
FROM sales.orders AS o 
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
GROUP BY o.custid
HAVING SUM(d.qty * d.unitprice) > 10000.0;

---------------------------------------------------------------------
-- Task 4
-- 
-- Скопируйте весь запрос Task 2, убрав условие, что заказчики должны быть из USA. 
-- Добавьте оператор INTERSECT, а после него - запрос Task 3.
-- Сколько строк вернулось и почему?
--
-- Результирующий набор сравните с Lab Exercise3 - Task4 Result.txt
---------------------------------------------------------------------

SELECT custid
FROM sales.customers
EXCEPT
SELECT o.custid
FROM sales.orders AS o 
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
GROUP BY o.custid
HAVING COUNT(DISTINCT d.productid) > 20
INTERSECT
SELECT o.custid
FROM sales.orders AS o 
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
GROUP BY o.custid
HAVING SUM(d.qty * d.unitprice) > 10000.
ORDER BY custid;

---------------------------------------------------------------------
-- Task 5
-- 
-- Скопируйте запрос Task 4 и добавьте скобки к первой группе запросов (с начала и до INTERSECT).
-- Сколько строк вернулось и почему?
--
-- Результирующий набор сравните с Lab Exercise3 - Task5 Result.txt
---------------------------------------------------------------------

(SELECT custid
FROM sales.customers
EXCEPT
SELECT o.custid
FROM sales.orders AS o 
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
GROUP BY o.custid
HAVING COUNT(DISTINCT d.productid) > 20)
INTERSECT
SELECT o.custid
FROM sales.orders AS o 
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
GROUP BY o.custid
HAVING SUM(d.qty * d.unitprice) > 10000.
ORDER BY custid;