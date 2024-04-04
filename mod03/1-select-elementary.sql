-------------------------------------------------------
--
-- Модуль 3
-- Демонстрация 1
-- Базовые SELECT-запросы
--
-------------------------------------------------------


-- 1. Все строки таблицы production.categories
SELECT *
FROM production.categories;


-- 2. Все строки таблицы production.categories с перечислением нужных столбцов (корректный вариант)
SELECT categoryid, categoryname, description
FROM production.categories;


-- 3. Все строки таблицы Production.Products с перечислением столбцов 'имя продукта' (productname) и 'цена' (unitprice)
SELECT productname, unitprice
FROM production.products;
  

-- 4. Все строки таблицы hr.employees с перечислением столбцов Title, FirstName, LastName, Country
SELECT Title, FirstName, LastName, Country
FROM hr.employees;


-- 5. Данные из production.products, с получением вычисляемого столбца (цена дороже на 10%)
SELECT productid, productname, unitprice, (unitprice * 1.1)
FROM production.products;


-- 6. SELECT с вычисляемым столбцом (цена, умноженная на количество)
SELECT orderid, ProductID, UnitPrice, qty, (UnitPrice * qty)
FROM sales.orderdetails;


-- 7. Данные из production.products, с получением вычисляемого столбца (имя продукта с пометкой NEW)
SELECT productname || ', ' || 'NEW', unitprice
FROM production.products;