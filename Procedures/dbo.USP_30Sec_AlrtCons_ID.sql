SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[USP_30Sec_AlrtCons_ID]
(
	@InMode					VARCHAR(20),
	@InRegID				Bigint,
	@InTktID				Bigint,
	@InDateTime				DATETIME = NULL,
	@InAlertGroup			VARCHAR(200)= NULL,
	@InPreviuosAlertType	VARCHAR(255)= NULL,
	@InDCDateTime			DATETIME= NULL,
	@InMNDateTime			DATETIME= NULL,
	@InStatus				VARCHAR(50)= NULL,
	@InAddDetails			VARCHAR(8000)= NULL,
	@InThValue				VARCHAR(200)= NULL,
	@InJobPostStatus		BIT = 0,
	@InRCThldSec			BIGINT = NULL,
	@InKAThldSec			BIGINT = NULL,
	@OutStatus				INT OUTPUT
)
AS

--------------------------------------------------------------------  
/*  
DECLARE @OutStatus INT
EXEC [USP_30Sec_AlrtCons_ID] @InMode='NEW',@InRegID=3,@InTktID=2156156156,@InDateTime='2013-01-04',
		@InAlertGroup='PNG',@InPreviuosAlertType='30SECALIVE',@InDCDateTime='2013-01-04',
		@InMNDateTime='2013-01-04',@InStatus='ERROR',@InAddDetails='',@InThValue='125',
		@InJobPostStatus=1,@InRCThldSec=960,@InKAThldSec=960,@OutStatus=@OutStatus OUTPUT
SELECT @OutStatus

DECLARE @OutStatus INT
EXEC [USP_30Sec_AlrtCons_ID] @InMode='AUTOCLOSE',@InRegID=3,@InTktID=2156156156,@InDateTime='2013-01-04',
		@InAlertGroup='PNG',@InPreviuosAlertType='30SECALIVE',@InDCDateTime='2013-01-04',
		@InMNDateTime='2013-01-04',@InStatus='ERROR',@InAddDetails='',@InThValue='125',
		@InJobPostStatus=1,@InRCThldSec=960,@InKAThldSec=960,@OutStatus=@OutStatus OUTPUT
SELECT @OutStatus


==============================PURPOSE==============================   
SP For "Device-Down" Alert Consolidation Audit.   
==========================PAGE NAME(CALLING)=======================  
DeviceDown_1_5000_Check 
==========================CREATED BY/DATE =========================  
Paresh Bhadekar
4th Jan 2013
*/   
--------------------------------------------------------------------  

SET NOCOUNT ON

BEGIN TRY
	IF @InMode ='NEW'
		BEGIN 
			INSERT INTO [30Sec_AlrtCons](RegID,TktID,DateTime,AlertGroup,ThresholdCounter,DCDateTime,
				MNDateTime,Status,AddDetails,ThValue,JobPostStatus,RCThldSec,KAThldSec)
			VALUES(@InRegID ,@InTktID ,@InDateTime,@InAlertGroup,@InPreviuosAlertType,@InDCDateTime,
				@InMNDateTime,@InStatus,@InAddDetails,@InThValue,@InJobPostStatus,@InRCThldSec,@InKAThldSec)
			
			SET @OutStatus =1
		END 

	IF @InMode ='AUTOCLOSE'		 
		BEGIN
		
			DELETE FROM [30Sec_AlrtCons] 
			OUTPUT DELETED.AlrtID,DELETED.RegID,DELETED.TktID,DELETED.DateTime,DELETED.AlertGroup,
					DELETED.ThresholdCounter,DELETED.DCDateTime,DELETED.MNDateTime,DELETED.Status,
					DELETED.AddDetails,DELETED.ThValue,DELETED.JobPostStatus,DELETED.RCThldSec,
					DELETED.KAThldSec,@InRCThldSec,@InKAThldSec
			INTO [30Sec_AlrtCons_History](AlrtID,RegID,TktID,DateTime,AlertGroup,
				ThresholdCounter,DCDateTime,MNDateTime,Status,
				AddDetails,ThValue,JobPostStatus,RCThldSec,KAThldSec,RCThldSec_OnClose,KAThldSec_OnClose)
			WHERE RegId=@InRegID AND TktID=@InTktID 
			
			SET @OutStatus =1
		END
END TRY

BEGIN CATCH
	SET @OutStatus =0
END CATCH	
SET NOCOUNT OFF
GO
