--  Demonstration C

-- 2: EXISTS
-- Заказчики, которые совершали заказы
SELECT custid, companyname
FROM "Sales"."Customers" AS c
WHERE EXISTS (
	SELECT * 
	FROM "Sales"."Orders" AS o
	WHERE c.custid=o.custid);

-- 3:  NOT EXISTS	
-- Заказчики, которые НЕ совершали заказы
EXPLAIN
SELECT custid, companyname
FROM "Sales"."Customers" AS c
WHERE NOT EXISTS (
	SELECT * 
	FROM "Sales"."Orders" AS o
	WHERE c.custid=o.custid);

-- LEFT JOIN
EXPLAIN
SELECT C.custid, C.companyname
FROM "Sales"."Customers" AS c
LEFT JOIN "Sales"."Orders" AS o
ON c.custid=o.custid
WHERE O.orderid IS NULL;


-- 4: Сравнение COUNT(*)>0 и EXISTS:
EXPLAIN
SELECT empid, lastname
FROM "HR"."Employees" AS e
WHERE (SELECT COUNT(*)
		FROM "Sales"."Orders" AS O
		WHERE O.empid = e.empid)>0;

-- 
EXPLAIN
SELECT empid, lastname
FROM "HR"."Employees" AS e
WHERE EXISTS (SELECT * 
		FROM "Sales"."Orders" AS O
		WHERE O.empid = e.empid);