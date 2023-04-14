---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 1
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий столбец productname таблицы Production.Products (p - псевдоним таблицы) и столбец categoryname таблицы Production.Categories  (c - псевдоним таблицы) 
-- Использовать inner join (77 строк)
---------------------------------------------------------------------
SELECT 
	p.productname, c.categoryname
FROM "Production"."Products" AS p
INNER JOIN "Production"."Categories" AS c 
ON p.categoryid = c.categoryid;

---------------------------------------------------------------------
-- Task 2
-- 
-- Выполните запрос. Почему ошибка?
---------------------------------------------------------------------

SELECT 
	custid, contactname, orderid
FROM "Sales"."Customers"
INNER JOIN "Sales"."Orders"
ON "Sales"."Customers".custid = "Sales"."Orders".custid;


---------------------------------------------------------------------
-- Task 3
-- 
-- Исправьте запрос Task 2. Используйте псевдонимы
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

SELECT 
	C.custid, C.contactname, O.orderid
FROM "Sales"."Customers" AS C
INNER JOIN "Sales"."Orders" AS O
ON C.custid = O.custid;

---------------------------------------------------------------------
-- Task 4
-- 
-- Измените запрос Task 3, включив дополнительные столбцы из таблицы Sales.OrderDetails: productid, qty, unitprice.
-- Результирующий набор сравните с Lab Exercise1 - Task4 Result.txt
---------------------------------------------------------------------

SELECT c.custid, c.contactname, o.orderid, d.productid, d.qty, d.unitprice
FROM "Sales"."Customers" AS C
INNER JOIN "Sales"."Orders" AS O
ON c.custid = o.custid
INNER JOIN "Sales"."OrderDetails" AS d
ON d.orderid = o.orderid;

---------------------------------------------------------------------
-- Task 5
--
-- Выведите всех поставщиков Production.Suppliers, а также их продукты, цены и название категории
-- Упорядочить по имени поставщика companyname
-- Результирующий набор сравните с Lab Exercise1 - Task5 Result.txt
---------------------------------------------------------------------

SELECT S.companyname, P.productname, P.unitprice, C.categoryname
from "Production"."Products" AS P
JOIN "Production"."Categories" AS C
ON P.categoryid = C.categoryid
JOIN "Production"."Suppliers" as S
ON S.supplierid = P.supplierid
ORDER BY S.companyname;

---------------------------------------------------------------------
-- Task 6
--
-- Выведите все заказы (и позиции в них), оформленные каждым менеджером
-- Упорядочить по empid
-- Результирующий набор сравните с Lab Exercise1 - Task6 Result.txt
---------------------------------------------------------------------

SELECT H.empid, H.firstname, H.lastname, O.orderid, O.orderdate, P.productid, P.productname, P.unitprice
from "Production"."Products" AS P
JOIN  "Sales"."OrderDetails" AS D
ON P.productid = D.productid
JOIN "Sales"."Orders" AS O
ON O.orderid = D.orderid
JOIN "HR"."Employees" as H
ON H.empid = O.empid
ORDER BY H.empid;