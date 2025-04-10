---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 4 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий 10 заказчиков (custid) с максимальной общей суммой покупок за все время работы магазина.
-- Отфильтруйте результат, где общая сумма покупок каждого заказчика больше 100,000 у.е.
--
-- Результирующий набор сравните с Lab Exercise4 - Task1 Result.txt
---------------------------------------------------------------------

SELECT o.custid, 
	SUM(d.qty * d.unitprice) AS totalsalesamount 
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
GROUP BY o.custid
HAVING SUM(d.qty * d.unitprice) > 100000.
ORDER BY totalsalesamount DESC
LIMIT 10;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к таблицам sales.orders и sales.orderdetails, возвращающий номер заказа, общую сумму этого заказа и номер сотрудника (empid), оформившего заказ
-- Рассчитайте итоговые суммы продаж только за 2023 год. 
--
-- Результирующий набор сравните с Lab Exercise4 - Task2 Result.txt
---------------------------------------------------------------------

SELECT
	o.orderid, 
	o.empid,
	SUM(d.qty * d.unitprice) as totalsalesamount
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
WHERE o.orderdate >= '20230101' AND o.orderdate < '20240101'
GROUP BY o.orderid, o.empid;

---------------------------------------------------------------------
-- Task 3
-- 
-- Измените запрос Task 2: найдите те строки, где суммы продаж больше 10,000 у.е.
-- Упорядочить по номеру сотрудника.
--
-- Результирующий набор сравните с Lab Exercise4 - Task3 Result.txt
---------------------------------------------------------------------

SELECT
	o.orderid,
	o.empid,
	SUM(d.qty * d.unitprice) as totalsalesamount
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
WHERE o.orderdate >= '20230101' AND o.orderdate < '20240101'
GROUP BY o.orderid, o.empid
HAVING SUM(d.qty * d.unitprice) >= 10000.
ORDER BY o.empid;


---------------------------------------------------------------------
-- Task 4
-- 
-- Измените запрос Task 3 так, чтобы вывести только строки по сотруднику номер 3.
--
-- Результирующий набор сравните с Lab Exercise4 - Task4 Result.txt
---------------------------------------------------------------------

SELECT
	o.orderid,
	o.empid,
	SUM(d.qty * d.unitprice) as totalsalesamount
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
WHERE 
	o.orderdate >= '20230101' AND o.orderdate <= '20240101'
	AND o.empid = 3
GROUP BY o.orderid, o.empid
HAVING SUM(d.qty * d.unitprice) >= 10000.;


---------------------------------------------------------------------
-- Task 5
-- 
-- Напишите SELECT-запрос, выводящий заказчиков, которые совершили более 25 заказов
-- Добавьте информацию о дате самого последнего заказа и общую сумму покупок
--
-- Результирующий набор сравните с Lab Exercise4 - Task5 Result.txt
---------------------------------------------------------------------

SELECT
	o.custid, 
	MAX(orderdate) AS lastorderdate, 
	SUM(d.qty * d.unitprice) AS totalsalesamount
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
GROUP BY o.custid 
HAVING COUNT(DISTINCT o.orderid) > 25;


---------------------------------------------------------------------
-- Task 6 *
-- 
-- Напишите SELECT-запрос, выводящий заказчиков, общую сумму покупок и столбец ordersall, содержащий номера заказов через запятую (string_agg)
-- Общая сумма всех заказов должна быть меньше 2000 у.е.
-- Упорядочить по номеру заказчика.
--
-- Результирующий набор сравните с Lab Exercise4 - Task6 Result.txt
---------------------------------------------------------------------

SELECT
	o.custid, 	
	SUM(d.qty * d.unitprice) AS totalsalesamount,
	string_agg(DISTINCT o.orderid::varchar, ', ') AS ordersall
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
GROUP BY o.custid
HAVING SUM(d.qty * d.unitprice) < 2000.
ORDER BY o.custid;