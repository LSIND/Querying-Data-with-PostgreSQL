-------------------------------------------------------
--
-- Модуль 4
-- Демонстрация 2
-- OUTER JOIN
--
-------------------------------------------------------

-- 1. Продукты и их категории (77 строк)
SELECT P.productid, P.productname, C.categoryname
FROM production.products AS P
INNER JOIN production.categories AS C
ON P.categoryid = C.categoryid;


-- 2. LEFT OUTER JOIN
-- Продукты и их категории, а также продукты без категорий (77 строк)
SELECT P.productid, P.productname, C.categoryname, P.unitprice
FROM production.products AS P
LEFT OUTER JOIN production.categories AS C
ON P.categoryid = C.categoryid;
-- В таблицу  production.products нельзя добавить товар, у которого не было бы категории (categoryid NOT NULL)


-- 3. Добавить новую категорию возможно
-- Добавим категорию, в которой еще нет соответствующих продуктов
INSERT INTO production.categories(categoryid, categoryname, description)
VALUES (10, 'Категория МОД4', 'Новая категория');


-- 4. RIGHT OUTER JOIN 
-- Продукты и их категории, а также категории без продуктов - 78
SELECT P.productid, P.productname, C.categoryname, P.unitprice
FROM production.products AS P
RIGHT OUTER JOIN production.categories AS C
ON P.categoryid = C.categoryid;


-- 5. FULL OUTER JOIN
-- Продукты и их категории, продукты без категорий, а также категории без продуктов - 78
SELECT P.productid, P.productname, C.categoryname, P.unitprice
FROM production.products AS P
FULL OUTER JOIN production.categories AS C
ON P.categoryid = C.categoryid;


-- 6. IS NULL
-- Категории без соответствующих продуктов
SELECT C.categoryname, C.description
FROM production.products AS P
RIGHT OUTER JOIN production.categories AS C
ON P.categoryid = C.categoryid
WHERE P.categoryid IS NULL;