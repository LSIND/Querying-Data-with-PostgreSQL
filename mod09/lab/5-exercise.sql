---------------------------------------------------------------------
-- LAB 09
--
-- Exercise 5
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос к таблице sales.customers и выведите: country, city и вычисляемый столбец noofcustomers - количество заказчиков.
-- Получите группирующие наборы по столбцам (country,  city), только country, только city, и общий столбец без группы ()
--
-- Результирующий набор сравните с Lab Exercise5 - Task1 Result.txt.  
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к представлению sales.ordervalues и получите следующие столбцы:
--  orderyear - год от даты orderdate
--  ordermonth - месяц от даты orderdate
--  orderday - день от даты orderdate 
--  salesvalue - общее количество продаж по val
-- Верните все возможные группируюшие наборы по orderyear, ordermonth, и orderday.
--
-- Результирующий набор сравните с Lab Exercise5 - Task2 Result.txt. Сколько строк вернул запрос?
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 3
-- 
-- Скопируйте запрос Task 2 и замените CUBE на ROLLUP.
--
-- Результирующий набор сравните с Lab Exercise5 - Task3 Result.txt. Сколько строк вернул запрос?
--
-- В чем отличие ROLLUP и CUBE?
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 4 *
-- 
-- Напишите SELECT-запрос к представлению sales.ordervalues и получите следующие столбцы:
--  groupid - вычисляемый столбец по orderyear и ordermonth с помощью функции GROUPING (год и месяц в качестве входных параметров)
--  orderyear - год от даты orderdate
--  ordermonth - месяц от даты orderdate
--  salesvalue - сумма продаж по столбцу val
-- Поскольку год и месяц образуют иерархию, верните все группирующие наборы 
-- Результат отсортируйте по groupid, orderyear, ordermonth.
--
-- Результирующий набор сравните с Lab Exercise5 - Task4 Result.txt. 
---------------------------------------------------------------------

