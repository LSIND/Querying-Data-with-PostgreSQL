-------------------------------------------------------
--
-- Модуль 2
-- Демонстрация 2
-- Примеры запросов
--
-------------------------------------------------------


-- 1. Список продуктов дороже 50 руб, купленных более 300 раз
SELECT	ProductID,UnitPrice,SUM(qty) as TotalOrdered
FROM sales.orderdetails
WHERE UnitPrice > 50::money
GROUP BY ProductID, UnitPrice
HAVING SUM(qty) > 300
ORDER BY TotalOrdered DESC;


-- 2. Все данные из таблицы sales.orderdetails (*)
SELECT *
FROM sales.orderdetails;


-- 3. Список продуктов дороже 50 руб в виде строк в заказах
SELECT * 
FROM sales.orderdetails
WHERE UnitPrice > 50::money
ORDER BY orderid;


-- 4. Пример ошибки (invalid SELECT)
-- Ошибка при использовании GROUP BY: column "orderdetails.orderid" must appear in the GROUP BY clause or be used in an aggregate function
SELECT *
FROM sales.orderdetails
WHERE UnitPrice > 50::money
GROUP BY ProductID, UnitPrice;

-- Исправление запроса
SELECT	ProductID
		,UnitPrice
		,SUM(qty) as TotalOrdered
FROM sales.orderdetails
WHERE UnitPrice > 50::money
GROUP BY ProductID, UnitPrice
ORDER BY TotalOrdered DESC;