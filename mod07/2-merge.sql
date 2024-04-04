-------------------------------------------------------
--
-- Модуль 7
-- Демонстрация 2
-- MERGE * (с версии PostgreSQL 15)
--
-------------------------------------------------------

CREATE TABLE public.workers
(
    workerid int PRIMARY KEY,
    lastname varchar(20) NOT NULL,
    name varchar(10) NOT NULL, 
    phonenumber varchar(24),
    address varchar(60) NOT NULL,
    city varchar(15) NOT NULL
);

INSERT INTO public.workers(workerid, lastname, name, phonenumber, address, city)
VALUES (1, 'Davis', 'Sara',     '(206) 555-0101', '7890 - 20th Ave. E., Apt. 2A',     'Seattle'),
       (3, 'Lew',   'Judy',     '(555) 313-3121', 'Kavaljersstigen 24, Hasselby',     'Stockholm'),
       (7, 'Konig', 'Russel',   '(71) 123-4567',  '2 Edgeham Hollow, Winchester Way', 'London');

SELECT * FROM public.workers; -- 3 строки в таблице workers: id 1, 3, 7

SELECT * FROM hr.employees; -- данные таблицы employees


-- Требуется перенести данные из таблицы employees в таблицу workers слиянием:
--  Связать две таблицы по уникальному полю
--  Существующие записи - обновить (сотрудник сменил фамилию, место жительства и тд)
--  Отсутствующие записи - добавить 

MERGE INTO public.workers AS w -- destination
USING hr.employees as e        -- source
ON w.workerid = e.empid
WHEN MATCHED THEN              -- если строки совпали по id: обновить нужные поля
  UPDATE SET lastname = e.lastname,
          name = e.firstname,
          phonenumber = e.phone,
          address = e.address, 
          city = e.city
WHEN NOT MATCHED THEN          -- если строки не совпали по id: добавить
  INSERT (workerid, lastname, name, phonenumber, address, city)
  VALUES (e.empid, e.lastname, e.firstname, e.phone, e.address, e.city);


  SELECT * FROM public.workers
  ORDER BY workerid; -- 


  -- Удалить таблицу демонстрации
  DROP TABLE IF EXISTS public.workers;