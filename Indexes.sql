

/*

A SQL Server Index is used on a database table for faster data access. 
In this article, learn what SQL Server Indexes are, why we need them,
and how to implement them in SQL Server.

 ->SQL Indexes are used in relational databases to retrieve data quickly. 
They are similar to indexes at the end of the books whose purpose is quickly finding a topic. 
SQL provides Create Index, Alter Index, and Drop Index commands used to create a new index,
update an existing one, and delete an index in SQL Server.

*Data is internally stored in a SQL Server database in "pages" where the size of each page is 8KB.
*A continuous eight pages are called an "Ex. "nt."
*When we create the table, one extent will be allocated for two tables; 
when it is computed, it is filled with the data.
Then another time will be given, and this extent may or may not be continuous to the first extent.
*/


--Types of indexes 
--1. clusterd index 
--2. non clusterd index
--3. unique index

/*
1. clusterd index 
	  -> A B-Tree (computed) clustered index is the Index that will arrange the rows physically
			in the memory in sorted order.
      -> An advantage of a clustered index is that searching for a range of values will be fast.
			A clustered index is internally maintained using a B-Tree data structure leaf node of
			the btree of the clustered Index will contain the table data; 
			you can create only one clustered Index for a table.
*/



/*<indexname> on <object name>(<column list>)
[include(<columnlst>)]
[with fillfactor=<n>]
*/
-- note 
-- by defult index will be non clusterd

-- syntax of clusterd index

create table emp
( e_id int primary key )

insert into emp (e_id) values 
(2),
(3),
(4),
(5),(6),(7),(8),(9),(10)





/*
Simple & Composite Indexes

	->Based on the number of columns on which an index is created,
		indexes are classified into simple and composite indexes.

->When indexes are created on single columns, it is called a simple index;
when combined with multiple columns, it's called a composite index.

*/


/*
Nonclustered Index in SQL Server

	->A nonclustered index is an index that will not arrange the rows physically in the memory in sorted order.

	->	An advantage of a nonclustered index is that searching for the values in a range will be fast.

	->You can create a maximum of 999 nonclustered indexes on a table, 254 up to SQL Server 2005.

	->A nonclustered index is also maintained in a B-Tree data structure. 
		Still, leaf nodes of a B-Tree of the nonclustered Index contain the pointers to the pages
		that contain the table data and not the table data directly.

*/

create nonclustered index empIndex on emp(e_id)


/*
Unique Index
	-> When an index is created using the keyword unique, it is called a unique index; 
			you create a unique index on columns, and a unique index constraint will be created.

	-> If the columns on which you create a unique index contain duplicate values, 
		then a unique index will not be created, and you will get an error.
**/

-- Altering index

/*
altering index syntax:
alter index empIndex on EMp rebuild
*/


-- getting list of indexs
/*
This stored procedure is used to compute a list of indexes available on a table.
sp_helpindex 'Stud'
*/

-- Deleting indexes

-- syntax
--drop index <indexname> on <object name>

drop index empIndex on emp

