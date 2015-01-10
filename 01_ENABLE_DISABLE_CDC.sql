DECLARE @SQL   NVARCHAR(MAX)
DECLARE @SQL1   NVARCHAR(MAX)
DECLARE @SQL2   NVARCHAR(MAX)
DECLARE @Database_Name varchar(255)
DECLARE @source_schema	sysname
DECLARE @source_name	sysname
DECLARE @capture_instance	sysname
DECLARE @role_name	sysname
DECLARE @captured_column_list	nvarchar(255)
DECLARE @supports_net_changes varchar(255)
DECLARE @cdc_source_name sysname

-- USER NEED TO PASS THESE PARAMETERS
SET @Database_Name = 'Northwind'
SET @source_name	= 'pmfEvent'
SET @captured_column_list	= 'EventId, EventSource, Category, EventTime, Expiration, AccountId ,AccountName, AccountType, ContactName, EmailAddress, PhoneNumber, Keywords, EventPKey, EventType'
SET @source_schema	= 'dbo'
SET @role_name      = 'CDCRole'
set @supports_net_changes = 0
set @cdc_source_name = 'cdc.dbo_'+ @source_name +'_CT'

-- ENABLE CDC FOR Database
SET @SQL = N'USE '+ @Database_Name + '

   EXEC sys.sp_cdc_enable_db;
   
   '
  select (@SQL)
  EXEC (@SQL)

-- DISABLE CDC FOR Database
SET @SQL = N'USE '+ @Database_Name + '
   EXEC sys.sp_cdc_disable_db;
   '
  select (@SQL)
  EXEC (@SQL)


-- ENABLE CDC FOR A TABLE
SET @SQL = N'USE '+ @Database_Name + '

   exec sys.sp_cdc_enable_table
	@source_schema = ''' + @source_schema + ''',
	@source_name ='''+ @source_name + ''',
	@role_name ='''+  @role_name + ''',
	@captured_column_list ='''+  @captured_column_list + ''',
	@supports_net_changes ='''+ @supports_net_changes +''';

select (@SQL)
EXEC (@SQL)


-- DISABLE CDC FOR A TABLE
SET @SQL = N'USE '+ @Database_Name + '

EXECUTE sys.sp_cdc_disable_table 
    @source_schema = ''' + @source_schema + ''',
    @source_name ='''+ @source_name + ''',
    @capture_instance = N'all';

select (@SQL)
EXEC (@SQL)


-- CREATE LSN TRACKING TABLE
SET @SQL = N'USE '+ @Database_Name + '

   CREATE TABLE dbo.cdc_Archieve_LSN2 (Current_LSN binary(10) NOT NULL);'
select (@SQL)
EXEC (@SQL)
