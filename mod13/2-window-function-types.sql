-------------------------------------------------------
--
-- Модуль 13
-- Демонстрация 2
-- Обзор оконных функций
--
-------------------------------------------------------

-- 1. Создание представлений для демонстрации
-- Список всех продуктов: имя, категория, цена
DROP VIEW IF EXISTS production.categorizedproducts;
CREATE VIEW production.categorizedproducts
AS
    SELECT  C.categoryid AS CatID, C.categoryname AS CatName,
            P.productname AS ProdName,
            P.unitprice AS UnitPrice
    FROM   production.categories AS C
            INNER JOIN production.products AS P
			ON C.categoryid=P.categoryid;

SELECT * FROM production.categorizedproducts;

-- Общая сумма продаж по каждому сотруднику в каждый год его работы
DROP VIEW IF EXISTS sales.ordersbyemployeeyear;
CREATE VIEW sales.ordersbyemployeeyear
AS
SELECT emp.empid AS employee, EXTRACT(YEAR FROM ord.orderdate) AS orderyear, SUM(od.qty * od.unitprice) AS totalsales
FROM hr.employees AS emp
	JOIN sales.orders AS ord ON emp.empid = ord.empid
	JOIN sales.orderdetails AS od ON ord.orderid = od.orderid
GROUP BY emp.empid, orderyear;

SELECT * FROM sales.ordersbyemployeeyear;

-- Существующее представление: сводная информация по кол-ву купленных продуктов за месяц для каждого заказчика.
SELECT custid, ordermonth, qty, to_char(ordermonth, 'Month YYYY') FROM sales.custorders;


-------------------------------------------------------
-- 2: Оконные функции агрегирования
-------------------------------------------------------

-- Общее количество продуктов по заказчику (одно значение на группу)
-- Сумма количества по partition (Custid)
SELECT  custid, to_char(ordermonth, 'Month YYYY') as mo_yyyy, qty,
        SUM(qty) OVER ( PARTITION BY custid ) AS totalpercust
FROM  sales.custorders
ORDER BY custid, ordermonth;

-- Сумма, среднее и общее количество по категории (partition - catid)
SELECT catid, catname, prodname, unitprice,
	SUM(unitprice) OVER(PARTITION BY catid) AS Total,
	AVG(unitprice) OVER(PARTITION BY catid) AS Average,
	COUNT(unitprice) OVER(PARTITION BY catid) AS ProdsPerCat
FROM production.categorizedproducts
ORDER BY catid; 

-- Нарастающий итог по месяцам продаж для каждого заказчика
SELECT  custid, to_char(ordermonth, 'Month YYYY') as mo_yyyy, qty,
        SUM(qty) OVER ( PARTITION BY custid ORDER BY  ordermonth ) AS totalpercust
FROM  sales.custorders
ORDER BY custid, ordermonth;

-- Нарастающий итог, как сумма текущего и одного предыдущего значения
SELECT  custid, to_char(ordermonth, 'Month YYYY') as mo_yyyy, qty,
        SUM(qty) OVER ( PARTITION BY custid ORDER BY  ordermonth
         ROWS BETWEEN 1 PRECEDING AND CURRENT ROW ) AS totalpercust
FROM  sales.custorders
ORDER BY custid, ordermonth;


-- ** Скользящее среднее
-- Среднее как сумма значений текущего месяца, предыдущего и последующего.
-- (округляем до 2х знаков после запятой)
SELECT  mo_yyyy, totalpercust, 
ROUND(AVG(totalpercust) OVER (order by mo_yyyy rows between 1 preceding and 1 following), 2)  as roll_avg
FROM
(SELECT to_char(ordermonth, 'Month YYYY') as mo_yyyy,
        SUM(qty) as totalpercust -- общее количество за месяц
FROM sales.custorders 
GROUP BY ordermonth) t
order by mo_yyyy;

