---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 4
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий 10 заказчиков (custid), сумма покупок которых максимальна
-- Отфильтруйте результат, где общая сумма покупок по каждому заказчику больше  $100,000
-- Результирующий набор сравните с Lab Exercise4 - Task1 Result.txt
---------------------------------------------------------------------

SELECT o.custid, 
	SUM(d.qty * d.unitprice) AS totalsalesamount 
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d ON d.orderid = o.orderid
GROUP BY o.custid
HAVING SUM(d.qty * d.unitprice) > 100000::money
ORDER BY totalsalesamount DESC
LIMIT 10;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к таблицам Sales.Orders и Sales.OrderDetails, возвращающий общую сумму продаж каждого сотрудника (empid) по каждому заказу (orderid)
-- Рассчитайте итоговые суммы продаж только за 2008 год. 
-- Результирующий набор сравните с Lab Exercise4 - Task2 Result.txt
---------------------------------------------------------------------

SELECT
	o.orderid, 
	o.empid,
	SUM(d.qty * d.unitprice) as totalsalesamount
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d ON d.orderid = o.orderid
WHERE o.orderdate >= '20080101' AND o.orderdate < '20090101'
GROUP BY o.orderid, o.empid;

---------------------------------------------------------------------
-- Task 3
-- 
-- Измените запрос Task 2, найдите те строки, где суммы продаж больше $10,000.
-- Результирующий набор сравните с Lab Exercise4 - Task3 Result.txt
---------------------------------------------------------------------

SELECT
	o.orderid,
	o.empid,
	SUM(d.qty * d.unitprice) as totalsalesamount
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d ON d.orderid = o.orderid
WHERE o.orderdate >= '20080101' AND o.orderdate < '20090101'
GROUP BY o.orderid, o.empid
HAVING SUM(d.qty * d.unitprice) >= 10000::money;


---------------------------------------------------------------------
-- Task 4
-- 
-- Измените запрос Task 4, найдите те строки, где суммы продаж больше $10,000, но для сотрудника 3.
-- Результирующий набор сравните с Lab Exercise4 - Task4 Result.txt
---------------------------------------------------------------------

SELECT
	o.orderid,
	o.empid,
	SUM(d.qty * d.unitprice) as totalsalesamount
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d ON d.orderid = o.orderid
WHERE 
	o.orderdate >= '20080101' AND o.orderdate <= '20090101'
	AND o.empid = 3
GROUP BY o.orderid, o.empid
HAVING SUM(d.qty * d.unitprice) >= 10000::money;


---------------------------------------------------------------------
-- Task 5
-- 
-- Напишите SELECT-запрос, выводящий заказчиков, которые совершили более 25 заказов
-- Добавьте информацию о дате самого последнего заказа и общую сумму покупок
-- Выведите также custid и два вычисляемых столбца lastorderdate, основанный на столбце дата заказа (orderdate), 
-- и totalsalesamount как количество (qty) умноженное на цену (unitprice) из таблицы Sales.OrderDetails.
--
-- Результирующий набор сравните с Lab Exercise4 - Task5 Result.txt
---------------------------------------------------------------------

SELECT
	o.custid, 
	MAX(orderdate) AS lastorderdate, 
	SUM(d.qty * d.unitprice) AS totalsalesamount
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d ON d.orderid = o.orderid
GROUP BY o.custid 
HAVING COUNT(DISTINCT o.orderid) > 25;


---------------------------------------------------------------------
-- Task 6 *
-- 
-- Напишите SELECT-запрос, выводящий заказчиков, общую сумму покупок и столбец ordersAll, содержащий номера заказов через запятую (string_agg)
-- Общая сумма всех заказов должна быть меньше $2000
--
-- Результирующий набор сравните с Lab Exercise4 - Task6 Result.txt
---------------------------------------------------------------------

SELECT
	o.custid, 	
	SUM(d.qty * d.unitprice) AS totalsalesamount,
	string_agg(o.orderid::varchar, ', ') AS ordersAll
FROM "Sales"."Orders" AS o
INNER JOIN "Sales"."OrderDetails" AS d 
ON d.orderid = o.orderid
GROUP BY o.custid
HAVING SUM(d.qty * d.unitprice) < 2000::money
ORDER BY o.custid;


---------------------------------------------------------------------
-- Task 7 *
-- 
-- Напишите SELECT-запрос, выводящий всех заказчиков (custid, companyname), которые покупали продукты категории Meat/Poultry, 
-- но ни разу не покупали продукты категории Seafood.
--
-- Результирующий набор сравните с Lab Exercise4 - Task7 Result.txt
---------------------------------------------------------------------

SELECT C.custid, C.companyname
FROM "Sales"."Customers" as C
JOIN "Sales"."Orders" as O
ON C.custid = O.custid
JOIN "Sales"."OrderDetails" AS OD
ON OD.orderid = O.orderid
JOIN "Production"."Products" AS P
on P.productid = OD.productid
join "Production"."Categories" as CA
ON CA.categoryid = P.categoryid
WHERE CA.categoryname IN ('Meat/Poultry', 'Seafood')
GROUP BY C.custid, C.companyname
HAVING SUM(CASE 
WHEN CA.categoryname = 'Meat/Poultry' THEN 1 ELSE 0 END) >= 1 
AND 
SUM(CASE WHEN CA.categoryname = 'Seafood' THEN 1 ELSE 0 END) = 0;