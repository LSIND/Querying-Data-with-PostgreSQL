-------------------------------------------------------
--
-- Модуль 6
-- Демонстрация 3
-- Функции для работы с датой и временем
--
-------------------------------------------------------

-- Текущие DATE and TIME

SELECT
	NOW()				AS Curr_Now, 		   -- текущие дата-время + часовой пояс
	LOCALTIMESTAMP      AS CurrentTimestamp,   -- текущие дата-время
	LOCALTIME		    AS CurrentTime,		   -- текущее время == CURRENT_TIME
	CURRENT_DATE		AS CurrentDate,    	   -- текущая дата
	CURRENT_TIMESTAMP	AS CurrentTimestamp;   -- for ANSI SQL compatibility == NOW()
	

-- Части даты и времени

SELECT EXTRACT(year from '20221005'::date) as Y, EXTRACT(month from '20221005'::date), EXTRACT(day from '20221005'::date);
SELECT DATE_PART('year', '20221005'::date);

-- Пересечение временных интервалов
SELECT (DATE '2001-02-16', DATE '2001-12-21') OVERLAPS
       (DATE '2001-10-30', DATE '2002-10-30');


-- Создание даты и времени из частей

SELECT make_time(8, 15, 23.5); -- make_time(hour int, min int, sec double precision)
SELECT make_timestamp(2022, 7, 15, 8, 15, 23.5); -- make_timestamp(year int, month int, day int, hour int, min int, sec double precision)
SELECT make_timestamptz(2013, 7, 15, 8, 15, 23.5) -- с ЧП
SELECT make_date(2022, 7, 15);
SELECT make_interval(days => 25);


-- Операторы даты/времени
SELECT date '2023-09-28' + integer '7';
SELECT time '05:00' - interval '2 hours';
SELECT date '2023-10-01' - date '2023-09-28';
SELECT double precision '3.5' * interval '1 hour';


-- date difference (Interval)
SELECT age(timestamp '2010-04-10', timestamp '1957-06-13'); -- разница между датами
SELECT age(timestamp '2001-04-10') -- разница с текущей датой


-- Date output
SELECT to_char(current_timestamp, 'FMDay, FMDD; HH12:MI:SS')


-- TIME ZONE 
SHOW TIME ZONE; -- текущий часовой пояс (клиент, сессия)

SELECT * FROM pg_timezone_names; -- аббревиатуры для часовых поясов

SET timezone TO 'US/Alaska';

SET timezone TO 'Europe/Helsinki';

SET timezone TO 'Europe/Moscow';

SELECT NOW();

SET timezone TO 'Europe/Moscow';
SELECT orderid, orderdate, CAST(orderdate as timestamptz) -- преобразование в timestamptz с учетом настройки сессии
FROM sales.orders;