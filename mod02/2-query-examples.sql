-------------------------------------------------------
--
-- Модуль 2
-- Демонстрация 2
-- Примеры запросов
--
-------------------------------------------------------


-- 1. Список продуктов дороже 50 у.е., купленных более 300 раз
SELECT	ProductID,UnitPrice,SUM(qty) as TotalOrdered
FROM sales.orderdetails
WHERE UnitPrice > 50
GROUP BY ProductID, UnitPrice
HAVING SUM(qty) > 300
ORDER BY TotalOrdered DESC;


-- 2. Все данные таблицы sales.orderdetails (*)
SELECT *
FROM sales.orderdetails;


-- 3. Список продуктов, проданных дороже 50 у.е. (из таблицы orderdetails - позиции в заказах)
SELECT * 
FROM sales.orderdetails
WHERE UnitPrice > 50
ORDER BY orderid;


-- 4. Пример ошибки (invalid SELECT)
-- Ошибка при использовании GROUP BY: column "orderdetails.orderid" must appear in the GROUP BY clause or be used in an aggregate function
SELECT *
FROM sales.orderdetails
WHERE UnitPrice > 50
GROUP BY ProductID, UnitPrice;

-- Исправление запроса 
-- Общее количество проданных товаров по определенной цене (дороже 50 у.е.) 
SELECT	ProductID
		,UnitPrice
		,SUM(qty) as TotalOrdered
FROM sales.orderdetails
WHERE UnitPrice > 50
GROUP BY ProductID, UnitPrice
ORDER BY TotalOrdered DESC;