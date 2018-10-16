--Q1
create schema Homework4
go

use danieljbell;
create table Homework4.Club
(
	ClubID int NOT NULL identity(1, 1) primary key,
	ClubName nvarchar(100) Not Null,
	Purpose nvarchar(150) Not Null,
	CreatedOn datetimeoffset Not Null default(sysdatetime()),
	UpdatedOn datetimeoffset Not Null default(sysdatetime())
	unique
	(
		ClubName	
	)
);

create table Homework4.Meeting
(
	MeetingID int Not Null identity(1, 1) primary Key,
	clubID int Not Null foreign key references Homework4.Club(ClubID),
	Meet_Time datetime2(0) Not Null,
	Meet_Location nvarchar(100) Not Null,
	CreatedOn datetimeoffset Not Null default(sysdatetime()),
	UpdatedOn datetimeoffset Not Null default(sysdatetime())
	unique
	(
		clubID,
		Meet_Time
	)
);

create table Homework4.Attendee
(
	AttendeeID int Not Null identity(1, 1) primary key,
	Email nvarchar(100) Not Null,
	FirstName nvarchar(45) Not Null,
	LastName nvarchar(45) Not Null,
	CreatedOn datetimeoffset Not Null default(sysdatetime()),
	UpdatedOn datetimeoffset Not Null default(sysdatetime())
);

create table Homework4.MeetingAttendee
(
	MeetingID int Not NUll foreign key references Homework4.Meeting(MeetingID),
	AttendeeID int Not NUll foreign key references Homework4.Attendee(AttendeeID),
	CreatedOn datetimeoffset Not Null,
	primary key (MeetingID, AttendeeID)
);


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


--Q3
use danieljbell
go

insert into Homework4.Attendee(Email, FirstName, LastName)
values
(
	'danieljbell@ksu.edu',
	'Daniel',
	'Bell'
)

insert into Homework4.MeetingAttendee(MeetingID, AttendeeID)
values(
	(
		select M.MeetingID
		from Homework4.Meeting as M
		where M.Meet_Time = 'October 9, 2018 6:30pm' --cast to datetime
	),
	IDENT_CURRENT('Homework4.Attendee')
)


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