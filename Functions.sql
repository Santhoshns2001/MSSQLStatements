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




--Practice

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


CREATE FUNCTION dbo.AverageSalaryByDepartment (@departmentName NVARCHAR(100))
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @avgSalary DECIMAL(10, 2);

    SELECT @avgSalary = AVG(Salary)
    FROM Employees
    WHERE Department = @departmentName;

    RETURN @avgSalary;
END;


SELECT dbo.AverageSalaryByDepartment('IT');


CREATE FUNCTION dbo.ReverseString (@inputString NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @reversedString NVARCHAR(MAX);
    SET @reversedString = REVERSE(@inputString);
    RETURN @reversedString;
END;


SELECT dbo.ReverseString('Hello'); 



CREATE FUNCTION dbo.CalculateAge (@birthdate DATE)
RETURNS INT
AS
BEGIN
    DECLARE @age INT;
    SET @age = DATEDIFF(YEAR, @birthdate, GETDATE());
    RETURN @age;
END;


SELECT dbo.CalculateAge('1990-05-15'); 


CREATE FUNCTION dbo.Square (@number INT)
RETURNS INT
AS
BEGIN
    RETURN @number * @number;
END;


SELECT dbo.Square(5); -- Output: 25
