-- Модуль 9

---------------------------------------------
-- GROUP BY
---------------------------------------------

-- Количество заказов, оформленных каждым сотрудником
SELECT empid, COUNT(*) AS Total_Orders
FROM "Sales"."Orders"
GROUP BY empid
ORDER BY Total_Orders asc;

-- Количество заказов, оформленных сотрудником N 8 для каждого покупателя по годам
SELECT custid, EXTRACT (YEAR FROM OrderDate) AS yearOrder, COUNT(*) AS Total_Orders
FROM "Sales"."Orders"
WHERE empid = 8
GROUP BY custid, EXTRACT (YEAR FROM OrderDate)
ORDER BY custid, yearOrder;


---------------------------------------------
-- Workflow of grouping 1
---------------------------------------------

-- Источник данных
SELECT orderid, productid, unitprice
FROM "Sales"."OrderDetails";

-- Условие
SELECT orderid, productid, unitprice
FROM "Sales"."OrderDetails"
WHERE orderid IN (10248, 10251,10259);

-- Группа
SELECT orderid, COUNT(productid), SUM(unitprice)
FROM "Sales"."OrderDetails"
WHERE orderid IN (10248, 10250,10259)
GROUP BY orderid;

---------------------------------------------

---------------------------------------------
-- Workflow of grouping 2
---------------------------------------------

-- Источник данных
SELECT custid, orderid
FROM "Sales"."Orders";

-- Условие
SELECT custid, orderid
FROM "Sales"."Orders"
WHERE shipcity = 'Madrid';

-- Группа
SELECT custid, COUNT(orderid)
FROM "Sales"."Orders"
WHERE shipcity = 'Madrid'
GROUP BY custid;

---------------------------------------------

-- Количество заказов каждого заказчика
SELECT custid, COUNT(*) AS Total_Orders
FROM "Sales"."Orders"
GROUP BY custid
ORDER BY Total_Orders DESC;

-- Максимальное количество определенного продукта в заказе
SELECT ProductID, MAX(qty) AS largest_order
FROM "Sales"."OrderDetails"
GROUP BY productid
ORDER BY largest_order DESC;