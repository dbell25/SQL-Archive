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