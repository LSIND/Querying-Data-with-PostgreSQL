-- TVF, возвращающая 3 самых дорогих товара поставщика по supplierid
CREATE OR REPLACE FUNCTION public."fn_TopProductsByShipper" (supplier int)
RETURNS TABLE 
  (productid int, productname varchar, unitprice money)
as $$
  SELECT P.productid, P.productname, P.unitprice
  FROM "Production"."Products" AS P
  WHERE P.supplierid = supplier
  ORDER BY unitprice DESC
  LIMIT(3);
$$ LANGUAGE sql;


-- Проверка функции
SELECT * FROM "public"."fn_TopProductsByShipper"(2);

-- CROSS JOIN LATERAL (cross apply)
SELECT S.supplierid, S.companyname,
	P.productid, P.productname, P.unitprice
FROM "Production"."Suppliers" AS S
CROSS JOIN LATERAL "public"."fn_TopProductsByShipper"(S.supplierid) AS P
ORDER BY S.supplierid ASC, P.unitprice DESC;

-- CROSS JOIN LATERAL (cross apply)
-- 3 самых последних заказа каждого заказчика
SELECT C.custid, TopOrders.orderid, TopOrders.orderdate
FROM "Sales"."Customers" AS C
CROSS JOIN LATERAL
(SELECT orderid, orderdate
	FROM "Sales"."Orders" AS O
	WHERE O.custid = C.custid
	ORDER BY orderdate DESC, orderid DESC LIMIT(3)) AS TopOrders;


-- LEFT JOIN LATERAL (outer apply)
-- Заказчики и 3 их самых последних заказа + заказчики без заказов 

-- Все заказчики и их заказы
SELECT C.custid, C.companyname
FROM "Sales"."Customers" AS C --91 customers
LEFT OUTER JOIN "Sales"."Orders" AS O -- 830 orders
ON C.custid = O.custid; --832 results with NULL cust

-- Заказчики и 3 их самых последних заказа + заказчики без заказов 
SELECT C.custid, TopOrders.orderid, TopOrders.orderdate
FROM "Sales"."Customers" AS C
LEFT JOIN LATERAL
(SELECT orderid, orderdate
	FROM "Sales"."Orders" AS O
	WHERE O.custid = C.custid
	ORDER BY orderdate DESC, orderid DESC LIMIT 3) AS TopOrders ON TRUE;