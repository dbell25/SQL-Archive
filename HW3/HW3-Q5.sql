--Q5
use WideWorldImporters;
with CTE(CustomerID, OrderCount, Sales)
as
(
	select 
		o.CustomerID,
		count(distinct o.OrderID) as [OrderCount],
		sum(ol.Quantity * ol.UnitPrice) as [Sales]
	from 
		Sales.Orders as o join Sales.OrderLines as ol on o.OrderID = ol.OrderID and year(o.OrderDate) = 2015
	group by
		o.CustomerID
)

select 
	c.CustomerID,
	c.CustomerName,
	OrderCount,
	Sales
from
	Sales.Customers c
	inner join CTE on c.CustomerID=CTE.CustomerID
group by
	c.CustomerID, c.CustomerName, OrderCount, Sales
order by
	Sales desc, CustomerID