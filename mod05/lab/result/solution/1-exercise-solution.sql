---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 1
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий столбцы custid, companyname, contactname, address, city, country и phone из таблицы Sales.Customers. 
-- Отфильтруйте результат, получив только заказчиков из Brazil.
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------

SELECT custid, companyname, contactname, address, city, country, phone
FROM "Sales"."Customers"
WHERE country = 'Brazil';


---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий столбцы custid, companyname, contactname, address, city, country и phone из таблицы Sales.Customers. 
-- Отфильтруйте результат, получив только заказчиков из Brazil, UK и USA.
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

SELECT custid, companyname, contactname, address, city, country, phone
FROM "Sales"."Customers"
WHERE country IN ('Brazil', 'UK', 'USA');

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, возвращающий столбцы custid, companyname, contactname, address, city, country и phone из таблицы Sales.Customers. 
-- Отфильтруйте результат, получив только заказчиков, contactname которых начинается на букву A.
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

SELECT custid, companyname, contactname, address, city, country, phone
FROM "Sales"."Customers"
WHERE contactname LIKE 'A%';

---------------------------------------------------------------------
-- Task 4a
-- 
-- Есть запрос, выводящий custid и companyname из таблицы Sales.Customers и orderid из таблицы Sales.Orders.
-- Выполните запрос. Запрос вернул:
---- Все строки таблицы Sales.Customers
---- В ON содержится также оператор сравнения, city = 'Paris'
---------------------------------------------------------------------

SELECT c.custid, c.companyname, o.orderid
FROM "Sales"."Customers" AS c
LEFT OUTER JOIN "Sales"."Orders" AS o 
ON c.custid = o.custid AND c.city = 'Paris'
ORDER BY c.custid;

---------------------------------------------------------------------
-- Task 4b
-- 
-- Скопируйте запрос Task 4a и поместите условие city = 'Paris'в инструкцию WHERE. 
-- Результирующий набор сравните с Lab Exercise1 - Task4b Result.txt
-- Что произошло?
---------------------------------------------------------------------

SELECT c.custid, c.companyname, o.orderid
FROM "Sales"."Customers" AS c
LEFT OUTER JOIN "Sales"."Orders" AS o
ON c.custid = o.custid 
WHERE c.city = 'Paris'
ORDER BY c.custid;

---------------------------------------------------------------------
-- Task 5
-- 
-- Напишите SELECT-запрос, выводящий заказчиков из таблицы Sales.Customers, которые еще не совершали заказы (не имеют заказов в таблице Sales.Orders). 
-- Вывести столбцы custid и companyname из Sales.Customers. 
-- Результирующий набор сравните с Lab Exercise1 - Task5 Result.txt
---------------------------------------------------------------------

SELECT c.custid, c.companyname
FROM "Sales"."Customers" AS c
LEFT OUTER JOIN "Sales"."Orders" AS o 
ON c.custid = o.custid 
WHERE o.custid IS NULL;