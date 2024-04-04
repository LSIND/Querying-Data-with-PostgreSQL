-------------------------------------------------------
--
-- Модуль 3
-- Демонстрация 3
-- Псевдонимы (aliases)
--
-------------------------------------------------------

-- 1. Данные из production.products, с получением вычисляемого столбца (цена дороже на 10%)
-- последний столбец не имеет имени (column4, ?column?)

SELECT productid, productname, unitprice, (unitprice * 1.1)
FROM production.products;


-- 2. Имя вычисляемого столбца

-- newprice
SELECT productid, productname, unitprice, (unitprice * 1.1) AS newprice
FROM production.products;

-- "New Price"
SELECT ProductID, productname, unitprice, (unitprice * 1.1) AS "New Price"
FROM production.products;

-- без инструкции AS - не рекомендуется
SELECT ProductID, productname, unitprice, (unitprice * 1.1) newprice
FROM production.products;


-- 3. Вывод нового имени столбца
SELECT productid AS pno, productname, unitprice
FROM production.products;


-- 4. Псевдоним на таблицу
SELECT SO.productid, SO.unitprice
FROM sales.orderdetails AS SO;

SELECT P.productid, P.productname
FROM production.products P;