--Q4
use WideWorldImporters
select
	c.CustomerID,
	c.CustomerName,
	[Sales].OrderCount,
	[Sales].Sales
from Sales.Customers as c
    join
    (
        select 
			o.CustomerID,
			count(distinct o.OrderID) as [OrderCount],
			sum(ol.Quantity * ol.UnitPrice) as [Sales]
		from 
			Sales.Orders as o join Sales.OrderLines as ol on o.OrderID = ol.OrderID and year(o.OrderDate) = 2015
		group by
			o.CustomerID
    ) as [Sales] on c.CustomerID = [Sales].CustomerID
order by
	[Sales] desc, CustomerID