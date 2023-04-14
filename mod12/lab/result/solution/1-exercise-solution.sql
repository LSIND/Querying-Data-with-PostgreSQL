---------------------------------------------------------------------
-- LAB 12
--
-- Exercise 1
---------------------------------------------------------------------
---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий productid и productname из таблицы Production.Products.
-- Выведите только товары категории categoryid = 4.
-- Запомнить результирующее количество строк
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------
SELECT productid, productname
FROM "Production"."Products"
WHERE categoryid = 4;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, выводящий productid и productname из таблицы Production.Products.
-- Отфильтруйте результат, где суммы продаж превышают $50,000. Суммы продаж получить из Sales.OrderDetails как (qty * unitprice).
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

SELECT d.productid, p.productname
FROM "Sales"."OrderDetails" as d 
INNER JOIN "Production"."Products" as p 
ON p.productid = d.productid
GROUP BY d.productid, p.productname
HAVING SUM(d.qty * d.unitprice) > 50000::money;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос с оператором UNION
-- Получите объединение наборов Task 1 и task 2.
-- Результирующий набор сравните с Lab Exercise1 - Task3_1 Result.txt. Сколько строк получилось?
--
-- Скопируйте запрос и замените оператор UNION на UNION ALL. 
-- Результирующий набор сравните с Lab Exercise1 - Task3_1 Result.txt. Сколько строк получилось? Почему?
---------------------------------------------------------------------

--UNION
SELECT productid, productname
FROM "Production"."Products"
WHERE categoryid = 4
UNION
SELECT d.productid, p.productname
FROM "Sales"."OrderDetails" as d 
INNER JOIN "Production"."Products" as p 
ON p.productid = d.productid
GROUP BY d.productid, p.productname
HAVING SUM(d.qty * d.unitprice) > 50000::money;

--UNION ALL
SELECT productid, productname
FROM "Production"."Products"
WHERE categoryid = 4
UNION ALL
SELECT d.productid, p.productname
FROM "Sales"."OrderDetails" as d 
INNER JOIN "Production"."Products" as p 
ON p.productid = d.productid
GROUP BY d.productid, p.productname
HAVING SUM(d.qty * d.unitprice) > 50000::money;

---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, выводящий custid и contactname из таблицы Sales.Customers. 
-- Выведите 10 последних заказчиков на январь 2008 года, купивших на наимбольшую сумму 
-- С помощью UNION объедините этот с запрос с 10 последних заказчиков на февраль 2008 года, купивших на наимбольшую сумму
-- Можно использовать представление ​Sales.OrderValues. Упорядочить по custid
--
-- Результирующий набор сравните с Lab Exercise1 - Task4 Result.txt.
---------------------------------------------------------------------

SELECT c1.custid, c1.contactname
FROM
(
	SELECT o.custid, c.contactname
	FROM "Sales"."OrderValues" AS o
	INNER JOIN "Sales"."Customers" AS c
    ON c.custid = o.custid
	WHERE o.orderdate >= '20080101' AND o.orderdate < '20080201'
	GROUP BY o.custid, c.contactname
	ORDER BY SUM(o.val) DESC
    LIMIT 10
) AS c1
UNION
SELECT c2.custid, c2.contactname
FROM
(
	SELECT o.custid, c.contactname
	FROM "Sales"."OrderValues" AS o
	INNER JOIN "Sales"."Customers" AS c
    ON c.custid = o.custid
	WHERE o.orderdate >= '20080201' AND o.orderdate < '20080301'
	GROUP BY o.custid, c.contactname
	ORDER BY SUM(o.val) DESC
    LIMIT 10
) AS c2
ORDER BY custid;