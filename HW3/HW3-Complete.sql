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

--Q2
use WideWorldImporters

select
	s.SupplierID,
	s.SupplierName,
	c.CityName as [City],
	sp.StateProvinceCode as [State],
	s.PostalPostalCode as [Postal Code]
from
	Purchasing.Suppliers as s
	join Purchasing.SupplierCategories as sc on s.SupplierCategoryID=sc.SupplierCategoryID
	join Application.Cities as c on s.PostalCityID=c.CityID
	join Application.StateProvinces as sp on c.StateProvinceID=sp.StateProvinceID
where s.SupplierID in
(
	select s.SupplierID
	from Warehouse.StockItems as si
	where si.SupplierID=s.SupplierID
	having count(si.SupplierID)=0
) and sc.SupplierCategoryName = 'Novelty Goods Supplier'
order by s.SupplierName

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

--Q4
use WideWorldImporters
select
	c.CustomerID,
	c.CustomerName,
	[Sales].OrderCount,
	[Sales].Sales
from Sales.Customers as c
    join
    (
        select 
			o.CustomerID,
			count(distinct o.OrderID) as [OrderCount],
			sum(ol.Quantity * ol.UnitPrice) as [Sales]
		from 
			Sales.Orders as o join Sales.OrderLines as ol on o.OrderID = ol.OrderID and year(o.OrderDate) = 2015
		group by
			o.CustomerID
    ) as [Sales] on c.CustomerID = [Sales].CustomerID
order by
	[Sales] desc, CustomerID

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