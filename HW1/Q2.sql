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