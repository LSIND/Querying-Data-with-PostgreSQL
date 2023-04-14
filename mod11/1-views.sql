-- VIEW

-- 1. System Views

SELECT * FROM INFORMATION_SCHEMA.TABLES; -- standard

SELECT * FROM pg_tables;

SELECT * FROM pg_settings
WHERE category = 'File Locations'; -- Расположения файлов
ORDER BY Category

-- 2. Simple views

CREATE VIEW "HR"."EmpPhoneList"
AS
SELECT empid, lastname, firstname, phone
FROM "HR"."Employees";

-- Select from "HR"."EmpPhoneList"
SELECT empid, lastname, firstname, phone
FROM "HR"."EmpPhoneList";


-- 3. Complex view
CREATE OR REPLACE VIEW "Sales"."OrdersByEmployeeYear"
AS
    SELECT  emp.empid AS employee ,
            EXTRACT(YEAR FROM ord.orderdate) AS orderyear ,
            SUM(od.qty * od.unitprice) AS totalsales
    FROM  "HR"."Employees"  AS emp
            JOIN "Sales"."Orders" AS ord ON emp.empid = ord.empid
            JOIN "Sales"."OrderDetails" AS od ON ord.orderid = od.orderid
    GROUP BY emp.empid , EXTRACT(YEAR FROM ord.orderdate);

-- Выбор данных из представления
SELECT employee, orderyear, totalsales
FROM "Sales"."OrdersByEmployeeYear"
ORDER BY employee, orderyear;


-- Удаление объектов DROP
DROP VIEW IF EXISTS "Sales"."OrdersByEmployeeYear";
DROP VIEW IF EXISTS "HR"."EmpPhoneList";