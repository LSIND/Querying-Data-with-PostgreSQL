-------------------------------------------------------
--
-- Модуль 4
-- Демонстрация 3
-- SELF JOIN
--
-------------------------------------------------------

-- 1. Список сотрудников (9 строк)
-- empid - номер сотрудника, mgrid - номер руководителя данного сотрудника
 SELECT empid ,lastname, title, mgrid
  FROM hr.employees;


-- 2. Сотрудники и их руководители
-- Разные псевдонимы на таблицу HR.Employees 
-- Почему в результирующем наборе 8 строк?

 SELECT e.empid ,e.lastname as empname,e.title,e.mgrid, m.lastname as mgrname
  FROM hr.employees AS e
  JOIN hr.employees AS m
  ON e.mgrid=m.empid; -- self-join


-- 3. ВСЕ сотрудники и их руководители (empid = 1 не имеет руководителя - CEO)
  SELECT e.empid ,e.lastname as empname,e.title,e.mgrid, m.lastname as mgrname
   FROM hr.employees AS e
  LEFT OUTER JOIN hr.employees AS m
  ON e.mgrid=m.empid;
  
-- 4. CROSS JOIN - все возможные варианты имя + фамилия
SELECT e1.firstname, e2.lastname
FROM hr.employees AS e1 
CROSS JOIN hr.employees AS e2;

-- 5. * self-join для сравнения строк в одной таблице
-- Заказчики из одного города (все возможные комбинации)

SELECT
    s1.city,
    s1.contactname as cust1,
    s2.contactname as cust2
FROM sales.customers as s1
INNER JOIN sales.customers as s2 
ON s1.custid > s2.custid -- чтобы не сравнивать одинаковых
AND s1.city = s2.city    -- composite
ORDER BY city, cust1, cust2;