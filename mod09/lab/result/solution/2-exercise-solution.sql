---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 2
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий номер заказа (orderid) и общую сумму заказа из Sales.Orders. (умножить qty на unitprice из Sales.OrderDetails)
-- Использовать псевдоним salesmount на вычисляемый столбец. Отсортировать результат по общей сумме заказов по убыванию.
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------
SELECT o.orderid, o.orderdate, SUM(d.qty * d.unitprice) AS salesamount
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d
ON d.orderid = o.orderid
GROUP BY o.orderid, o.orderdate
ORDER BY salesamount DESC;

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопировать запрос из Task 1. Включить количество позиций в заказе и среднюю цену заказа
-- Использовать псевдонимы nooforderlines и avgsalesamountperorderline соответственно
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt. 
---------------------------------------------------------------------
EXPLAIN
SELECT
	o.orderid, o.orderdate, 
	SUM(d.qty * d.unitprice) AS salesamount, 
	COUNT(*) AS noofoderlines, 
	AVG(d.qty * d.unitprice::numeric)::money AS avgsalesamountperorderline
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d
ON d.orderid = o.orderid
GROUP BY o.orderid, o.orderdate
ORDER BY salesamount DESC;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, возвращающий общее количество продаж (qty * unitprice) по месяцам.
-- Вычисляемый столбец yearmonthno (YYYY-MM) по столбцу orderdate в таблице Sales.Orders table и общее количество продаж по месяцам saleamountpermonth
-- Упорядочить по yearmonthno
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt. 
---------------------------------------------------------------------

SELECT EXTRACT (YEAR FROM orderdate)  || '-' || EXTRACT (MONTH FROM orderdate) AS yearmonthno, 
	SUM(d.qty * d.unitprice) AS saleamountpermonth
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d 
ON d.orderid = o.orderid
GROUP BY EXTRACT (YEAR FROM orderdate), EXTRACT (MONTH FROM orderdate)
ORDER BY yearmonthno;

SELECT to_char(orderdate, 'YYYY-MM') AS yearmonthno,
	SUM(d.qty * d.unitprice) AS saleamountpermonth
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d 
ON d.orderid = o.orderid
GROUP BY to_char(orderdate, 'YYYY-MM')
ORDER BY yearmonthno;


---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, возвращающий всех заказчиков (91) и их общую сумму покупок, максимальную сумму заказа и количество позиций в заказе
--
-- Включить custid и contactname из Sales.Customers table и четыре вычисляемых столбца:
--  totalsalesamount - общая сумма покупок
--  maxsalesamountperorderline - максимальная сумма заказа
--  numberofrows - общее количество строк
--  numberoforderlines - общее количество заказов
--
-- Упорядочить по столбцу totalsalesamount.
-- Результирующий набор сравните с Lab Exercise2 - Task4 Result.txt. 
-- custid 22 и 57 содержит NULL в SUM и MAX. Что содержится в столбцах COUNT?
---------------------------------------------------------------------
SELECT 
	c.custid, c.contactname, 
	SUM(d.qty * d.unitprice) AS totalsalesamount,
	MAX(d.qty * d.unitprice) AS maxsalesamountperorderline, 
	COUNT(*) AS numberofrows,
	COUNT(o.orderid) AS numberoforderlines
FROM "Sales"."Customers" AS c
LEFT OUTER JOIN "Sales"."Orders" AS o 
ON o.custid = c.custid
LEFT OUTER JOIN "Sales"."OrderDetails" AS d ON
d.orderid = o.orderid
GROUP BY c.custid, c.contactname
ORDER BY totalsalesamount;