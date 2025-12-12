---------------------------------------------------------------------
-- LAB 11
--
-- Exercise 3 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос аналогичный Exercise 2 - Task 1, но с использованием CTE. Имя CTE - productsbeverages 
-- Используйте inline-псевдонимы.
--
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------

WITH productsbeverages AS
(
	SELECT
		productid, productname, supplierid, unitprice, discontinued,
		CASE WHEN unitprice > 100 THEN 'high' ELSE 'normal' END AS pricetype
	FROM production.products
	WHERE categoryid = 1
)
SELECT productid, productname
FROM productsbeverages
WHERE pricetype = 'high';

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к sales.ordervalues и получите список всех заказчиков и общую сумму покупок каждого их них в 2023 году.
-- Определите CTE с именем c2023 с использованием внешних псевдонимов custid и salesamt2023.
--   Если заказчик ничего не купил в 2023 году, в столбце salesamt2023 должно стоять значение 0. 
-- Соедините CTE с таблицей sales.customers и получите custid, contactname из sales.customers и salesamt2023 из c2023 CTE.
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
---------------------------------------------------------------------

WITH c2023 (custid, salesamt2023) AS
(
	SELECT custid, SUM(val)
	FROM sales.ordervalues 
	WHERE EXTRACT(YEAR FROM orderdate) = 2023
	GROUP BY custid
)
SELECT
	c.custid, c.contactname, COALESCE(c2023.salesamt2023, 0) AS salesamt2023
FROM sales.customers AS c
LEFT OUTER JOIN c2023 ON c.custid = c2023.custid;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, выводящий custid и contactname из таблицы sales.customers. Также получите вычисляемые столбцы:
--  salesamt2023 - Общая сумма покупок за 2023 год (создайте CTE с именем c2023)
--  salesamt2022 - Общая сумма покупок за 2022 год (создайте CTE с именем c2022)
--  percentgrowth - процентный рост продаж 2023 года к 2022 (Если percentgrowth = NULL- отобразить 0). Упорядочить результат по этому столбцу
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt.
---------------------------------------------------------------------

WITH c2023 (custid, salesamt2023) AS
(
	SELECT custid, SUM(val)
	FROM sales.ordervalues
	WHERE EXTRACT(YEAR FROM orderdate) = 2023
	GROUP BY custid
),
c2022 (custid, salesamt2022) AS
(
	SELECT custid, SUM(val)
	FROM sales.ordervalues
	WHERE EXTRACT(YEAR FROM orderdate) = 2022
	GROUP BY custid
)
SELECT
	c.custid, c.contactname, 
	c2023.salesamt2023, 
	c2022.salesamt2022,
	ROUND(COALESCE((c2023.salesamt2023 - c2022.salesamt2022) / c2022.salesamt2022 * 100., 0),3) AS percentgrowth
FROM sales.customers AS c
LEFT OUTER JOIN c2023 ON c.custid = c2023.custid
LEFT OUTER JOIN c2022 ON c.custid = c2022.custid
ORDER BY percentgrowth DESC;



---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, выводящий всех заказчиков (custid, companyname), которые покупали продукты категории Meat/Poultry, 
-- но ни разу не покупали продукты категории Seafood.
--
-- Результирующий набор сравните с Lab Exercise3 - Task4 Result.txt
---------------------------------------------------------------------

WITH meat_customers AS (
    SELECT DISTINCT o.custid
    FROM sales.orderdetails od
    JOIN production.products p ON od.productid = p.productid
    JOIN production.categories c ON p.categoryid = c.categoryid
    JOIN sales.orders o ON od.orderid = o.orderid
    WHERE c.categoryname = 'Meat/Poultry'
),
seafood_customers AS (
    SELECT DISTINCT o.custid
    FROM sales.orderdetails od
    JOIN production.products p ON od.productid = p.productid
    JOIN production.categories c ON p.categoryid = c.categoryid
    JOIN sales.orders o ON od.orderid = o.orderid
    WHERE c.categoryname = 'Seafood'
)
SELECT DISTINCT c.custid, c.companyname
FROM sales.customers c
JOIN meat_customers mpc ON c.custid = mpc.custid
LEFT JOIN seafood_customers sc ON c.custid = sc.custid
WHERE sc.custid IS NULL;


---------------------------------------------------------------------
-- Task 5 * 
-- 
-- Определите рекурсивное CTE, выводящее значение факториала числа (n!).
--  определите начальное значение в CTE (1, 1)
--  определите формулу факториала числа для заданного значения
--
---------------------------------------------------------------------

WITH RECURSIVE factorial_cte(n, factorial) AS (
  SELECT 1, 1   -- initial values
  UNION ALL
  SELECT n + 1, (n + 1) * factorial
  FROM factorial_cte
  WHERE n < 6   -- условие (n = 6): n - 1
)
SELECT n, factorial
FROM factorial_cte
WHERE n = 6;    -- условие. 6! = 720

---------------------------------------------------------------------
-- Task 6 ** 
-- 
-- Есть следующий запрос: сумма продаж по дням за первые три месяца 2023 года
---- Обратите внимание, что в какие-то даты продаж вообще не было (между датами есть "дыры")
--  
--  Требуется вывести ВСЕ даты работы магазина за период: 
---- работаем без выходных
---- дата начала - 01 января 2023
---- дата окончания - 31 марта 2023
---- если в какой-то день продаж не было - в столбце sum_price вывести 0
--
-- Результирующий набор сравните с Lab Exercise3 - Task6 Result.txt.
---------------------------------------------------------------------

SELECT orderdate::date AS order_date, SUM(od.unitprice*od.qty) AS sum_price
       FROM sales.orders AS o
       JOIN sales.orderdetails AS od
       ON O.orderid = od.orderid
       WHERE orderdate >= '20230101' AND orderdate < '20230401'
       GROUP BY orderdate::date
       ORDER BY order_date;


-- Рекурсивное CTE
WITH RECURSIVE sale_dates AS
(
  SELECT orderdate::date AS order_date, SUM(od.unitprice*od.qty) AS sum_price
       FROM sales.orders AS o
       JOIN sales.orderdetails AS od
       ON O.orderid = od.orderid
	   WHERE orderdate >= '20230101' AND orderdate < '20230401'
       GROUP BY orderdate::date
  UNION ALL
  SELECT (order_date + '1 day'::interval)::date, 0.00
  FROM sale_dates
  WHERE (order_date + '1 day'::interval)::date < '20230401'
)
SELECT order_date, SUM(sum_price) AS sum_price FROM sale_dates
GROUP BY order_date
ORDER BY order_date;
