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


-- COLLATION

UPDATE "HR"."Employees"
SET lastname = 'funk'
where empid = 1


SELECT * FROM  "HR"."Employees"
WHERE lastname ILIKE 'funk'; -- регистронезависимый поиск

SELECT *--datcollate AS collation
FROM pg_database 
WHERE datname = current_database();