---------------------------------------------------------------------
-- LAB 03
--
-- Exercise 4 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
--
-- Напишите SELECT-запрос, возвращающий столбцы categoryid и productname таблицы production.products.
---------------------------------------------------------------------

SELECT p.categoryid, p.productname
FROM production.products AS p;

---------------------------------------------------------------------
-- Task 2
--
-- Измените запрос Task 1, добавив вычисляемый столбец categoryname с использованием CASE
-- categoryname должен выводить соответствующее имя категории, основываясь на номере categoryid.
--
-- Результирующий набор сравните с Lab Exercise4 - Task2 Result.txt. 
---------------------------------------------------------------------

SELECT p.categoryid, p.productname,
		CASE p.categoryid
			WHEN 1 THEN 'Beverages'
			WHEN 2 THEN 'Condiments'
			WHEN 3 THEN 'Confections'
			WHEN 4 THEN 'Dairy Products'
			WHEN 5 THEN 'Grains/Cereals'
			WHEN 6 THEN 'Meat/Poultry'
			WHEN 7 THEN 'Produce'
			WHEN 8 THEN 'Seafood'
			ELSE 'Other'
		END AS categoryname
FROM production.products AS p;

---------------------------------------------------------------------
-- Task 3
--
-- Измените запрос Task 2, добавив еще один вычисляемый столбец iscampaign с использованием CASE
--     iscampaign имеет значение 'Campaign Products' для категорий Beverages, Produce и Seafood; 
--     значение 'Non-Campaign Products' для остальных категорий.
--
-- Результирующий набор сравните с Lab Exercise4 - Task3 Result.txt. 
---------------------------------------------------------------------

SELECT p.categoryid, p.productname,
		CASE p.categoryid
			WHEN 1 THEN 'Beverages'
			WHEN 2 THEN 'Condiments'
			WHEN 3 THEN 'Confections'
			WHEN 4 THEN 'Dairy Products'
			WHEN 5 THEN 'Grains/Cereals'
			WHEN 6 THEN 'Meat/Poultry'
			WHEN 7 THEN 'Produce'
			WHEN 8 THEN 'Seafood'
			ELSE 'Other'
		END AS categoryname,
        CASE
			WHEN p.categoryid IN (1, 7, 8) THEN 'Campaign Products'
			ELSE 'Non-Campaign Products' 
		END AS iscampaign
FROM production.products AS p;


---------------------------------------------------------------------
-- Task 4
-- 
-- Напишите SELECT-запрос, возвращающий custid и contactname из sales.customers.
-- Добавьте вычисляемый столбец с именем segmentgroup, выводящий значение 'Target group' для заказчиков из Mexico и имеющих значение Owner в contacttitle. 
-- Для всех остальных выводите 'Other'. 
--
-- Результирующий набор сравните с Lab Exercise4 - Task4 Result.txt. 
---------------------------------------------------------------------
SELECT custid, contactname,
	CASE
		WHEN (country = 'Mexico' AND contacttitle = 'Owner') THEN 'Target group'
		ELSE 'Other'
	END AS segmentgroup
FROM sales.customers;