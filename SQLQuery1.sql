select * from Student;

use FirstDatabase;


select * from Employees;

drop table Employees;

truncate table Employees;

create table Employees (
EmployeeId int primary key Identity(1,1),
EmployeeName varchar(30) not null,
EmployeeDesig varchar(30) not null,
EmployeeSalary decimal not null,
EmployeeAddress varchar(50) not null,
);

select * from Employees;

use FirstDatabase
select * from Student;



	

