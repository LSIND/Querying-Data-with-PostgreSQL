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


SELECT * FROM "Production"."CategorizedProducts";
SELECT * FROM "Sales"."CategoryQtyYear";

-- 2:  OVER с ORDER BY
-- RANK() по цене
SELECT CatID, CatName, ProdName, UnitPrice,
	RANK() OVER(ORDER BY UnitPrice DESC) AS PriceRank
FROM "Production"."CategorizedProducts"
ORDER BY PriceRank; 

-- 3. OVER с ORDER BY и PRTITION BY Категории
SELECT CatID, CatName, ProdName, UnitPrice,
	RANK() OVER(PARTITION BY CatID ORDER BY UnitPrice DESC) AS PriceRank
FROM "Production"."CategorizedProducts"
ORDER BY CatID; 

-- 4: FRAME для нарастающего итога
-- Нарастающий итог по суммам продаж в категориях с упорядочиванием по годам
SELECT Category, Qty, Orderyear,
	SUM(Qty) OVER (
		PARTITION BY category
		ORDER BY orderyear
		ROWS BETWEEN UNBOUNDED PRECEDING
		AND CURRENT ROW) AS RunningQty
FROM "Sales"."CategoryQtyYear";

-- Нарастающий итог по суммам продаж по годам с упорядочиванием по категориям
SELECT Category, Qty, Orderyear,
	SUM(Qty) OVER (
		PARTITION BY orderyear
		ORDER BY Category
		ROWS BETWEEN UNBOUNDED PRECEDING
		AND CURRENT ROW) AS RunningQty
FROM "Sales"."CategoryQtyYear";

-- По категориям и по годам
SELECT Category, Qty, Orderyear,
	SUM(Qty) OVER (PARTITION BY orderyear ORDER BY Category	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotalByYear,
	SUM(Qty) OVER (PARTITION BY Category ORDER BY OrderYear	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotalByCategory
FROM "Sales"."CategoryQtyYear"
ORDER BY Orderyear, Category;

-- 5: Удаление объектов
DROP VIEW IF EXISTS "Production"."CategorizedProducts";
DROP VIEW IF EXISTS "Sales"."CategoryQtyYear";