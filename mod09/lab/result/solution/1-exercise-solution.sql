---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 1 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
--
-- Напишите SELECT-запрос, возвращающий заказчиков, которые что-то купили у сотрудника (empid) номер 5. 
-- Выведите custid из sales.orders и contactname из sales.customers. 
-- Сгруппировать по столбцам custid и contactname
--
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------

SELECT o.custid, c.contactname
FROM sales.orders AS o
INNER JOIN sales.customers AS c ON c.custid = o.custid
WHERE o.empid = 5
GROUP BY o.custid, c.contactname;

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос Task 1 и добавьте в SELECT столбец city из sales.customers. 
-- Почему ошибка?
-- Исправьте запрос
--
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

-- error 
-- column "c.city" must appear in the GROUP BY clause or be used in an aggregate function
SELECT o.custid, c.contactname, c.city
FROM sales.orders AS o
INNER JOIN sales.customers AS c ON c.custid = o.custid
WHERE o.empid = 5
GROUP BY o.custid, c.contactname;

-- исправленный 
-- Добавить столбец city в group by
SELECT o.custid, c.contactname, c.city
FROM sales.orders AS o
INNER JOIN sales.customers AS c ON c.custid = o.custid
WHERE o.empid = 5
GROUP BY o.custid, c.contactname, c.city;


---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, возвращающий номера заказчиков и годы, когда они что-то купили
-- Включите только заказы, оформленные сотрудником empid = 5
--
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

SELECT custid, EXTRACT(YEAR FROM orderdate) AS orderyear
FROM sales.orders
WHERE empid = 5
GROUP BY custid, EXTRACT (YEAR FROM orderdate)
ORDER BY custid, orderyear;

---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, возвращающий категории (categoryid и categoryname) из таблицы production.categories.
-- Включите только те категории продуктов, которые были проданы 15 января 2008 г.
--
-- Результирующий набор сравните с Lab Exercise1 - Task4 Result.txt
---------------------------------------------------------------------

SELECT c.categoryid, c.categoryname
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
INNER JOIN production.products AS p  ON p.productid = d.productid
INNER JOIN production.categories AS c  ON c.categoryid = p.categoryid
WHERE orderdate >= '20080115' AND orderdate < '20080116'
GROUP BY c.categoryid, c.categoryname;