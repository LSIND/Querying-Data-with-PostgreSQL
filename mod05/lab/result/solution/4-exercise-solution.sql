---------------------------------------------------------------------
-- LAB 05
--
-- Exercise 4 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий столбцы custid, orderid и orderdate из таблицы sales.orders. 
-- Упорядочить строки по столбцам orderdate и orderid.
-- Получить первые 20 строк.
--
-- Результирующий набор сравните с Lab Exercise4 - Task1 Result.txt
---------------------------------------------------------------------

SELECT custid, orderid, orderdate
FROM sales.orders
ORDER BY orderdate, orderid
OFFSET 0 ROWS FETCH FIRST 20 ROWS ONLY;

SELECT custid, orderid, orderdate
FROM sales.orders
ORDER BY orderdate, orderid
LIMIT 20 OFFSET 0 ROWS;

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос Task 1, сформировав вторую страницу: пропустить 20 строк и получить следующие 20 строк.
--
-- Результирующий набор сравните с Lab Exercise4 - Task2 Result.txt
---------------------------------------------------------------------

SELECT custid, orderid, orderdate
FROM sales.orders
ORDER BY orderdate, orderid
OFFSET 20 ROWS FETCH NEXT 20 ROWS ONLY;

SELECT custid, orderid, orderdate
FROM sales.orders
ORDER BY orderdate, orderid
LIMIT 20 OFFSET 20 ROWS;


---------------------------------------------------------------------
-- Task 3 ***
-- Сделайте запрос Task 2 универсальным, используя переменные
-- Создайте параметры pagenum (номер страницы) и pagesize (размер страницы); напишите запрос с OFFSET-FETCH
-- 
-- hint: использовать табличную функцию
---------------------------------------------------------------------

-- с использованием табличной функции

CREATE FUNCTION orders_pagination(pagenum int, pagesize int) 
RETURNS TABLE(custid int, orderid int, orderdate timestamp)
AS $$
BEGIN 
    RETURN QUERY
		SELECT o.custid, o.orderid, o.orderdate FROM sales.orders as o
        ORDER BY o.orderdate, o.orderid
        OFFSET ((pagenum-1)*pagesize) ROWS FETCH NEXT pagesize ROWS ONLY;
END
$$ STABLE LANGUAGE plpgsql;

SELECT * FROM orders_pagination(2, 10);

DROP FUNCTION orders_pagination(int, int) ;



-- ** с использованием анонимного блока DO и курсора
BEGIN;
DO $$ 
DECLARE
 pagenum integer:= 2;
 pagesize integer:= 10;
 _query text;  
 _cursor CONSTANT refcursor := '_cursor';
BEGIN _query := 'SELECT custid, orderid, orderdate
FROM sales.orders ORDER BY orderdate, orderid
OFFSET ' || CAST(((pagenum - 1) * pagesize) AS text) || ' ROWS FETCH NEXT ' || CAST(pagesize AS TEXT) || ' ROWS ONLY;';
OPEN _cursor FOR EXECUTE _query;
END $$;
FETCH ALL FROM _cursor;
COMMIT;



--------------------------------------
-- *** с использованием подготовленного запроса (prepared)
PREPARE q(integer, integer) AS
SELECT custid, orderid, orderdate
FROM sales.orders
ORDER BY orderdate, orderid
OFFSET (($1 - 1) * $2) ROWS FETCH NEXT $2 ROWS ONLY;

execute q(4,10);

--select * from pg_prepared_statements;
deallocate "q";