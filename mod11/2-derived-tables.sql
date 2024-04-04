-------------------------------------------------------
--
-- Модуль 11
-- Демонстрация 2
-- Наследуемые таблицы (DERIVED TABLES)
--
-------------------------------------------------------

-- 1. Псевдонимы на столбцы в наследуемых таблицах (внутренние)
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM 
(SELECT EXTRACT(YEAR FROM orderdate) AS orderyear, custid
FROM sales.orders) AS derived_year
GROUP BY orderyear;

-- 2. Псевдонимы на столбцы в наследуемых таблицах (внешние)
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM 
(SELECT EXTRACT(YEAR FROM orderdate), custid
FROM sales.orders) AS derived_year(orderyear, custid)
GROUP BY orderyear;

-- 3. Использование условий 
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM (	
	SELECT EXTRACT(YEAR FROM orderdate) AS orderyear, custid
	FROM sales.orders
	WHERE empid=9
) AS derived_year
GROUP BY orderyear;

-- 4. Несколько уровней вложенности - не рекомендуется
SELECT orderyear, cust_count
FROM  (
	SELECT  orderyear, COUNT(DISTINCT custid) AS cust_count
	FROM (
		SELECT EXTRACT(YEAR FROM orderdate) AS orderyear ,custid
        FROM sales.orders) AS derived_table_1
	GROUP BY orderyear) AS derived_table_2
WHERE cust_count > 80;

-- Альтернатива c HAVING
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
	FROM (
		SELECT EXTRACT(YEAR FROM orderdate) AS orderyear ,custid
        FROM sales.orders) AS derived_table_1
	GROUP BY orderyear
HAVING COUNT(DISTINCT custid) > 80;