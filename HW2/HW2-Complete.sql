--Question 1
use WideWorldImporters
select
	year(o.OrderDate) as [Order Year],
	cc.CustomerCategoryName,
	count(distinct o.CustomerID) as [Customer Count],
	count(o.OrderID) as [Order Count],
	sum(ol.Quantity*ol.UnitPrice) as [Sales],
	avg(ol.Quantity*ol.UnitPrice) as [Average Sales Per Customer]
from
	Sales.Orders o inner join Sales.OrderLines ol on o.OrderID=ol.OrderID
	inner join Sales.Customers c on o.CustomerID=c.CustomerID
	inner join Sales.CustomerCategories cc on c.CustomerCategoryID=cc.CustomerCategoryID
group by
	CustomerCategoryName, year(OrderDate) 
order by 
	[Order Year], CustomerCategoryName

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
	[Sales] desc, s1.SupplierName

