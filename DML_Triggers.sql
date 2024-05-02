create schema TriggerSchema


create table TriggerSchema.Employee(
Emp_Id int primary key identity(1,1),
Emp_Name varchar (100) not null,
Emp_Sal decimal(10,2) not null,
Emp_DOB datetime not null,
Emp_Experience int not null,
Record_DateTime  datetime not null);

	--Insert trigger
create trigger trgAfterInsert
on TriggerSchema.Employee
after insert
as
begin
declare @emp_dob varchar(20);
declare @age int ;
declare @emp_Experience int;


select @emp_dob=i.Emp_DOB from  inserted i;
select @emp_Experience =i.Emp_Experience  from  inserted i;

-- employee's age should not be above 25
set @age=year (getdate ())-year(@emp_dob);
if @age >25
begin 
print 'not eligible : age is greater then 25'
rollback
end
else if  @emp_Experience <5
begin
print 'not eligible :experience is less then 5'
rollback
end

else
begin 
print 'employee details inserted succussfully '
end

end

insert into TriggerSchema.Employee(Emp_Name,Emp_Sal,Emp_DOB,Emp_Experience,Record_DateTime)
values  ('smith ',30000,'1994-01-03',6,GETDATE());

select * from TriggerSchema.Employee



	--Update Trigger

/* for update trigger, here i will create a table named as history which will 
contain older and upated values .
*/

create table TriggerSchema.EmployeeHistory
(
Emp_Id int not null,
field_name varchar (100) not null,
old_value varchar (100) not null,
new_value varchar (100) not null,
Record_DateTime datetime not null
)


create trigger trgAfterUpdate 
on TriggerSchema.Employee
after update
as 
begin
declare @emp_id int ;
declare @emp_name varchar(100) ;
declare @old_emp_name varchar(100);
declare @emp_sal decimal(10,2);
declare @old_emp_sal decimal(10,2);


select @emp_id=i.Emp_Id from inserted i;
select @emp_name=i.Emp_Name from inserted i;
select @old_emp_name=i.Emp_Name from deleted i;
select @emp_sal=s.Emp_Sal from inserted s;
select @old_emp_sal=s.Emp_Sal from deleted s;

if update (Emp_Name)
begin 
insert into TriggerSchema.EmployeeHistory (Emp_Id,field_name,old_value,new_value,Record_DateTime) values
(@emp_id,'Emp_Name',@old_emp_name,@emp_name,GETDATE());
end 


if update (emp_sal)
begin
insert into TriggerSchema.EmployeeHistory(Emp_Id,field_name,old_value,new_value,Record_DateTime) values
(@emp_id,'Emp_sal',@old_emp_sal,@emp_sal,GETDATE());
end
end


select * from TriggerSchema.Employee

update TriggerSchema.Employee set Emp_Name='smith' where Emp_Id=2;

-- After update 
select * from TriggerSchema.Employee
select * from TriggerSchema.EmployeeHistory


-- Delete Trigger 

/*
before deleting the records we have to store or backup the records that has to be deleted 
for backing up, here im creating a table to store the deleted one
*/


create table TriggerSchema.EmployeeBackUp
(
Emp_Id int not null,
Emp_Name varchar (100) not null,
Emp_Sal decimal(10,2) not null,
Emp_DOB datetime not null,
Emp_Experience int not null,
Record_DateTime  datetime not null
);


create trigger TriggerSchema.trgAfterDelete
on TriggerSchema.Employee
after delete
as
begin

declare @Emp_id int;
declare @Emp_Name varchar(100);
declare @Emp_Sal decimal (10,2);
declare @Emp_Dob datetime ;
declare @Emp_Experince int ;

select @Emp_id=i.Emp_Id from deleted i;
select @Emp_Name =i.Emp_Name from deleted i;
select @Emp_Sal =i.Emp_Sal from deleted i;
select @Emp_Dob =i.Emp_DOB from deleted i;
select @Emp_Experince=i.Emp_Experience from deleted i;

insert into TriggerSchema.EmployeeBackUp(Emp_Id,Emp_Name,Emp_Sal,Emp_DOB,Emp_Experience,Record_DateTime) values 
(@Emp_id,@Emp_Name,@Emp_Sal,@Emp_Dob,@Emp_Experince,GETDATE());

end

drop trigger TriggerSchema.trgAfterDelete

select * from TriggerSchema.Employee



delete from TriggerSchema.Employee
where Emp_Id=7;


-- After delete

select * from TriggerSchema.Employee
select * from TriggerSchema.EmployeeBackUp