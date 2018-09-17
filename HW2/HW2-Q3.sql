--Question 3
use WideWorldImporters
select
	s1.SupplierID,
	s1.SupplierName,
	count(distinct o.OrderID) as [Order Count],
	isnull(sum(ol.Quantity*ol.UnitPrice), 0.00) as [Sales]
from
	Sales.OrderLines ol full outer join Warehouse.StockItems si on ol.StockItemID=si.StockItemID
	right join Sales.Orders o on o.OrderID=ol.OrderID and o.OrderDate between '01/01/2015' and '12/31/2015'
	right join Purchasing.Suppliers s1 on s1.SupplierID=si.SupplierID

group by
	s1.SupplierName, s1.SupplierID
order by
	[Sales] desc, [Order Count], s1.SupplierName