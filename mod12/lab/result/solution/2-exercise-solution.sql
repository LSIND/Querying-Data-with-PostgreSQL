---------------------------------------------------------------------
-- LAB 12
--
-- Exercise 2 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий productid и productname из таблицы production.products. 
-- Также для каждого продукта получите номера двух последних оформленных заказов, в которых встречаются эти продукты
-- Для корреляционного подзапроса использовать CROSS JOIN LATERAL. Упорядочить по productid.
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------

SELECT p.productid, p.productname, o.orderid
FROM production.products AS p
CROSS JOIN LATERAL 
(
	SELECT d.orderid	
	FROM sales.orderdetails AS d
	WHERE d.productid = p.productid
	ORDER BY d.orderid DESC
	LIMIT 2
) AS o
ORDER BY p.productid;

---------------------------------------------------------------------
-- Task 2
-- 
-- Выполните код, чтобы создать табличную функцию public.fnGetTop3ProductsForCustomer.
-- Функция выводит 3 самых дорогих покупки для конркетного заказчика
-- Получите данные из этой функции для заказчика N = 1.
-- 
-- Напишите SELECT-запрос, выводящий custid и contactname из таблицы sales.customers. 
-- Используя CROSS JOIN LATERAL к функции fnGetTop3ProductsForCustomer получить productid, productname, и totalsalesamount для каждого заказчика.
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt
---------------------------------------------------------------------

-- Функция
CREATE OR REPLACE FUNCTION public.fnGetTop3ProductsForCustomer
(customer INT)
RETURNS TABLE (productid int, productname varchar, totalsalesamount numeric)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN query 
	SELECT d.productid, MAX(p.productname)::varchar AS productname, 
	SUM(d.qty * d.unitprice) AS totalsalesamount	
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
INNER JOIN production.products AS p ON p.productid = d.productid
WHERE o.custid = customer
GROUP BY d.productid
ORDER BY totalsalesamount DESC
LIMIT 3;
END; $$ 


-- Проверка функции
SELECT productid, productname, totalsalesamount 
FROM public.fnGetTop3ProductsForCustomer(1);

-- Запрос
SELECT c.custid, c.contactname, p.productid, p.productname, p.totalsalesamount
FROM sales.customers AS c
CROSS JOIN LATERAL public.fnGetTop3ProductsForCustomer(c.custid) AS p
ORDER BY c.custid;

---------------------------------------------------------------------
-- Task 3
-- 
-- Скопируйте SELECT-запрос Task 2 и замените CROSS JOIN LATERAL на LEFT JOIN LATERAL ON TRUE.
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
---------------------------------------------------------------------

SELECT c.custid, c.contactname, p.productid, p.productname, p.totalsalesamount
FROM sales.customers AS c
LEFT JOIN LATERAL public.fnGetTop3ProductsForCustomer(c.custid) AS p ON TRUE
ORDER BY c.custid;


---------------------------------------------------------------------
-- Task 4
--
-- Скопируйте SELECT-запрос Task 3, добавьте к результату заказчиков, которые ничего не купили.
-- 
-- Результирующий набор сравните с Lab Exercise2 - Task4 Result.txt
--
-- В чем отличие операторов CROSS JOIN LATERAL и LEFT JOIN LATERAL ON TRUE?
---------------------------------------------------------------------

SELECT c.custid, c.contactname, p.productid, p.productname, p.totalsalesamount
FROM sales.customers AS c
LEFT JOIN LATERAL public.fnGetTop3ProductsForCustomer(c.custid) AS p ON TRUE
WHERE p.productid IS NULL
ORDER BY c.custid;

---------------------------------------------------------------------
-- Task 5
-- 
-- Удалить табличную функцию fnGetTop3ProductsForCustomer
---------------------------------------------------------------------

DROP FUNCTION IF EXISTS public.fnGetTop3ProductsForCustomer;