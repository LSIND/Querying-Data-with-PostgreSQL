---------------------------------------------------------------------
-- LAB 10
--
-- Exercise 3
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос, возвращающий custid и contactname из таблицы Sales.Customers. 
-- Добавьте дополнительный вычисляемый столбец lastorderdate: дата последнего заказа из таблицы Sales.Orders конкретного заказчика.
--
-- Результирующий набор сравните с Lab Exercise3 - Task1 Result.txt
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, возвращающий информацию обо всех заказчиках, которые ничего не купили.
-- Используйте предикат EXISTS.
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
--
-- Почему не требовалась проверка на NULL?
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, возвращающий custid и contactname из таблицы Sales.Customers.
-- Выведите только тех заказчиков, которые оформили заказ(ы) с 1 Апреля 2023, а цена продукта в этих заказах больше 100 у.е.
--
-- Результирующий набор сравните с Lab Exercise3 - Task3 Result.txt
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Task 4 ***
-- 
-- Нарастающие итоги - итоги, накапливающие значения во времени.
-- Напишите SELECT-запрос, возвращающий следующую информацию по каждому году продаж:
--  Год продаж 
--  Общее количество продаж за год 
--  Нарастающий итог по продажам. Например, за первый год работы (2021) вернется общее количество продаж за год, за следующий год (2022) - сумма продаж за 2022 + предыдущий год и т.д.
-- В SELECT-запросе три вычисляемых столбца:
--  orderyear - год от даты заказа таблицы sales.orders
--  totalsales - общее количество продаж, цена * количество товаров из таблицы sales.orderdetails
--  runsales - нарастающий итог (корреляционный подзапрос) 
--
-- Результирующий набор сравните с Lab Exercise3 - Task4 Result.txt
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Task 5
--
-- Удалить заказ, созданный в Exercise 2 - Task 3
---------------------------------------------------------------------

DELETE FROM sales.orders
WHERE custid is NULL;