-- ** string_agg
-- нарастающий итог, 'добавляющий' кол-во купленных товаров через запятую (строки) каждого месяца
-- для каждого покупателя
SELECT  custid,
        to_char(ordermonth, 'Month YYYY') mo_yyyy,
        qty,
        string_agg(qty::varchar, ', ') OVER ( PARTITION BY custid ORDER BY ordermonth ) AS totalpercust
FROM  sales.custorders
ORDER BY custid, ordermonth;


-------------------------------------------------------
-- 3: Функции ранжирования (ORDER BY - обязателен в OVER)
-------------------------------------------------------

-- RANK() по цене (ранжирование ВСЕХ продуктов по цене)
SELECT catid, catname, prodname, unitprice,
	RANK() OVER(ORDER BY unitprice DESC) AS PriceRank
FROM production.categorizedproducts
ORDER BY PriceRank; 

-- OVER с ORDER BY и PARTITION BY по имени категории
-- ранжирование продуктов по цене в каждой категории
SELECT catid, catname, prodname, unitprice,
	RANK() OVER(PARTITION BY catid ORDER BY unitprice DESC) AS PriceRank
FROM production.categorizedproducts
ORDER BY catid; 

-- Сравнение RANK() и DENSE_RANK()
SELECT catid, catname, prodname, unitprice,
	RANK() OVER(PARTITION BY catid ORDER BY unitprice DESC) AS PriceRank,
	DENSE_RANK() OVER(PARTITION BY catid ORDER BY unitprice DESC) AS DensePriceRank
FROM production.categorizedproducts
ORDER BY catid; 

-- Функция Row_Number() - нумерация строк
SELECT catid, catname, prodname, unitprice,
	ROW_NUMBER() OVER(PARTITION BY catid ORDER BY unitprice DESC) AS RowNumber
FROM production.categorizedproducts
ORDER BY catid; 

-- Функция NTILE(N) - разделяет значения в категориях на n частей (распределение значений)
-- продукты каждого типа в ценовой категории 1 (дороже) или 2 (дешевле)
SELECT catid, catname, prodname, unitprice,
	NTILE(2) OVER(PARTITION BY catid ORDER BY unitprice DESC) AS NT
FROM production.categorizedproducts
ORDER BY catid, NT; 

-- Функция NTH_VALUE(column, N) - возвращает N-й элемент в окне или партиции
-- возвращает второй по дороговизне продукт в данной категории
SELECT catid, catname, prodname, unitprice,
	NTH_VALUE(prodname,2) OVER(PARTITION BY catid ORDER BY unitprice DESC RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING) AS NT
FROM production.categorizedproducts
ORDER BY catid, unitprice DESC; 


-------------------------------------------------------
-- 4: Функции сдвига
-------------------------------------------------------

-- LAG для сравнения продаж сотрудника в текущем году с предыдущим годом
SELECT employee, orderyear, totalsales AS currentsales,
      LAG(totalsales, 1,0.) OVER (PARTITION BY employee ORDER BY orderyear) AS previousyearsales,
      totalsales - LAG(totalsales, 1,0.) OVER (PARTITION BY employee ORDER BY orderyear) AS diff
      FROM sales.ordersbyemployeeyear
ORDER BY employee, orderyear;

-- FIRST_VALUE - первое значение в данной категории
-- сравниваем сумму продаж каждого сотрудника в определенном году с самым первым годом продаж данного сотрудника
SELECT employee,
      orderyear,
      totalsales AS currentsales,
      FIRST_VALUE(totalsales) OVER (PARTITION BY employee ORDER BY orderyear) AS firstvalue,
      (totalsales - FIRST_VALUE(totalsales) OVER (PARTITION BY employee ORDER BY orderyear)) AS salesdiffsincefirstyear
  FROM sales.ordersbyemployeeyear
ORDER BY employee, orderyear;



-- 5. Удаление представлений
DROP VIEW IF EXISTS production.categorizedproducts;
DROP VIEW IF EXISTS sales.ordersbyemployeeyear;
DROP VIEW IF EXISTS sales.ordersbyemployeeyear;