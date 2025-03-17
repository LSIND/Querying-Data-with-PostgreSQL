-------------------------------------------------------
--
-- Модуль 6
-- Демонстрация 3
-- Функции для работы с датой и временем
--
-------------------------------------------------------

-- Текущие DATE и TIME

SELECT
	NOW()				AS Curr_Now, 		   -- текущие дата-время + часовой пояс
	LOCALTIMESTAMP      AS CurrentTimestamp,   -- текущие дата-время
	LOCALTIME		    AS CurrentTime,		   -- текущее время == CURRENT_TIME
	CURRENT_DATE		AS CurrentDate,    	   -- текущая дата
	CURRENT_TIMESTAMP	AS CurrentTimestamp;   -- for ANSI SQL compatibility == NOW()
	

-------------------------------------------------------
-- Части даты и времени

SELECT EXTRACT(year from '20221005'::date) as Y, EXTRACT(month from '20221005'::date), EXTRACT(day from '20221005'::date);
SELECT DATE_PART('year', '20221005'::date);


-------------------------------------------------------
-- Создание даты и времени из частей

SELECT make_time(8, 15, 23.5); -- make_time(hour int, min int, sec double precision)
SELECT make_timestamp(2022, 7, 15, 8, 15, 23.5); -- make_timestamp(year int, month int, day int, hour int, min int, sec double precision)
SELECT make_timestamptz(2013, 7, 15, 8, 15, 23.5); -- с ЧП
SELECT make_date(2022, 7, 15);
SELECT make_interval(days => 25);

-------------------------------------------------------
-- Операторы даты/времени

SELECT date '2023-09-28' + 7; -- + 7 дней
SELECT time '05:00' - interval '2 hours';
SELECT date '2023-10-01' - date '2023-09-28';
SELECT 3.5 * interval '1 hour';


-------------------------------------------------------
-- Разница между датами (Interval)
SELECT age('2010-04-10'::timestamp, '1957-06-13'::timestamp); -- разница между датами
SELECT age('2010-04-10'::timestamp); -- разница с текущей датой


-------------------------------------------------------
-- Date output

SHOW LC_TIME;

SELECT to_char(current_timestamp, 'FMMONTH FMDay, FMDD; HH12:MI:SS');
-- Приставка FM	режим заполнения (подавляет ведущие нули и дополнение пробелами)

SET LC_TIME to 'ru_RU.utf8'; -- язык должен быть установлен в системе
SHOW LC_TIME;

SELECT to_char(current_timestamp, 'TMDay, DD TMMonth YYYY'); -- Пятница, 26 Апрель 2024
-- Приставка TM	режим перевода (используются локализованные названия дней и месяцев, исходя из lc_time)	

SET LC_TIME to 'en_US.utf8'; 


-------------------------------------------------------
-- TIME ZONE 
SHOW TIMEZONE; -- текущий часовой пояс (клиент, сессия)

SELECT * FROM pg_timezone_names; -- аббревиатуры для часовых поясов

SET TIMEZONE TO 'Asia/Magadan';
SHOW TIMEZONE;
SELECT NOW();

SET timezone TO 'Europe/Moscow';
SHOW TIMEZONE;
SELECT NOW();

SET TIMEZONE TO 'Asia/Magadan';
SELECT orderid, orderdate, CAST(orderdate as timestamptz) -- преобразование в timestamptz с учетом настройки сессии
FROM sales.orders;