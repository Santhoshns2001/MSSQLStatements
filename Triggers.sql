/*
SQL Server triggers are special stored procedures that are executed automatically 
in response to the database object, database, and server events.
SQL Server provides three type of triggers:

-> Data manipulation language (DML) triggers which are invoked automatically 
in response to INSERT, UPDATE, and DELETE events against tables.

->Data definition language (DDL) triggers which fire 
in response to CREATE, ALTER, and DROP statements. 
DDL triggers also fire in response to some system stored procedures that perform DDL-like operations.

->Logon triggers which fire in response to LOGON events
*/



	--CREATE TRIGGER statement

	/*
	syntax

	 CREATE TRIGGER [schema_name.]trigger_name
     ON table_name
     AFTER  {[INSERT],[UPDATE],[DELETE]}
     [NOT FOR REPLICATION]
     AS
     {sql_statements}


	*/


	CREATE TABLE product_audits(
    change_id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' or operation='DEL')
);


create table products (
product_id int primary key identity(1,1),
  product_name varchar(100), 
    brand_id int not null, 
    category_id int not null, 
    model_year smallint not null, 
    list_price dec(10,2) not null
	);



CREATE TRIGGER trg_product_audit
ON products
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO product_audits(
        product_id, 
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price, 
        updated_at, 
        operation
    )
    SELECT
        i.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        i.list_price,
        GETDATE(),
        'INS'
    FROM
        inserted i
    UNION ALL
    SELECT
        d.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        d.list_price,
        GETDATE(),
        'DEL'
    FROM
        deleted d;
		
END


INSERT INTO products(
    product_name, 
    brand_id, 
    category_id, 
    model_year, 
    list_price
)
VALUES (
    'Test product',
    2,
    2,
    2018,
    599
);


SELECT 
    * 
FROM 
    product_audits;


	
	DELETE FROM products
WHERE 
    product_id = 3;
	
	
