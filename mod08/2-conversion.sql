-------------------------------------------------------
--
-- Модуль 8
-- Демонстрация 2
-- Функции преобразования
--
-------------------------------------------------------

-- 1. CAST и преобразование типов
-- CAST +
SELECT CAST(NOW() AS DATE);

-- CAST -
SELECT CAST(NOW() AS INT);


-- 2. Преобразование в строку, число и дату
-- TO_CHAR
SELECT to_char(current_timestamp, 'HH24:MI:SS'), to_char(interval '15h 2m 12s', 'HH24:MI:SS');

SELECT to_char(125, '999') AS IntCol, to_char(125.8::real, '999D9') AS RealCol, to_char(-135.8, '999D99S') AS DecCol;

-- TO_NUMBER
SELECT to_number('12,454.8-', '99G999D9S'); -- G, D зависят от локали
-- SHOW LC_NUMERIC;
SELECT to_number('12,454.8-', '99,999.9S'); -- S - знак

-- TO_DATE
SELECT to_date('05 Feb 2026', 'DD Mon YYYY'), to_timestamp('05 Dec 2020', 'DD Mon YYYY'), to_timestamp(1384356778);