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