use FirstDatabase
-- creating a table 
create table Customers(
CustomerId int primary key ,
CustomerName varchar(50) not null, 
CustomerNumber bigint not null,
CustomerAddress  varchar(50) not null
)

drop table customers
select * from Customers;

--alter table  Customers 
--alter CustomerId int primary key indentity(1,1)

insert into Customers values(1,'santhosh',9110894393,'ballari');


insert into Customers (CustomerId,CustomerName,CustomerNumber,CustomerAddress) 
values(2,'lokesh',8512346971,'bidar'),
(3,'shoiab',741859612,'anantpuram'),
(4,'chirudeep',789632111,'tirupati');

alter table Customers
drop column   CustomerId;

alter table Customers
drop constraint CustomerName;

delete from Customers;


truncate table Customers

drop table Customers

select * from Customers


--create table Customers (
--CustomerId int primary key identity(1,1),
--CustomerName varchar(50) not null,
--CustomerPhNo decimal not null,
--CustomerAddress varchar(50) not null,

--);


-- inserting a record into the table
insert into Customers values('santhosh',9110894393,'ballari');


--inserting multiple  records in single statement
insert into Customers (CustomerName,CustomerPhNo,CustomerAddress) 
values('lokesh',8512346971,'bidar'),
('shoiab',741859612,'anantpuram'),
('chirudeep',789632111,'tirupati');


-- adding check constraint to the customerphone number column 
alter table Customers
add constraint CustomerPhNo check(CustomerPhNo not like '[6-9][0-9]%' and len(CustomerPhNo)=10);


-- adding column to the existing table
alter table Customers 
add  CustomerSalary decimal ;

select * from Customers


-- adding new values into the created column
update Customers
set CustomerSalary=30000

select * from Employees

-- adding a column into the table 
alter table Customers
add EmployeeId int;

-- adding foreign key into to customers table 
alter table Customers
add constraint EmployeeId
foreign key (EmployeeId)
references Employees (EmployeeId);

select *from CustomerDetails

insert into Employees(EmployeeName,EmployeeDesig,EmployeeSalary,EmployeeAddress) 
values ('santhosh','developer',30000,'ballari'),
('lokesh','developer',30000,'bidar'),
('shoiab','developer',30000,'anantpuram'),
('chirudeep','developer',30000,'tirupati');


select * from Employees

select * from CustomerDetails

--renameing table 
exec  sp_rename 'Customers','CustomerDetails';

--renameing column name 
exec sp_rename 'CustomerDetails.CustomerSalary','Salary','column';	

exec sp_rename 'CustomerDetails.CustomerPhNo', 'CustomerNumber','column';



-- Today's task

-- Section 1

-- select statment
use  FirstDatabase

select * from Employees

select * from Employees
where EmployeeAddress='ballari';

select * from CustomerDetails


select * from Employees

use  FirstDatabase

select * from Employees

exec sp_rename 'Employees.EmployeeName','EName','column';

exec sp_rename 'Employees.EmployeeId','EId','column';

alter table Employees 
add  Job varchar(50) ;

alter table Employees
add MGR int ;

alter table Employees
add Hiredate date ;

select * from Employees

exec sp_rename 'Employees.EmployeeSalary','Sal','column';

exec sp_rename 'Employees.EmployeeAddress','ADDRESS','column';

exec sp_rename 'Employees.EId','EID','column';

exec sp_rename 'Employees.EName','ENAME','column';

exec sp_rename 'Employees.Sal','SAL','column';

exec sp_rename 'Employees.Job','JOB','column';

exec sp_rename 'Employees.Hiredate','HIREDATE','column';



alter table Employees
drop column  EmployeeDesig;

alter table Employees
add COMM  int;

select * from Employees


update Employees
set EName='SMITH'
WHERE EId=3;

update Employees
set EName='ALLEN'
WHERE EId=4;

update Employees
set EName='WARD'
WHERE EId=5;

update Employees
set EName='JONES'
WHERE EId=6;

SELECT * FROM Employees

--INSERT INTO Employees (ENAME,SAL,ADDRESS,JOB,HIREDATE,MGR,COMM) VALUES 
--('MARTIN',1250,'SALESMAN','1981-09-28',7698,1400);

update Employees
set JOB='CLERK',HIREDATE='1981-12-17',MGR=7902,SAL=800
WHERE EID=3

update Employees
set JOB='SALESMAN',HIREDATE='1981-02-20',MGR=7698,Sal=1600,COMM=500
WHERE EID=4


