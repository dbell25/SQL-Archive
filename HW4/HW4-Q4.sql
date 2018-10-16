--Q4
use  danieljbell
go

update M
set 
	m.Meet_Location = 'Business Building 4001',
	m.UpdatedOn = sysdatetimeoffset()
from 
	Homework4.Meeting m inner join Homework4.Club c on m.ClubID = c.ClubID
where 
	c.ClubName = 'MIS Club' and m.Meet_Time = '2018-12-04 18:00:00'