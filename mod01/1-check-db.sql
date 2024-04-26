-- версия СУБД
SELECT VERSION();

-- текущая дата-время
SELECT NOW();
SELECT CURRENT_TIMESTAMP;

-- Список заказчиков
SELECT * FROM sales.customers;

-- Список категорий продуктов
SELECT * FROM production.categories;