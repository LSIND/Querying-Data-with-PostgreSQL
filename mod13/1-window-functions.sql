-------------------------------------------------------
--
-- Модуль 13
-- Демонстрация 1
-- Обзор оконных функций
--
-------------------------------------------------------

-- 1. Создание представлений для демонстрации

-- Список всех продуктов: имя, категория, цена
DROP VIEW IF EXISTS production.categorizedproducts;
CREATE VIEW production.categorizedproducts
AS
    SELECT  C.categoryid AS CatID, C.categoryname AS CatName,
            P.productname AS ProdName,
            P.unitprice AS UnitPrice
    FROM   production.categories AS C
            INNER JOIN production.products AS P
			ON C.categoryid=P.categoryid;

SELECT * FROM production.categorizedproducts;

-- Количество продуктов каждой категории, проданных в конкретный год работы магазина
DROP VIEW IF EXISTS sales.categoryqtyyear;
CREATE VIEW sales.categoryqtyyear
AS
SELECT  c.categoryname AS Category,
        SUM(od.qty) AS Qty,
        EXTRACT (YEAR FROM o.orderdate) AS Orderyear
FROM   production.categories AS c
        INNER JOIN production.products AS p ON c.categoryid=p.categoryid
        INNER JOIN sales.orderdetails AS od ON p.productid=od.productid
        INNER JOIN sales.orders AS o ON od.orderid=o.orderid
GROUP BY c.categoryname, Orderyear;

SELECT * FROM sales.categoryqtyyear;


-- 1: Принцип работы оконной функции на примере функции COUNT()

-- COUNT как функция агрегирования
SELECT catid, catname, COUNT(prodname) AS productsQty -- всего у нас 77 различных продуктов
FROM production.categorizedproducts
GROUP BY catid, catname
ORDER BY catid;


SELECT catid, catname, prodname, unitprice, 
COUNT(prodname) OVER() AS productsQty                         -- window
FROM production.categorizedproducts
ORDER BY catid;

SELECT catid, catname, prodname, unitprice, 
COUNT(prodname) OVER(PARTITION BY catid) AS productsQty       -- partition
FROM production.categorizedproducts
ORDER BY catid;

SELECT catid, catname, prodname, unitprice, 
COUNT(prodname) OVER(PARTITION BY catid 
                     ORDER BY unitprice DESC) AS productsQty  -- frame
FROM production.categorizedproducts
ORDER BY catid;


-- 2: FRAME для нарастающего итога
-- Нарастающий итог по суммам продаж в категориях с упорядочиванием по годам
SELECT Category, Qty, Orderyear,
	SUM(Qty) OVER (
		PARTITION BY category
		ORDER BY orderyear
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) --  используется по умолчанию
                AS RunningQty
FROM sales.categoryqtyyear;


-- 3:  OVER с ORDER BY
-- RANK() по цене (ранжирование ВСЕХ продуктов по цене)
SELECT CatID, CatName, ProdName, UnitPrice,
	RANK() OVER(ORDER BY UnitPrice DESC) AS PriceRank
FROM production.categorizedproducts
ORDER BY PriceRank; 

-- ранжирование продуктов по цене в каждой категории
SELECT CatID, CatName, ProdName, UnitPrice,
	RANK() OVER(PARTITION BY CatID ORDER BY UnitPrice DESC) AS PriceRank
FROM production.categorizedproducts
ORDER BY CatID; 

-- 4: Фильтр на столбцы с оконными функциями
-- Вывести список продуктов, ранг которых 1 или 2
SELECT CatID, CatName, ProdName, UnitPrice,
	RANK() OVER(PARTITION BY CatID ORDER BY UnitPrice DESC) AS PriceRank
FROM production.categorizedproducts
WHERE RANK() OVER(PARTITION BY CatID ORDER BY UnitPrice DESC) <=2 -- ERROR!!!
ORDER BY CatID; 

-- Как решить проблему?



-- 1. derived table
SELECT CatID, CatName, ProdName, UnitPrice, Pricerank 
FROM 
( SELECT CatID, CatName, ProdName, UnitPrice,
	RANK() OVER(PARTITION BY CatID ORDER BY UnitPrice DESC) AS PriceRank
FROM production.categorizedproducts) as catprod
WHERE Pricerank <=2 
ORDER BY CatID; 

-- 2. CTE
WITH catprod AS 
(SELECT CatID, CatName, ProdName, UnitPrice,
	RANK() OVER(PARTITION BY CatID ORDER BY UnitPrice DESC) AS PriceRank
FROM production.categorizedproducts)
SELECT CatID, CatName, ProdName, UnitPrice, Pricerank 
FROM catprod 
WHERE Pricerank <=2 
ORDER BY CatID;



-- 5: Удаление объектов
DROP VIEW IF EXISTS production.categorizedproducts;
DROP VIEW IF EXISTS sales.categoryqtyyear;