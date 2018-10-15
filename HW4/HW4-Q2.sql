--Q2
use danieljbell
go

insert into Homework4.Club (ClubName, Purpose)
values
	(N'ACM', N'The Association for Computing Machinery is the professional organization for computer scientists.'), 
	(N'MIS Club', N'The Kansas State MIS Club is a student driven organization focused on the management of information systems.')

insert into Homework4.Meeting (ClubID, Meet_Location, Meet_Time)
select 
	c.ClubID as ClubID, loc.Location as Location, loc.MeetingTime as MeetingTime
from 
(
	values
        (N'ACM',N'Engineering Building 1114', 'October 9, 2018 6:30pm'),
        (N'ACM',N'Engineering Building 1114', 'November 13, 2018 6:30pm'),
        (N'MIS Club',N'Business Building 2116', 'November 6, 2018 6:00pm'),
        (N'MIS Club',N'Business Building 2116', 'December 4, 2018 6:00pm')
) AS loc(ClubName, Location, MeetingTime)
inner join Homework4.Club c on c.ClubName = loc.ClubName;