-- stored procedure 


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

exec GetEmployeeByID(1);


CREATE PROCEDURE AddEmployee
    ename NVARCHAR(50),
    dno NVARCHAR(50),
    @Sal DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Employees (ename, dno, Salary)
    VALUES (@ename, @dno, @Sal);
END;

