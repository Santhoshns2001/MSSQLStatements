
-- creating table using all constraint

CREATE TABLE EMP (
    EID INT PRIMARY KEY,
    ENAME VARCHAR(25) NOT NULL,
    JOB VARCHAR(25) NOT NULL,
    MGRID INT,
    HIREDATE DATE NOT NULL,
    SAL DECIMAL NOT NULL,
    COMMISSION INT,
    ENUMBER VARCHAR(20) UNIQUE CHECK (ENUMBER LIKE '[6-9][0-9]%' AND LEN(ENUMBER)=10),
    COUNTRY VARCHAR(20) DEFAULT 'INDIA'
);

DROP TABLE EMP

-- ADDING FOREIGN KEY INTO EMP TABLE 
ALTER TABLE EMP 
ADD DNO INT FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNO);


   -- inserting records into the table

INSERT INTO EMP (EID,ENAME,JOB,MGRID,HIREDATE,SAL,COMMISSION,ENUMBER,DNO) VALUES 
(7369,'SMITH','CLERK',7902,'1980-12-17',800,0,'7894653221',20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,'7896325411',30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,500,'9896325411',30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,0,'8896325411',20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,1400,'6896325411',30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850,0,'9696325411',30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450,0,'8796325411',10),
(7788,'SCOTT','ANALYST',7566,'1987-04-19',3000,0,'8996325411',20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000,0,'6596325411',10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,'7596325411',30),
(7876,'ADAMS','CLERK',7788,'1987-05-23',1100,0,'7196325411',20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950,0,'9196325411',30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000,0,'9296325411',20),
(7934,'MILLE','CLERK',7782,'1982-01-23',1300,0,'9396325411',10);

SELECT * FROM  EMP

CREATE TABLE DEPARTMENT(
DNO INT PRIMARY KEY,
DNAME VARCHAR(100) NOT NULL,
LOC VARCHAR(100) NOT NULL
); 

INSERT INTO DEPARTMENT(DNO,DNAME,LOC) VALUES
(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON');

SELECT * FROM DEPARTMENT


--SELECT * INTO TABLE3 FROM EMP;

--SELECT * FROM TABLE3



SELECT * FROM DEPARTMENT

-- HAVING CLAUSE

SELECT COUNT(*),DNO
FROM EMP
WHERE JOB ='CLERK'
GROUP BY DNO
HAVING COUNT(*)>=2;

SELECT * FROM EMP

SELECT SUM(SAL),DNO
FROM EMP
WHERE JOB ='CLERKS'
GROUP BY DNO
HAVING COUNT(*)>=4


SELECT COUNT(*)
FROM EMP
WHERE SAL>1200
GROUP BY JOB
HAVING COUNT(*) >3800


SELECT COUNT(*),DNO 
FROM EMP
WHERE JOB ='MANAGER'
GROUP BY DNO
HAVING COUNT(*)=2;

SELECT * FROM EMP

SELECT MAX(SAL),JOB  
FROM EMP
GROUP BY JOB
HAVING MAX(SAL)>2600


SELECT SAL
FROM EMP
GROUP BY SAL


SELECT HIREDATE 
FROM EMP
GROUP BY HIREDATE

SELECT AVG(SAL)
FROM EMP
GROUP BY DNO
HAVING AVG(SAL)<3000

SELECT DNO
FROM EMP
WHERE ENAME LIKE '%A%' OR ENAME LIKE '%S%'
GROUP BY DNO
HAVING COUNT(*)=3;

SELECT MIN(SAL),MAX(SAL)
FROM EMP
GROUP BY JOB
HAVING MIN(SAL)>1000 AND MAX(SAL)<5000;

-- grouping sets

	select sal,job
	from emp
	group by 
	grouping sets(
	(sal,job),
	(sal),
	(job),
	()
	);

		

	SELECT JOB,HIREDATE 
	FROM EMP
	GROUP BY 
	GROUPING SETS(
	(JOB,HIREDATE),
	()
	);

	SELECT JOB,HIREDATE
	FROM EMP
	GROUP BY JOB,HIREDATE

	-- CUBE  

	SELECT HIREDATE,JOB
	FROM EmpTab
	GROUP BY 
	CUBE (HIREDATE,JOB)


	SELECT DNO,COUNTRY
	FROM EmpTab
	GROUP BY 
	CUBE(DNO,COUNTRY)

	--ROLLUP

	SELECT JOB, HIREDATE 
	FROM EmpTab
	GROUP BY 
	ROLLUP (JOB,HIREDATE)

	SELECT COUNTRY,JOB
	FROM EmpTab
	GROUP BY 
	ROLLUP(COUNTRY,JOB)


	--SECTION 8
	    --SET OPERTORS

		--SQL Server UNION is one of the set operations that allow you to combine results of two SELECT statements
		--into a single result set which includes all the rows that belong to the SELECT statements in the union.


		--1. UNION
		SELECT ENAME,HIREDATE
		FROM EmpTab
		UNION 
		SELECT ENAME, HIREDATE FROM Employees

		SELECT ENAME,HIREDATE 
		FROM EmpTab
		UNION 
		SELECT ENAME,HIREDATE FROM EMP

		-- UNION ALL

		SELECT ENAME,HIREDATE 
		FROM EmpTab
		UNION ALL
		SELECT ENAME,HIREDATE FROM EMP

		SELECT ENAME,HIREDATE
		FROM EmpTab
		UNION ALL
		SELECT ENAME, HIREDATE FROM Employees

		-- INTERSECT

	--	The SQL Server INTERSECT combines result sets of two or more queries and returns distinct rows that are output by both queries.


		SELECT ENAME,JOB
		FROM EmpTab
		INTERSECT
		SELECT ENAME,JOB
		FROM EMP

		SELECT JOB, COUNTRY
		FROM EMP
		INTERSECT 
		SELECT JOB,COUNTRY
		FROM EmpTab


		--EXCEPT

		--The SQL Server EXCEPT compares the result sets of two queries and returns the distinct
		--rows from the first query that are not output by the second query.
		--In other words, the EXCEPT subtracts the result set of a query from another.


		SELECT EID
		FROM EmpTab
		EXCEPT
		SELECT EID
		FROM Employees

		SELECT EID
		FROM EmpTab
		EXCEPT
		SELECT EID
	    FROM EMP


		 -- Exercise


		

--1  fetch last two rows from a table.
select * from EmpTab
order by ename desc 
offset 0 rows
fetch next 2 rows only

--2 Retrieve all the records from a table where a certain condition is met (e.g., all employees with a salary greater than 50,000).
select * from EmpTab
where sal>50000


--3. Group data from a table based on a specific column and apply aggregate functions on each group (e.g., find the total sales amount for each product category).
select eid,sum(sal) as total_sal
from Employees
group by eid


--4. Use OFFSET and FETCH to retrieve 2 records from a table, skipping 2 rows .

select * from Employees
order by eid
offset 2 rows
fetch next 2 rows only;

--5. Retrieve all orders placed in January 2024

select hiredate 
from EmpTab
where hiredate between '2024-01-01' and '2024-01-31';

--6.Retrieve all customers whose names start with 'J'.

select * from EmpTab
where ename like 'j%';