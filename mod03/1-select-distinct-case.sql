-- Модуль 3

---------------------------------------------
-- BASIC SELECT
---------------------------------------------

-- Все строки таблицы Production.Categories
SELECT *
FROM "Production"."Categories";

-- Все строки таблицы Production.Categories, перечисляя столбцы
SELECT categoryid, categoryname, description
FROM "Production"."Categories";

-- Все строки таблицы Production.Products, перечисляя столбцы productname, unitprice
SELECT productname, unitprice
FROM "Production"."Products";
  
-- Все строки таблицы HR.Employees, перечисляя столбцы Title, FirstName, LastName, Country
SELECT Title, FirstName, LastName, Country
FROM "HR"."Employees";


-- SELECT с вычисляемым столбцом (цена дороже на 10%)
SELECT ProductID, productname, unitprice, (unitprice * 1.1)
FROM "Production"."Products";


-- SELECT с вычисляемым столбцом (цена, умноженная на количество)
SELECT orderid, ProductID, UnitPrice, qty, (UnitPrice * qty)
FROM "Sales"."OrderDetails";

-- SELECT с вычисляемым столбцом (имя продукта с пометкой NEW)
SELECT productname || ', ' || 'NEW', unitprice
FROM "Production"."Products";
  

---------------------------------------------
-- SELECT DISTINCT
---------------------------------------------

-- Страны, из которых заказчики 
SELECT country 
FROM "Sales"."Customers"
ORDER BY country;


-- Страны, из которых заказчики (без дублей)
SELECT DISTINCT country
FROM "Sales"."Customers"
ORDER BY country;


-- Страны и города, из которых заказчики (без дублей)
SELECT DISTINCT country, city
FROM "Sales"."Customers"
ORDER BY country, city;

---------------------------------------------
-- ALIASES
---------------------------------------------

-- SELECT с псевдонимом на productid
SELECT productid AS "No", productname, unitprice
FROM "Production"."Products";

-- SELECT с вычисляемым столбцом AS "New Price" (цена дороже на 10%)
SELECT ProductID, productname, unitprice, (unitprice * 1.1) AS "New Price"
FROM "Production"."Products";

-- SELECT с вычисляемым столбцом "New Price" (цена дороже на 10%) - не рекомендуется
SELECT ProductID, productname, unitprice, (unitprice * 1.1)  "New Price"
FROM "Production"."Products";

-- Псевдоним на таблицу
SELECT SO.productid, SO.unitprice
FROM "Sales"."OrderDetails" AS SO;

-- Псевдоним на таблицу
SELECT P.productid, P.productname
FROM "Production"."Products" P;


---------------------------------------------
-- CASE
---------------------------------------------

-- simple case
SELECT empid, lastname, titleofcourtesy,
	CASE titleofcourtesy
		WHEN 'Ms.' THEN 'Miss'
		WHEN 'Mr.' THEN 'Mister'
		WHEN 'Dr.' THEN 'Doctor' 
		ELSE titleofcourtesy -- 'Default'
	END AS title -- alias
FROM "HR"."Employees";


-- searched case
SELECT productid, productname, unitprice,
	CASE 
		WHEN unitprice < 5::money THEN 'X'
		WHEN unitprice >=5::money and unitprice <30::money THEN 'M'
		WHEN unitprice >=30::money and unitprice <50::money THEN 'L'
		ELSE 'XXL'
	END AS Category
FROM "Production"."Products";