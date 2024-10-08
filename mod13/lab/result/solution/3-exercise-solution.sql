---------------------------------------------------------------------
-- LAB 13
--
-- Exercise 3 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий столбцы custid, orderid, orderdate, val из представления sales.ordervalues. 
-- Добавьте вычисляемый столбец percoftotalcust, содержащий отношение суммы одного заказа к итоговой сумме покупок конкретного покупателя (в процентах)
--
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------

SELECT 
	custid,
	orderid, orderdate,
	val,
	(100 * val / SUM(val) OVER (PARTITION BY custid))::numeric(5,2) AS percoftotalcust
FROM sales.ordervalues
ORDER BY custid, percoftotalcust DESC;

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос Task 1, добавьте к нему вычисляемый столбец runval - нарастающий итог по сумме покупок для каждого заказчика с упорядочиванием по дате заказа и номеру заказа
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
---------------------------------------------------------------------

SELECT 
	custid,
	orderid, orderdate,
	val,
	(100 * val / SUM(val) OVER (PARTITION BY custid))::numeric(5,2) AS percoftotalcust,
    SUM(val) OVER (PARTITION BY custid 
				   ORDER BY orderdate, orderid 
				   ROWS BETWEEN UNBOUNDED PRECEDING
                         AND CURRENT ROW) AS runval
FROM sales.ordervalues
ORDER BY custid, orderid;


---------------------------------------------------------------------
-- Task 3
-- 
-- Скопируйте CTE SalesMonth2007 CTE из exercise 2 - Task 3. Напишите SELECT-запрос к CTE и получите столбцы monthno и val, а также два вычисляемых столбца:
--  avglast3months - среднее количество продаж за предыдущие три месяца (относительно текущей строки) с использованием оконной функции агрегирования AVG.
--  ytdval - совокупный объем продаж до и включая текущий месяц
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt 
-- Сравните данные в столбце avglast3months с результатом exercise 2 - Task 3.
---------------------------------------------------------------------

WITH SalesMonth2007 AS
(
	SELECT
		EXTRACT(MONTH FROM orderdate) AS monthno,
		SUM(val) AS val
	FROM sales.ordervalues
	WHERE orderdate >= '20070101' AND orderdate < '20080101'
	GROUP BY monthno
)
SELECT
    monthno::int,
	val,
	COALESCE(AVG(val) OVER (ORDER BY monthno ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING), 0)::numeric(10,3) AS avglast3months,
	SUM(val) OVER (ORDER BY monthno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ytdval
FROM SalesMonth2007;



---------------------------------------------------------------------
-- Task 4 **
-- 
-- Найти разницу в суммах, потраченных клиентами из Германии за зиму (декабрь, январь, февраль) каждого года
-- Вывести столбцы: custid, companyname, yyyy_w (год), total (общая сумма покупок за зиму данного года)
-- и msg (сообщение): 
---- Вывести сообщение 'Вы потратили на $X больше/меньше, чем прошлой зимой'
---- Если предыдущего года нет - вывести сообщение 'Прошлой зимой Вы еще не были нашим клиентом'
--
-- Результирующий набор сравните с Lab Exercise3 - Task4 Result.txt 
---------------------------------------------------------------------


SELECT custid, companyname, yyyy as yyyy_w, total, -- LAG(total, 1) OVER(Partition by custid ORDER BY yyyy),
CASE
   WHEN LAG(total, 1) OVER(Partition by custid ORDER BY yyyy) IS NULL THEN 'Прошлым летом Вы еще не были нашим клиентом'
   WHEN total - LAG(total, 1 ,0::money) OVER(Partition by custid ORDER BY yyyy) > 0::money 
         THEN 'Вы потратили на ' || (total - LAG(total, 1 ,0::money) OVER(Partition by custid ORDER BY yyyy))::varchar || ' больше, чем прошлым летом'
   ELSE 'Вы потратили на ' || TRANSLATE((total - LAG(total, 1 ,0::money) OVER(Partition by custid ORDER BY yyyy))::varchar, '()', '') || ' меньше, чем прошлым летом'
END AS msg
FROM 
(
SELECT c.custid, c.companyname, EXTRACT(YEAR from orderdate) AS yyyy,
        SUM(qty*unitprice) as total
FROM sales.orders AS o 
JOIN sales.orderdetails as od ON o.orderid = od.orderid  
JOIN  sales.customers as c ON c.custid = o.custid 
WHERE EXTRACT(MONTH from orderdate) IN (12, 1, 2) -- зима
      AND c.country = 'Germany'
GROUP BY c.custid, c.companyname, EXTRACT(YEAR from orderdate) ) AS totals_seasons
ORDER BY custid, yyyy_w;