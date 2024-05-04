
--Views in SQL Server
/*
->Views are virtual tables that hold data from one or more tables. 
	It is stored in the database. A view does not contain any data itself, 
	it is a set of queries that are applied to one or more tables that are stored 
	within the database as an object. Views are used for security purposes in databases.
	Views restrict the user from viewing certain columns and rows.

->In other words, using a view we can apply the restriction on accessing specific rows 
	and columns for a specific user. A view can be created using the tables of the same 
	database or different databases. It is used to implement the security mechanism in the
	SQL Server

*/

-- Uses of View 

/*
->
Views are used to implement the security mechanism in SQL Server.
	Views are generally used to restrict the user from viewing certain columns and rows.
	Views display only the data specified in the query, so it shows only the data that is 
	returned by the query defined during the creation of the view.
	The rest of the data is totally abstract from the end user. 
*/


--Types of views
/*
There are the following two types of views.

User-Defined Views
System-Defined Views

*/

CREATE TABLE [dbo].[Employee_Details]
(
    [Emp_Id] [int] IDENTITY(1,1) NOT NULL,
    [Emp_Name] [nvarchar](50) NOT NULL,
    [Emp_City] [nvarchar](50) NOT NULL,
    [Emp_Salary] [int] NOT NULL,
 CONSTRAINT [PK_Employee_Details] PRIMARY KEY CLUSTERED
   (
    [Emp_Id] ASC
   )

)
 

GO


Insert Into Employee_Details Values('Pankaj','Alwar',25000)
Insert Into Employee_Details Values('Rahul','Jaipur',26000)
Insert Into Employee_Details Values('Rajan','Delhi',27000)
Insert Into Employee_Details Values('Sandeep','Alwar',28000)
Insert Into Employee_Details Values('Sanjeev','Jaipur',32000)
Insert Into Employee_Details Values('Narendra','Alwar',34000)
Insert Into Employee_Details Values('Neeraj','Delhi',29000)
Insert Into Employee_Details Values('Div','Jaipur',25000)
Insert Into Employee_Details Values('Tanuj','Alwar',22000)
Insert Into Employee_Details Values('Nitin','Jaipur',20000)


select * from Employee_Details


CREATE TABLE [dbo].[Employee_Contact]
(
    [Emp_Id] [int] NOT NULL,
    [MobileNo] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Employee_Contact]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Contact_Employee_Details] FOREIGN KEY([Emp_Id])
REFERENCES [dbo].[Employee_Details] ([Emp_Id])
GO

ALTER TABLE [dbo].[Employee_Contact] CHECK CONSTRAINT [FK_Employee_Contact_Employee_Details]
GO


Insert Into Employee_Contact Values(1,'9813220191')
Insert Into Employee_Contact Values(2,'9813220192')
Insert Into Employee_Contact Values(3,'9813220193')
Insert Into Employee_Contact Values(4,'9813220194')
Insert Into Employee_Contact Values(5,'9813220195')
Insert Into Employee_Contact Values(6,'9813220196')
Insert Into Employee_Contact Values(7,'9813220197')
Insert Into Employee_Contact Values(8,'9813220198')
Insert Into Employee_Contact Values(9,'9813220199')
Insert Into Employee_Contact Values(10,'9813220135')


-- creating of view

Create View Employee_View1
as
select * from Employee_Details

select * from Employee_View1


Create View Employee_View2
as
select Emp_Id,Emp_Name,Emp_City from Employee_Details

select * from Employee_View2


Create View Employee_View3
as
select * from Employee_Details where Emp_Id>3

select * from Employee_View3

Create View Employee_View4
as
select Employee_Details.Emp_Id,Employee_Details.Emp_Name,Employee_Details.Emp_Salary,Employee_Contact.MobileNo
from Employee_Details
Left Outer Join
Employee_Contact
on
Employee_Details .Emp_Id= Employee_Contact.Emp_Id
Where Employee_Details.Emp_Id>2

select * from Employee_View4


--retriving from views
Select * from Employee_View4
Select Emp_Id,Emp_Name,Emp_Salary from Employee_View4

--Dropping a View in SQL Server
/*We can use the Drop command to drop a view. For example, 
to drop the view Employee_View3, we can use the following statement.
*/
Drop View dbo.Employee_View1 
select * from Employee_View1


