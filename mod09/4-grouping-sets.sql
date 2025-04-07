-------------------------------------------------------
--
-- Модуль 9
-- Демонстрация 4
-- Группирующие наборы
--
-------------------------------------------------------

-- 1: Представление для демонстраций

DROP VIEW IF EXISTS sales.categorysales;

CREATE VIEW sales.categorysales
AS
SELECT  c.categoryname AS Category,
        o.empid AS Emp,
        o.custid AS Cust,
        od.qty AS Qty,
        EXTRACT(YEAR FROM o.orderdate) AS Orderyear
FROM    production.categories AS c
        INNER JOIN production.products AS p ON c.categoryid=p.categoryid
        INNER JOIN sales.orderdetails AS od ON p.productid=od.productid
        INNER JOIN sales.orders AS o ON od.orderid=o.orderid
WHERE c.categoryid IN (1,2,3) AND o.custid BETWEEN 1 AND 5; --limits results for slides

-- Позиции в заказах с учетом категории, оформившего сотрудника, покупателя и года
SELECT * FROM sales.categorysales;


-- 2: Запрос с grouping sets
-- Итоги по категориям, по заказчикам и общие итоги
EXPLAIN
SELECT Category, Cust, SUM(Qty) AS TotalQty
FROM sales.categorysales
GROUP BY 
GROUPING SETS((Category),(Cust),()) 
ORDER BY Category, Cust; -- 9 строк

-- UNION ALL как альтернатива grouping sets
EXPLAIN
SELECT Category, NULL AS Cust, SUM(Qty) AS TotalQty
FROM sales.categorysales
GROUP BY category
UNION ALL 
SELECT  NULL, Cust, SUM(Qty) AS TotalQty
FROM sales.categorysales
GROUP BY cust 
UNION ALL
SELECT NULL, NULL, SUM(Qty) AS TotalQty
FROM sales.categorysales;


-- 3: Запрос с CUBE
-- Итоги по категориям, по заказчикам, а также информация о конкретном заказчике в каждой конкретной категории и общие итоги
SELECT Category, Cust, SUM(Qty) AS TotalQty
FROM sales.categorysales
GROUP BY CUBE(Category,Cust) 
ORDER BY Category, Cust; -- 21 строка


-- 4: Запрос с ROLLUP
-- Итоги по категориям, а также информация о конкретном заказчике в каждой конкретной категории и общие итоги
SELECT Category, Cust, SUM(Qty) AS TotalQty
FROM sales.categorysales
GROUP BY ROLLUP(Category,Cust) -- важен порядок столбцов в Rollup
ORDER BY Category, Cust; -- 16 строк

------------------------------------------------------------
-- "Чековая лента" за сутки (за 8 июля 2021)
SELECT d.orderid,  o.orderdate, p.productname, p.unitprice, d.qty, SUM(p.unitprice*d.qty) as Total
FROM sales.orderdetails as d
JOIN sales.orders as o 
ON d.orderid = o.orderid
JOIN production.products as p
ON p.productid = d.productid
WHERE o.orderdate >= '20210708' AND o.orderdate < '20210709'
GROUP BY ROLLUP ((d.orderid, o.orderdate),(p.productname,p.unitprice,d.qty));


-- 5:  Функция GROUPING: Уровень вложенности
SELECT	GROUPING(Category) AS grpCat, GROUPING(Cust) AS grpCust, Category, Cust, SUM(Qty) AS TotalQty
FROM sales.categorysales
GROUP BY CUBE(Category,Cust)
ORDER BY Category, Cust;


-- "Чековая лента" за период с тегом Total и SubTotal
SELECT
CASE 
   WHEN GROUPING(p.productname, p.unitprice, d.qty)!=0 AND GROUPING(d.orderid, o.orderdate)!=0 THEN 'Total'
   WHEN GROUPING(p.productname, p.unitprice, d.qty)!=0 THEN 'SubTotal'
   ELSE '-'
END AS Tag,
  d.orderid,  o.orderdate, p.productname, p.unitprice, d.qty, SUM(p.unitprice*d.qty) as Total
FROM sales.orderdetails as d
JOIN sales.orders as o ON d.orderid = o.orderid
JOIN production.products as p ON p.productid = d.productid
WHERE o.orderdate >= '20210708' AND o.orderdate < '20210709' -- период
GROUP BY ROLLUP ((d.orderid, o.orderdate),(p.productname,p.unitprice,d.qty));


-- 6: Удаление представления sales.categorysales;
DROP VIEW IF EXISTS sales.categorysales;