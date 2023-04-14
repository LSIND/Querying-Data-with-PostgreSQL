---------------------------------------------------------------------
-- LAB 11
--
-- Exercise 3
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос аналогичный exercise 2 - task 1, но с использованием CTE. Имя CTE - ProductBeverages 
-- Используйте inline-псевдонимы
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос к Sales.OrderValues и получите номер каждого заказчика и общую сумму покупок в 2008 году.
-- Определите CTE с именем c2008 с использованием внешних псевдонимов custid и salesamt2008. 
-- Соедините CTE с таблицей Sales.Customers и получите custid, contactname из Sales.Customers и salesamt2008 из c2008 CTE.
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, выводящий custid и contactname из таблицы Sales.Customers. Также получите вычисляемые столбцы:
--  salesamt2008 - Общее количество продаж за 2008
--  salesamt2007 - Общее количество продаж за 2007 
--  percentgrowth - процентный рост продаж 2008 года к 2007 (Если percentgrowth = NULL- отобразить 0). Упорядочить результат по этому столбцу
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt.
---------------------------------------------------------------------
