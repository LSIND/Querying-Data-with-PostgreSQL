-------------------------------------------------------
--
-- Модуль 6
-- Демонстрация 1
-- Обзор типов данных
--
-------------------------------------------------------

-- Неявная конвертация
---- Математические операторы: возвращают в результате тот же тип данных, что и аргументы.
---- Если типы аргументов не совпадают, то возвращаем тип с большим приоритетом: int -> numeric

SELECT 1 + '2' AS result;     -- -> int
SELECT 1.5 + '2' AS result;   -- -> numeric

SELECT 10.5 / 8 AS result;    -- -> numeric
SELECT 5 / 2 AS result;       -- -> int !!!

SELECT 1 + '2.9' AS result;   -- error: невозможно преобразовать строку '2.9' в int
SELECT 1 + 'abc' AS result;   -- error: невозможно преобразовать строку 'abc' в int

SELECT '2023-09-28' + 7;      -- error: invalid input syntax for type integer: "2023-09-28"


---- Конкатенация строк: text || text
---- возвращает строку (text) в результат
SELECT 1 || 'abc' AS result;

SELECT 50.5 || 8.5 AS result; -- error: operator does not exist: numeric || numeric


-------------------------------------------------------
-- Явная конвертация
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


-------------------------------------------------------
-- Размер данных разных типов (в Байтах)
SELECT pg_column_size(500) as IntSize, pg_column_size('20240101'::date) as DateSize, pg_column_size(50.25::money) as MoneySize;

SELECT orderid, pg_column_size(orderid) as IntB, orderdate, pg_column_size(orderdate) as DatetimeB,
shipcity, pg_column_size(shipcity) as VarcharB
FROM sales.orders;


-------------------------------------------------------

UPDATE hr.employees  -- Обновляем фамилию сотрудника #1
SET lastname = 'funk'
where empid = 1;


SELECT * FROM  hr.employees
WHERE lastname = 'funk';

SELECT * FROM  hr.employees
WHERE lastname ILIKE 'funk'; -- регистронезависимый поиск


-- Возращаем исходную фамилию сотрудника #1
UPDATE hr.employees  
SET lastname = 'Davis'
where empid = 1;