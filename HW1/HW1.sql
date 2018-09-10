--Q1
select month(OrderDate) as [Month],
COUNT(distinct CustomerID) as [Customer Count],
SUM(month(OrderDate)) as [Order Count]
from Sales.Orders
where year(OrderDate)='2015'
group by month(OrderDate)
order by [Month]

--Q2
select distinct CustomerID,
Count(OrderID) as [Order Count],
min(OrderDate) as [First Purchase Date],
max(OrderDate) as [Latest Purchase Date],
Case when Count(OrderID) < 25 Then 'Few Orders'
when Count(OrderID) >= 25 AND Count(OrderID) < 100 Then 'Growing Customer'
Else 'Large Customer'
End As 'Customer Type'
from Sales.Orders
group by CustomerID
Order by CustomerID

--Q3
Declare @FirstOrderDate date = '01/01/2013';
Declare @LastOrderDate date = '12/31/2013';
Declare @PageSize int = 100;
Declare @Page int = 1;

select OrderID, OrderDate, CustomerID, SalespersonPersonID
from Sales.Orders
where OrderDate >= @FirstOrderDate AND OrderDate <= @LastOrderDate
Order By OrderID
Offset ((@Page-1) * @PageSize) rows
fetch next @pageSize rows only