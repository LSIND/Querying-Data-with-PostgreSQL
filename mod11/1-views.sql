-------------------------------------------------------
--
-- Модуль 11
-- Демонстрация 1
-- Представления (view)
--
-------------------------------------------------------

-- 1. Системные представления

SELECT * FROM INFORMATION_SCHEMA.TABLES; -- standard

SELECT * FROM pg_tables;

SELECT * FROM pg_settings
WHERE category = 'File Locations' -- Расположения файлов
ORDER BY category;

-- 2. Создание простого представления
CREATE VIEW hr.empphonelist
AS
SELECT empid, lastname, firstname, phone
FROM hr.employees;

-- Запрос к представлению hr.empphonelist
SELECT empid, lastname, firstname, phone
FROM hr.empphonelist;


-- 3. Представление с выборкой из нескольких таблиц и группировкой
CREATE OR REPLACE VIEW sales.ordersbyemployeeyear
AS
    SELECT  emp.empid AS employee ,
            EXTRACT(YEAR FROM ord.orderdate) AS orderyear ,
            SUM(od.qty * od.unitprice) AS totalsales
    FROM  hr.employees AS emp
            JOIN sales.orders AS ord ON emp.empid = ord.empid
            JOIN sales.orderdetails AS od ON ord.orderid = od.orderid
    GROUP BY emp.empid , EXTRACT(YEAR FROM ord.orderdate);

-- Выбор данных из представления
SELECT employee, orderyear, totalsales
FROM sales.ordersbyemployeeyear
ORDER BY employee, orderyear;


-- Удаление объектов
DROP VIEW IF EXISTS sales.ordersbyemployeeyear;
DROP VIEW IF EXISTS hr.empphonelist;