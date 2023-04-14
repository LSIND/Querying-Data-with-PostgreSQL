-- Модуль 9

---------------------------------------------
-- HAVING
---------------------------------------------

-- Количество заказов каждого заказчика
SELECT custid, COUNT(*) AS Total_Orders
FROM "Sales"."Orders"
GROUP BY custid
ORDER BY Total_Orders DESC;

-- Заказчики, совершившие менее 20 заказов
SELECT custid, COUNT(*) AS Total_Orders
FROM "Sales"."Orders"
GROUP BY custid
HAVING COUNT(*) <= 20;

-- HAVING не работает с псевдонимами столбцов
SELECT custid, COUNT(*) AS Total_Orders
FROM "Sales"."Orders"
GROUP BY custid
HAVING Total_Orders <= 20;

-- Продукты, которые купили менее 10 раз
SELECT p.ProductID, COUNT(*) AS cnt
FROM "Production"."Products" AS p
JOIN "Sales"."OrderDetails" AS od
ON p.ProductID = od.Productid
GROUP BY p.ProductID
HAVING COUNT(*) < 10
ORDER BY cnt DESC;

---------------------------------------------
-- Сравнение WHERE и HAVING

-- Количество и общее количество товаров по категориям
SELECT categoryid, COUNT(*) AS cnt, SUM(qty) AS sum_qty
FROM "Production"."Products" AS p
JOIN "Sales"."OrderDetails" AS od
ON p.productid = od.productid
GROUP BY p.categoryid
ORDER BY categoryid;

-- WHERE Количество и общее количество товаров по категориям, где в заказе количество товаров больше 20
SELECT categoryid, COUNT(*) AS cnt, SUM(qty) AS sum_qty
FROM "Production"."Products" AS p
JOIN "Sales"."OrderDetails" AS od
ON p.productid = od.productid
WHERE od.qty > 20
GROUP BY p.categoryid
ORDER BY categoryid;

-- HAVING Количество и общее количество товаров по категориям, где общее количество товаров по категориям больше 20
SELECT categoryid, COUNT(*) AS cnt, SUM(qty) AS sum_qty
FROM "Production"."Products" AS p
JOIN "Sales"."OrderDetails" AS od
ON p.productid = od.productid
GROUP BY p.categoryid
HAVING SUM(qty) > 20
ORDER BY categoryid;

---------------------------------------------
-- Заказчики и сколько заказов они совершили
-- 89 rows 
SELECT c.custid, COUNT(*) AS No_Of_Orders
FROM "Sales"."Customers" AS c
JOIN "Sales"."Orders" AS o
ON c.custid = o.custid
GROUP BY c.custid
ORDER BY No_Of_Orders DESC;

-- HAVING: Заказчики, совершившие в сумме более 100 заказов
SELECT c.custid, COUNT(*) AS No_Of_Orders
FROM "Sales"."Customers" AS c
JOIN "Sales"."Orders" AS o
ON c.custid = o.custid
GROUP BY c.custid
HAVING COUNT(*) > 100
ORDER BY No_Of_Orders DESC;

-- HAVING: продукты, которые редко встречаются в заказах (менее 10 раз)
SELECT p.ProductID, COUNT(*) AS cnt
FROM "Production"."Products" AS p
JOIN "Sales"."OrderDetails" AS od
ON p.ProductID = od.Productid
GROUP BY p.ProductID
HAVING COUNT(*) < 10
ORDER BY cnt DESC;