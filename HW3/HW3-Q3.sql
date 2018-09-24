--Q3
use WideWorldImporters

select 
	o.OrderID,
	o.OrderDate,
	sum(ol.Quantity*ol.UnitPrice) as [Order Total],
	(
		select datediff(day, max(o2.OrderDate), o.OrderDate)
		from Sales.Orders o2
		where o2.OrderDate < o.OrderDate and o2.CustomerID=90
	) as [DaysSincePreviousOrder]
from
	Sales.Orders o join Sales.OrderLines ol on o.OrderID=ol.OrderID
where
	o.CustomerID=90
group by
	o.OrderID,
	o.OrderDate
order by
	o.OrderID