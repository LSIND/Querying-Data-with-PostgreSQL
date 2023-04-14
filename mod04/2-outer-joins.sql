-- Модуль 4

---------------------------------------------
-- OUTER JOIN
---------------------------------------------

-- Продукты и их категории - 77
SELECT P.productid, P.productname, C.categoryname, P.unitprice
FROM "Production"."Products" AS P
INNER JOIN "Production"."Categories" AS C
ON P.categoryid = C.categoryid;

-- Продукты и их категории, а также продукты без категорий - 77
SELECT P.productid, P.productname, C.categoryname, P.unitprice
FROM "Production"."Products" AS P
LEFT OUTER JOIN "Production"."Categories" AS C
ON P.categoryid = C.categoryid;


-- Добавим категорию, в которой еще нет соответсвующих продуктов
INSERT INTO "Production"."Categories"(categoryid, categoryname, description)
VALUES (10, 'Категория ЛР4', 'Test');


-- Продукты и их категории, а также категории без продуктов - 78
SELECT P.productid, P.productname, C.categoryname, P.unitprice
FROM "Production"."Products" AS P
RIGHT OUTER JOIN "Production"."Categories" AS C
ON P.categoryid = C.categoryid;

-- Продукты и их категории, продукты без категорий, а также категории без продуктов - 78
SELECT P.productid, P.productname, C.categoryname, P.unitprice
FROM "Production"."Products" AS P
FULL OUTER JOIN "Production"."Categories" AS C
ON P.categoryid = C.categoryid;

-- Заказчики и их заказы, а также заказчики без заказов
SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM "Sales"."Customers" AS c
LEFT OUTER JOIN "Sales"."Orders" AS o
ON c.custid =o.custid;

-- Заказчики без заказов (2)
SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM "Sales"."Customers" AS c
LEFT OUTER JOIN "Sales"."Orders" AS o
ON c.custid =o.custid
WHERE o.orderid IS NULL;

-- Категории без соотв. продуктов
SELECT C.categoryname, C.description
FROM "Production"."Products" AS P
RIGHT OUTER JOIN "Production"."Categories" AS C
ON P.categoryid = C.categoryid
WHERE P.categoryid IS NULL;