-- Common Table Expressions

-- 1. CTE 
WITH CTE_year AS
	(
	SELECT EXTRACT(YEAR FROM orderdate) AS orderyear, custid
	FROM "Sales"."Orders"
	)
SELECT orderyear, COUNT(DISTINCT custid) AS cust_count
FROM CTE_year
GROUP BY orderyear;


-- (Optional) Recursive CTE
-- Сотрудники и их подчиненные в иерархии
WITH RECURSIVE "EmpOrg_CTE" AS
(SELECT empid, mgrid, lastname, firstname --anchor query
	FROM "HR"."Employees"
WHERE empid = 2 -- starting "top" of tree. Change this to show other root employees

UNION ALL
SELECT child.empid, child.mgrid, child.lastname, child.firstname -- recursive member which refers back to CTE
	FROM "EmpOrg_CTE" AS parent --
	JOIN "HR"."Employees" AS child
	ON child.mgrid=parent.empid
)
SELECT empid, mgrid, lastname, firstname
FROM "EmpOrg_CTE";

-- (Optional) MATERIALIZED
EXPLAIN -- Обычный запрос
SELECT * FROM "Sales"."OrderDetails"
WHERE productid = 14 AND qty > 5;

EXPLAIN
WITH yy AS MATERIALIZED ( -- сначала явно выполнится запрос в CTE
     SELECT * FROM "Sales"."OrderDetails" WHERE  qty > 5 )
SELECT * FROM yy WHERE productid = 14;

EXPLAIN
WITH yy AS NOT MATERIALIZED ( -- запрос в CTE выполняется как часть одного большого запроса
     SELECT * FROM "Sales"."OrderDetails" WHERE  qty > 5 )
SELECT * FROM yy WHERE productid = 14;


-- (Optional) изменение данных в CTE
WITH CTE_move_data AS (
    DELETE FROM products
    WHERE
        "date" >= '2010-10-01' AND
        "date" < '2010-11-01'
    RETURNING * -- 
)
INSERT INTO Products_log
SELECT * FROM CTE_move_data;