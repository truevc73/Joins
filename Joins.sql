Use MetroAlt
/*
Select * from BusType
Select * from Bus
Select * from BusBarn
Select * from BusDriverShift
Select * from BusRoute
Select * from BusRouteStops
Select * from BusRouteStopSchedule
Select * from BusScheduleAssignment
Select * from BusStop
Select * from BusType
select * from Employee
select * from EmployeePosition
select * from Fare
select * from Position
select * from Ridership
*/

select positionKey
from position

--1) Create a cross join between employees and bus routes to show all possible 
--combinations of routes and drivers (better use position to 
--distinguish only drivers this involves a cross join and an inner join. I will accept either)
Select employeeLastName, BusrouteKey
From dbo.employee
inner join dbo.EmployeePosition
on dbo.Employee.EmployeeKey = dbo.EmployeePosition.EmployeeKey
Cross join dbo.BusRoute
Where PositionKey = 1

--2) List all the bus type details for each bus assigned to bus barn 3
Select * From Bus
Select * From BusType
Select * From BusBarn

Select BusKey, BusPurchaseDate, BusBarnAddress, BusBarnCity, BusBarnZipCode, BusBarnPhone, 
BusTypeCapacity, BusTypeEstimatedMPG, BusTypeDescription
From dbo.Bus
JOIN Bustype
On Bus.BustypeKey = Bustype.BustypeKey 
join BusBarn
On Bus.BusKey = bus.BusBarnKey

--3) What is the total cost of all the busses at bus barn 3
Select sum(BustypePurchasePrice) as [Total BusCost]
From dbo.Bustype
join BusBarn
On BusType.BusTypeKey = BusBarn.BusBarnKey
 
--4) What is the total cost per type of bus at bus barn 3
Select Bus.BusTypekey, sum(BustypePurchasePrice) as [Total BusCost]
From dbo.Bustype
Join Bus
On Bustype.BusTypeKey = Bus.BusTypekey
Where BusBarnKey = 4
Group by Bus.BusTypekey

--5) List the last name, first name, email, position name and hourly pay for each employee
Select EmployeeLastName, EmployeeFirstName, EmployeeEmail, PositionName, EmployeeHourlyPayRate 
From dbo.Employee, Position, EmployeePosition
where Employee.EmployeeKey = EmployeePosition.EmployeeKey
and Position.PositionKey = EmployeePosition.PositionKey

--6) List the bus driver’s last name  the shift times, the bus number (key)  and the bus type
--for each bus on route 43
Select EmployeeLastName, PositionName, BusDriverShiftName, BusTypeDescription
From dbo.Employee
inner join dbo.EmployeePosition
On EmployeePosition.EmployeeKey = Employee.EmployeeKey
inner join Position
on Position.PositionKey = EmployeePosition.PositionKey
inner join BusDriverShift
On Employee.EmployeeKey = BusDriverShift.BusDriverShiftKey
inner join BusScheduleAssignment
On BusScheduleAssignment.EmployeeKey = Employee.EmployeeKey
inner join Bus
On Bus.BusKey = BusScheduleAssignment.BusKey
inner join Bustype
On Bus.BusTypekey = Bustype.BusTypeKey
Where position.PositionKey = 1
Select BusRouteKey, bus.BusKey, BusTypekey, BusBarnKey 
FROM dbo.Bus
JOIN BusScheduleAssignment
ON Bus.BusKey = BusScheduleAssignment.BusKey
Where BusRouteKey = 43

--7) Return all the positions that no employee holds.
SELECT PositionName, EmployeePosition.PositionKey
From Position 
Left outer Join EmployeePosition
ON Position.PositionKey = EmployeePosition.PositionKey
Where EmployeePosition.PositionKey is null

--8) Get the employee key, first name, last name, position key for every driver 
--(position key=1) who has never been assigned to a shift. (This is hard it involves
-- an inner join of several tables and then an outer join with BusscheduleAssignment.)
Select dbo.Employee.EmployeeKey, EmployeeFirstName, EmployeeLastName, BusScheduleAssignmentKey
FROM dbo.Employee
JOIN EmployeePosition
ON dbo.Employee.EmployeeKey = EmployeePosition.EmployeeKey
LEFT OUTER JOIN BusScheduleAssignment
ON Employee.EmployeeKey = BusScheduleAssignment.EmployeeKey
WHERE BusScheduleAssignmentKey is NULL
AND PositionKey = 1
