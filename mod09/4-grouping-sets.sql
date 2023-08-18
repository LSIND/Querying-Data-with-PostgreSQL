-- 1: Представление для демонстраций

DROP VIEW IF EXISTS "Sales"."CategorySales";

CREATE VIEW "Sales"."CategorySales"
AS
SELECT  c.categoryname AS Category,
        o.empid AS Emp,
        o.custid AS Cust,
        od.qty AS Qty,
        EXTRACT(YEAR FROM o.orderdate) AS Orderyear
FROM    "Production"."Categories" AS c
        INNER JOIN "Production"."Products" AS p ON c.categoryid=p.categoryid
        INNER JOIN "Sales"."OrderDetails" AS od ON p.productid=od.productid
        INNER JOIN "Sales"."Orders" AS o ON od.orderid=o.orderid
WHERE c.categoryid IN (1,2,3) AND o.custid BETWEEN 1 AND 5; --limits results for slides

SELECT * FROM "Sales"."CategorySales";


-- 2: Запрос grouping sets
EXPLAIN
SELECT Category, Cust, SUM(Qty) AS TotalQty
FROM "Sales"."CategorySales"
GROUP BY 
GROUPING SETS((Category),(Cust),())
ORDER BY Category, Cust;

-- UNION ALL как замена grouping sets
EXPLAIN
SELECT Category, NULL AS Cust, SUM(Qty) AS TotalQty
FROM "Sales"."CategorySales"
GROUP BY category
UNION ALL 
SELECT  NULL, Cust, SUM(Qty) AS TotalQty
FROM "Sales"."CategorySales"
GROUP BY cust 
UNION ALL
SELECT NULL, NULL, SUM(Qty) AS TotalQty
FROM "Sales"."CategorySales";


-- 3: CUBE
SELECT Category, Cust, SUM(Qty) AS TotalQty
FROM "Sales"."CategorySales"
GROUP BY CUBE(Category,Cust)
ORDER BY Category, Cust;


-- 4: ROLLUP
SELECT Category, Cust, SUM(Qty) AS TotalQty
FROM "Sales"."CategorySales"
GROUP BY ROLLUP(Category,Cust)
ORDER BY Category, Cust;

-- "Чековая лента" за сутки
SELECT d.orderid,  o.orderdate, p.productname, p.unitprice, d.qty, SUM(p.unitprice*d.qty) as Total
FROM "Sales"."OrderDetails" as d
JOIN "Sales"."Orders" as o 
ON d.orderid = o.orderid
JOIN "Production"."Products" as p
ON p.productid = d.productid
WHERE o.orderdate >= '20060708' AND o.orderdate < '20060709'
GROUP BY ROLLUP ((d.orderid, o.orderdate),(p.productname,p.unitprice,d.qty));


-- 5:  Функция GROUPING 
SELECT	GROUPING(Category) AS grpCat, GROUPING(Cust) AS grpCust, Category, Cust, SUM(Qty) AS TotalQty
FROM "Sales"."CategorySales"
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
FROM "Sales"."OrderDetails" as d
JOIN "Sales"."Orders" as o 
ON d.orderid = o.orderid
JOIN "Production"."Products" as p
ON p.productid = d.productid
WHERE o.orderdate >= '20060708' AND o.orderdate < '20060711' -- период
GROUP BY ROLLUP ((d.orderid, o.orderdate),(p.productname,p.unitprice,d.qty));


-- 6: Удаление "Sales"."CategorySales";
DROP VIEW IF EXISTS "Sales"."CategorySales";