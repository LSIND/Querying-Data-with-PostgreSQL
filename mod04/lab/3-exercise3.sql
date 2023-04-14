---------------------------------------------------------------------
-- LAB 04
--
-- Exercise 3
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Task 1
-- 
-- Выполнить запрос, который создает и заполняет таблицу HR.Calendar для Task 2
---------------------------------------------------------------------

DROP TABLE IF EXISTS "HR"."Calendar";


CREATE TABLE "HR"."Calendar" (
	calendardate DATE CONSTRAINT PK_Calendar PRIMARY KEY
);

DO $$ 
DECLARE startdate DATE:= make_date(EXTRACT(YEAR FROM NOW())::int, 1, 1);
DECLARE enddate DATE:= make_date(EXTRACT(YEAR FROM NOW())::int, 12, 31);

BEGIN
WHILE startdate <= enddate LOOP

	INSERT INTO "HR"."Calendar" (calendardate)
	VALUES (startdate);
	startdate = startdate + INTERVAL '1 day';
END LOOP;
END $$;


-- Просмотрите содержимое таблицы HR.Calendar
SELECT calendardate
FROM "HR"."Calendar";

---------------------------------------------------------------------
-- Task 2
-- 
-- Напишите SELECT-запрос, выводящий empid, firstname и lastname columns из HR.Employees, а также calendardate из HR.Calendar.
-- Перемножьте все строки левой таблицы на все строки правой. Что это за множество?
-- Результирующий набор сравните с Lab Exercise3 - Task2 Result.txt
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Task 3
-- 
-- Удалить таблицу HR.Calendar.
---------------------------------------------------------------------

DROP TABLE IF EXISTS "HR"."Calendar";