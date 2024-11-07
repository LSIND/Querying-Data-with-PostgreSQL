---------------------------------------------------------------------
-- LAB 12
--
-- Exercise 1 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий productid и productname из таблицы production.products.
-- Выведите только товары категории categoryid = 4.
-- Запомните результирующее количество строк
--
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------
SELECT productid, productname
FROM production.products
WHERE categoryid = 4; -- 10 продуктов категории #4

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, выводящий productid и productname из таблицы production.products.
-- Выведите только те продукты, суммы продаж которых превышают 50,000 у.е. Суммы продаж получить из sales.orderdetails как (qty * unitprice).
--
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------

SELECT d.productid, p.productname
FROM sales.orderdetails as d 
INNER JOIN production.products as p 
ON p.productid = d.productid
GROUP BY d.productid, p.productname
HAVING SUM(d.qty * d.unitprice) > 50000.; -- 4 продукта

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос с оператором UNION
-- Получите объединение наборов Task 1 и Task 2.
-- Результирующий набор сравните с Lab Exercise1 - Task3_1 Result.txt. Сколько строк получилось?
--
-- Скопируйте запрос и замените оператор UNION на UNION ALL. 
-- Упорядочить результат по первому столбцу (productid).
--
-- Результирующий набор сравните с Lab Exercise1 - Task3_2 Result.txt. Сколько строк получилось? Почему?
---------------------------------------------------------------------

-- UNION: объединение как оператор множеств: выброс дубликатов
SELECT productid, productname
FROM production.products
WHERE categoryid = 4
UNION
SELECT d.productid, p.productname
FROM sales.orderdetails as d 
INNER JOIN production.products as p 
ON p.productid = d.productid
GROUP BY d.productid, p.productname
HAVING SUM(d.qty * d.unitprice) > 50000.
ORDER BY productid;

-- UNION ALL: `склеивание наборов`: 10 строк первого + 4 строки второго = 14 итоговых строк
SELECT productid, productname
FROM production.products
WHERE categoryid = 4
UNION ALL
SELECT d.productid, p.productname
FROM sales.orderdetails as d 
INNER JOIN production.products as p 
ON p.productid = d.productid
GROUP BY d.productid, p.productname
HAVING SUM(d.qty * d.unitprice) > 50000.
ORDER BY 1;

---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, выводящий custid и contactname из таблицы sales.customers. 
-- Выведите 10 заказчиков на январь 2008 года, купивших на наибольшую сумму 
-- С помощью UNION объедините этот с запрос с 10 заказчиками на февраль 2008 года, купивших на наибольшую сумму
-- Можно использовать представление ​sales.orderValues. Упорядочить по custid.
--
-- Результирующий набор сравните с Lab Exercise1 - Task4 Result.txt.
---------------------------------------------------------------------

SELECT c1.custid, c1.contactname
FROM
(
	SELECT o.custid, c.contactname
	FROM sales.orderValues AS o
	INNER JOIN sales.customers AS c
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
	FROM sales.orderValues AS o
	INNER JOIN sales.customers AS c
    ON c.custid = o.custid
	WHERE o.orderdate >= '20080201' AND o.orderdate < '20080301'
	GROUP BY o.custid, c.contactname
	ORDER BY SUM(o.val) DESC
    LIMIT 10
) AS c2
ORDER BY custid;