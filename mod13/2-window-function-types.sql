
-- 1. Создание представлений для демонстрации

DROP VIEW IF EXISTS "Production"."CategorizedProducts";

CREATE VIEW "Production"."CategorizedProducts"
AS
    SELECT  C.categoryid AS CatID,
			C.categoryname AS CatName,
            P.productname AS ProdName,
            P.unitprice AS UnitPrice
    FROM    "Production"."Categories" AS C
            INNER JOIN "Production"."Products" AS P
			ON C.categoryid=P.categoryid;

DROP VIEW IF EXISTS "Sales"."CategoryQtyYear";
CREATE VIEW "Sales"."CategoryQtyYear"
AS
SELECT  c.categoryname AS Category,
        SUM(od.qty) AS Qty,
        EXTRACT (YEAR FROM o.orderdate) AS Orderyear
FROM    "Production"."Categories" AS c
        INNER JOIN "Production"."Products" AS p ON c.categoryid=p.categoryid
        INNER JOIN "Sales"."OrderDetails" AS od ON p.productid=od.productid
        INNER JOIN "Sales"."Orders" AS o ON od.orderid=o.orderid
GROUP BY c.categoryname, Orderyear;


DROP VIEW IF EXISTS "Sales"."OrdersByEmployeeYear";

CREATE VIEW "Sales"."OrdersByEmployeeYear"
AS
SELECT emp.empid AS employee, EXTRACT(YEAR FROM ord.orderdate) AS orderyear, SUM(od.qty * od.unitprice) AS totalsales
FROM "HR"."Employees" AS emp
	JOIN "Sales"."Orders" AS ord ON emp.empid = ord.empid
	JOIN "Sales"."OrderDetails" AS od ON ord.orderid = od.orderid
GROUP BY emp.empid, orderyear;


SELECT * FROM "Production"."CategorizedProducts";
SELECT * FROM "Sales"."CategoryQtyYear";
SELECT * FROM "Sales"."OrdersByEmployeeYear";


-- 2: Window Aggregate Functions

-- Сумма по partition (Custid)
SELECT  custid,
        ordermonth,
        qty,
        SUM(qty) OVER ( PARTITION BY custid ) AS totalpercust
FROM  "Sales"."CustOrders" ;

-- Сумма, среднее и общее количество по partition (custid)
SELECT CatID, CatName, ProdName, UnitPrice,
	SUM(UnitPrice) OVER(PARTITION BY CatID) AS Total,
	AVG(UnitPrice::numeric) OVER(PARTITION BY CatID) AS Average,
	COUNT(UnitPrice) OVER(PARTITION BY CatID) AS ProdsPerCat
FROM "Production"."CategorizedProducts"
ORDER BY CatID; 


-- 3: Функции ранжирования
-- RANK и DENSE_RANK
SELECT CatID, CatName, ProdName, UnitPrice,
	RANK() OVER(PARTITION BY CatID ORDER BY UnitPrice DESC) AS PriceRank,
	DENSE_RANK() OVER(PARTITION BY CatID ORDER BY UnitPrice DESC) AS DensePriceRank
FROM "Production"."CategorizedProducts"
ORDER BY CatID; 

-- Row_Number
SELECT CatID, CatName, ProdName, UnitPrice,
	ROW_NUMBER() OVER(PARTITION BY CatID ORDER BY UnitPrice DESC) AS RowNumber
FROM "Production"."CategorizedProducts"
ORDER BY CatID; 

-- NTILE(N) 
SELECT CatID, CatName, ProdName, UnitPrice,
	NTILE(7) OVER(PARTITION BY CatID ORDER BY UnitPrice DESC) AS NT
FROM "Production"."CategorizedProducts"
ORDER BY CatID, NT; 

-- NTH_VALUE(column, N) - возвращает второй по дороговизне продукт в данной категории
SELECT CatID, CatName, ProdName, UnitPrice,
	NTH_VALUE(ProdName,2) OVER(PARTITION BY CatID ORDER BY UnitPrice DESC RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING) AS NT
FROM "Production"."CategorizedProducts"
ORDER BY CatID, UnitPrice DESC; 


-- 4: Offset Functions
-- LAG для сравнения продаж сотрудника в текущем году с предыдущим годом

SELECT employee, orderyear, totalsales AS currentsales,
      LAG(totalsales, 1,0::money) OVER (PARTITION BY employee ORDER BY orderyear) AS previousyearsales
      FROM "Sales"."OrdersByEmployeeYear"
ORDER BY employee, orderyear;


--FIRST_VALUE -первое значение в данной категории
-- сравниваем общую сумму продаж с самым первым годом продаж сотрудника
SELECT employee
      ,orderyear
      ,totalsales AS currentsales,     
      (totalsales - FIRST_VALUE(totalsales) OVER (PARTITION BY employee ORDER BY orderyear)) AS salesdiffsincefirstyear
  FROM "Sales"."OrdersByEmployeeYear"
ORDER BY employee, orderyear;


-- *** string_agg
SELECT  custid,
        ordermonth,
        qty,
        string_agg(qty::varchar, ', ') OVER ( PARTITION BY custid ORDER BY ordermonth ) AS totalpercust
FROM  "Sales"."CustOrders" ;


-- 5. Удаление данных
DROP VIEW IF EXISTS "Production"."CategorizedProducts";
DROP VIEW IF EXISTS "Sales"."OrdersByEmployeeYear";
DROP VIEW IF EXISTS "Sales"."OrdersByEmployeeYear";