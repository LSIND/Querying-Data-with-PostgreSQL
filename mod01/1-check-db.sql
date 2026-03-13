-------------------------------------------------------
--
-- Модуль 1
-- Демонстрация 1
-- Проверка подключения, некоторые запросы к бд foodstore
--
-------------------------------------------------------

-- версия СУБД
SELECT VERSION();


-- БД, к которой подключены
SELECT current_database(); -- foodstore


-- Текущая дата-время
SELECT NOW();
SELECT CURRENT_TIMESTAMP;

-- Список заказчиков из бд foodstore
SELECT * FROM sales.customers;

-- Список категорий продуктов из бд foodstore
SELECT * FROM production.categories;

