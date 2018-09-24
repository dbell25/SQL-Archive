--Q2
use WideWorldImporters

select
	s.SupplierID,
	s.SupplierName,
	c.CityName as [City],
	sp.StateProvinceCode as [State]
from
	Purchasing.Suppliers s,
	Application.Cities c,
	Application.StateProvinces sp