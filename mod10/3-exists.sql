-------------------------------------------------------
--
-- Модуль 10
-- Демонстрация 3
-- Предикат EXISTS
--
-------------------------------------------------------

-- Заказчики, которые хоть раз совершили заказ
SELECT custid, companyname
FROM sales.customers AS c
WHERE EXISTS (
	SELECT * 
	FROM sales.orders AS o
	WHERE c.custid=o.custid);

-- NOT EXISTS: заказчики, которые ни разу не совершили заказ
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


-- Сравнение COUNT(*)>0 и EXISTS:

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