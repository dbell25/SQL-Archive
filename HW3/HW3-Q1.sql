--Q1
use WideWorldImporters

select 
	o.OrderID,
	o.OrderDate,
	o.CustomerID,
	sum(ol.Quantity*ol.UnitPrice) as [Order Total]
from
	Sales.Customers c left join Sales.Orders o on o.CustomerID=c.CustomerID
	full outer join Sales.CustomerCategories cc on c.CustomerCategoryID=cc.CustomerCategoryID
	right join Sales.OrderLines ol on o.OrderID=ol.OrderID
where 
	cc.CustomerCategoryName in
	(
		select cc.CustomerCategoryName 
		from Sales.CustomerCategories cc 
		where cc.CustomerCategoryName='Computer Store'
	) and o.OrderDate between '01-01-2016' and '01-31-2016'
group by 
	o.OrderID, o.OrderDate, o.CustomerID
order by
	[Order Total] desc, OrderID