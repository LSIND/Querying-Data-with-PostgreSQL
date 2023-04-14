---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 1
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
--
-- Напишите SELECT-запрос, возвращающий группы заказчиков, которые что-то купили у сотрудника (empid) номер 5. Выведите custid из Sales.Orders table и contactname из Sales.Customers. 
-- Сгруппировать по столбцам custid и contactname
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------

SELECT o.custid, c.contactname
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."Customers" AS c
ON c.custid = o.custid
WHERE o.empid = 5
GROUP BY o.custid, c.contactname;

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос Task 1 и добавьте в SELECT столбец city из Sales.Customers. 
-- Почему ошибка?
-- Исправьте запрос
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

-- error
SELECT o.custid, c.contactname, c.city
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."Customers" AS c
ON c.custid = o.custid
WHERE o.empid = 5
GROUP BY o.custid, c.contactname;

-- исправленный
SELECT o.custid, c.contactname, c.city
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."Customers" AS c
ON c.custid = o.custid
WHERE o.empid = 5
GROUP BY o.custid, c.contactname, c.city;


---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, возвращающий группы по custid и вычисляемому столбцу orderyear (год от даты orderdate из Sales.Orders)
-- Включите только заказы, оформленные сотрудником empid = 5
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

SELECT custid, EXTRACT (YEAR FROM orderdate)::int AS orderyear
FROM "Sales"."Orders"
WHERE empid = 5
GROUP BY custid, EXTRACT (YEAR FROM orderdate)
ORDER BY custid, orderyear;

---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, возвращающий группы по categoryname из таблицы Production.Categories. 
-- Включите только те категории продуктов, продукты которых были оформлены в 2008 году.
-- Результирующий набор сравните с Lab Exercise1 - Task4 Result.txt
---------------------------------------------------------------------

SELECT c.categoryid, c.categoryname
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d
ON d.orderid = o.orderid
INNER JOIN "Production"."Products" AS p 
ON p.productid = d.productid
INNER JOIN "Production"."Categories" AS c 
ON c.categoryid = p.categoryid
WHERE orderdate >= '20080101' AND orderdate < '20090101'
GROUP BY c.categoryid, c.categoryname;