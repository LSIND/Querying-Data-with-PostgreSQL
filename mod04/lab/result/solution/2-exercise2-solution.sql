---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 2
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий информацию о сотруднике: empid, lastname, firstname, title и mgrid.
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------

SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid
FROM "HR"."Employees" AS e;

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос Task 1 и добавьте информацию о руководителе (lastname, firstname) с использованием self-join. 
-- Псевдонимы на столбцы mgrlastname и mgrfirstname соответственно
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
-- Почему строк меньше, чем в результате Task 1?
---------------------------------------------------------------------

SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid,
	m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM "HR"."Employees" AS e
INNER JOIN "HR"."Employees" AS m
ON e.mgrid = m.empid;

---------------------------------------------------------------------
-- Task 3
--
-- Напишите SELECT-запрос, выводящий custid и contactname таблицы Sales.Customers, а также orderid таблицы Sales.Orders. 
-- Запрос должен отобразить ВСЕ строки таблицы Sales.Customers.
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
--
-- Есть ли пустые значения в orderid? почему?
---------------------------------------------------------------------

SELECT c.custid, c.contactname, o.orderid
FROM "Sales"."Customers" AS c
LEFT OUTER JOIN "Sales"."Orders" AS o 
ON c.custid = o.custid
ORDER BY c.custid;