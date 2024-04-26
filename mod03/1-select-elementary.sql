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


-- 3. Все строки таблицы production.products с перечислением столбцов 'имя продукта' (productname) и 'цена' (unitprice)
SELECT productname, unitprice
FROM production.products;
  

-- 4. Все строки таблицы hr.employees с перечислением столбцов Title, FirstName, LastName, Country
SELECT title, firstname, lastname, country
FROM hr.employees;


-- 5. Данные из production.products, с получением вычисляемого столбца (цена дороже на 10%)
SELECT productid, productname, unitprice, (unitprice * 1.1)
FROM production.products;


-- 6. SELECT с вычисляемым столбцом (цена, умноженная на количество)
SELECT orderid, productid, unitprice, qty, (unitprice * qty)
FROM sales.orderdetails;


-- 7. Данные из production.products: вывод названий продуктов, а также вычисляемого столбца (название продукта с пометкой NEW)
SELECT productname, productname || ', NEW', unitprice
FROM production.products;