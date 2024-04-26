---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 3
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Выполните запрос ниже, который создает и заполняет таблицу hr.calendar данными для Task 2.
-- Таблица заполняется датами за текущий календарный год.
---------------------------------------------------------------------

DROP TABLE IF EXISTS hr.calendar;

CREATE TABLE hr.calendar (
	calendardate DATE CONSTRAINT PK_Calendar PRIMARY KEY
);

DO $$ 
DECLARE startdate DATE:= make_date(EXTRACT(YEAR FROM NOW())::int, 1, 1);
DECLARE enddate DATE:= make_date(EXTRACT(YEAR FROM NOW())::int, 12, 31);

BEGIN
WHILE startdate <= enddate LOOP
	INSERT INTO hr.calendar (calendardate)
	VALUES (startdate);
	startdate = startdate + INTERVAL '1 day';
END LOOP;
END $$;


-- Просмотрите содержимое таблицы hr.calendar
SELECT calendardate
FROM hr.calendar;

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, выводящий empid, firstname и lastname из HR.Employees, а также calendardate из hr.calendar.
-- Перемножьте все строки левой таблицы на все строки правой. Что это за множество?
--
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
-- Отличается ли ваш результат от набора из Lab Exercise3 - Task2 Result.txt?
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 3
-- 
-- Удалите таблицу hr.calendar.
---------------------------------------------------------------------

DROP TABLE IF EXISTS hr.calendar;