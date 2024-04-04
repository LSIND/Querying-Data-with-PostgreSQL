-------------------------------------------------------
--
-- Модуль 9
-- Демонстрация 2
-- GROUP BY
--
-------------------------------------------------------


-- Количество заказов, оформленных каждым сотрудником
SELECT empid, COUNT(*) AS Total_Orders
FROM sales.orders
GROUP BY empid
ORDER BY Total_Orders asc;

-- Количество заказов, оформленных сотрудником N 8 для каждого покупателя в каждом конкретном году
SELECT custid, EXTRACT (YEAR FROM OrderDate) AS yearOrder, COUNT(*) AS Total_Orders
FROM sales.orders
WHERE empid = 8
GROUP BY custid, EXTRACT (YEAR FROM OrderDate)
ORDER BY custid, yearOrder;


---------------------------------------------
-- Workflow of grouping 1
---------------------------------------------

-- Источник данных
SELECT orderid, productid, unitprice
FROM sales.orderdetails;

-- Условие
SELECT orderid, productid, unitprice
FROM sales.orderdetails
WHERE orderid IN (10248, 10251,10259);

-- Группа
SELECT orderid, COUNT(productid), SUM(unitprice)
FROM sales.orderdetails
WHERE orderid IN (10248, 10250,10259)
GROUP BY orderid;

---------------------------------------------

---------------------------------------------
-- Workflow of grouping 2
---------------------------------------------

-- Источник данных
SELECT custid, orderid
FROM sales.orders;

-- Условие
SELECT custid, orderid
FROM sales.orders
WHERE shipcity = 'Madrid';

-- Группа
SELECT custid, COUNT(orderid)
FROM sales.orders
WHERE shipcity = 'Madrid'
GROUP BY custid;

---------------------------------------------

-- Количество заказов каждого заказчика
SELECT custid, COUNT(*) AS Total_Orders
FROM sales.orders
GROUP BY custid
ORDER BY Total_Orders DESC;

-- Максимальное количество определенного продукта в заказе
SELECT ProductID, MAX(qty) AS largest_order
FROM sales.orderdetails
GROUP BY productid
ORDER BY largest_order DESC;