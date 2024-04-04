---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 1 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий столбец productname таблицы production.products (p - псевдоним таблицы) 
-- и столбец categoryname таблицы production.categories (c - псевдоним таблицы) 
-- Использовать inner join (77 строк)
---------------------------------------------------------------------
SELECT 
	p.productname, c.categoryname
FROM production.products AS p
INNER JOIN production.categoies AS c 
ON p.categoryid = c.categoryid;

---------------------------------------------------------------------
-- Task 2
-- 
-- Выполните запрос. Почему ошибка?
---------------------------------------------------------------------

SELECT 
	custid, contactname, orderid
FROM sales.customers
INNER JOIN sales.orders
ON sales.customers.custid = sales.orders.custid;

-- column reference "custid" is ambiguous
-- СУБД не понимает из какой таблицы выбрать custid - 
-- такой столбец есть как в sales.customers, так и в sales.orders


---------------------------------------------------------------------
-- Task 3
-- 
-- Исправьте запрос Task 2. Используйте псевдонимы
-- 
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt (порядок результата может отличаться)
---------------------------------------------------------------------

SELECT 
	C.custid, C.contactname, O.orderid
FROM sales.customers AS C
INNER JOIN sales.orders AS O
ON C.custid = O.custid;

---------------------------------------------------------------------
-- Task 4
-- 
-- Измените запрос Task 3, включив дополнительные столбцы из таблицы sales.orderdetails: productid, qty, unitprice.
--
-- Результирующий набор сравните с Lab Exercise1 - Task4 Result.txt (порядок результата может отличаться)
---------------------------------------------------------------------

SELECT c.custid, c.contactname, o.orderid, d.productid, d.qty, d.unitprice
FROM sales.customers AS C
INNER JOIN sales.orders AS O
ON c.custid = o.custid
INNER JOIN sales.orderdetails AS d
ON d.orderid = o.orderid;

---------------------------------------------------------------------
-- Task 5
--
-- Выведите всех поставщиков production.suppliers, а также их товары, цены продуктов и название категории этих продуктов
-- Упорядочить (ORDER BY) по имени поставщика companyname
--
-- Результирующий набор сравните с Lab Exercise1 - Task5 Result.txt 
---------------------------------------------------------------------

SELECT S.companyname, P.productname, P.unitprice, C.categoryname
FROM production.products AS P
JOIN production.categories AS C
ON P.categoryid = C.categoryid
JOIN production.suppliers as S
ON S.supplierid = P.supplierid
ORDER BY S.companyname;

---------------------------------------------------------------------
-- Task 6
--
-- Выведите информацию о работе сотрудников:
---- У сотрудника указать его номер, имя и фамилию
---- Выведите все заказы (номер, дата оформления) и позиции в заказах (имя продукта, цена), оформленные каждым менеджером.
---- Упорядочить по номеру сотрудника empid (ORDER BY)
--
-- Результирующий набор сравните с Lab Exercise1 - Task6 Result.txt
---------------------------------------------------------------------

SELECT H.empid, H.firstname, H.lastname, O.orderid, O.orderdate, P.productname, P.unitprice
from production.products AS P
JOIN  sales.orderdetails AS D
ON P.productid = D.productid
JOIN sales.orders AS O
ON O.orderid = D.orderid
JOIN hr.employees as H
ON H.empid = O.empid
ORDER BY H.empid;