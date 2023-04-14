-- 2. Примеры запросов

-- 1: Запрос
-- 
SELECT	ProductID
		,UnitPrice
		,SUM(qty) as TotalOrdered
FROM "Sales"."OrderDetails"
WHERE UnitPrice > 50::money
GROUP BY ProductID, UnitPrice
HAVING SUM(qty) > 19
ORDER BY TotalOrdered DESC;

-- 2: Querying a table	 
-- Все данные из таблицы Sales"."OrderDetails"
SELECT *
FROM "Sales"."OrderDetails";

-- 3: Запрос
-- Все позиции в заказах, цена которых больше 50
SELECT * 
FROM "Sales"."OrderDetails"
WHERE UnitPrice > 50::money;

-- 4: invalid SELECT 
-- Ошибка при использовании GROUP BY
SELECT *
FROM "Sales"."OrderDetails"
WHERE UnitPrice > 50::money
GROUP BY ProductID, UnitPrice;

-- Fix
SELECT	ProductID
		,UnitPrice
		,SUM(qty) as TotalOrdered
FROM "Sales"."OrderDetails"
WHERE UnitPrice > 50::money
GROUP BY ProductID, UnitPrice
ORDER BY TotalOrdered DESC;


-- 5: Запрос
-- HAVING - фильтр данных для групп 
SELECT	ProductID
		,UnitPrice
		,SUM(qty) as TotalOrdered
FROM "Sales"."OrderDetails"
WHERE UnitPrice > 50::money
GROUP BY ProductID, UnitPrice
HAVING SUM(qty) > 300;

-- 6: Запрос
-- Упорядочивание данных с ORDER BY
SELECT	ProductID
		,UnitPrice
		,SUM(qty) as TotalOrdered
FROM "Sales"."OrderDetails"
WHERE UnitPrice > 50::money
GROUP BY ProductID, UnitPrice
HAVING SUM(qty) > 300
ORDER BY TotalOrdered DESC;