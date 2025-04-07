---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 5 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос к таблице sales.customers и выведите: country, city и вычисляемый столбец noofcustomers - количество заказчиков.
-- Получите группирующие наборы по столбцам (country,  city), только country, только city, и общий столбец без группы ()
--
-- Результирующий набор сравните с Lab Exercise5 - Task1 Result.txt. 
---------------------------------------------------------------------

SELECT country, city, COUNT(custid) AS noofcustomers
FROM sales.customers
GROUP BY
GROUPING SETS 
(
	(country, city),
	(country),
	(city),
	()
) 
ORDER BY country,city; -- 160 строк 


---------------------------------------------------------------------
-- Task 2
--
-- Необходимо рассчитать среднюю стоимость доставки (freight) из таблицы sales.orders с разбивкой:
---- 
---- По странам и перевозчикам (shipcountry, shipperid),
---- Только по странам (shipcountry),
---- Общий итог.
--
-- Упорядочить по shipcountry, shipperid.
--
-- Результирующий набор сравните с Lab Exercise5 - Task2 Result.txt. 
---------------------------------------------------------------------

SELECT 
    shipcountry,
    shipperid,
    ROUND(AVG(freight),2) AS avgfreight
FROM sales.orders
GROUP BY ROLLUP (shipcountry, shipperid)
ORDER BY shipcountry, shipperid;  -- 85 строк


---------------------------------------------------------------------
-- Task 3
-- 
-- Скопируйте запрос Task 2 и замените ROLLUP на CUBE.
--
-- Результирующий набор сравните с Lab Exercise5 - Task3 Result.txt. Сколько строк вернул запрос?
--
-- Какие различия ROLLUP и CUBE?
---------------------------------------------------------------------

SELECT 
    shipcountry,
    shipperid,
    ROUND(AVG(freight),2) AS avgfreight
FROM sales.orders
GROUP BY CUBE (shipcountry, shipperid)
ORDER BY shipcountry, shipperid; -- 88 строк


---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, рассчитывающий общую стоимость продуктов (unitprice), дешевле 20 у.е., а также количество продуктов в каждой группе, с разбивкой:
---- По категориям (categoryname),
---- По поставщикам (companyname),
---- По всем возможным комбинациям этих полей (включая общий итог).
--
-- Добавить два столбца, использующих функцию GROUPING по столбцам categoryname и companyname.
-- Функция GROUPING() возвращает 1, если значение соответствует итоговой строке, и 0 — если это обычное значение.
---- В случае, если итог по категориям - выводить CATEGORY
---- В случае, если итог по поставщикам - выводить SUPPLIER
---- Во всех остальных случаях выводить - (прочерк)
--
-- Результирующий набор сравните с Lab Exercise5 - Task4 Result.txt. 
---------------------------------------------------------------------

SELECT
    CASE WHEN GROUPING(c.categoryname)=0 THEN 'CATEGORY'
	 ELSE '-'
END AS iscategorytotal,
    CASE WHEN GROUPING(s.companyname)=0 THEN 'SUPPLIER'
	 ELSE '-'
END AS issuppliertotal,
    c.categoryname,
    s.companyname,
    COUNT(productid) AS productcount,
    SUM(unitprice) AS totalprice    
FROM production.products AS p 
INNER JOIN production.categories as c
ON p.categoryid = c.categoryid
INNER JOIN production.suppliers as s
ON p.supplierid = s.supplierid
WHERE unitprice < 20
GROUP BY CUBE (c.categoryname, s.companyname)
ORDER BY 
    c.categoryname, s.companyname;