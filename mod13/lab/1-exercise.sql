---------------------------------------------------------------------
-- LAB 13
--
-- Exercise 1
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, выводящий столбцы orderid, orderdate, val, а также вычисляемый столбец rowno из представления sales.ordervalues. 
-- Для вывода rowno использовать функцию ROW_NUMBER: пронумеровать все строки результата. Упорядочить номера строк по дате заказа.
--
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Task 2
-- 
-- Скопируйте запрос Task 1 и добавьте еще один вычисляемый столбец rankno. 
-- Вывести только дату заказа (без времени).
-- Для вывода rankno использовать функцию RANK: проранжировать все строки набора по дате заказа.
--
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
--
-- В чем отличие функций RANK и ROW_NUMBER?
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, выводящий столбцы orderid, orderdate, custid, val, а также вычисляемый столбец orderrankno из представления sales.ordervalues.
-- Столбец orderrankno отображает ранг кажого покупателя, относительно суммы его покупок (от наибольшей к наименьшей). 
--
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, выводящий столбцы custid и val из sales.ordervalues. Добавьте два вычисляемых столбца: 
--  orderyear - год от даты orderdate  
--  orderrankno - ранг с разбиением по заказчику и году, упорядоченный по номеру заказа по убыванию
--
-- Результирующий набор сравните с Lab Exercise1 - Task4 Result.txt
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Task 5
-- 
-- Скопируйте запрос Task 4. Отобразите только те заказы, где ранг равен 1 или 2.
-- Помните, что оконные функции нельзя применять в конструкции WHERE 
--
-- Результирующий набор сравните с Lab Exercise1 - Task5 Result.txt
---------------------------------------------------------------------

