-------------------------------------------------------
--
-- Модуль 10
-- Демонстрация 2
-- Корреляционные подзапросы
--
-------------------------------------------------------

-- Заказчики и их самые последние заказы (по дате)
SELECT custid, orderid, orderdate
FROM sales.orders AS outerorders
WHERE orderdate =
	(SELECT MAX(orderdate)
	FROM sales.orders AS innerorders
	WHERE innerorders.custid = outerorders.custid)
ORDER BY custid;

-- Последний(е) заказы, оформленные каждым сотрудником
SELECT orderid, empid, orderdate
FROM sales.orders AS O1
WHERE orderdate =
	(SELECT MAX(orderdate)
	 FROM sales.orders AS O2
	 WHERE O2.empid = O1.empid)
ORDER BY empid, orderdate;

-- Информация о заказах каждого заказчика с максимальным количеством товаров внутри - 91 строка
SELECT custid, ordermonth, qty
FROM sales.custorders AS outercustorders
WHERE qty =
	(SELECT MAX(qty)
		FROM sales.custorders AS innercustorders
		WHERE innercustorders.custid =outercustorders.custid
	)
ORDER BY custid;

-- Информация о заказах каждого заказчика с максимальным количеством товаров внутри - 89 строк
SELECT custid, MAX(ordermonth), MAX(qty)
FROM sales.custorders AS outercustorders
GROUP BY custid
ORDER BY custid;