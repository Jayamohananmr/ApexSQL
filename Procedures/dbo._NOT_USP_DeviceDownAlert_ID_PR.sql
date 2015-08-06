SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_DeviceDownAlert_ID_PR]
@InMode VARCHAR(20),
@InRegID  BIGINT,
@InAlertID BIGINT,
@InConditionID BIGINT = NULL,
@InCloseStatus INT,
@OutStatus INT OUTPUT	 
AS

--------------------------------------------------------------------  
/*  
DECLARE @OutStatus INT
EXEC [USP_DeviceDownAlert_ID_PR] 'NewAlert',1,102,12345,1,'MD4125175000',@OutStatus OUTPUT
SELECT @OutStatus 
 
DECLARE @OutStatus INT
EXEC [USP_DeviceDownAlert_ID_PR] 'AutoClose',1,102,12345,0,'MD4125175000', @OutStatus OUTPUT
SELECT @OutStatus 
  
==============================PURPOSE==============================   
SP For "Device-Down" Alert Consolidation Audit.   
==========================PAGE NAME(CALLING)=======================  
DeviceDown_1_5000_Check 
==========================CREATED BY/DATE =========================  
Anamika Pandey
15 Nov 2012

==========================CREATED BY/DATE =========================  
Prakriti Singh
10th Jun 2013
Created with _PR
*/   
--------------------------------------------------------------------  

SET NOCOUNT ON

BEGIN TRY
	IF @InMode ='NEWALERT'
		BEGIN 
			INSERT INTO DeviceDownAlert_Cons(RegId, AlertId, ConditionId, CloseStatus)
			VALUES(@InRegID ,@InAlertID ,@InConditionID ,0)
			
			SET @OutStatus =1
		END 

	IF @InMode ='AUTOCLOSE'		 
		BEGIN
			INSERT INTO DeviceDownAlert_Cons_History(RegId, AlertId, ConditionId, CloseStatus,DcDtime)
			SELECT RegId, AlertId, ConditionId,@InCloseStatus,DcDtime
			FROM DeviceDownAlert_Cons WITH(NOLOCK)
			WHERE RegId=@InRegID AND AlertId=@InAlertID 
			
			DELETE FROM DeviceDownAlert_Cons 
			WHERE RegId=@InRegID AND AlertId=@InAlertID 
			
			SET @OutStatus =1
		END
END TRY

BEGIN CATCH
	SET @OutStatus =0
END CATCH	
SET NOCOUNT OFF
GO
