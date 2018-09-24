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