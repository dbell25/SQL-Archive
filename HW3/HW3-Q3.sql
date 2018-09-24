--Q3
use WideWorldImporters

select 
	o.OrderID,
	o.OrderDate,
	sum(ol.Quantity*ol.UnitPrice) as [Order Total]
from
	Sales.Orders o join Sales.OrderLines ol on o.OrderID=ol.OrderID
group by
	o.OrderID,
	o.OrderDate
order by
	o.OrderID

select o2.OrderDate
from Sales.Orders o2
where DATEDIFF(DAY, o2.OrderDate, o2.OrderDate) > 0
--partition?