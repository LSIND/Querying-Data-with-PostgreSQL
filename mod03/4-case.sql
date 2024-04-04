-------------------------------------------------------
--
-- Модуль 3
-- Демонстрация 4
-- CASE
--
-------------------------------------------------------

-- 1. simple case
SELECT empid, lastname, titleofcourtesy,
	CASE titleofcourtesy
		WHEN 'Ms.' THEN 'Miss'
		WHEN 'Mr.' THEN 'Mister'
		WHEN 'Dr.' THEN 'Doctor' 
		ELSE titleofcourtesy -- 'Default'
	END AS title -- alias
FROM hr.employees;


-- 2. searched case
SELECT productid, productname, unitprice,
	CASE 
		WHEN unitprice < 5::money THEN 'X'
		WHEN unitprice >=5::money and unitprice <30::money THEN 'M'
		WHEN unitprice >=30::money and unitprice <50::money THEN 'L'
		ELSE 'XXL'
	END AS Category
FROM production.products;