--Renaming the View in SQL Server

/*We can use the sp_rename system procedure to rename a view. 
The syntax of the sp_rename command is given below.
*/
sp_rename Employee_View1 , employee_viewtable

--Getting Information about a view
/*We can retrieve all the information of a view using the Sp_Helptext system Stored Procedure.
Let us see an example.
*/
Sp_Helptext Employee_View4

--Alter View in SQL Server 
/*We can alter the schema or structure of a view. In other words,
we can add or remove some columns or change some conditions that are applied in
a predefined view. Let us see an example.
*/


Alter View Employee_View4
as
select Employee_Details.Emp_Id,Employee_Details.Emp_Name,Employee_Details.Emp_Salary,Employee_Contact.MobileNo from Employee_Details
Left Outer Join
Employee_Contact
on
Employee_Details .Emp_Id= Employee_Contact.Emp_Id
Where Employee_Details.Emp_Id>5 and Employee_Details.Emp_City='Alwar'


--Refreshing a View in SQL Server

/*Let us consider the scenario now by adding a new column to the table Employee_Details
and examine the effect. We will first create a view.
*/

Create View Employee_View1
as
Select * from Employee_Details

--Now add a column in the Employee_Details table  

Alter Table Employee_Details Add MY_sal nvarchar(50)

--Now retrieve the data from the table and view and you will receive the following output.

Select * from Employee_Details
Select * from Employee_View1

/*
-> We don't get the results we expected because the schema of the view is already defined. 
	So when we add a new column to the table it will not change the schema of the view and 
	the view will contain the previous schema. 
	For removing this problem we use the system-defined Stored Procedure sp_refreshview.

-> sp_refreshview is a system-level Stored Procedure that refreshes the metadata of
	any view once you edit the schema of the table. Let's execute the following.
*/

Exec sp_refreshview Employee_View1
Select * from Employee_Details
Select * from Employee_View1

--SchemaBinding a VIEW

/*

In the previous example, we saw that if we add a new column to the table then we must refresh 
the view.

In such a way if we change the data type of any column in a table then we should 
refresh the view. If we want to prevent any type of change in a base table then 
we can use the concept of SCHEMABINDING. It will lock the tables being referred 
to by the view and restrict all kinds of changes that may change the table schema
(no Alter command).


note
We can't specify "Select * from tablename" with the query. We need to specify
all the column names for reference.
*/

Create View Employee_Details3
with SCHEMABINDING
as
select Emp_Id,Emp_Name,Emp_Salary,Emp_City from DBO.Employee_Details

--now we cannot change the datatype of column 

--Encrypt a view in SQL Server

/*The “WITH ENCRYPTION” option can encrypt any views. 
That means it will not be visible via SP_HELPTEXT. 
This option encrypts the definition. This option encrypts the definition of the view.
Users will not be able to see the definition of the view after it is created. 
This is the main advantage of the view where we can make it secure.

*/

Create View Employee_Details4
with Encryption
as
select Emp_Id,Emp_Name,Emp_Salary,Emp_City from DBO.Employee_Details

--Now we try to retrieve the definition of the view.

Exec sp_helptext 'Employee_Details4'

-- output will be "the text object 'Employee_Details4' is encrypted"


--Check Option

/*The use of the Check Option in a view is to ensure that all the Update and Insert
commands must satisfy the condition in the view definition
*/



Create view [dbo].[Employee_Details7]
as
select * from Employee_Details
where Emp_Salary>30000

GO

/*In the preceding example, we create a view that contains all the data 
for which Emp_Salry > 30000 but we can insert the data for a salary less than 30000 as follows.
*/
Insert Into Employee_Details7 values ('ram','mumbai',25000,'Pan')

--For preventing this problem we can use the Check Option property such as.

GO

Create view [dbo].[Employee_Details7]
as
select * from Employee_Details
where Emp_Salary>30000
with Check Option
GO

--Now if we try to execute the preceding query then it will throw an error such as.

Insert Into Employee_Details7 values ('ram','mumbai',25000,'Pan')

/*
Output

Msg 550, Level 16, State 1, Line 1

The attempted insert or update failed because the target view either specifies
WITH CHECK OPTION or spans a view that specifies WITH CHECK OPTION and one or 
more rows resulting from the operation did not qualify under the CHECK OPTION constraint.
*/

