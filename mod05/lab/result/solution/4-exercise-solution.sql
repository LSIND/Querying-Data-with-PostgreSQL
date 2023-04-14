---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 4
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий столбцы custid, orderid и orderdate из таблицы Sales.Orders. 
-- Упорядочить строки по столбцам orderdate и orderid.
-- Получить первые 20 строк.
-- Результирующий набор сравните с Lab Exercise4 - Task1 Result.txt
---------------------------------------------------------------------

SELECT custid, orderid, orderdate
FROM "Sales"."Orders"
ORDER BY orderdate, orderid
OFFSET 0 ROWS FETCH FIRST 20 ROWS ONLY;

SELECT custid, orderid, orderdate
FROM "Sales"."Orders"
ORDER BY orderdate, orderid
LIMIT 20 OFFSET 0 ROWS;

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос Task 1, сформировав вторую страницу: пропустить 20 строк и получить следующие 20 строк.
-- Результирующий набор сравните с Lab Exercise4 - Task2 Result.txt
---------------------------------------------------------------------

SELECT custid, orderid, orderdate
FROM "Sales"."Orders"
ORDER BY orderdate, orderid
OFFSET 20 ROWS FETCH NEXT 20 ROWS ONLY;

SELECT custid, orderid, orderdate
FROM "Sales"."Orders"
ORDER BY orderdate, orderid
LIMIT 20 OFFSET 20 ROWS;


---------------------------------------------------------------------
-- Task 3 *
-- Сделайте запрос Task 2 универсальным, используя переменные
-- Создайте параметры pagenum (номер страницы) и pagesize (размер страницы); напишите запрос с OFFSET-FETCH
---------------------------------------------------------------------

DO $$ 
DECLARE pagenum integer:= 2;
DECLARE pagesize integer:= 10;
DECLARE result RECORD;

BEGIN 
SELECT custid, orderid, orderdate
INTO result
FROM "Sales"."Orders"
ORDER BY orderdate, orderid
OFFSET ((pagenum - 1) * pagesize) ROWS FETCH NEXT pagesize ROWS ONLY;

raise notice '%', result;
END $$;


BEGIN;
DO $$ 
DECLARE
 pagenum integer:= 2;
 pagesize integer:= 10;
 _query text;  
 _cursor CONSTANT refcursor := '_cursor';
BEGIN _query := 'SELECT custid, orderid, orderdate
FROM "Sales"."Orders" ORDER BY orderdate, orderid
OFFSET ' || CAST(((pagenum - 1) * pagesize) AS text) || ' ROWS FETCH NEXT ' || CAST(pagesize AS TEXT) || ' ROWS ONLY;';
OPEN _cursor FOR EXECUTE _query;
END $$;
FETCH ALL FROM _cursor;
COMMIT;









