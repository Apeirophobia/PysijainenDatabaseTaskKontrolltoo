insert into Items (ItemID, Name, Category, Price, StockAmount)
values(newid(), 'GoodPilow', 'Pillow', 50, 120),
(newid(), 'BadPillow', 'Pillow', 15, 300),
(newid(), 'AveragePillow', 'Pillow', 30, 200),
(newid(), 'BunkBed', 'Bed', 50, 120),
(newid(), 'KingSizeBed', 'Bed', 50, 120),
(newid(), 'Armchair', 'Chair', 50, 120)

-- delete from Item where ItemID = 'F84FCE61-61E3-48F9-9AE6-9E5186D32138' 



select * from Items

insert into Branches (BranchID, Name, PhoneNumber)
values
(newid(), 'Puidu-Padi Tallinn', 50055005),
(newid(), 'Puidu-Padi Tartu', 50055004),
(newid(), 'Puidu-Padi Pärnu', 50055003),
(newid(), 'Puidu-Padi Valga', 50055002),
(newid(), 'Puidu-Padi Haapsalu', 50055001)

select * from Branches

insert into Employees (EmployeeID, FirstName, LastName, DepartmentName, Salary, BranchID)
values
(newid(), 'Jake', 'Dog', 'Warehouse Management', 1500, CAST('6351FF6A-F9AE-4E88-B7BC-5963E4DF05C3' as uniqueidentifier)),
(newid(), 'Gary', 'Home', 'Cleaning', 1500, CAST('D17B71AF-8280-480D-919A-6D3A4C0A39A9' as uniqueidentifier)),
(newid(), 'Luke', 'Warm', 'Customer Service', 1500, CAST('95B7EB4A-D581-4DE6-AD21-7E3BD89E711E' as uniqueidentifier)),
(newid(), 'Ash', 'Fire', 'Customer Service', 1500, CAST('95B7EB4A-D581-4DE6-AD21-7E3BD89E711E' as uniqueidentifier)),
(newid(), 'Alice', 'Wonder', 'Warehouse Management', 1500, CAST('6351FF6A-F9AE-4E88-B7BC-5963E4DF05C3' as uniqueidentifier))

delete from Employees where EmployeeID = '94716CEA-9135-4BEC-B03B-657C9C44B850'

select * from Employees

insert into Sales (SalesID, Date, Total, CustomerID, EmployeeID, ItemID)
values
(newid(), '11.30.2025', 200, CAST('19268CA4-B10B-40A9-A8F2-0FE9B087585E' as uniqueidentifier), -- 1
CAST('65AB1404-71E0-42A6-93A6-8C0F290D84D5' as uniqueidentifier), CAST('61831D06-D83A-4C0E-B55E-C668F291BC34' as uniqueidentifier)), -- 1
(newid(), '11.30.2025', 200, CAST('D2326B67-84FD-4956-874E-B1C514DEDED1' as uniqueidentifier), -- 2
CAST('65AB1404-71E0-42A6-93A6-8C0F290D84D5' as uniqueidentifier), CAST('3777B98A-2F7C-4A2C-B838-CA6C64AEB3DA' as uniqueidentifier)), -- 2
(newid(), '11.30.2025', 200, CAST('8389AD1B-617A-42AC-83E6-C2275234C2AB' as uniqueidentifier), -- 3
CAST('95579E35-BC2A-4433-BAE2-BE8FBB64CF22' as uniqueidentifier), CAST('61831D06-D83A-4C0E-B55E-C668F291BC34' as uniqueidentifier)), -- 3
(newid(), '11.30.2025', 200, CAST('D2326B67-84FD-4956-874E-B1C514DEDED1' as uniqueidentifier), -- 4
CAST('95579E35-BC2A-4433-BAE2-BE8FBB64CF22' as uniqueidentifier), CAST('CAB0D87D-F945-48A4-AA52-F9F3D04AF7AD' as uniqueidentifier)), -- 4
(newid(), '11.30.2025', 200, CAST('E21CCC7F-21C3-4A62-A069-C74BDA39B678' as uniqueidentifier), -- 5
CAST('95579E35-BC2A-4433-BAE2-BE8FBB64CF22' as uniqueidentifier), CAST('EC17F484-8EE5-4804-80EA-CB4BF62E0571' as uniqueidentifier)) -- 5

select * from Sales

insert into Customers (CustomerID, FirstName, LastName, PhoneNumber, Email)
values
(newid(), 'Shrek', 'Swamp', 55771122, 's@rek.swamp'),
(newid(), 'Leopold', 'Cat', 55771123, 'l@pold.cat'),
(newid(), 'Stone', 'Material', 55771124, 's@tone.material'),
(newid(), 'Derek', 'Friend', 55771125, 'd@rek.friend'),
(newid(), 'Meep-Meep', 'Roadrunner', 55771126, 'm@m.roadrunner')

select * from Customers

create proc spSearchEmployeesGoodDynamicSQL
	@FirstName nvarchar(100) = null,
	@LastName nvarchar(100) = null,
	@DepartmentName nvarchar(50) = null,
	@Salary int = null
	as begin
	declare @sql nvarchar(max)

	set @sql = 'Select * from Employees where 1 = 1'
	if(@FirstName is not null)
		set @sql = @sql + ' and FirstName=@FN'
	if(@LastName is not null)
		set @sql = @sql + ' and LastName=@LN'
	if(@DepartmentName is not null)
		set @sql = @sql + ' and DepartmentName=@DN'
	if(@Salary is not null)
		set @sql = @sql + ' and Salary=@Sal'

	execute sp_executesql @sql,
		N'@FN nvarchar(50), @LN nvarchar(50), @DN nvarchar(50), @Sal int',
		@FN = @FirstName, @LN = @LastName, @DN = @DepartmentName, @Sal = @Salary
end
go

select Sales.SalesID, Sales.CustomerID, Sales.Date
from Sales
left join Customers on Sales.CustomerID = Customers.CustomerID

select Sales.SalesID, ItemID, Sales.EmployeeID, Sales.Date
from Sales
inner join Employees on Sales.EmployeeID = CAST('65AB1404-71E0-42A6-93A6-8C0F290D84D5' as uniqueidentifier)

select * from
Employees
inner join Branches on Branches.BranchID = CAST('6351FF6A-F9AE-4E88-B7BC-5963E4DF05C3' as uniqueidentifier)
where Employees.BranchID = CAST('6351FF6A-F9AE-4E88-B7BC-5963E4DF05C3' as uniqueidentifier)