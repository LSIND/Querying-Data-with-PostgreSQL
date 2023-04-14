---------------------------------------------------------------------
-- LAB 11
--
-- Exercise 2
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос к наследуемой таблице, получите productid и productname. 
-- Верните только те строки, где значение в столбце pricetype равно "high". 
-- В качестве внутреннего запроса используйте запрос из exercise 1 - task 4 (исправленный). Не забудьте использовать псевдонимы
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, выводящий столбец custid и два вычисляемых столбца: 
--  totalsalesamount - сумма покупок на каждого покупателя, 
--  avgsalesamount - средняя сумма покупок на каждого покупателя.
-- Определите наследуемую таблицу как JOIN-запрос к Sales.Orders и Sales.OrderDetails и к напишите SELECT-запрос с агрегатами. 
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, выводящий следующие столбцы: 
--  orderyear - год от даты заказа
--  curtotalsales - общее количество продаж за текущий год
--  prevtotalsales - общее количество продаж за предыдущий год
--  percentgrowth - отношение роста продаж текущего года к предыдущему (в процентах) 
-- Используйте две наследуемые таблицы. Получить год и общую сумму продаж можно из существующего представления Sales.OrderValues (столбец val объекмы продаж).
-- 2006 год - первый год работы магазина, но он также должен быть включен в результат.
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
---------------------------------------------------------------------

