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