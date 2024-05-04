

-- DDL Operations

create table test
(id int)

-- trigger for creating table
create trigger trgPreventCreateTable
on database 
for create_table
as
begin
print 'you cannot create the in this database'
rollback transaction
end

drop trigger trgPreventCreateTable  on database

create table test2 (id int)
  
  -- trigger for altertion

create trigger trgPreventAlterTable 
on database 
for alter_table
as
begin
print 'you cannot alter any of the table in this database'
rollback transaction
end

drop trigger trgPreventAlterTable on database


alter table test 
add ename varchar(100)

-- drop trigger 

create trigger trgPreventDropTable
on database
for drop_table
as
begin
print 'you cannot delete the table in this database'
end


drop trigger trgPreventDropTable on database


-- Event group

create trigger trgDDLTable
on database
for create_table, alter_table,drop_table
as 
begin
print 'you cannot  create or alter or delete the table in this database'
end

drop trigger trgDDLTable on database
   --or
create trigger trgDemo
on database
for ddl_table_events
as 
begin
print 'you cannot  create or alter or delete the table in this database'
end

/*
scope 1. database
	  2. all server

on database -> can be accessed only within the database 
on all server -> can be accessed on all specified databases
*/

-- trigger using all server

create trigger trgScopeDemo
on all server
for ddl_table_events
as 
begin
print 'you cannot  create or alter or delete the table in this database'
end

drop trigger trgScopeDemo on all server




create table DDLAudit
(
DatabaseName  nvarchar(250),
TableName nvarchar(250),
EventType nvarchar(250),
LoginName nvarchar(250),
SQLCommand nvarchar(250),
AuditDateTime datetime

)



create database MyDatabase
use MyDatabase


create trigger trgDDLAuditTableChanges
on all server
for ddl_table_events
as
begin
declare @EventData  xml;
select @EventData=EVENTDATA();
insert into MyDatabase.dbo.DDLAudit (DatabaseName,TableName,EventType,LoginName,SQLCommand,AuditDateTime)
values(
@EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]','varchar(250)'),
@EventData.value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(250)'),
@EventData.value('(/EVENT_INSTANCE/EventType)[1]','varchar(250)'),
@EventData.value('(/EVENT_INSTANCE/LoginName)[1]','varchar(250)'),
@EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]','varchar(2500)'),
GETDATE()
);

end

disable trigger trgDDLAuditTableChanges
on all server


	use MyDatabase
	create table testing(id int)

	drop table testing


	select * from DDLAudit


