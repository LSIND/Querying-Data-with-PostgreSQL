-------------------------------------------------------
--
-- Модуль 12
-- Демонстрация 3
-- crosstab
--
-------------------------------------------------------

-- Есть запрос, возвращающий количество проданных продуктов по категориям и по годам:

SELECT  c.categoryname AS category,        
        EXTRACT(year FROM o.orderdate) AS orderyear,
        SUM(od.qty) AS Qty
FROM    production.categories AS c
        INNER JOIN production.products AS p ON c.categoryid=p.categoryid
        INNER JOIN sales.orderdetails AS od ON p.productid=od.productid
        INNER JOIN sales.orders AS o ON od.orderid=o.orderid
GROUP BY c.categoryname, EXTRACT(year FROM o.orderdate)
ORDER BY c.categoryname, EXTRACT(year FROM o.orderdate);


-- Требуется "перевернуть" результат, где столбцами стали бы: категория, 2021, 2022 и 2023 годы:
-- category	        2021	2022	2023
------------------------------------------
-- Beverages	    1842	3996	3694
-- Condiments	    962	    2895	1441
-- Confections	    1357	4137	2412
-- Dairy Products	2086	4374	2689
-- Grains/Cereals	549	    2636	1377
-- Meat/Poultry	    950	    2189	1060
-- Produce	        549	    1583	858
-- Seafood	        1286	3679	2716



-- 1. Установка расширения в БД, содержащего функцию crosstab
CREATE EXTENSION IF NOT EXISTS tablefunc;


-- 2. Использование функции crosstab (source_sql text, category_sql text) → setof record

SELECT *
FROM crosstab(
    $$ 
    -- 1 ИСХОДНЫЙ ЗАПРОС --
    SELECT  c.categoryname AS category,               -- основной столбец   
        EXTRACT(year FROM o.orderdate) AS orderyear,  -- годы распределятся вправо
        SUM(od.qty) AS Qty                            -- итоги
FROM    production.categories AS c
        INNER JOIN Production.Products AS p ON c.categoryid=p.categoryid
        INNER JOIN Sales.OrderDetails AS od ON p.productid=od.productid
        INNER JOIN Sales.Orders AS o ON od.orderid=o.orderid
GROUP BY c.categoryname, EXTRACT(year FROM o.orderdate)
ORDER BY c.categoryname, EXTRACT(year FROM o.orderdate) 
     -- ИСХОДНЫЙ ЗАПРОС --
    $$,
    $$ 
    -- 2 "Перевернутые значения для новых столбцов"
    SELECT DISTINCT EXTRACT(year FROM orderdate)
    FROM Sales.Orders
    ORDER BY EXTRACT(year FROM orderdate)
    --
    $$
) AS ct (
   category TEXT,  -- основной столбец   
   "2021" NUMERIC, -- значения, совпадающие с результатом запроса 2
   "2022" NUMERIC, 
   "2023" NUMERIC
);



-- Удаление расширения из БД
DROP EXTENSION tablefunc;

