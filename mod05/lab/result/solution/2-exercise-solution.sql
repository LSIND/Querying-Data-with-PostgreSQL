---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 2 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий столбцы custid и contactname из таблицы sales.customers и столбцы orderid и orderdate из таблицы sales.orders. 
-- (список заказчиков (номер, имя) и их заказы (номер заказа, дата заказа))
-- Отфильтруйте результат, получив только заказы, совершенные после April, 1 2008 включительно (столбец orderdate). 
-- Отсортируйте результат по дате заказа orderdate по убыванию и по номеру заказчика custid по возрастанию.
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------

SELECT c.custid, c.contactname, o.orderid, o.orderdate
FROM sales.customers AS c
INNER JOIN sales.orders AS o 
ON c.custid = o.custid 
WHERE o.orderdate >= '20080401'
ORDER BY o.orderdate DESC, c.custid ASC;

---------------------------------------------------------------------
-- Task 2
-- 
-- Выполните запрос. Почему ошибка?
-- Перепишите запрос.
-- Условие WHERE не использует псевдонимы из-за порядка выполнения SELECT-запроса.
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt
---------------------------------------------------------------------

SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM hr.employees AS e
INNER JOIN hr.employees AS m 
ON e.mgrid = m.empid
WHERE mgrlastname = 'Buck';

-- Исправленный
SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM hr.employees AS e
INNER JOIN hr.employees AS m 
ON e.mgrid = m.empid
WHERE m.lastname = 'Buck';

---------------------------------------------------------------------
-- Task 3a
-- 
-- Скопируйте исправленный запрос Task 2 и удалите условие WHERE
-- Результирующий набор отсортируйте по имени руководителя - используйте исходное имя столбца
---------------------------------------------------------------------

SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM hr.employees AS e
INNER JOIN hr.employees AS m 
ON e.mgrid = m.empid
ORDER BY m.firstname;

---------------------------------------------------------------------
-- Task 3b

-- Упорядочить результирующий набор, полученный в Task3 по имени руководителя - используйте псевдоним
-- Что получилось?
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
---------------------------------------------------------------------

SELECT e.empid, e.lastname, e.firstname, e.title, e.mgrid, m.lastname AS mgrlastname, m.firstname AS mgrfirstname
FROM hr.employees AS e
INNER JOIN hr.employees AS m 
ON e.mgrid = m.empid
ORDER BY mgrfirstname;