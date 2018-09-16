--Question 3
use WideWorldImporters
select
	s1.SupplierID,
	s1.SupplierName,
	count(s2.SupplierID) as [Order Count],
	sum(ol.Quantity*ol.UnitPrice) as [Sales]
from
	Purchasing.Suppliers s1 join Purchasing.SupplierTransactions st on s1.SupplierID=st.SupplierID
	join Warehouse.StockItems si on s1.SupplierID=si.SupplierID
	full outer join Purchasing.PurchaseOrders s2 on s2.SupplierID=s1.SupplierID
	full outer join Sales.OrderLines ol on si.StockItemID=ol.StockItemID
group by
	s1.SupplierName, s1.SupplierID
order by
	[Sales] desc