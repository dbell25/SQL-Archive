select month(OrderDate) as [Month],
COUNT(distinct CustomerID) as [Customer Count],
SUM(month(OrderDate)) as [Order Count]
from Sales.Orders
where year(OrderDate)='2015'
group by month(OrderDate)
order by [Month]