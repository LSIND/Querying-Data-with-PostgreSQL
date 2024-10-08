-------------------------------------------------------
--
-- Модуль 9
-- Демонстрация 3
-- HAVING
--
-------------------------------------------------------


-- Количество заказов каждого заказчика
SELECT custid, COUNT(*) AS Total_Orders
FROM sales.orders
GROUP BY custid
ORDER BY Total_Orders DESC;

-- Заказчики, совершившие менее 2 покупок
SELECT custid, COUNT(*) AS Total_Orders
FROM sales.orders
GROUP BY custid
HAVING COUNT(*) <= 2;

-- HAVING не работает с псевдонимами столбцов
SELECT custid, COUNT(*) AS Total_Orders
FROM sales.orders
GROUP BY custid
HAVING Total_Orders <= 2;

-- Продукты, которые купили менее 10 раз
SELECT p.ProductID, COUNT(*) AS cnt
FROM production.products AS p
JOIN sales.orderdetails AS od
ON p.ProductID = od.Productid
GROUP BY p.ProductID
HAVING COUNT(*) < 10
ORDER BY cnt DESC;

---------------------------------------------
-- Заказчики и сколько заказов они совершили
-- 89 rows 
SELECT c.custid, COUNT(*) AS No_Of_Orders
FROM sales.customers AS c
JOIN sales.orders AS o ON c.custid = o.custid
GROUP BY c.custid
ORDER BY No_Of_Orders DESC;

-- HAVING: Заказчики, совершившие более 25 заказов
SELECT c.custid, COUNT(*) AS No_Of_Orders
FROM sales.customers  AS c
JOIN sales.orders AS o ON c.custid = o.custid
GROUP BY c.custid
HAVING COUNT(*) > 25
ORDER BY No_Of_Orders DESC;

-- HAVING: продукты, которые редко покупали (встречаются во всех заказах менее 10 раз)
SELECT p.productid, COUNT(*) AS cnt
FROM production.products AS p
JOIN sales.orderdetails AS od ON p.productid = od.productid
GROUP BY p.productid
HAVING COUNT(*) < 10
ORDER BY cnt DESC;

---------------------------------------------
-- Сравнение WHERE и HAVING

-- Заказчики и сколько заказов они совершили
SELECT c.custid, COUNT(*) AS No_Of_Orders
FROM sales.customers AS c
JOIN sales.orders AS o ON c.custid = o.custid
GROUP BY c.custid
ORDER BY c.custid;

-- Требуется вывести только заказчиков с 10 по 20 (custid) и кол-во их заказов.
-- Какой запрос будет наиболее оптимальным?

SELECT c.custid, COUNT(*) AS No_Of_Orders
FROM sales.customers AS c
JOIN sales.orders AS o ON c.custid = o.custid
WHERE c.custid BETWEEN 10 AND 20    -- условие
GROUP BY c.custid
ORDER BY c.custid;

SELECT c.custid, COUNT(*) AS No_Of_Orders
FROM sales.customers AS c
JOIN sales.orders AS o ON c.custid = o.custid
GROUP BY c.custid
HAVING c.custid BETWEEN 10 AND 20   -- условие
ORDER BY c.custid;