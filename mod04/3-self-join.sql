-- Модуль 4

---------------------------------------------
-- SELF JOIN
---------------------------------------------

-- Сотрудники и их руководители
-- Разные псевдонимы на таблицу HR.Employees
 SELECT e.empid ,e.lastname as empname,e.title,e.mgrid, m.lastname as mgrname
  FROM "HR"."Employees" AS e
  JOIN "HR"."Employees" AS m
  ON e.mgrid=m.empid;

-- Все сотрудники и их руководители (empid = 1 не имеет руководителя)
  SELECT e.empid ,e.lastname as empname,e.title,e.mgrid, m.lastname as mgrname
   FROM "HR"."Employees" AS e
  LEFT OUTER JOIN "HR"."Employees" AS m
  ON e.mgrid=m.empid;
  
-- CROSS JOIN - все возможные варианты имя + фамилия
SELECT e1.firstname, e2.lastname
FROM "HR"."Employees" AS e1 
CROSS JOIN "HR"."Employees" AS e2;