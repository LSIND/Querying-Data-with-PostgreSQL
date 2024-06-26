-------------------------------------------------------
--
-- Модуль 11
-- Демонстрация 3
-- Общие табличные выражения (Common Table Expressions, CTE)
--
-------------------------------------------------------

-- 1. CTE 
WITH CTE_year AS
	(
	SELECT EXTRACT(YEAR FROM orderdate) AS orderyear, custid
	FROM sales.orders
	)
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM CTE_year
GROUP BY orderyear;

---------------------------------------------------------------------
--
-- (* Optional) Recursive CTE
-- Сотрудники и их подчиненные в иерархии
--
---------------------------------------------------------------------
WITH RECURSIVE EmpOrg_CTE AS
(SELECT empid, mgrid, lastname, firstname --anchor query
	FROM hr.employees
WHERE empid = 2 --  `top` of tree. Сотрудник, для которого будут отображены подчиненные в иерархии
UNION ALL
SELECT child.empid, child.mgrid, child.lastname, child.firstname -- рекурсия Employees x EmpOrg_CTE
	FROM EmpOrg_CTE AS parent --
	JOIN hr.employees AS child
	ON child.mgrid=parent.empid
)
SELECT empid, mgrid, lastname, firstname
FROM EmpOrg_CTE;


---------------------------------------------------------------------
--
-- (** Optional) MATERIALIZED
--
---------------------------------------------------------------------

EXPLAIN -- Обычный запрос: информация о проданных товарах с номером 14 в кол-ве от 6 шт.
SELECT * FROM sales.orderdetails
WHERE productid = 14 AND qty > 5;

EXPLAIN
WITH yy AS -- инструкция NOT MATERIALIZED - значение по умолчанию
NOT MATERIALIZED -- запрос в CTE выполняется как часть одного большого запроса
( SELECT * FROM sales.orderdetails WHERE  qty > 5 )
SELECT * FROM yy WHERE productid = 14;

EXPLAIN
WITH yy 
AS MATERIALIZED -- сначала явно выполнится запрос в CTE
( SELECT * FROM sales.orderdetails WHERE  qty > 5 )
SELECT * FROM yy WHERE productid = 14;


---------------------------------------------------------------------
--
-- (*** Optional) изменение данных в CTE
--
---------------------------------------------------------------------

-- (создание таблиц для демонстрации и заполнение данными)

CREATE TABLE public.production -- Основная таблица
(
pid INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
pname varchar(100) NOT NULL,
pdate timestamp NOT NULL
);

CREATE TABLE public.production_log -- Таблица 'журнала'
(
pid INT NOT NULL,
pname varchar(100) NOT NULL,
pdate timestamp NOT NULL,
modifiedon timestamp DEFAULT NOW() NOT NULL,
modifiedby varchar(100) DEFAULT session_user NOT NULL
);

-- данные с 1 мая 2023 по 01 декабря 2023
INSERT INTO public.production (pname, pdate)
VALUES ('Product' || FLOOR(RANDOM() * 1000 + 1)::int::varchar(10), generate_series('2023-05-01'::timestamp, '2023-12-01'::timestamp, '5 hours'::interval))

SELECT * FROM public.production 

--
-- используем CTE для перемещения данных: удаление из public.production и добавление в public.production_log
WITH CTE_move_data AS (
    DELETE FROM public.production
    WHERE
        pdate >= '20231001' AND -- удаление данных за октябрь 2023
        pdate < '20231101'
    RETURNING * -- 
)
INSERT INTO public.production_log
SELECT * FROM CTE_move_data;

-- Проверяем, что данные за октябрь 2023 попали в таблицу лога
SELECT * FROM public.production_log;

-- и были удалены из основной таблицы
SELECT * FROM public.production 
 WHERE
        pdate >= '20231001' AND 
        pdate < '20231101';

-- Удаление таблиц
DROP TABLE IF EXISTS public.production;
DROP TABLE IF EXISTS public.production_log;