update Employees
set JOB='SALESMAN',HIREDATE='1981-02-22',MGR=7698,SAL=1250,COMM=500
WHERE EID=5

SELECT * FROM Employees

update Employees
set JOB='MANAGER',HIREDATE='1981-04-02',MGR=7839,SAL=2975
WHERE EID=6


select ename, sal*12 as ANN_SAL
from Employees

select ename,job ,sal*6 as half_ann_sal
from Employees


select sal+sal*10/100
from Employees

select sal*2
from Employees

select * from Employees
where job='manager'

select ename,hiredate
from Employees
where hiredate<'1981-01-01'

select ename,sal
from Employees
where comm =1400

select * from Employees
where job='salesman'



-- Section 2
-- SORTING THE Data

select ename 
from Employees
order by EName

select ename 
from Employees
order by Ename desc;

select * from Employees
order by sal  


select * from Employees
order by comm


select * from Employees
order by Hiredate


select * from Employees
order by job,
ename desc;


-- seection 3
			-- limiting rows

			--The OFFSET and FETCH clauses are the options of the ORDER BY clause. 
			--They allow you to limit the number of rows to be returned by a query.


			-- offset fetch using

			select * from Employees
			order by sal,ename
			offset 2 rows        -- in this initailly the sal column is sort in ascending  order and removing first two rows and printing remaining rows



			select * from Employees
			order by sal,ename
			offset 2 rows
			fetch next 1 rows only


			-- SELECT TOP Using 

			select top 2
			ename ,job
			from Employees
			order by sal desc

			select top 5 *
			from Employees
			order by sal desc
				



--Section 4   
      -- Filtering data

	  -- returns unique results that are in select 

		-- Distinct use
	  select distinct hiredate 
	  from Employees

	  select distinct * from employees

	  select distinct job 
	  from Employees

		-- where clause use

		select * from Employees
		where sal>1000

		select * from Employees
		where ename='allen'

		select * from Employees
		where HIREDATE>'1981'

		select * from Employees
		where comm is not null

		select * from Employees
		where job ='salesman'

			-- AND Operator use

			select * from Employees
			where SAL>1000 and job='salesman'


			select ename, job 
			from Employees
			where sal<4000 and sal>1500


			select * from Employees
			where job='clerk' and sal<3000;

			-- OR Operator use

			select ename, job 
			from Employees
			where job='manager' or sal>1000;


			select * from Employees
			where ename='scott' or sal>comm

			select ename 
			from Employees
			where job='salesman' or job='manager'

			select * from Employees
			where job='salesman' or job='manager' or job='clerk';


			   --IN Operator 

			   select * from Employees

			   select eid,ename,job 
			   from Employees
			   where job in('manager','clerk','salesman')

			   select * 
			   from Employees
			   where eid in(3,4,5,6)

			   select ename,job,hiredate,sal
			   from Employees
			   where job in('salesman','clerk') and sal>1000 

			  -- Between Operator

			  select ename,sal 
			  from Employees
			  where sal between 1000 and 2000;


			  select * from Employees
			  where hiredate between    '1980-01-01'and '1982-12-31' 


			  select eid,ename,hiredate,sal
			  from Employees
			  where job='analyst' and sal between 2000 and 4000;

			  select * from Employees
			  where HIREDATE between '1981-01-01' and '1981-12-31'


			    select * from Employees
			  where HIREDATE between '1987-01-01' and '1987-12-31'


			  -- Like opreator

			  select * 
			  from Employees
			  where ename like 'a%';

			  select ename,job from Employees
			  where ename like '%r';

			  select ename from Employees
			  where ename like 'm%n';

			  select * from Employees
			  where job like 's%';

			  select ename, hiredate 
			  from Employees
			  where HIREDATE like '%-02-%';

			  select * from Employees

			   select ename, hiredate 
			  from Employees
			  where HIREDATE like '%-22';

			  -- Alias Operator

			  select sal*12 as Ann_sal
			  from Employees

			  select sal*6 as half_ann_sal
			  from Employees


		-- section 6 grouping data 
		
			-- group by 

			select sum(sal),job
			from Employees
			group by job


			select count(*)
			from Employees
			group by SAL

			select count(*)
			from Employees
			where sal>1000
			group by job

			-- having 
			-- it is used to filter group by  clause 

			select count(*) 
			from Employees
			group by sal
			having count(*)>=2


			select ename from Employees
			group by  ename
			having  count(*)>=1;


			select * from Employees









