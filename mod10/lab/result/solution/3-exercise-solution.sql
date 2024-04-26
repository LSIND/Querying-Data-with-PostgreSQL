---------------------------------------------------------------------
-- LAB 10
--
-- Exercise 3 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий custid и contactname из таблицы Sales.Customers. 
-- Добавьте дополнительный вычисляемый столбец lastorderdate: дата последнего заказа из таблицы Sales.Orders конкретного заказчика.
--
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------

SELECT
	c.custid, c.contactname,
	(
		SELECT MAX(o.orderdate) 
		FROM sales.orders AS o 
		WHERE o.custid = c.custid
	) AS lastorderdate
FROM sales.customers AS c;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий информацию обо всех заказчиках, которые ничего не купили.
-- Используйте предикат EXISTS.
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
--
-- Почему не требовалась проверка на NULL?
---------------------------------------------------------------------
SELECT c.custid, c.contactname
FROM sales.customers AS c
WHERE NOT EXISTS 
      (SELECT * FROM sales.orders AS o 
	      WHERE o.custid = c.custid);

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, возвращающий custid и contactname из таблицы Sales.Customers.
-- Выведите только тех заказчиков, которые оформили заказ(ы) с 1 Апреля 2008, а цена продукта в этих заказах больше 100 у.е.
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt
---------------------------------------------------------------------

SELECT c.custid, c.contactname
FROM sales.customers AS c
WHERE 
	EXISTS (
		SELECT * 
		FROM sales.orders AS o 
		INNER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
		WHERE o.custid = c.custid
			AND d.unitprice > 100::money
			AND o.orderdate >= '20080401' 
		);

---------------------------------------------------------------------
-- Task 4 ***
-- 
-- Нарастающие итоги - итоги, накапливающие значения во времени.
-- Напишите SELECT-запрос, возвращающий следующую информацию по каждому году продаж:
--  Год продаж 
--  Общее количество продаж за год 
--  Нарастающий итог по продажам. Например, за первый год (2006) вернется общее количество продаж за год, за следующий год (2007) - сумма продаж за 2007 и предыдущий год и т.д.
-- В SELECT-запросе три вычисляемых столбца:
--  orderyear - год от даты заказа таблицы sales.orders
--  totalsales - общее количество продаж, цена * количество товаров из таблицы sales.orderdetails
--  runsales - нарастающий итог (корреляционный подзапрос) 
--
-- Результирующий набор сравните с Lab Exercise3 - Task4 Result.txt
---------------------------------------------------------------------

-- Решение через вложенную таблицу (SELECT FROM SELECT)
SELECT Y.orderyear, Y.totalsales,
	(
		SELECT SUM(d2.qty * d2.unitprice)
		FROM sales.orders AS o2
		INNER JOIN sales.orderdetails AS d2 
        ON d2.orderid = o2.orderid
		WHERE EXTRACT(YEAR FROM o2.orderdate) <= Y.orderyear
	) AS runsales
FROM (SELECT EXTRACT(YEAR FROM o.orderdate) as orderyear, 
	SUM(d.qty * d.unitprice) AS totalsales FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
GROUP BY EXTRACT(YEAR FROM o.orderdate)) AS Y
ORDER BY orderyear;


---------------------------------------------------------------------
-- Task 5
--
-- Удалить заказ, созданный в Exercise 2 - Task 3
---------------------------------------------------------------------
DELETE FROM sales.orders
WHERE custid is NULL;
