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
		WHEN unitprice < 5 THEN 'X'
		WHEN unitprice >=5 and unitprice <30 THEN 'M'
		WHEN unitprice >=30 and unitprice <50 THEN 'L'
		ELSE 'XXL'
	END AS Category
FROM production.products;