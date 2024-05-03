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
     [NOT FOR REPLICATION]  -> The NOT FOR REPLICATION option instructs SQL Server not to fire the trigger when data modification is made as part of a replication process.
     AS
	 begin
	 SET NONCOUNT ON; -> inside the body of the trigger, you set the SET NOCOUNT to ON to suppress the number of rows affected messages from being returned whenever the trigger is fired.

     {sql_statements}
	 end

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
    --CHECK operation in( 'INS','UPD','DEL')
	check (operation ='INS' OR operation='UPD' OR operation='DEL')
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
AFTER INSERT, DELETE ,UPDATE
AS
BEGIN
    SET NOCOUNT ON;   --
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
	
	-- DELETE OPERATION
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

		UNION ALL

		 SELECT
        d.product_id,
        d.product_name,
        d.brand_id,
        d.category_id,
        d.model_year,
        d.list_price,
        GETDATE(),
        'DEL'
    FROM
        deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted i WHERE i.product_id = d.product_id) -- Only deletes
    
    UNION ALL
    
    -- UPDATE operation
    SELECT
        i.product_id,
        i.product_name,
        i.brand_id,
        i.category_id,
        i.model_year,
        i.list_price,
        GETDATE(),
        'UPD'
    FROM
        inserted i
    INNER JOIN deleted d ON i.product_id = d.product_id -- Updated records
END; 


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
	
	


	--creating of INSTEAD OF Trigger


	--DISABLING OF Triggers
	/* syntax

	DISABLE TRIGGER [schema_name.][trigger_name] 
ON [object_name | DATABASE | ALL SERVER]

In this syntax:

	->First, specify the name of the schema to which the trigger belongs and the name of the 
		trigger that you want to disable after the DISABLE TRIGGER keywords.

	->Second, specify the table name or view that the trigger was bound to if the trigger is
		a DML trigger. Use DATABASE if the trigger is DDL database-scoped trigger, 
		or SERVER if the trigger is DDL server-scoped trigger.
*/


-- disableing of dml triggers
disable trigger TriggerSchema.trgAfterDelete
on TriggerSchema.Employee

disable trigger TriggerSchema.trgAfterInsert
on TriggerSchema.Employee


disable trigger TriggerSchema.trgAfterUpdate
on TriggerSchema.Employee

-- disabling of ddl triggers

disable trigger trgPreventAlterTable
on database

disable trigger trgPreventCreateTable
on database

disable trigger trgPreventDropTable
on database


	--ENABLING OF TRIGGERS



	--Viewing the defination of triggers


	--Listing of all triggers in sqlserver


	--Removing of triggers
