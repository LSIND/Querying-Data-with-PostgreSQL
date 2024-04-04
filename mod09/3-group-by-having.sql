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

-- Количество товаров каждой категории (cnt) и общее количество проданных товаров в каждой категории (sum_qty)
SELECT c.categoryid, c.categoryname, COUNT(*) AS cnt, SUM(qty) AS sum_qty
FROM production.products AS p
JOIN sales.orderdetails AS od ON p.productid = od.productid 
JOIN production.categories AS c  ON c.categoryid = p.categoryid
GROUP BY c.categoryid, c.categoryname
ORDER BY categoryid;

-- WHERE 
-- Количество товаров каждой категории (cnt) и общее количество проданных товаров в каждой категории (sum_qty) 
-- С условием, что эти товары были проданы в количестве от 20 шт.
SELECT c.categoryid, c.categoryname, COUNT(*) AS cnt, SUM(qty) AS sum_qty
FROM production.products AS p
JOIN sales.orderdetails AS od ON p.productid = od.productid 
JOIN production.categories AS c  ON c.categoryid = p.categoryid
WHERE od.qty > 20
GROUP BY c.categoryid, c.categoryname
ORDER BY categoryid;

-- HAVING 
-- Количество товаров каждой категории (cnt) и общее количество проданных товаров в каждой категории (sum_qty)
-- Где итоговое количество проданных товаров в каждой категории более 20 шт.
SELECT c.categoryid, c.categoryname, COUNT(*) AS cnt, SUM(qty) AS sum_qty
FROM production.products AS p
JOIN sales.orderdetails AS od ON p.productid = od.productid 
JOIN production.categories AS c  ON c.categoryid = p.categoryid
GROUP BY c.categoryid, c.categoryname
HAVING SUM(qty) > 20
ORDER BY categoryid;

