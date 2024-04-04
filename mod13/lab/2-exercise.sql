---------------------------------------------------------------------
-- LAB 13
--
-- Exercise 2
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Определите CTE с именем OrderRows, которое выбирает orderid, orderdate, val из представления Sales.OrderValues. 
-- Добавьте вычисляемый столбец rowno с помощью фукнции ROW_NUMBER, упорядочив данные по orderdate и orderid. 
--
-- Напишите SELECT-запрос к CTE, а также LEFT JOIN к нему же, чтобы получить текущую и предыдущую строки (основываясь на столбце rowno).
-- Выведите столбцы orderid, orderdate, val для текущей строки и столбец val из предыдущей строки с псевдонимом prevval. 
-- Добавьте вычисляемый столбец diffprev, показывающий разницу между текущим значением и предыдущим значением val.
--
-- Результирующий набор сравните с Lab Exercise2 - Task1 Result.txt
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос с использованием функции LAG для получения тех же результатов, что и в Task 1 (без CTE)
--
-- Результирующий набор сравните с Lab Exercise2 - Task2 Result.txt
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 3 
--
-- Определите CTE с именем SalesMonth2007 с двумя столбцами:
--   monthno (месяц от столбца orderdate). Столбец группировки
--   val (сумма по столбцу val).
--  Месяца и суммы должны быть только за 2007 год
--
-- Напишите SELECT-запрос к CTE и получите столбцы monthno и val, а также три вычисляемых столбца:
--  avglast3months - среднее количество продаж за предыдущие три месяца (относительно текущей строки): (LAG(1) + LAG(2) +LAG(3)) / 3
--  diffjanuary - разница между текущей строкой и значением за Январь: FIRST_VALUE 
--  nextval - следующее значение val для текущей строки: LEAD
--
-- Результирующий набор сравните с Lab Exercise2 - Task3 Result.txt
-- Обратите внимание, что среднее за предыдущие три месяца (avglast3months) рассчитано неверно для строк 2 и 3.
---------------------------------------------------------------------

