create table Employees(
EmployeeId int not null,
EmployeeName varchar not null,
EmployeeSalary decimal not null,
EmployeeLocation varchar(50) not null,
EmployeeDesignation varchar(50) not null,
primary key(EmployeeId)
);


insert into Employees(EmployeeId,EmployeeName,EmployeeSalary,EmployeeLocation,EmployeeDesignation)
values (1,'Santhosh',30000,'hydrabad','.NetfullstackDeveloper'),
(2,'lokesh',30000,'chennai','.NetfullstackDeveloper'),
(3,'shoiab',30000,'mumbai','.NetfullstackDeveloper'),
(4,'akash',30000,'jaipur','..netdeveloper');

select * from Employees;


alter table Employees
alter column EmployeeName varchar(50); 


-- renameing the column name 
exec sp_rename 'Employees.EmployeeDesignation', 'EmpDesg','column';


insert into Employees values(5,'chirudeep',30000,'hydrabad','.NetfullstackDeveloper');

select * from Employees;

	
