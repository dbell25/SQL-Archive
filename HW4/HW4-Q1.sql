--Q1
create schema Homework4
go
use danieljbell;

create table Homework4.Club
(
	Clubid int NOT NULL identity(1, 1) primary key,
	MemberName nvarchar(45) Not Null,
	Purpose nvarchar(45) Not Null,
	CreatedOn datetimeoffset Not Null,
	UpdatedOn datetimeoffset Not Null
	unique
	(
		MemberName	
	)
);

create table Homework4.Meeting
(
	MeetingID int Not Null primary Key,
	clubID int Not Null identity(1, 1) foreign key references Homework4.Club(ClubID),
	Meet_Time datetime2(0) Not Null,
	Meet_Location nvarchar(45) Not Null,
	CreatedOn datetimeoffset Not Null,
	UpdatedOn datetimeoffset Not Null
	unique
	(
		clubID,
		Meet_Time
	)
);

create table Homework4.Attendee
(
	AttendeeID int Not Null identity(1, 1) primary key,
	Email nvarchar(45) Not Null,
	FirstName nvarchar(45) Not Null,
	LastName nvarchar(45) Not Null,
	CreatedOn datetimeoffset Not Null,
	UpdatedOn datetimeoffset Not Null
);

create table Homework4.MeetingAttendee
(
	MeetingID int Not NUll foreign key references Homework4.Meeting(MeetingID),
	AttendeeID int Not NUll foreign key references Homework4.Attendee(AttendeeID),
	CreatedOn datetimeoffset Not Null,
	primary key (MeetingID, AttendeeID)
);