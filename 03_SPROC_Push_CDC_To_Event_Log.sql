USE [Northwind]
GO

/****** Object:  StoredProcedure [dbo].[AddCdc_Event2]    Script Date: 11/03/2010 12:32:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[AddCdc_Event2]
AS
SET NOCOUNT ON 

BEGIN 

DECLARE @from_lsn binary(10)
DECLARE @to_lsn binary(10)
DECLARE @msg    VARCHAR(4000) 

/* insert the record 1st time when it insert into  */
IF NOT EXISTS (SELECT 1 FROM dbo.cdc_Archieve_LSN2 WHERE Current_LSN IS NOT NULL) 
BEGIN 
  INSERT INTO dbo.cdc_Archieve_LSN2 
   SELECT MIN(start_lsn) FROM cdc.lsn_time_mapping
END

/* get the current / late lsn from archive table */
SELECT @from_lsn = Current_LSN 
 FROM dbo.cdc_Archieve_LSN2;
 
/* get the new lsn number from cdc table */
SELECT @to_lsn = MAX(__$start_lsn)  
 FROM cdc.dbo_pmfEvent_CT;
 
/* if there is any update / insert / delete happen send it to event log */
IF (@from_lsn < @to_lsn)
BEGIN 
   /* get the message in xml form */
	SET @msg = (SELECT EventPKey, EventSource, Category, AccountId, AccountName, AccountType, ContactName, EmailAddress, PhoneNumber, Keywords, EventType from cdc.fn_cdc_get_all_changes_dbo_pmfEvent(@from_lsn,@to_lsn,'all') for XML RAW);

	 /* just for debugging  */
	SELECT @msg
	 
	/* send into to event log  */
	EXEC xp_logevent 61000, @msg, INFORMATIONAL 

END

/* mark the latest lsn number into archive table */
IF (@to_lsn IS NOT NULL)
BEGIN
UPDATE dbo.cdc_Archieve_LSN2
   SET Current_LSN = @to_lsn
END
END

GO

