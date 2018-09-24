--Q4
select
	c.CustomerID,
	c.CustomerName,
	count(distinct o.OrderID) as [Order Count],
	sum(ol.Quantity*ol.UnitPrice) as [Sales]	
from
	Sales.Customers c join Sales.Orders o on c.CustomerID=o.CustomerID
	join Sales.OrderLines ol on o.OrderID=ol.OrderID
where
	year(o.OrderDate)='2015'
group by
	c.CustomerID, c.CustomerName
order by
	[Sales] desc, CustomerID