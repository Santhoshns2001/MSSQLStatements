use FirstDatabase





select * into CloneEmpTab
from EMP

select * from CloneEmpTab



select * into CloneDeptTab
from DEPARTMENT



alter table CloneEmpTab
add constraint frk_eid foreign key (EID) references CloneDeptTab (EID)


alter table CloneEmpTab
add constraint primary_key_ref  primary key (EID)


select * from CloneDeptTab

alter table CloneDeptTab
add  EID int

alter table CloneDeptTab
add constraint forign_key_ref foreign key (EID) references CloneEmpTab (EID)

select * from PRODUCT_LIST

alter table PRODUCT_LIST
ADD CONSTRAINT CHK_PCOST CHECK(PCOST>0)

--ALTER TABLE PRODUCT_LIST
--ADD DISCOUNT DECIMAL NOT NULL, CONSTRAINT DEF_REF default (0.0),
--constraint chk_discount check (DISCOUNT>=0 AND DISCOUNT<=PCOST)


ALTER TABLE PRODUCT_LIST
ADD DISCOUNT DECIMAL NOT NULL DEFAULT 0.0,
CONSTRAINT CHK_discount CHECK (DISCOUNT >= 0 AND DISCOUNT <= PCOST);









-- 5th week (1st sql) review questions on sql

--1.Select the top 5 departments with the highest total salary:

SELECT TOP 5 DNO, SUM(SAL) AS TotalSalary
FROM CloneEmpTab
GROUP BY DNO
ORDER BY TotalSalary DESC; 



--2. --Select the names of all employees who have a name that contains the string "son":

select * from CloneEmpTab
where ename like '%son%';

select * from CloneEmpTab

--3. convert a primary key into foreign key

 ALTER TABLE CloneEmpTab
ADD CONSTRAINT fk_emp_ref FOREIGN KEY (DNO) REFERENCES Departments(DNO);


--4)Write an SQL query to retrieve the total sales amount for each product category from the Sales table.

SELECT  SUM(pcost) AS TotalSalesAmount
FROM PRODUCT_LIST
GROUP BY cataegory;

select * from PRODUCT_LIST





alter table PRODUCT_LIST
add cataegory varchar(100)


exec sp_rename CloneEmpTab,emptable


select * from emptable

   --practice on subqueries

select ename 
from emptable
where sal>2500


select ename 
from emptable
where sal >(select sal
from emptable 
where ename ='miller')


select ename 
from emptable 
where sal >(select sal
from emp
where ename ='adams')


select ename,sal from emptable
where sal<(select sal
from emptable 
where ename ='king');

select ename,dno
from emp
where dno=(select dno 
from emptable 
where ename ='jones')

select ename ,job 
from emptable 
where job=(select job
from emptable
where ename ='james');


select eid,ename, sal*12 as Salary
from emptable
where Sal > (select sal*12 
from emptable
where ename ='wards');


select ename ,hiredate 
from emptable
where hiredate <(select hiredate 
from emptable 
where ename ='scott')


select ename,hiredate 
from emptable
where hiredate >(select hiredate 
from emptable
where job='president')


select ename ,sal
from emptable 
where sal<(select sal
from emptable 
where eid=7839);


select count(*)
from emptable
where dno=10  and job=(select job 
from emptable 
where ename ='smith')

select ename ,hiredate 
from emptable
where hiredate >'31-dec-1980' and hiredate <(select hiredate 
from emptable 
where ename ='king')


select ename 
from emptable
where ename like '%a%' and dno=(select dno
from emptable
where ename ='blake')

select ename ,sal ,hiredate 
from emptable 
where hiredate > (select hiredate from emptable where ename='smith')  and sal<(select sal
from emptable 
where ename ='james')

select ename,sal
from emptable
where sal*12 >(select sal*12 from emptable where ename ='miller')
 and sal <(select sal*12
 from emptable
 where ename ='scott')


select loc from depttable 
where dno =(select dno from emptable 
where ename ='scott')


select ename 
from emptable 
where dno =(select dno
from depttable
where loc='london')


select * from depttable

select sal
from emptable 
where dno=(select dno 
from depttable 
where dno=20)


select loc 
from depttable 
where dno=(select dno
from emptable 
where eid=7902)

select * from depttable

select ename 
from emptable 
where dno=(select dno
from depttable 
where dname ='accounting')


select ename, sal
from emptable 
where dno=(select dno
from depttable 
where loc='chicago')


select emptable.* ,sal*12 as Annual_Sal
from emptable
where dno=(select dno
from depttable 
where loc ='new york')


select ename 
from emptable 
where sal> (select sal from emptable 
where ename ='scott') and dno=(select dno 
from depttable 
where dname ='accounting')

