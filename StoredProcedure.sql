-- stored procedure 
--seection 1.
	--creating procedures
CREATE PROCEDURE GetAllRecords
AS
BEGIN
    SELECT * FROM emptable;
END;

EXEC GetAllRecords;



CREATE PROCEDURE GetEmployeeByID
    @employeeID INT
AS
BEGIN
    SELECT * FROM emptable WHERE eid = @employeeID;
END;

exec GetEmployeeByID 7839;


CREATE PROCEDURE AddEmployee
    ename VARCHAR(50),
    dno NVARCHAR(50),
    @Sal DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Employees (ename, dno, Salary)
    VALUES (@ename, @dno, @Sal);
END;


CREATE PROCEDURE GetAllRecords
AS
BEGIN
    SELECT * FROM emptable;
END;


EXEC GetAllRecords;



create procedure GetByEmployeeName
as
begin
select * from emptable where ename ='scott';
end;

exec GetByEmployeeName




create procedure GetByEmployeecountry
as
begin
select * from emptable where country ='india';
end;

exec GetByEmployeecountry


-- 
create proc GetAllEmp
as 
select * from emptable


exec GetAllEmp
-- or
execute GetAllEmp

/*The uspProductList is the name of the stored procedure.

The AS keyword separates the heading and the body of the stored procedure.

If the stored procedure has one statement, the BEGIN and END keywords 
surrounding the statement are optional. However, it is a good practice to include them to make the code clear.

Note that in addition to the CREATE PROCEDURE keywords, 
you can use the CREATE PROC keywords to make the statement shorter.
*/


create proc Demo
as 
begin 
select * from depttable
end


exec Demo

-- deleteing the procedure
drop proc Demo



	--Creating a stored procedure with one parameter

	create proc usFindEmployee
	as
	begin
	select ename,
	sal
	from emptable
	order by sal
	end

	exec usFindEmployee


	--altereed 

	ALTER proc dbo.usFindEmployee(@min_salary as decimal)
	as
	begin
	select ename,
	sal
	from emptable
	where SAL>@min_salary
	order by sal
	end

	exec usFindEmployee 2000.0


	--Creating a stored procedure with multiple parameters


	ALTER proc dbo.usFindEmployee(@min_salary as decimal,@max_salary as decimal)
	as
	begin
	select ename,
	sal
	from emptable
	where SAL>@min_salary and 
	SAL<=@max_salary
	order by sal
	end

	exec usFindEmployee 1000.0,2000.0


	create proc add2Num(@num1 int,@num2 as int)
	as 
	begin
	declare @result int ;
	  set @result=@num1+@num2
	select @result 
	end

	drop proc add2Num

	execute add2Num 5,5


	ALTER proc dbo.usFindEmployee(@min_salary as decimal,@max_salary as decimal,@name as varchar(max))
	as
	begin
	select ename,
	sal
	from emptable
	where SAL>@min_salary and 
	SAL<=@max_salary and  
	ename like  '% @name%'

	order by sal
	end

	exec usFindEmployee 1000.0,2000.0,'%mm%'

	-- Using named parameters

	/*In case stored procedures have multiple parameters,
	it is better and more clear to execute the stored procedures using named parameters.
	*/

	exec add2Num @num1=10 ,@num2=10;

	exec usFindEmployee @min_salary=1000, @max_salary=2000.0;

	--Creating optional parameters

	/*
	* When you execute the uspFindProducts stored procedure,
	you must pass all three arguments corresponding to the three parameters.

    * SQL Server allows you to specify default values for parameters so that when you call stored procedures,
      you can skip the parameters with default values.*/


	 ALTER proc dbo.usFindEmployee(
	 @min_salary as decimal=0,
	 @max_salary as decimal=9999.9,   
	 @name as varchar(max)
	 )
	as
	begin
	select ename,
	sal
	from emptable
	where SAL>@min_salary and 
	SAL<=@max_salary and  
	ename like  '% @name%'

	order by sal
	end

	exec usFindEmployee 500.0,5000.0,'%sm%'
	--or
	exec usFindEmployee @name ='smith'


	--Declaring a variable

	/*
	To declare a variable, you use the DECLARE statement. 
	For example, the following statement declares a variable named @model_year:

	DECLARE @model_year SMALLINT;
	*/

	SELECT
    ename,
    hiredate,
    sal 
FROM 
   emptable
WHERE 
    HIREDATE=HIREDATE
ORDER BY
   ename
   --**************************


   DECLARE @hiredate SMALLINT;
SET @hiredate = 2018;
	SELECT
    ename,
    hiredate,
    sal 
FROM 
   emptable
