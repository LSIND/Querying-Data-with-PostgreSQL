---------------------------------------------------------------------
-- LAB 08
--
-- Exercise 1
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Напишите SELECT-запрос к таблице production.products с единственным вычисляемым столбцом productdesc. 
-- Выведите только те продукты, цена которых больше или равна 60.
-- productdesc должен содержать краткое описание товара в следующем формате:
--  Цена продукта <productname> равна <unitprice>.
---- Цена продукта Product HHYDP равна 18.00.
--
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt
---------------------------------------------------------------------




---------------------------------------------------------------------
-- Task 2
-- 
-- Отдел маркетинга предоставил дату начала 4/1/2022 (1 апреля 2022 г.) и дату окончания 11/30/2022 (30 ноября 2022 г.) некоторого периода. 
-- Напишите SELECT-запрос к таблице sales.orders и получите столбцы orderid, orderdate, shippeddate, shipregion.
-- Включите только те строки, которые подходят под условие отдела маркетинга (в их формате месяц/день/год), а также имеют более 30 дней в промежутке между датой отправки и датой заказа.
-- Если в столбце region есть значение NULL - при выводе заменить его на 'No region'.
--
-- Результирующий набор сравните с Lab Exercise1 - Task2 Result.txt
---------------------------------------------------------------------


---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, конвертирующий номера телефонов из таблицы sales.customers в числовые значения int / bigint.
-- Удалите все лишние символы в номерах перед конвертацией. 
--
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt
---------------------------------------------------------------------

