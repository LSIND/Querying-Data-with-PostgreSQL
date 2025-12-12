-------------------------------------------------------
--
-- Модуль 10
-- Демонстрация 2
-- Корреляционные подзапросы
--
-------------------------------------------------------

-- Заказчики и их самые последние заказы (по дате). 
SELECT custid, orderid, orderdate
FROM sales.orders AS O1
WHERE orderdate =
	(SELECT MAX(orderdate)
	FROM sales.orders AS O2
	WHERE O2.custid = O1.custid)
ORDER BY custid; -- 89 строк


-- А что, если некоторые заказчики оформили за день несколько заказов?
SELECT custid, orderid, orderdate
FROM sales.orders AS O1
WHERE orderdate::date =
	(SELECT MAX(orderdate::date)
	FROM sales.orders AS O2
	WHERE O2.custid = O1.custid)
ORDER BY custid; -- 90 строк
-- клиент N 40 оформил 2023-03-24 два заказа


-- Информация о самой большой покупке (максимальное количество товаров) каждого заказчика
----  Покупатель N 43 приобрел за раз максимально 10 товаров 2022-03-01 и 2022-05-01. Оба эти заказа отображены в результате.
----  Покупатель N 61 приобрел за раз максимально 59 товаров 2022-01-01 и 2023-03-01. Оба эти заказа отображены в результате.
SELECT custid, ordermonth, qty
FROM sales.custorders AS outercustorders
WHERE qty =
	(SELECT MAX(qty)
		FROM sales.custorders AS innercustorders
		WHERE innercustorders.custid =outercustorders.custid
	)
ORDER BY custid;


-- Продукты, цена которых выше средней цены продуктов соответствующей категории
SELECT  p1.productid, p1.productname, p1.unitprice, C.categoryname
FROM production.products as p1
JOIN production.categories as C  ON P1.categoryid = C.categoryid
WHERE unitprice >
    (SELECT AVG(unitprice)
     FROM production.products as p2
     WHERE p1.categoryid = p2.categoryid)
	 ORDER BY C.categoryname;