WHERE 
    HIREDATE=HIREDATE
ORDER BY
   ename


   --OUTPUT PARAMETERS

   -- output parameters are used  to return data back to the calling program.


create proc returnEmployeeName(@id int,@name varchar(50) output)
as 
begin
select @name = ENAME from emptable where EID=@id;
end 


declare @name2 varchar(50) ;
exec returnEmployeeName @id=7499, @name=@name2 output ;
select @name2;



create proc returnEmployeeByHredate(@hiredate as  date, @ename as varchar(50) output)
as 
begin
select @ename = ename from emptable where hiredate=@hiredate;
end


declare @ename2 varchar(50);
exec returnEmployeeByHredate '1980-12-17',@ename2 output
select @ename2


--**********************************************************************************************************
-- section -2 
		-- control of flow statements 

	--	we use the BEGIN...END statement to wrap a set of Transact-SQL statements into a statement block.
	/*
	   The BEGIN...END statement is used to define a statement block. 
	   A statement block consists of a set of SQL statements that execute together.
	   A statement block is also known as a batch.

      In other words, if statements are sentences, the BEGIN...END
      statement allows you to define paragraphs.
	*/


BEGIN
    SELECT
       ename
        sal
    FROM
        emptable
    WHERE
       sal>2500

    IF @@ROWCOUNT = 0
        PRINT 'No employees  with sal greater than 2500 found';
END

-- Note that the @@ROWCOUNT is a system variable that returns the number of rows 
--affected by the last previous statement.


	select * from emptable



	--using while conditon

	create proc prInting5Num(@num as int)
	as
	begin
	while(@num<=5)
	begin 
	print @num;
	set @num=@num+1;
	end
	end

	exec prInting5Num 1;

	-- using of break statement 

	create procedure printIngNumUsingBreak
	as 
	begin 
	declare @counter int=1;
	while(@counter<=5)
	begin
	if @counter=4
	break;
	print @counter
	set @counter=@counter+1;
	end
	end

	drop proc printIngNumUsingBreak


	exec printIngNumUsingBreak


	-- using of continue statement 

		/*
		The CONTINUE statement stops the current iteration of the loop and starts the new one.
		The following illustrates the syntax of the CONTINUE statement:

		*/

		create proc deMoByContinue
		as 
		begin
		DECLARE @counter INT = 0;

          WHILE @counter < 5
           BEGIN
           SET @counter = @counter + 1;
           IF @counter = 3
             CONTINUE;	
            PRINT @counter;
             END

			 end


			 exec deMoByContinue



 --**********************************************************************************************************


 -- section 4 -> Handling Exceptions

		-- try catch

	/*	The TRY CATCH construct allows you to gracefully handle exceptions in SQL Server.
	To use the TRY CATCH construct, you first place a group of Transact-SQL statements that could 
	cause an exception in a BEGIN TRY...END TRY block as follows:

	BEGIN TRY  
   -- statements that may cause exceptions
    END TRY  
	BEGIN CATCH  
   -- statements that handle exception
	END CATCH  

	The CATCH block functions
	Inside the CATCH block, you can use the following functions to get the detailed 
	information on the error that occurred:

	ERROR_LINE() returns the line number on which the exception occurred.
	ERROR_MESSAGE() returns the complete text of the generated error message.
	ERROR_PROCEDURE() returns the name of the stored procedure or trigger where the error occurred.
	ERROR_NUMBER() returns the number of the error that occurred.
	ERROR_SEVERITY() returns the severity level of the error that occurred.
	ERROR_STATE() returns the state number of the error that occurred.

	Inside a CATCH block, you can test the state of transactions by using the XACT_STATE() function.

  ->If the XACT_STATE() function returns -1, it means that an uncommittable transaction is pending,
            you should issue a ROLLBACK TRANSACTION statement.
    ->In case the XACT_STATE() function returns 1, it means that a committable transaction is pending.
		You can issue a COMMIT TRANSACTION statement in this case.
	->If the XACT_STATE() function return 0, it means no transaction is pending, 
		therefore, you don’t need to take any action.
	-> It is a good practice to test your transaction state before issuing a COMMIT TRANSACTION or ROLLBACK TRANSACTION statement in a CATCH block to ensure consistency.

	*/


	CREATE PROC usp_divide(
    @a decimal,
    @b decimal,
    @c decimal output
) AS
BEGIN
    BEGIN TRY
        SET @c = @a / @b;
    END TRY
    BEGIN CATCH
        SELECT  
            ERROR_NUMBER() AS ErrorNumber  
            ,ERROR_SEVERITY() AS ErrorSeverity  
            ,ERROR_STATE() AS ErrorState  
            ,ERROR_PROCEDURE() AS ErrorProcedure  
            ,ERROR_LINE() AS ErrorLine  
            ,ERROR_MESSAGE() AS ErrorMessage;  
    END CATCH
