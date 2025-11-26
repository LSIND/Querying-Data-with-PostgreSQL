# Запрос данных в PostgreSQL

## 1: Введение в PostgreSQL
- общие сведения о СУБД
- клиентские приложения
- база данных курса
## 2: Введение в язык запросов SQL
```sql
5  SELECT <select_list>  
1  FROM <source_1> AS P
     INNER JOIN <source_2> AS C
     ON <join_on_clause>
2  WHERE <predicate_condition>
3  GROUP BY <group_by_list / GROUPING SETS | CUBE | ROLLUP >
4  HAVING <having_condition>
6  ORDER BY <column(s)_order>
7  LIMIT (number_of_rows);
```
## 3: Написание SELECT-запросов
- Множества и дубликаты: ```DISTINCT```
- ```CASE```-выражения
## 4: Запрос данных из нескольких таблиц
- SQL:89 vs SQL:92
- ```JOIN: INNER, OUTER, CROSS```
- Самосоединения
## 5: Сортировка и фильтрация данных
- ```ORDER BY [ASC, DESC]```
- ```WHERE``` + операторы сравнения + предикаты
- ```LIMIT, OFFSET-FETCH```
## 6: Встроенные типы данных PostgreSQL
- Обзор типов данных
- ```CAST```, оператор ```::```
- Типы данных строка, дата-время
## 7: Использование DML для изменения данных
- ```INSERT INTO .. VALUES, INSERT INTO .. SELECT```
- ```SELECT INTO```
- ```UPDATE, DELETE```
- ```MERGE``` *
## 8: Использование встроенных функций
- Обзор: скалярные, агрегирования, оконные
- Скалярные функции преобразования данных, функции-условия, функции для работы с NULL
- Тип данных ```Array```
## 9: Группировка и агрегирование данных
- Функции агрегирования: ```COUNT, SUM, AVG, MIN, MAX, STRING_AGG```
- ```GROUP BY``` + фильтр ```HAVING```
- Расширения ```GROUP BY: GROUPING SETS, CUBE, ROLLUP```
## 10: Использование подзапросов
- Подзапросы возвращающие скаляр, вектор, таблицу (```EXISTS```)
- Простые и корреляционные подзапросы
## 11: Другие виды SELECT-запросов
- Создание и использование представлений: ```CREATE VIEW view_name... SELECT FROM view_name...```
- Использование наследуемых таблиц (derived table): ```SELECT FROM (SELECT ...)```
- Использование общих табличных выражений (common table expression, CTE): ```WITH cte_name AS ( SELECT ...)```.
## 12: Использование операторов множеств
- Объединение (```UNION```), пересечение (```INTERSECT```), вычитание (```EXCEPT```)
- Табличная инструкция: ```CROSS (LEFT) LATERAL JOIN ... ON TRUE```
- Функция ```crosstab``` из расширения ```tablefunc```
## 13: Использование оконных функций
- Расчет нарастающих итогов, изменений данных, скользящих средних
- Функции ранжирования, агрегирования, сдвига и статистические
- ``` ... OVER (PARTITION BY ... ORDER BY ... ROWS BETWEEN ...) ``` 

## [База данных курса](https://github.com/LSIND/Querying-Data-with-PostgreSQL/tree/master/SetupFiles)