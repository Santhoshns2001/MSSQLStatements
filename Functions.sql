	-- Basic inbuilt funtions 



--GETDATE(): Returns the current system date and time.
SELECT GETDATE();

--LEN(): Returns the length of a string.
SELECT LEN('Hello');

--UPPER(): Converts a string to uppercase.
SELECT UPPER('hello');

--LOWER(): Converts a string to lowercase.
SELECT LOWER('HELLO');

--CONCAT(): Concatenates two or more strings.
SELECT CONCAT('Hello', ' ', 'World');

--LEFT(): Returns the left part of a string with a specified number of characters.
SELECT LEFT('Hello World', 5);

--RIGHT(): Returns the right part of a string with a specified number of characters.
SELECT RIGHT('Hello World', 5);

--LTRIM(): Removes leading spaces from a string.
SELECT LTRIM('   Hello');

--RTRIM(): Removes trailing spaces from a string.
SELECT RTRIM('Hello   ');

--SUBSTRING(): Extracts a substring from a string.
SELECT SUBSTRING('Hello World', 7, 5);


--Practice user defined functions

CREATE FUNCTION dbo.AddTwoNumbers (@num1 INT, @num2 INT)
RETURNS INT
AS
BEGIN
    DECLARE @result INT;
    SET @result = @num1 + @num2;
    RETURN @result;
END;

--calling above functions
print dbo.AddTwoNumbers(5,7);


CREATE FUNCTION dbo.GetEmployeesByDepartment (@departmentNo int(10)
RETURNS INT
AS
RETURN
(
    SELECT eid, ename, dno
    FROM emptable
    WHERE dno = @departmentNo
);


SELECT * FROM dbo.GetEmployeesByDepartment(10);



create function AddDigit(@num1 int, @num2 int)
returns int
as 
begin 
declare @result int;
set @result = @num1+@num2;
return @result 
end


select dbo.AddDigit(5,7);


create table Students(

SID INT NOT NULL PRIMARY KEY,
SNAME VARCHAR(50) NOT NULL, 
ROLL_NO INT NOT NULL UNIQUE,
SCIENCE FLOAT NOT NULL DEFAULT 0,
MATHS FLOAT NOT NULL DEFAULT 0,
SOCIAL FLOAT NOT NULL DEFAULT 0,
);


INSERT INTO Students (SID,SNAME,ROLL_NO,SCIENCE,MATHS,SOCIAL) VALUES(1,'ABHI',1,35,42,65),
(2,'ABHI',2,36,42,65),
(3,'BARGHAV',3,45,52,75),
(4,'CHARAN',4,55,62,85),
(5,'DEEPAK',5,65,72,95),
(6,'ESHWAR',6,37,82,45);

SELECT * FROM Students


CREATE FUNCTION GET_AVG(@ROLL_NO INT)
RETURNS DECIMAL 
AS 
BEGIN
DECLARE  @RESULT DECIMAL;
select @RESULT = (SCIENCE+MATHS+SOCIAL) /3 FROM STUDENTS WHERE ROLL_NO=@ROLL_NO;
RETURN @RESULT
END


select SID,SNAME,ROLL_NO,SCIENCE,MATHS,SOCIAL,dbo.TOTAL_MARKS(ROLL_NO) AS TOTAL_MARKS, dbo.GET_AVG(ROLL_NO) AS AVERGAE  from Students

SELECT * FROM STUDENTS


 -- creating table valued functions
     -- there are two types of table valued functions
	 --1. inline table value function



	 create function  GetStudentList(@total int)
	 returns table 
	 as 
	 return select * from Students where (SCIENCE+MATHS+SOCIAL) >@total;

	 select * from dbo.GetStudentList(150);




