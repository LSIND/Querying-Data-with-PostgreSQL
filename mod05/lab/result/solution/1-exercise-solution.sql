---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 1 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий столбцы custid, companyname, contactname, address, city, country и phone из таблицы sales.customers. 
-- Отфильтруйте результат, получив только заказчиков из Brazil.
--
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------

SELECT custid, companyname, contactname, address, city, country, phone
FROM sales.customers
WHERE country = 'Brazil';


---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий столбцы custid, companyname, contactname, address, city, country и phone из таблицы sales.customers. 
-- Отфильтруйте результат, получив только заказчиков из Brazil, UK и USA.
--
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

SELECT custid, companyname, contactname, address, city, country, phone
FROM sales.customers
WHERE country IN ('Brazil', 'UK', 'USA');

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, возвращающий столбцы custid, companyname, contactname, address, city, country и phone из таблицы sales.customers. 
-- Выведите только заказчиков, contactname которых начинается на букву A.
--
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

SELECT custid, companyname, contactname, address, city, country, phone
FROM sales.customers 
WHERE contactname LIKE 'A%';

---------------------------------------------------------------------
-- Task 4a
-- 
-- Есть запрос, выводящий custid и companyname из таблицы sales.customers и orderid из таблицы sales.orders.
-- Выполните запрос. Что вернул запрос?
---- Обратите внимание, что в ON содержится city = 'Paris'
--
-- Запрос вернул 94 строки: 
-- заказчики не из Парижа с NULL в столбце orderid, а также заказчики из Парижа со своими заказами

---------------------------------------------------------------------

SELECT c.custid, c.companyname, o.orderid
FROM sales.customers AS c
LEFT OUTER JOIN sales.orders AS o 
ON c.custid = o.custid AND c.city = 'Paris'
ORDER BY c.custid;

---------------------------------------------------------------------
-- Task 4b
-- 
-- Скопируйте запрос Task 4a и поместите условие city = 'Paris'в инструкцию WHERE. 
--
-- Результирующий набор сравните с Lab Exercise1 - Task4b Result.txt
-- Что произошло?

-- Список заказчиков из Парижа и номера их заказов + заказчик из Парижа без заказов
---------------------------------------------------------------------

SELECT c.custid, c.companyname, o.orderid
FROM sales.customers AS c
LEFT OUTER JOIN sales.orders AS o 
ON c.custid = o.custid 
WHERE c.city = 'Paris'
ORDER BY c.custid;

---------------------------------------------------------------------
-- Task 5
-- 
-- Напишите SELECT-запрос, выводящий заказчиков из таблицы sales.customers, которые еще не совершали заказы (не имеют заказов в таблице sales.orders). 
-- Вывести столбцы custid и companyname из sales.customers. 
--
-- Результирующий набор сравните с Lab Exercise1 - Task5 Result.txt
---------------------------------------------------------------------

SELECT c.custid, c.companyname
FROM sales.customers AS c
LEFT OUTER JOIN sales.orders AS o 
ON c.custid = o.custid 
WHERE o.custid IS NULL;