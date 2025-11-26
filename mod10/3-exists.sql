-------------------------------------------------------
--
-- Модуль 10
-- Демонстрация 3
-- Предикат EXISTS
--
-------------------------------------------------------

-- 1. Заказчики, которые хоть раз совершили заказ
SELECT custid, companyname
FROM sales.customers AS c
WHERE EXISTS (
	SELECT * 
	FROM sales.orders AS o
	WHERE c.custid=o.custid);

-- 2. NOT EXISTS: заказчики, которые ни разу не совершили заказ
SELECT custid, companyname
FROM sales.customers AS c
WHERE NOT EXISTS (
	SELECT * 
	FROM sales.orders AS o
	WHERE c.custid=o.custid);

-- Тот же результат, но с LEFT JOIN
SELECT C.custid, C.companyname
FROM sales.customers AS c
LEFT JOIN sales.orders AS o
ON c.custid=o.custid
WHERE O.orderid IS NULL;


-- 3. Сравнение COUNT(*)>0 и EXISTS:
-- Сотрудники, кто хоть раз оформил заказ
SELECT empid, lastname
FROM hr.employees AS e
WHERE (SELECT COUNT(*)
		FROM sales.orders AS O
		WHERE O.empid = e.empid)>0;

-- Тот же результат, но с EXISTS
SELECT empid, lastname
FROM hr.employees AS e
WHERE EXISTS (SELECT * 
		FROM sales.orders AS O
		WHERE O.empid = e.empid);


-- 4. Поиск товаров, которые чаще всего покупают вместе с товаром productid = 1
SELECT p.productid,  p.productname, COUNT(*) as purchase_count
FROM sales.orders o
JOIN sales.orderdetails od ON o.orderid = od.orderid
JOIN production.products p ON od.productid = p.productid
WHERE od.productid != 1
  AND EXISTS (
    SELECT *
    FROM sales.orderdetails od2 
    WHERE od2.orderid = o.orderid 
      AND od2.productid = 1
  )
GROUP BY p.productid, p.productname
ORDER BY purchase_count DESC;


-- 5. Заказчики, которые еще не получили свои заказы (shippeddate IS NULL)
SELECT custid, companyname
FROM sales.customers AS c
WHERE EXISTS (
    SELECT * 
    FROM sales.orders AS o
    WHERE c.custid = o.custid
    AND o.shippeddate IS NULL
)
ORDER BY c.custid;

-- Тот же результат, но через Inner Join
SELECT DISTINCT  c.custid, c.companyname
FROM sales.customers AS c
INNER JOIN sales.orders AS o
ON c.custid = o.custid
WHERE o.shippeddate IS NULL
ORDER BY c.custid;
