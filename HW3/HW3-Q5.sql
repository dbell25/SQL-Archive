--Q5
use WideWorldImporters
;with CTE(OrderCount, Sales)
as
(
	select 
		count(distinct o.OrderID) as [Order Count],
		sum(ol.Quantity*ol.UnitPrice) as [Sales]
	from 
		Sales.Customers c join Sales.Orders o on c.CustomerID=o.CustomerID
		join Sales.OrderLines ol on o.OrderID=ol.OrderID
	where
		year(OrderDate)='2015'
)

select 
	c.CustomerID,
	c.CustomerName,
	OrderCount,
	Sales
from
	CTE,
	Sales.Customers c
group by
	c.CustomerID, c.CustomerName, OrderCount, Sales
order by
	Sales desc, CustomerID