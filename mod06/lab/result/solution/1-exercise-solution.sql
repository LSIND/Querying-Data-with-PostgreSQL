---------------------------------------------------------------------
-- LAB 06
--
-- Exercise 1 (Solution)
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- 
-- Напишите SELECT-запрос, который выводит следующие столбцы:
--  Текущие дата и время. Псевдоним currentdatetime.
--  Только текущая дата. Псевдоним currentdate.
--  Только текущее время. Псевдоним currenttime.
--  Только текущий год. Псевдоним currentyear.
--  Только текущий месяц. Псевдоним currentmonth.
--  Только текущий день. Псевдоним currentday.
--  Текущая неделя в году. Псевдоним currentweeknumber.
--  Название текущей месяца. Псевдоним currentmonthname.
-- 
-- Результирующий набор сравните с Lab Exercise1 - Task1 Result.txt.

---------------------------------------------------------------------

SELECT 
	CURRENT_TIMESTAMP AS currentdatetime,
	CAST(CURRENT_TIMESTAMP AS date) AS currentdate,
	CAST(CURRENT_TIMESTAMP AS time) AS currenttime,
	EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS currentyear,
	EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS currentmonth,
	EXTRACT(DAY FROM CURRENT_TIMESTAMP) AS currentday,
	EXTRACT(week FROM CURRENT_TIMESTAMP) AS currentweeknumber,
	TO_CHAR(CURRENT_TIMESTAMP, 'Month') AS currentmonthname;


---------------------------------------------------------------------
-- Task 2
--  
-- Запишите дату '2020-12-11' (date) в виде 'December 11, 2020. Неделя 50'. Псевдоним somedate.
---------------------------------------------------------------------

SELECT to_char('2020-12-11'::date, 'Month DD, YYYY. Неделя WW') AS somedate;

---------------------------------------------------------------------
-- Task 3
-- 
-- Напишите SELECT-запрос, который выводит следующие столбцы:
--  Три месяца от текущей даты-времени. Псевдоним threemonths.
--  Количество дней между значением столбца threemonths и текущей датой. Псевдоним diffdays.
--  Разница между April 4, 1992 и September 16, 2011 (Функция AGE). Псевдоним diffAge.
--  Первый день текущего месяца (датой). Функция date_trunc. Псевдоним firstday.
--
-- Результирующий набор сравните с Lab Exercise1 - Task3 Result.txt. 
---------------------------------------------------------------------

SELECT 
	CURRENT_TIMESTAMP + interval '3 months' AS threemonths,
	date_part('day', (CURRENT_TIMESTAMP + interval '3 months')::timestamp - CURRENT_TIMESTAMP) AS diffdays,
	AGE('19920404'::timestamp, '20110916'::timestamp) AS diffAge,
	date_trunc('month', current_date) AS firstday; 