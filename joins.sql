-- joins 

	-- Inner join  -> selects the records that have matching values in both tables 

	select * from emptable inner join depttable 
	on emptable.dno=depttable.dno


	select ename,loc
	from emptable inner join depttable 
	on emptable.dno =depttable.dno


	select dname,sal
	from emptable inner join depttable 
	on emptable.dno =depttable.dno


	select dname,sal*12 
	from emptable join depttable 
	on emptable.dno =depttable.dno


	select ename ,dname
	from emptable join depttable 
	on emptable.dno=depttable.dno and ename like '%a%'


	select ename,dname 
	from emptable join depttable 
	on emptable.dno =depttable.dno and JOB='salesman';



		-- left join  -> selects all the records from left table i.e(table ) and 
		      --selects the matched columns from right side table (tab )


			  select * from
			  emptable left join depttable 
			  on emptable.dno =depttable.dno

			  select ename,loc
	from emptable left join depttable 
	on emptable.dno =depttable.dno


	select dname,sal
	from emptable left join depttable 
	on emptable.dno =depttable.dno


	select dname,sal*12 
	from emptable left join depttable 
	on emptable.dno =depttable.dno


	select ename ,dname
	from emptable left join depttable 
	on emptable.dno=depttable.dno and ename like '%a%'


	select ename,dname 
	from emptable left join depttable 
	on emptable.dno =depttable.dno and JOB='salesman';

	-- right join  -> selects all records from right table (tab-2) and matched records from left side table (tab-1)




	select * from
	emptable right join depttable 
	on emptable.dno =depttable.dno

	select ename,loc
	from emptable right join depttable 
	on emptable.dno =depttable.dno


	select dname,sal
	from emptable right join depttable 
	on emptable.dno =depttable.dno


	select dname,sal*12 
	from emptable right join depttable 
	on emptable.dno =depttable.dno


	select ename ,dname
	from emptable right join depttable 
	on emptable.dno=depttable.dno and ename like '%a%'


	select ename,dname 
	from emptable right join depttable 
	on emptable.dno =depttable.dno and JOB='salesman';


			  
	-- full join -> returns all records when there is match in left table (tab-1) or right(tab-2) records

	 select * from 
	 emptable full join depttable
	 on emptable.dno=depttable.dno


			  select ename,loc
	from emptable full join depttable 
	on emptable.dno =depttable.dno


	select dname,sal
	from emptable full join depttable 
	on emptable.dno =depttable.dno


	select dname,sal*12 
	from emptable full join depttable 
	on emptable.dno =depttable.dno


	select ename ,dname
	from emptable full join depttable 
	on emptable.dno=depttable.dno and ename like '%a%'


	select ename,dname 
	from emptable full join depttable 
	on emptable.dno =depttable.dno and JOB='salesman';


	-- self join -> it is a regular join, but the table is joined with itself

	

	select * from 
	emptable t1, emptable t2
	where t1.ename =t2.ename


	
	