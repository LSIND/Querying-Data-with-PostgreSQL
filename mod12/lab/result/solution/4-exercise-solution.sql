---------------------------------------------------------------------
-- LAB 12
--
-- Exercise 4 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Выполните запрос ниже для создания представления sales.custgroups
-- Данное представление содержит информацию о заказчиках: номер заказчика, страну и группу (A, B или С) в зависимости от порядкового номера
--
---------------------------------------------------------------------

CREATE VIEW sales.custgroups AS
SELECT 
	custid,
    CASE 
       WHEN custid % 3 = 0 THEN 'A'
       WHEN custid % 3 = 1 THEN 'B'
       ELSE 'C'
	END AS custgroup,
	country
FROM Sales.Customers;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к представлению sales.custgroups, который вернет количество заказчиков каждой группы в каждой стране. 
-- Упорядочить по стране, затем по группе.
--
-- Результирующий набор сравните с Lab Exercise4 - Task2 Result.txt
---------------------------------------------------------------------

SELECT country, custgroup, COUNT(custid) AS customers
    FROM sales.custgroups
    GROUP BY country, custgroup
    ORDER BY country, custgroup;


---------------------------------------------------------------------
-- Task 3
--
-- Превратите SELECT-запрос из Task 2 в горизонтальное отображение. Первым столбцом явлется country. 
-- С помощью функции crosstab распределите вправо 3 столбца со значением из группы (A, B или С), 
-- на пересечении страны и группы поставьте количество заказчиков каждой группы в стране.
--
-- Если заказчиков определенной группы нет в стране - crosstab выставит на пересечении NULL. Заменить на 0.
--
-- Результирующий набор сравните с Lab Exercise4 - Task3 Result.txt.
---------------------------------------------------------------------

-- Установите расширение в БД, содержащее функцию crosstab:
CREATE EXTENSION IF NOT EXISTS tablefunc;

-- Запрос
SELECT country, COALESCE("A", 0) AS "A",
COALESCE("B", 0) AS "B", COALESCE("C", 0) AS "C"
FROM crosstab(
    $$ 
    SELECT country, custgroup, COUNT(custid) AS customers
    FROM sales.custgroups
    GROUP BY country, custgroup
    ORDER BY country, custgroup
    $$,
    $$
    SELECT DISTINCT custgroup
    FROM sales.custgroups
    ORDER BY custgroup
    $$
) AS ct (
   country TEXT,  -- основной столбец   
   "A" INT,         -- значения, совпадающие с результатом запроса 2 (порядок нужно сохранить)
   "B" INT, 
   "C" INT
);


---------------------------------------------------------------------
-- Task 4
--
-- Для каждого покупателя определите общую сумму покупок в каждой категории. Все категории должны отображаться как отдельные столбцы:
--  Основным столбцом является custid из таблицы sales.orders,
--  Столбцы, распределенные вправо: названия категорий продуктов,
--  На пересечении определенного заказчика и определенной категории должна стоять сумма его покупок.
--
-- Результирующий набор сравните с Lab Exercise4 - Task4 Result.txt.
---------------------------------------------------------------------

SELECT *
FROM crosstab(
    $$ 
    SELECT
		o.custid,		
		c.categoryname,
        SUM(d.qty * d.unitprice) AS salesvalue
	FROM Sales.Orders AS o
	INNER JOIN sales.orderdetails AS d ON o.orderid = d.orderid
	INNER JOIN production.products AS p ON p.productid = d.productid
	INNER JOIN production.categories AS c ON c.categoryid = p.categoryid
    GROUP BY o.custid, c.categoryname
    ORDER BY o.custid, c.categoryname
    $$,
    $$
    SELECT DISTINCT categoryname
    FROM production.categories
    ORDER BY categoryname
    $$
) AS ct (
   custid INT,
   "Beverages" NUMERIC,        
   "Condiments" NUMERIC, 
   "Confections" NUMERIC,
   "Dairy Products" NUMERIC,
   "Grains/Cereals" NUMERIC, 
   "Meat/Poultry" NUMERIC,
   "Produce" NUMERIC, 
   "Seafood" NUMERIC
);


---------------------------------------------------------------------
-- Task 5
-- 
-- Выполните код ниже для удаления представления sales.custgroups, а также расширения tablefunc
---------------------------------------------------------------------

DROP VIEW IF EXISTS sales.custgroups;
DROP EXTENSION IF EXISTS tablefunc;