---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 2
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


---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос из Task 1. Добавьте столбцы: общее количество позиций в заказе и средняя цена товаров в заказе
-- Использовать псевдонимы nooforderlines и avgsalesamountperorderline соответственно.
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt. 
---------------------------------------------------------------------


---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, возвращающий общую сумму продаж (qty * unitprice) по месяцам.
-- Определите вычисляемый столбец yearmonthno (YYYY-MM) по столбцу orderdate из sales.orders. 
-- Упорядочить по yearmonthno по возрастанию.
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt. 
---------------------------------------------------------------------




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
---------------------------------------------------------------------

