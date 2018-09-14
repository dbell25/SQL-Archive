--Question 2
use WideWorldImporters
select
	c.CustomerID,
	c.CustomerName,
	sum(ol1.Quantity*ol1.UnitPrice) as [2014 Sales],
	sum(ol2.Quantity*ol2.UnitPrice) as [2015 Sales],
	sum((ol3.Quantity*ol3.UnitPrice)) as [Total Sales]
from
	Sales.Orders o left join Sales.OrderLines ol1 on o.OrderID=ol1.OrderID and year(o.OrderDate)='2014'
	left join Sales.OrderLines ol2 on o.OrderID=ol2.OrderID and year(o.OrderDate)='2015'
	left join Sales.OrderLines ol3 on o.OrderID=ol3.OrderID
	inner join Sales.Customers c on o.CustomerID=c.CustomerID
where
	year(o.OrderDate)='2014' or year(o.OrderDate)='2015'
group by 
	c.CustomerID, 
	c.CustomerName
Order by
	CustomerID, [2014 Sales] desc, [2015 Sales] desc, [Total Sales] desc