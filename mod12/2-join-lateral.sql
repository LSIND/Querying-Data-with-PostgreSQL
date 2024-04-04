-------------------------------------------------------
--
-- Модуль 12
-- Демонстрация 2
-- JOIN LATERAL
--
-------------------------------------------------------

-- TVF, возвращающая 3 самых дорогих товара поставщика по supplierid

DROP FUNCTION IF EXISTS production.fn_TopProductsByShipper(int);

CREATE FUNCTION production.fn_TopProductsByShipper (supplier int)
RETURNS TABLE 
  (productid int, productname varchar, unitprice money)
as $$
  SELECT P.productid, P.productname, P.unitprice
  FROM production.products AS P
  WHERE P.supplierid = supplier
  ORDER BY unitprice DESC
  LIMIT(3);
$$ LANGUAGE sql;


-- Проверка функции: 3 самых дорогих товара поставщика номер 2
SELECT * FROM production.fn_TopProductsByShipper(2);


-- 1. CROSS JOIN LATERAL (Аналог cross apply из MS SQL Server / Oracle)

-- Список всех поставщиков и 3 их самых дорогих товара
SELECT S.supplierid, S.companyname,
	P.productid, P.productname, P.unitprice
FROM production.suppliers AS S
CROSS JOIN LATERAL production.fn_TopProductsByShipper(S.supplierid) AS P
ORDER BY S.supplierid ASC, P.unitprice DESC;

-- 2 самых последних заказа каждого заказчика
SELECT C.custid, TopOrders.orderid, TopOrders.orderdate
FROM sales.customers AS C
CROSS JOIN LATERAL
(SELECT orderid, orderdate
	FROM sales.orders AS O
	WHERE O.custid = C.custid
	ORDER BY orderdate DESC, orderid DESC LIMIT(2)) AS TopOrders;


-- 2. LEFT JOIN LATERAL ON TRUE (Аналог outer apply)

-- Все заказчики и их заказы
SELECT C.custid, C.companyname
FROM sales.customers AS C            -- 91 customers
LEFT OUTER JOIN sales.orders AS O    -- 830 orders
ON C.custid = O.custid;              -- 832 results with NULL cust

-- Заказчики и 2 их самых последних заказа + заказчики без заказов 
SELECT C.custid, TopOrders.orderid, TopOrders.orderdate
FROM sales.customers AS C
LEFT JOIN LATERAL
(SELECT orderid, orderdate
	FROM sales.orders AS O
	WHERE O.custid = C.custid
	ORDER BY orderdate DESC, orderid DESC LIMIT 2) AS TopOrders ON TRUE;