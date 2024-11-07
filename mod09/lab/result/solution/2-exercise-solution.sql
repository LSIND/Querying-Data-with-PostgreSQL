---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 2 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий номер заказа, дату заказа и итоговую сумму заказа из таблицы sales.orders. 
-- Для итоговой суммы требуется умножить количество позиций в заказе (qty) на цену одного товара (unitprice) из таблицы sales.orderdetails
-- Использовать псевдоним salesmount на вычисляемый столбец. Отсортировать результат по итоговой сумме по убыванию.
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------
SELECT o.orderid, o.orderdate, SUM(d.qty * d.unitprice) AS salesamount
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
GROUP BY o.orderid, o.orderdate
ORDER BY salesamount DESC;

---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос из Task 1. Добавьте столбцы: общее количество позиций в заказе и средняя цена товаров в заказе
-- Использовать псевдонимы nooforderlines и avgsalesamountperorderline соответственно.
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt. 
---------------------------------------------------------------------
SELECT
	o.orderid, o.orderdate, SUM(d.qty * d.unitprice) AS salesamount, 
	COUNT(*) AS noofoderlines, 
	AVG(d.qty * d.unitprice) AS avgsalesamountperorderline
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d
ON d.orderid = o.orderid
GROUP BY o.orderid, o.orderdate
ORDER BY salesamount DESC;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, возвращающий общую сумму продаж (qty * unitprice) по месяцам.
-- Определите вычисляемый столбец yearmonthno (YYYY-MM) по столбцу orderdate из sales.orders. 
-- Упорядочить по yearmonthno по возрастанию.
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt. 
---------------------------------------------------------------------

SELECT to_char(orderdate, 'YYYY-MM') AS yearmonthno,
	SUM(d.qty * d.unitprice) AS saleamountpermonth
FROM sales.orders AS o
INNER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
GROUP BY to_char(orderdate, 'YYYY-MM')
ORDER BY yearmonthno;


---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, возвращающий всех заказчиков (91) и их общую сумму покупок, самый дорогой заказ и общее количество купленных товаров.
--
-- Включить custid и contactname из sales.customers и четыре вычисляемых столбца:
--  totalsalesamount - общая сумма покупок
--  maxsalesamountperorderline - общая сумма самого дорогого заказа
--  numberofrows - общее количество строк (COUNT(*))
--  numberoforderlines - общее количество заказов
-- 
-- Упорядочить по столбцу totalsalesamount по убыванию.
--
-- Результирующий набор сравните с Lab Exercise2 - Task4 Result.txt. 
--
-- custid 22 и 57 содержат значение NULL в totalsalesamount и maxsalesamountperorderline. 
-- А что содержится в столбцах numberofrows и numberoforderlines для этих покупателей? Почему?

-- Покупатели с номерами 22 и 57 еще ни разу не совршали покупки в нашем магазине, поэтому в суммах покупок стоит NULL.
-- В столбце numberoforderlines (кол-во заказов) стоит значение 0.
-- В столбце numberofrows (общее кол-во строк) - 1. У других же покупателей, которые совершали покупки, numberofrows = numberoforderlines.
---------------------------------------------------------------------
SELECT 
	c.custid, c.contactname, 
	SUM(d.qty * d.unitprice) AS totalsalesamount,
	MAX(d.qty * d.unitprice) AS maxsalesamountperorderline, 
	COUNT(*) AS numberofrows,
	COUNT(o.orderid) AS numberoforderlines
FROM sales.customers AS c
LEFT OUTER JOIN sales.orders AS o ON o.custid = c.custid
LEFT OUTER JOIN sales.orderdetails AS d ON d.orderid = o.orderid
GROUP BY c.custid, c.contactname
ORDER BY totalsalesamount DESC;