---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 2 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий уникальных покупателей (столбец custid) из таблицы sales.orders. 
-- Примените фильтр к заказам: оформлены в феврале 2023.
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt.
---------------------------------------------------------------------

SELECT DISTINCT custid
FROM sales.orders
WHERE 
	orderdate >= '20230201'
	AND orderdate < '20230301'
ORDER BY custid;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос со следующими столбцами:
--  Текущая дата и время
--  Первая дата текущего месяца
--  Последняя дата текущего месяца
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt. 
---------------------------------------------------------------------

SELECT 
	CURRENT_TIMESTAMP AS currentts,
	date_trunc('month', current_date)::date AS firstday,
    (date_trunc('month', now()) + interval '1 month - 1 day')::date AS lastday; 

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос к таблице sales.orders и получите orderid, custid, orderdate (только дата, без времени). 
-- Выведите заказы, которые были оформлены в последние 5 дней каждого месяца.
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt.
---------------------------------------------------------------------

SELECT 
	orderid, custid, orderdate::date
    , date_part(
		'day', (date_trunc('month', orderdate) + interval '1 month - 1 day') - orderdate
	)
FROM sales.orders
WHERE 
	date_part(
		'day', (date_trunc('month', orderdate) + interval '1 month - 1 day') - orderdate
	) < 5


SELECT 
	orderid, custid, orderdate::date
FROM sales.orders
WHERE EXTRACT(DAY FROM orderdate) >= EXTRACT(DAY FROM 
    (DATE_TRUNC('MONTH', orderdate) + INTERVAL '1 MONTH - 5 DAYS')::date
);


---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос к таблицам sales.orders и sales.orderdetails, получите уникальные значения столбца productid. 
-- Выведите только те продукты, которые были куплены в первые 10 недель 2022 года.
--
-- Результирующий набор сравните с Lab Exercise2 - Task4 Result.txt.
---------------------------------------------------------------------

SELECT DISTINCT
	d.productid
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d 
ON d.orderid = o.orderid
WHERE 
	EXTRACT(week FROM orderdate) <= 10 
	AND orderdate >= '20220101' AND orderdate < '20220101'::date + '70 days'::interval
ORDER BY d.productid;


---------------------------------------------------------------------
-- Task 5
-- 
-- Напишите SELECT-запрос к таблице sales.orders, который выводит номер заказа, дату заказа и дату отправки,
-- а также вычисляемый стоблец - время обработки заказа (разница между shippeddate и orderdate).
-- Вычисляемый столбец:
---- "Быстрая обработка" — если время обработки меньше 3 дней,
---- "Стандартная обработка" — если время обработки от 3 до 7 дней,
---- "Длительная обработка" — если время обработки больше 7 дней,
---- Если заказ не доставлен (shippeddate отсутствует), категория должна быть "Обработка не завершена".
-- Упорядочить по номеру заказа по убыванию.
--
-- Результирующий набор сравните с Lab Exercise2 - Task5 Result.txt.
---------------------------------------------------------------------

SELECT 
    orderid,
    orderdate,
    shippeddate,
    CASE
        WHEN shippeddate IS NULL THEN 'Обработка не завершена'
        WHEN shippeddate - orderdate < INTERVAL '3 days' THEN 'Быстрая обработка'
        WHEN shippeddate - orderdate <= INTERVAL '7 days' THEN 'Стандартная обработка'
        ELSE 'Длительная обработка'
    END AS processing_time
FROM sales.orders
ORDER BY orderid DESC;
