-------------------------------------------------------
--
-- Модуль 6
-- Демонстрация 1
-- Обзор типов данных
--
-------------------------------------------------------

-- неявная конвертация
SELECT 1 + '2' AS result;

-- неявная конвертация
SELECT 1 + 'abc' AS result;

-- явная конвертация
SELECT CAST(1 AS VARCHAR(10)) || 'abc' AS result;

SELECT CAST('20221008' AS date);
 
SELECT CAST(20.25 AS int);

SELECT CAST('200.566' AS bit); -- error

SELECT CAST('200.566' AS INT); -- error

SELECT CAST(CAST('200.566' AS NUMERIC) AS INT); -- 

SELECT '200.566'::numeric::int;

-- использование ::
SELECT 50.25::int;

SELECT '200.566'::bit; -- error 

--------------------
-- Размер данных разных типов (в Байтах)
SELECT pg_column_size(500) as IntSize, pg_column_size('20240101'::date) as DateSize, pg_column_size(50.25::money) as MoneySize;

SELECT orderid, pg_column_size(orderid) as IntB, orderdate, pg_column_size(orderdate) as DatetimeB,
shipcity, pg_column_size(shipcity) as VarcharB
FROM sales.orders;


-- COLLATION

UPDATE hr.employees  -- Обновляем фамилию сотрудника #1
SET lastname = 'funk'
where empid = 1;


SELECT * FROM  hr.employees
WHERE lastname = 'funk';

SELECT * FROM  hr.employees
WHERE lastname ILIKE 'funk'; -- регистронезависимый поиск

---------------
UPDATE hr.employees  -- Возращаем исходную фамилию сотрудника #1
SET lastname = 'Davis'
where empid = 1;