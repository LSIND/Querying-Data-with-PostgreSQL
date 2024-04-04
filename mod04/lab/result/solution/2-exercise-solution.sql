---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 2 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий информацию о сотруднике: empid, lastname, firstname, title и mgrid.
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------

SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid
FROM hr.employees AS e;

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос Task 1 и добавьте информацию о руководителе (lastname, firstname) с использованием self-join. 
-- Псевдонимы на столбцы mgrlastname и mgrfirstname соответственно.
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
-- Почему строк меньше, чем в результате Task 1?
---------------------------------------------------------------------

SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid,
	m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM hr.employees AS e
INNER JOIN hr.employees AS m
ON e.mgrid = m.empid;

---------------------------------------------------------------------
-- Task 3
--
-- Напишите SELECT-запрос, выводящий custid и contactname таблицы sales.customers, а также orderid таблицы sales.orders. 
-- Запрос должен отобразить ВСЕ строки таблицы sales.customers.
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
--
-- Есть ли пустые значения в orderid? почему?
---------------------------------------------------------------------

SELECT c.custid, c.contactname, o.orderid
FROM sales.customers AS c
LEFT OUTER JOIN sales.orders AS o 
ON c.custid = o.custid
ORDER BY c.custid;