END;
GO

declare @r decimal
exec usp_divide 10,2,@r output;
select @r;


  -- Using TRY CATCH with transactions example

	CREATE TABLE persons
(
    person_id  INT 
    PRIMARY KEY IDENTITY, 
    first_name NVARCHAR(100) NOT NULL, 
    last_name  NVARCHAR(100) NOT NULL
);

CREATE TABLE deals
(
    deal_id   INT
    PRIMARY KEY IDENTITY, 
    person_id INT NOT NULL, 
    deal_note NVARCHAR(100), 
    FOREIGN KEY(person_id) REFERENCES persons(
    person_id)
);

insert into 
    persons(first_name, last_name)
values
    ('John','Doe'),
    ('Jane','Doe');

insert into 
    deals(person_id, deal_note)
values
    (1,'Deal for John Doe');


	CREATE PROC usp_report_error
AS
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_LINE () AS ErrorLine  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;  
GO


CREATE PROC usp_delete_person(
    @person_id INT
) AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        -- delete the person
        DELETE FROM persons 
        WHERE person_id = @person_id;
        -- if DELETE succeeds, commit the transaction
        COMMIT TRANSACTION;  
    END TRY
    BEGIN CATCH
        -- report exception
        EXEC usp_report_error;
        
        -- Test if the transaction is uncommittable.  
        IF (XACT_STATE()) = -1  
        BEGIN  
            PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'  
            ROLLBACK TRANSACTION;  
        END;  
        
        -- Test if the transaction is committable.  
        IF (XACT_STATE()) = 1  
        BEGIN  
            PRINT N'The transaction is committable.' +  
                'Committing transaction.'  
            COMMIT TRANSACTION;     
        END;  
    END CATCH
END;
GO


--  using of RAISERROR

/*
The RAISERROR statement allows you to generate your own error messages and
return these messages back to the application using the same format as a 
system error or warning message generated by SQL Server Database Engine.
In addition, the RAISERROR statement allows you to set a specific message id,
level of severity, and state for the error messages.
*/



DECLARE 
    @ErrorMessage  NVARCHAR(4000), 
    @ErrorSeverity INT, 
    @ErrorState    INT;

BEGIN TRY
    RAISERROR('Error occurred in the TRY block.', 17, 1);
END TRY
BEGIN CATCH
    SELECT 
        @ErrorMessage = ERROR_MESSAGE(), 
        @ErrorSeverity = ERROR_SEVERITY(), 
        @ErrorState = ERROR_STATE();

    -- return the error inside the CATCH block
    RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH;

/*
Msg 50000, Level 17, State 1, Line 16
Error occurred in the TRY block.
*/


/*

When to use RAISERROR statement
	You use the RAISERROR statement in the following scenarios:

Troubleshoot Transact-SQL code.
Return messages that contain variable text.
Examine the values of data.
Cause the execution to jump from a TRY block to the associated CATCH block.
Return error information from the CATCH block to the callers, either calling batch or application.
In this tutorial, you will learn how to use the SQL Server 
RAISERROR statement to generate user-defined error messages.

*/




-- using of THROW 


/*
The THROW statement raises an exception and transfers execution 
to a CATCH block of a TRY CATCH construct.

syntax  :
THROW [ error_number ,  
        message ,  
        state ];


		->error_number

The error_number is an integer that represents the exception. 
The error_number must be greater than 50,000 and less than or equal to 2,147,483,647.

	->message
The message is a string of type NVARCHAR(2048) that describes the exception.

->	state
The state is a TINYINT with the value between 0 and 255.
The state indicates the state associated with the message.

If you don’t specify any parameter for the THROW statement, you must place the THROW statement inside a CATCH block:
*/

CREATE TABLE t1(
    id int primary key
);
GO

BEGIN TRY
    INSERT INTO t1(id) VALUES(1);
    --  cause error
    INSERT INTO t1(id) VALUES(1);
END TRY
BEGIN CATCH
    PRINT('Raise the caught error again');
    THROW;
END CATCH

-- adding custom exception message 

EXEC sys.sp_addmessage 
    @msgnum = 50010, 
    @severity = 16, 
    @msgtext =
    N'The order number %s cannot be deleted because it does not exist.', 
    @lang = 'us_english';   
GO


DECLARE @MessageText NVARCHAR(2048);
SET @MessageText =  FORMATMESSAGE(50010, N'1001');   
THROW 50010, @MessageText, 1; 

