  -- Cursor 
		/* A database cursor is an object that enables traversal over the rows of a result set.
		It allows you to process individual row returned by a query.
		*/



		create  table Students   
    (  
      Id INT ,  
      RollNo INT ,  
      EnrollmentNo NVARCHAR(15) ,  
      Name NVARCHAR(50) ,  
      Branch NVARCHAR(50) ,  
      University NVARCHAR(50)  
    ) 

	drop table Students

INSERT  INTO Students  
        ( Id, RollNo, EnrollmentNo, Name, Branch, University )  
VALUES  ( 1, 1, N'', N'Nikunj Satasiya', N'CE', N'rymec' ),  
        ( 2, 2, N'', N'Hiren Dobariya', N'CE', N'rymec' ),  
        ( 3, 3, N'', N'Sapna Patel', N'IT', N'bitm' ),  
        ( 4, 4, N'', N'Vivek Ghadiya', N'CE', N'reva university' ),  
        ( 5, 5, N'', N'Pritesh Dudhat', N'CE', N'jyoti engieering collage' ),  
        ( 5, 5, N'', N'Hardik Goriya', N'EC', N'pes University' ),  
        ( 6, 6, N'', N'Sneh Patel', N'ME', N'RK University' ) ;



DECLARE @Id INT ,  
@RollNo INT,  
@Branch NVARCHAR(50) ,  
@Year AS INT  
   
SET @Year = RIGHT(YEAR(GETDATE()), 2)  
   
DECLARE MY_data CURSOR  
FOR  
    SELECT  Id ,  
            Branch,  
            RollNo,  
            @Year  
    FROM    Students  
   
OPEN MY_data  
FETCH NEXT FROM MY_data INTO @Id, @Branch, @RollNo,@Year  
WHILE @@FETCH_STATUS = 0  
    BEGIN  
        DECLARE @EnrollmentNo NVARCHAR(15)  
                SET @EnrollmentNo = 'SOE' + CAST(@Year AS VARCHAR(2)) + CAST(@Branch AS NVARCHAR(50)) + '000' + CAST(@RollNo AS NVARCHAR(10))  
                  
                UPDATE Students SET EnrollmentNo =  @EnrollmentNo WHERE Id =	Id  
   
        FETCH NEXT FROM MY_data INTO  @Id, @Branch, @RollNo,@Year  
    END  
CLOSE MY_data  
DEALLOCATE MY_data 